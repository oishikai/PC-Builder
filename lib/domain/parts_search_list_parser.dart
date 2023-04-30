import 'package:html/dom.dart';

import '../models/pc_parts.dart';
import 'document_repository.dart';

class PartsSearchListParser {
  static const _partsListSelector = '#compTblList > tbody > tr.tr-border';
  static const _partsMakerSelector = 'td.end.checkItem > table > tbody > tr > td.ckitemLink > a > span';
  static const _partsCombinedMakerAndTitleSelector = 'td.end.checkItem > table > tbody > tr > td.ckitemLink > a';
  static const _partsNewSelector = 'td.end.checkItem > table > tbody > tr > td.ckitemLink > img';
  static const _partsImageUrlSelector = 'td.alignC > a > img';
  static const _partsDetailUrlSelector = 'td.alignC > a';
  static const _partsPriceSelector = 'td.td-price > ul > li.pryen > a';
  static const _patsRankedSelector = 'td.swrank2 > span';

  final String targetUrl;
  Document? document;
  List<PcParts>? partsList;

  /*
  コンストラクタをプライベートとし、createでオブジェクトを生成。
  オブジェクト生成時に該当ページのDocumentのフェッチ、パースを完了させ、
  .partsListを参照してパーツリストを取り出す。
   */
  PartsSearchListParser._(this.targetUrl);
  static Future<PartsSearchListParser> create(String url) async {
    final self = PartsSearchListParser._(url);
    self.document = await DocumentRepository.fetchDocument(url);
    self.partsList = self._parsePartsList();
    return self;
  }

  List<PcParts> _parsePartsList() {
    if (document == null) {
      return [];
    }

    final List<PcParts> partsList = [];
    final partsListElement = document!.querySelectorAll(_partsListSelector);

    for (int i = 1; i < partsListElement.length; i += 3) {
      final maker = partsListElement[i].querySelectorAll(_partsMakerSelector)[0].text;
      // 商品名を直接取得できず、"{メーカー名} {商品名}"という形式で取得し、"{メーカー名} "を除く
      final combined = partsListElement[i].querySelectorAll(_partsCombinedMakerAndTitleSelector)[0].text;
      final title = combined.replaceFirst(maker, '');
      final isNew = partsListElement[i].querySelectorAll(_partsNewSelector).isNotEmpty;
      var imageUrl = partsListElement[i + 1].querySelectorAll(_partsImageUrlSelector)[0].attributes['src']!.replaceFirst('/m/', '/ll/');

      // if (imageUrl!.contains('https://img1.kakaku.k-img.com/images/productimage/m/')) {
      //   imageUrl.replaceFirst('m/', 'll/');
      // }

      final detailUrl = partsListElement[i + 1].querySelectorAll(_partsDetailUrlSelector)[0].attributes['href'];
      final price = partsListElement[i + 1].querySelectorAll(_partsPriceSelector)[0].text;
      final ranked = partsListElement[i + 1].querySelectorAll(_patsRankedSelector)[0].text;

      // レビュー、評価数はセレクターでうまくパースできなかった為、改行ごとに区切って6つ目の要素を取得する
      // evaluate は 取得時 "4.95(15件)" という形式なので、"件"を除く
      final evaluation = partsListElement[i + 1].text.split('\n')[5].replaceAll('件', '');
      final strStar = evaluation.split('(')[0];

      int? star;
      if (strStar != '—') {
        // "4.95" -> "49" に変換
        if (double.tryParse(strStar) != null) {
          final doubleStar = double.parse(strStar);
          star = doubleStar * 100 ~/ 10;
        }
      }
      partsList.add(PcParts(maker, isNew, title, star, evaluation, price, ranked, imageUrl!, detailUrl!));
    }
    return partsList;
  }
}