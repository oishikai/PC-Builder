import 'package:custom_pc/models/pc_parts.dart';
import 'package:custom_pc/pages/parts_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/url_builder.dart';
import '../main.dart';
import '../widgets/parts_list/parts_list_app_bar.dart';

class CategoryHomePage extends ConsumerWidget {
  CategoryHomePage(
    this.category, {
    super.key,
  });

  final Category category;
  final _controller = TextEditingController();
  final _mainColor = const Color.fromRGBO(60, 130, 80, 1);
  final _subColor = const Color(0xFFEDECF2);

  final List<String> urls = [
    "https://img1.kakaku.k-img.com/images/productimage/fullscale/K0001529514.jpg",
    "https://img1.kakaku.k-img.com/images/productimage/fullscale/K0001529513.jpg",
    "https://img1.kakaku.k-img.com/images/productimage/fullscale/K0001391662.jpg",
    "https://img1.kakaku.k-img.com/images/productimage/fullscale/K0001507103.jpg",
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    searchToPartsListPage(String text) async {
      final url = UrlBuilder.searchPartsList(Category.graphicsCard, text);
      ref.read(targetUrlProvider.notifier).update((state) => url);
      ref.read(searchTextProvider.notifier).update((state) => text);

      Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const PartsListPage(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return CupertinoPageTransition(primaryRouteAnimation: animation, secondaryRouteAnimation: secondaryAnimation, linearTransition: false, child: child);
            }),
      );
    }

    return Scaffold(
      backgroundColor: _mainColor,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: _subColor,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30, right: 16),
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 30,
                              color: _mainColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: _mainColor,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: TextField(
                              controller: _controller,
                              cursorColor: Colors.white,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Search',
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                                contentPadding: EdgeInsets.only(top: 14, left: 8.0),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                isDense: true,
                              ),
                              onSubmitted: (text) {
                                final trim = text.trim();
                                if (text == '') {
                                  return;
                                }
                                searchToPartsListPage(trim);
                              },
                            ),
                          ),
                        ),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16, left: 16),
                      child: Container(
                        height: 60,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          category.categoryName,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _mainColor,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_outlined,
                                size: 24,
                                color: _mainColor,
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Text(
                                '搭載チップ',
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: _mainColor),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            'NVIDIA',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: _mainColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 16,
                              ),
                              InkWell(
                                onTap: () {
                                  searchToPartsListPage('Geforce RTX 4090');
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Geforce RTX 4090',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: _mainColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Geforce RTX 4090',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: _mainColor,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Geforce RTX 4090',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: _mainColor,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            'AMD',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: _mainColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 16,
                              ),
                              InkWell(
                                onTap: () {
                                  searchToPartsListPage('Radeon RX 7900 XTX');
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Radeon RX 7900 XTX',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: _mainColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Radeon RX 7900 XTX',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: _mainColor,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Radeon RX 7900 XTX',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: _mainColor,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.label_important_outlined,
                                size: 27,
                                color: _mainColor,
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Text(
                                '人気製品',
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: _mainColor),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: GridView.count(
                            childAspectRatio: 0.7,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            children: [
                              for (int i = 0; i < 4; i++)
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    margin: const EdgeInsets.only(right: 16, bottom: 16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(8),
                                          child: Image.network(
                                            urls[i],
                                          ),
                                        ),
                                        Text(
                                          'Palit Microsystems',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: _mainColor,
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(bottom: 6),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "GeForce RTX 3060 VENTUS 2X 12G OC V2 [PCIExp 12GB] パソコン工房限定モデル",
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: _mainColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        const Text(
                                          '¥99,000',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}