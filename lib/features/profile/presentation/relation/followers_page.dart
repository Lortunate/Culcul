import 'package:culcul/features/profile/controllers/relation_controller.dart';
import 'package:culcul/features/profile/presentation/relation/widgets/relation_user_list.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FollowersPage extends ConsumerWidget {
  final int vmid;

  const FollowersPage({super.key, required this.vmid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final followersAsync = ref.watch(followersProvider(vmid));
    final hasMore = ref.watch(followersProvider(vmid).notifier).hasMore;

    return Scaffold(
      appBar: AppBar(title: const Text('我的粉丝'), centerTitle: true),
      body: RelationUserList(
        asyncValue: followersAsync,
        onRefresh: () => ref.refresh(followersProvider(vmid).future),
        onLoadMore: () => ref.read(followersProvider(vmid).notifier).loadMore(),
        hasMore: hasMore,
        emptyText: '暂无粉丝',
      ),
    );
  }
}
