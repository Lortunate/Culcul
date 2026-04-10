import 'package:culcul/features/video/domain/entities/video_entities.dart';
import 'package:culcul/i18n/i18n.dart';
import 'package:culcul/shared/widgets/app_clickable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ExpandableDescriptionAndTags extends HookWidget {
  final String description;
  final List<VideoTag> tags;

  const ExpandableDescriptionAndTags({
    super.key,
    required this.description,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = i18n(context);

    return AppClickable(
      onTap: () => isExpanded.value = !isExpanded.value,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    description.isEmpty ? t.video.no_desc : description,
                    maxLines: isExpanded.value ? null : 1,
                    overflow: isExpanded.value ? null : TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      height: 1.6,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  isExpanded.value
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  size: 20,
                  color: colorScheme.onSurfaceVariant,
                ),
              ],
            ),
            if (isExpanded.value && tags.isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: tags.take(12).map((tag) => CompactTag(tag: tag)).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class CompactTag extends StatelessWidget {
  final VideoTag tag;

  const CompactTag({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        tag.tagName,
        style: theme.textTheme.labelSmall?.copyWith(
          color: colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
