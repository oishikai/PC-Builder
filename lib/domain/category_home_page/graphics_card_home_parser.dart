import 'package:custom_pc/domain/document_repository.dart';
import 'package:custom_pc/models/category_home_data.dart';
import 'package:html/dom.dart';

import '../../models/pc_parts.dart';

class GraphicsCardHomeParser {
  // パース対象のURL
  static const _pageUrl = 'https://kakaku.com/pc/videocard/?lid=pc_ksearch_relatedpage';

  // NVIDIAの最新チップ名 10件くらいとれる
  static const _nvidiaChipListSelector = '#menu > div:nth-child(24) > div > div:nth-child(3) > ul:nth-child(3) > li';

  // AMDの最新チップ名 6件くらいとれる
  static const _amdChipListSelector = '#menu > div:nth-child(24) > div > div:nth-child(5) > ul:nth-child(3) > li';

  // 売れ筋ランキングのリスト
  static const _popularPartsListSelector = '#ct087 > div.contMain > div.contMainIn > ol > li';

  // パーツの画像
  static const _partsImageSelector = 'div > div.itemImg > img';

  static const _makerSelector = 'div > div.itemIn2 > p.makerName';
  static const _titleSelector = 'div > div.itemIn2 > p:nth-child(3)';
  static const _priceSelector = 'div > div.itemIn3 > p.itemPrice';
  static const _starSelector = 'div > div.itemIn3 > p.starRate > span.num1';
  static const _evaluationSelector = 'div > div.itemIn3 > p.starRate > span.num2';
  static const _detailUrlSecelctor = 'div > div.itemIn2 > p:nth-child(3) > a';
  //#ct087 > div.contMain > div.contMainIn > ol > li:nth-child(1) > div > div.itemIn2 > p.itemName.is-ellipsis
  static const _popularPartsRequired = 4;

  static Document? _document;
  static Future<GraphicsCardHome?> fetchAndParse() async {
    _document = await DocumentRepository.fetchDocument(_pageUrl);
    final nvidiaChips = _parseNvidiaChips();
    final amdChips = _parseAmdChips();
    final partsList = _parsePopularPats();

    return GraphicsCardHome(nvidiaChips!, amdChips!, partsList!);
  }

  static List<String>? _parseNvidiaChips() {
    if (_document == null) {
      return null;
    }
    List<String> chips = [];
    final chipElementList = _document!.querySelectorAll(_nvidiaChipListSelector);
    for (var element in chipElementList) {
      // "チップ名(製品数)" の形式で取得する為、チップ名のみ抽出する
      chips.add(element.text.split('(')[0]);
    }
    return chips;
  }

  static List<String>? _parseAmdChips() {
    if (_document == null) {
      return null;
    }
    List<String> chips = [];
    final chipElementList = _document!.querySelectorAll(_amdChipListSelector);
    for (var element in chipElementList) {
      chips.add(element.text.split('(')[0]);
    }
    return chips;
  }

  static List<PcParts>? _parsePopularPats() {
    if (_document == null) {
      return null;
    }
    List<PcParts> partsList = [];
    final partsListElement = _document!.querySelectorAll(_popularPartsListSelector);

    for (int i = 0; i < _popularPartsRequired; i++) {
      final element = partsListElement[i];
      final imageUrl = element.querySelectorAll(_partsImageSelector)[0].attributes['data-src'];
      final maker = element.querySelectorAll(_makerSelector)[0].text;
      final title = element.querySelectorAll(_titleSelector)[0].text;
      final price = element.querySelectorAll(_priceSelector)[0].text;
      final tempStar = element.querySelectorAll(_starSelector)[0].text;
      final evaluation = '$tempStar${element.querySelectorAll(_evaluationSelector)[0].text.replaceFirst('人', '').replaceFirst('（', '(').replaceFirst('）', ')')}';
      final detailUrl = element.querySelectorAll(_detailUrlSecelctor)[0].attributes['href'];
      int? star;
      if (tempStar != '—') {
        final doubleStar = double.parse(tempStar);
        star = doubleStar * 100 ~/ 10;
      }

      partsList.add(PcParts(maker, false, title, star, evaluation, price, '$i', imageUrl!, detailUrl!));
    }
  }
}
