import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/auth/controllers/auth_controller.dart';
import 'package:culcul/data/models/history/history_model.dart';
import 'package:culcul/features/history/controllers/history_provider.dart';
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
      appBar: AppBar(title: Text(t.profile.menu.history), centerTitle: true),
      body: authState.isLoggedIn
          ? _HistoryContent(historyListAsync: historyListAsync)
          : GuestView(title: t.profile.not_logged_in, message: t.profile.login_hint),
    );
  }
}

class _HistoryContent extends ConsumerWidget {
  final AsyncValue<List<HistoryItem>> historyListAsync;

  const _HistoryContent({required this.historyListAsync});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (historyListAsync) {
      AsyncData(:final value) when value.isEmpty => const _HistoryEmptyState(),
      AsyncData(:final value) => RefreshIndicator(
        onRefresh: () => ref.refresh(historyListProvider.future),
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: value.length,
          separatorBuilder: (_, _) => const Divider(height: 1, indent: 16, endIndent: 16),
          itemBuilder: (context, index) {
            final item = value[index];
            return HistoryItemWidget(
              item: item,
              onTap: () {
                final bvid = item.history.bvid;
                if (item.history.business == 'archive' && bvid.isNotEmpty) {
                  context.push('/video/$bvid');
                }
              },
            );
          },
        ),
      ),
      AsyncError(:final error, :final stackTrace) => AppErrorWidget(
        error: error,
        stackTrace: stackTrace,
        onRetry: () => ref.invalidate(historyListProvider),
      ),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}

class _HistoryEmptyState extends StatelessWidget {
  const _HistoryEmptyState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.history_rounded, size: 40, color: colorScheme.outline),
            const SizedBox(height: 12),
            Text(
              t.history.empty,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
