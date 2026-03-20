import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/history/logic/history_provider.dart';
import 'package:culcul/providers/auth/auth_provider.dart';
import 'package:culcul/ui/widgets/app_error_widget.dart';
import 'package:culcul/ui/widgets/guest_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'widgets/history_item_widget.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyListAsync = ref.watch(historyListProvider);
    final authState = ref.watch(authProvider);
    final t = Translations.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('历史记录'), centerTitle: true),
      body: authState.isLoggedIn
          ? historyListAsync.when(
              data: (list) {
                if (list.isEmpty) {
                  return const Center(child: Text('暂无历史记录'));
                }
                return RefreshIndicator(
                  onRefresh: () => ref.refresh(historyListProvider.future),
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: list.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1, indent: 16, endIndent: 16),
                    itemBuilder: (context, index) {
                      final item = list[index];
                      return HistoryItemWidget(
                        item: item,
                        onTap: () {
                          if (item.history.business == 'archive' &&
                              item.history.bvid.isNotEmpty) {
                            context.push('/video/${item.history.bvid}');
                          }
                        },
                      );
                    },
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) {
                debugPrint('HistoryPage Error: $err\n$stack');
                return AppErrorWidget(
                  error: err,
                  stackTrace: stack,
                  onRetry: () => ref.refresh(historyListProvider),
                );
              },
            )
          : GuestView(
              title: t.profile.not_logged_in,
              message: t.profile.login_hint,
            ),
    );
  }
}
