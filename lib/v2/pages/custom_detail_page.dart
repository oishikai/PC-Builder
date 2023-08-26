import 'package:custom_pc/v2/providers/custom_repository.dart';
import 'package:custom_pc/v2/widgets/custom_detail_page/parts_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/edit_custom.dart';
import '../widgets/custom_detail_page/custom_summary_widget.dart';

class CustomDetailPage extends ConsumerWidget {
  const CustomDetailPage({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final custom = ref.watch(customRepositoryNotifierProvider);
    return custom.when(
      data: (data) {
        final custom = data.firstWhere((element) => element.id == id);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            title: Text(
              custom.name!,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: Theme.of(context).colorScheme.secondary,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            actions: [
              IconButton(
                onPressed: () {
                  // context.push('/sub_route');
                },
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 32,
                ),
              ),
            ],
          ),
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      'SUMMARY',
                      style: TextStyle(
                        fontSize: 24,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      custom.formatPrice(),
                      style: TextStyle(
                        fontSize: 24,
                        color: Theme.of(context).colorScheme.error,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              CustomSummaryWidget(custom: custom),
              PartsListWidgetV2(custom: custom)
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              ref.read(editCustomNotifierProvider.notifier).setCustom(custom);
              context.go('/edit');
            },
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            child: const Icon(
              Icons.edit,
              size: 32,
            ),
          ),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      error: (e, s) {
        return const Center(
          child: Text('読み込みに失敗しました'),
        );
      },
    );
  }
}
