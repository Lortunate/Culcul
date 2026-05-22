import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:culcul/features/notification/presentation/view_models/private_session_view_model.dart';
import 'package:culcul/features/notification/presentation/widgets/notification_skeletons.dart';
import 'package:culcul/features/notification/presentation/widgets/private_session_item.dart';
import 'package:culcul/core/data/pagination/pagination_load_gate.dart';
import 'package:culcul/core/data/pagination/scroll_load_trigger.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PrivateSessionListView extends HookConsumerWidget {
  final void Function(
    PrivateSession session, {
    required String name,
    required String avatarUrl,
  })
  onOpenChat;

  const PrivateSessionListView({super.key, required this.onOpenChat});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionListAsync = ref.watch(privateSessionListProvider);
    final loadGate = useMemoized(PaginationLoadGate.new, const []);
    final t = context.t;

    return sessionListAsync.when(
      data: (sessions) {
        final notifier = ref.read(privateSessionListProvider.notifier);
        final hasMore = notifier.hasMore;
        return EasyRefresh(
          onRefresh: () async {
            return ref.refresh(privateSessionListProvider.future);
          },
          onLoad: !hasMore
              ? null
              : () => ScrollLoadTrigger.runWithNotifier(
                  gate: loadGate,
                  hasMore: () => ref.read(privateSessionListProvider.notifier).hasMore,
                  loadMore: notifier.loadMore,
                  itemCount: () =>
                      ref.read(privateSessionListProvider).asData?.value.length ??
                      sessions.length,
                  source: 'notification.private_session_list',
                ),
          footer: hasMore ? const MaterialFooter() : null,
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
                    final session = sessions[index];
                    return KeyedSubtree(
                      key: ValueKey('private_session_${session.talkerId}_$index'),
                      child: PrivateSessionItem(session: session, onOpenChat: onOpenChat),
                    );
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
            height: MediaQuery.sizeOf(context).height * 0.7,
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
