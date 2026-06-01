import 'dart:async';

import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/core/feedback/app_feedback.dart';
import 'package:culcul/features/auth/application/auth_session_providers.dart';
import 'package:culcul/features/notification/application/notification_navigation.dart';
import 'package:culcul/features/notification/data/notification_repository_impl.dart';
import 'package:culcul/features/notification/domain/entities/system_notice.dart';
import 'package:culcul/core/utils/format_extensions.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _systemNotificationListProvider =
    AsyncNotifierProvider<_SystemNotificationList, List<SystemNotice>>(
      _SystemNotificationList.new,
    );

class _SystemNotificationList extends AsyncNotifier<List<SystemNotice>> {
  StreamSubscription<List<SystemNotice>>? _subscription;

  @override
  Future<List<SystemNotice>> build() async {
    final ownerUid = int.tryParse(ref.watch(currentUserProvider)?.uid ?? '');
    if (ownerUid == null) return const <SystemNotice>[];

    final repository = ref.read(notificationRepositoryProvider);
    final stream = repository.watchSystemNotices(ownerUid: ownerUid);
    _subscription = stream.listen((items) {
      state = AsyncData(items);
    });
    ref.onDispose(() => _subscription?.cancel());

    unawaited(repository.syncSystemNotices(ownerUid: ownerUid));
    return stream.first;
  }

  Future<void> refresh() async {
    final ownerUid = int.tryParse(ref.read(currentUserProvider)?.uid ?? '');
    if (ownerUid == null) return;
    await ref.read(notificationRepositoryProvider).syncSystemNotices(ownerUid: ownerUid);
  }
}

class SystemNotificationPage extends ConsumerWidget {
  final NotificationTargetOpener onOpenTarget;

  const SystemNotificationPage({super.key, required this.onOpenTarget});

  static const NotificationNavigationParser _navigationParser =
      NotificationNavigationParser();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(_systemNotificationListProvider);
    final t = context.t;
    final refresh = ref.read(_systemNotificationListProvider.notifier).refresh;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(t.notification.types.system),
        actions: [IconButton(icon: const Icon(Icons.refresh), onPressed: refresh)],
      ),
      body: state.when(
        data: (items) {
          final list = items.isEmpty
              ? ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    const SizedBox(height: 120),
                    Center(child: Text(t.notification.empty)),
                  ],
                )
              : ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(12),
                  itemCount: items.length,
                  separatorBuilder: (_, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Card(
                      elevation: 0,
                      color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                        ),
                      ),
                      child: InkWell(
                        onTap: () async {
                          final target = _navigationParser.fromSystemNotice(item);
                          final handled = await onOpenTarget(target);
                          if (handled || !context.mounted) return;

                          context.showAppFeedback(
                            t.notification.navigation_error(
                              type: 'system',
                              id: item.id.toString(),
                            ),
                            level: AppFeedbackLevel.error,
                          );
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (item.title != null && item.title!.isNotEmpty) ...[
                                Text(
                                  item.title!,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                              if (item.text != null)
                                Text(item.text!, style: theme.textTheme.bodyMedium),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Text(
                                    item.time.formatTimestamp(),
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: colorScheme.outline,
                                    ),
                                  ),
                                  const Spacer(),
                                  if (item.jumpText != null) ...[
                                    Text(
                                      item.jumpText!,
                                      style: theme.textTheme.labelMedium?.copyWith(
                                        color: colorScheme.primary,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 12,
                                      color: colorScheme.primary,
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );

          return RefreshIndicator(onRefresh: refresh, child: list);
        },
        error: (err, stack) =>
            AppErrorWidget(error: err, stackTrace: stack, onRetry: refresh),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
