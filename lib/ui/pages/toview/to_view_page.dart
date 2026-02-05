import 'package:culcul/providers/auth/auth_provider.dart';
import 'package:culcul/providers/toview/toview_provider.dart';
import 'package:culcul/ui/pages/toview/to_view_item.dart';
import 'package:culcul/ui/widgets/app_error_widget.dart';
import 'package:culcul/ui/widgets/guest_view.dart';
import 'package:flutter/material.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:go_router/go_router.dart';

class ToViewPage extends ConsumerWidget {
  const ToViewPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toViewListAsync = ref.watch(toViewListProvider);
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.to_view.title),
        actions: [
          if (authState.isLoggedIn)
            IconButton(
              icon: const Icon(Icons.delete_sweep_outlined),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(t.to_view.clear_all),
                    content: Text(t.to_view.clear_all_confirm),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(t.common.cancel),
                      ),
                      TextButton(
                        onPressed: () {
                          ref.read(toViewListProvider.notifier).clearToView();
                          Navigator.of(context).pop();
                        },
                        child: Text(t.common.confirm),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
      body: authState.isLoggedIn
          ? toViewListAsync.when(
              data: (list) {
                if (list.isEmpty) {
                  return Center(child: Text(t.common.no_content));
                }
                return EasyRefresh(
                  header: const MaterialHeader(),
                  onRefresh: () async {
                    final _ = await ref.refresh(toViewListProvider.future);
                    return IndicatorResult.success;
                  },
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final item = list[index];
                      if (item.aid == null || item.bvid == null) {
                        return const SizedBox.shrink();
                      }
                      return Dismissible(
                        key: Key(item.aid.toString()),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (direction) {
                          ref
                              .read(toViewListProvider.notifier)
                              .deleteToView(item.aid!);
                        },
                        child: ToViewItem(
                          item: item,
                          onTap: () {
                            context.push('/video/${item.bvid!}');
                          },
                        ),
                      );
                    },
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) {
                debugPrint('ToViewPage Error: $err\n$stack');
                return AppErrorWidget(
                  error: err,
                  stackTrace: stack,
                  onRetry: () => ref.refresh(toViewListProvider),
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
