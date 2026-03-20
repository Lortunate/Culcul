import 'package:culcul/providers/relation/relation_provider.dart';
import 'package:culcul/ui/pages/relation/widgets/relation_user_list.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FollowingsPage extends ConsumerWidget {
  final int vmid;

  const FollowingsPage({super.key, required this.vmid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final followingsAsync = ref.watch(followingsProvider(vmid));
    final hasMore = ref.watch(followingsProvider(vmid).notifier).hasMore;

    return Scaffold(
      appBar: AppBar(title: const Text('我的关注'), centerTitle: true),
      body: RelationUserList(
        asyncValue: followingsAsync,
        onRefresh: () => ref.refresh(followingsProvider(vmid).future),
        onLoadMore: () =>
            ref.read(followingsProvider(vmid).notifier).loadMore(),
        hasMore: hasMore,
        emptyText: '暂无关注',
      ),
    );
  }
}
