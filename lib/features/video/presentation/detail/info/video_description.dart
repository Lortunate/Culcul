import 'package:culcul/features/video/application/video_detail_models.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/theme/culcul_tokens.dart';
import 'package:culcul/ui/widgets/buttons/app_clickable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ExpandableDescriptionAndTags extends HookWidget {
  final String description;
  final List<VideoTagViewData> tags;

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
    final t = context.t;

    return AppClickable(
      onTap: () => isExpanded.value = !isExpanded.value,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: CulculSpacing.sm,
          vertical: CulculSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(CulculRadius.sm),
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
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 13,
                      height: 1.45,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
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
              const SizedBox(height: CulculSpacing.xs),
              Wrap(
                spacing: CulculSpacing.xs,
                runSpacing: CulculSpacing.xs,
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
  final VideoTagViewData tag;

  const CompactTag({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: CulculSpacing.sm,
        vertical: CulculSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(CulculRadius.lg),
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
