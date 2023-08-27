import 'package:custom_pc/models/pc_parts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/edit_custom.dart';

class PartsEditWidget extends ConsumerWidget {
  const PartsEditWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final custom = ref.watch(editCustomNotifierProvider);
    final partsList = custom.align().entries.map((e) => _PartsAndCategory(e.key, e.value)).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '構成',
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          for (final p in partsList)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // カテゴリ名部分
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_drop_down,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      Text(
                        p.category.categoryName,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  // パーツ情報部分
                  InkWell(
                    onTap: () {},
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 8,
                        ),
                        SizedBox(
                          height: 60.0,
                          width: 60.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              p.parts.image,
                              fit: BoxFit.cover,
                              colorBlendMode: BlendMode.darken,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                p.parts.maker,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.secondary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                p.parts.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    p.parts.price,
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.error,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Spacer(),
                                  TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.cached_outlined,
                                          color: Theme.of(context).colorScheme.secondary,
                                          size: 18,
                                        ),
                                        Text(
                                          '変更',
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.secondary,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // co/
                                  TextButton(
                                    onPressed: () {
                                      ref.read(editCustomNotifierProvider.notifier).removeParts(p.category);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('${p.parts.title}を削除しました'),
                                          duration: const Duration(seconds: 1),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.delete,
                                          color: Theme.of(context).colorScheme.error,
                                          size: 18,
                                        ),
                                        Text(
                                          '削除',
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.error,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    height: 1,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _PartsAndCategory {
  _PartsAndCategory(this.category, this.parts);
  final PartsCategory category;
  final PcParts parts;
}
