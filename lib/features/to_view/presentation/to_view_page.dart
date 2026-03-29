import 'package:culcul/features/auth/controllers/auth_controller.dart';
import 'package:culcul/features/to_view/controllers/to_view_controller.dart';
import 'package:culcul/features/to_view/presentation/widgets/to_view_list.dart';
import 'package:culcul/features/to_view/presentation/widgets/to_view_page_app_bar.dart';
import 'package:culcul/ui/widgets/app_error_widget.dart';
import 'package:culcul/ui/widgets/guest_view.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:go_router/go_router.dart';

class ToViewPage extends ConsumerWidget {
  const ToViewPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final isLoggedIn = authState.isLoggedIn;

    return Scaffold(
      appBar: ToViewPageAppBar(
        isLoggedIn: isLoggedIn,
        onClearAll: () => _showClearAllDialog(context, ref),
      ),
      body: isLoggedIn
          ? _ToViewBody(
              onRefresh: () => _refreshList(ref),
              onDelete: (aid) => ref.read(toViewListProvider.notifier).delete(aid),
              onOpenVideo: (bvid) => context.push('/video/$bvid'),
            )
          : GuestView(title: t.profile.not_logged_in, message: t.profile.login_hint),
    );
  }

  Future<void> _showClearAllDialog(BuildContext context, WidgetRef ref) async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(t.watch_later.clear_all),
          content: Text(t.watch_later.clear_all_confirm),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(t.common.cancel),
            ),
            TextButton(
              onPressed: () {
                ref.read(toViewListProvider.notifier).clear();
                Navigator.of(dialogContext).pop();
              },
              child: Text(t.common.confirm),
            ),
          ],
        );
      },
    );
  }

  Future<IndicatorResult> _refreshList(WidgetRef ref) async {
    final refreshedItems = await ref.refresh(toViewListProvider.future);
    if (refreshedItems.isNotEmpty) {
      return IndicatorResult.success;
    }
    return IndicatorResult.success;
  }
}

class _ToViewBody extends ConsumerWidget {
  const _ToViewBody({
    required this.onRefresh,
    required this.onDelete,
    required this.onOpenVideo,
  });

  final Future<IndicatorResult> Function() onRefresh;
  final ValueChanged<int> onDelete;
  final ValueChanged<String> onOpenVideo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toViewListAsync = ref.watch(toViewListProvider);
    return switch (toViewListAsync) {
      AsyncData(:final value) when value.isEmpty => Center(
        child: Text(t.common.no_content),
      ),
      AsyncData(:final value) => ToViewListView(
        items: value,
        onRefresh: onRefresh,
        onDelete: onDelete,
        onOpenVideo: onOpenVideo,
      ),
      AsyncError(:final error, :final stackTrace) => AppErrorWidget(
        error: error,
        stackTrace: stackTrace,
        onRetry: () => ref.invalidate(toViewListProvider),
      ),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}
