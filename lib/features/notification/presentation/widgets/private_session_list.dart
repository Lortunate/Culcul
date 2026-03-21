import 'package:culcul/features/notification/controllers/private_session_controller.dart';
import 'package:culcul/features/notification/presentation/widgets/notification_skeletons.dart';
import 'package:culcul/features/notification/presentation/widgets/private_session_item.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PrivateSessionList extends ConsumerWidget {
  const PrivateSessionList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionListAsync = ref.watch(privateSessionListProvider);

    return sessionListAsync.when(
      data: (sessions) {
        return EasyRefresh(
          onRefresh: () async {
            return ref.refresh(privateSessionListProvider.future);
          },
          onLoad: () async {
            await ref.read(privateSessionListProvider.notifier).loadMore();
          },
          child: sessions.isEmpty
              ? LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: constraints.maxHeight),
                        child: const Center(child: Text('暂无消息')),
                      ),
                    );
                  },
                )
              : ListView.builder(
                  itemCount: sessions.length,
                  itemBuilder: (context, index) {
                    return PrivateSessionItem(session: sessions[index]);
                  },
                ),
        );
      },
      error: (e, s) => EasyRefresh(
        onRefresh: () async {
          return ref.refresh(privateSessionListProvider.future);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('加载失败: $e'),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      ref.invalidate(privateSessionListProvider);
                    },
                    child: const Text('重试'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      loading: () => const PrivateSessionSkeletonList(),
    );
  }
}
