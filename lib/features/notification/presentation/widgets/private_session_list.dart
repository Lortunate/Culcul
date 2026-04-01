import 'package:culcul/i18n/i18n.dart';
import 'package:culcul/features/notification/presentation/view_models/private_session_view_model.dart';
import 'package:culcul/features/notification/presentation/widgets/notification_skeletons.dart';
import 'package:culcul/features/notification/presentation/widgets/private_session_item.dart';
import 'package:culcul/ui/widgets/app_error_widget.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PrivateSessionList extends ConsumerWidget {
  const PrivateSessionList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionListAsync = ref.watch(privateSessionListProvider);
    final t = i18n(context);

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
                        child: Center(child: Text(t.notification.chat.no_message)),
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
            child: AppErrorWidget(
              error: e,
              stackTrace: s,
              onRetry: () {
                ref.invalidate(privateSessionListProvider);
              },
            ),
          ),
        ),
      ),
      loading: () => const PrivateSessionSkeletonList(),
    );
  }
}
