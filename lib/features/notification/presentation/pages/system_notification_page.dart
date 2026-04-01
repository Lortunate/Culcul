import 'package:culcul/i18n/i18n.dart';
import 'package:culcul/features/notification/presentation/view_models/system_notification_view_model.dart';
import 'package:culcul/features/notification/domain/entities/system_notice.dart';
import 'package:culcul/core/utils/format_extensions.dart';
import 'package:culcul/ui/widgets/app_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class SystemNotificationPage extends ConsumerWidget {
  const SystemNotificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(systemNotificationListProvider);
    final t = i18n(context);

    return Scaffold(
      appBar: AppBar(title: Text(t.notification.types.system)),
      body: state.when(
        data: (items) {
          if (items.isEmpty) {
            return Center(child: Text(t.notification.empty));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: items.length,
            separatorBuilder: (_, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final item = items[index];
              return _SystemNotificationCard(item: item);
            },
          );
        },
        error: (err, stack) => AppErrorWidget(
          error: err,
          stackTrace: stack,
          onRetry: () => ref.refresh(systemNotificationListProvider),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class _SystemNotificationCard extends StatelessWidget {
  final SystemNotice item;

  const _SystemNotificationCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: colorScheme.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: InkWell(
        onTap: item.uri != null
            ? () async {
                final uri = Uri.tryParse(item.uri!);
                if (uri != null) {
                  await launchUrl(uri);
                }
              }
            : null,
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
              if (item.text != null) Text(item.text!, style: theme.textTheme.bodyMedium),
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
                    Icon(Icons.arrow_forward_ios, size: 12, color: colorScheme.primary),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
