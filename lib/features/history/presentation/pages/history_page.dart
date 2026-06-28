import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/core/perf/dev_logger.dart';
import 'package:culcul/features/auth/application/auth_session_providers.dart';
import 'package:culcul/features/history/data/history_repository_impl.dart';
import 'package:culcul/features/history/models/history_entry.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/cards/video_list_card.dart';
import 'package:culcul/ui/widgets/cards/video_list_card_dimensions.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:culcul/ui/widgets/text/icon_text.dart';
import 'package:culcul/ui/widgets/users/guest_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _historyListProvider = FutureProvider.autoDispose<List<HistoryEntry>>((ref) async {
  final result = await ref.read(historyRepositoryProvider).getHistory();
  return result.when(
    success: (data) => data,
    failure: (error) {
      DevLogger.log('feature', 'history.load_error', <String, Object?>{'error': error});
      return const <HistoryEntry>[];
    },
  );
});

class HistoryPage extends ConsumerWidget {
  final VoidCallback onLogin;
  final ValueChanged<String> onOpenVideo;

  const HistoryPage({required this.onLogin, required this.onOpenVideo, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyListAsync = ref.watch(_historyListProvider);
    final isLoggedIn = ref.watch(
      currentUserProvider.select((s) => s?.isLoggedIn ?? false),
    );
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(t.profile.menu.history), centerTitle: true),
      body: isLoggedIn
          ? switch (historyListAsync) {
              AsyncData(:final value) when value.isEmpty => Center(
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
              ),
              AsyncData(:final value) => RefreshIndicator(
                onRefresh: () => ref.refresh(_historyListProvider.future),
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: value.length,
                  separatorBuilder: (_, _) =>
                      const Divider(height: 1, indent: 16, endIndent: 16),
                  itemBuilder: (context, index) {
                    final item = value[index];
                    final progressColor = colorScheme.primary;
                    return KeyedSubtree(
                      key: ValueKey(item.bvid),
                      child: DefaultTextStyle.merge(
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.2,
                        ),
                        child: VideoListCard(
                          onTap: () {
                            final bvid = item.bvid;
                            if (item.business == 'archive' && bvid.isNotEmpty) {
                              onOpenVideo(bvid);
                            }
                          },
                          coverUrl: item.coverUrl,
                          title: item.title,
                          duration: item.progress > 0 ? 0 : item.duration,
                          aspectRatio: wideVideoListCardThumbnailAspectRatio,
                          height: wideVideoListCardThumbnailHeight,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          overlay: item.progress > 0 && item.duration > 0
                              ? Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: LinearProgressIndicator(
                                    value: item.progress / item.duration,
                                    minHeight: 3,
                                    backgroundColor: Colors.transparent,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      progressColor,
                                    ),
                                  ),
                                )
                              : null,
                          middleContent: Text(
                            item.authorName,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                              fontSize: 12,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          stats: [
                            if (item.badge.isNotEmpty)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 1,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: colorScheme.primary,
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: Text(
                                  item.badge,
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: colorScheme.primary,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            IconText(
                              icon: Icons.access_time_rounded,
                              text: FormatUtils.formatTimeAgo(item.viewedAt),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              AsyncError(:final error, :final stackTrace) => AppErrorWidget(
                error: error,
                stackTrace: stackTrace,
                onRetry: () => ref.invalidate(_historyListProvider),
              ),
              _ => const Center(child: CircularProgressIndicator()),
            }
          : GuestView(
              title: t.profile.not_logged_in,
              message: t.profile.login_hint,
              onLogin: onLogin,
            ),
    );
  }
}
