import 'package:culcul/features/video/application/video_detail_models.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/buttons/app_clickable.dart';
import 'package:flutter/material.dart';

class VideoPartsSection extends StatelessWidget {
  final List<VideoPartViewData> pages;
  final int currentCid;
  final ValueChanged<int> onPartChanged;

  const VideoPartsSection({
    super.key,
    required this.pages,
    required this.currentCid,
    required this.onPartChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text(
                '${t.video.parts} (${pages.length})',
                style: theme.textTheme.labelLarge?.copyWith(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.chevron_right_rounded,
                size: 18,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 46,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: pages.length,
            separatorBuilder: (context, index) => const SizedBox(width: 6),
            itemBuilder: (context, index) {
              final page = pages[index];
              final isSelected = page.cid == currentCid;
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Material(
                  color: isSelected
                      ? colorScheme.primary.withValues(alpha: 0.08)
                      : colorScheme.surfaceContainerHighest.withValues(alpha: 0.42),
                  child: AppClickable(
                    onTap: () => onPartChanged(page.cid),
                    child: Container(
                      width: 112,
                      padding: const EdgeInsets.symmetric(horizontal: 9),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          if (isSelected) ...[
                            Icon(
                              Icons.graphic_eq_rounded,
                              size: 14,
                              color: colorScheme.primary,
                            ),
                            const SizedBox(width: 5),
                          ],
                          Expanded(
                            child: Text(
                              page.part.isEmpty
                                  ? 'P${page.page}'
                                  : '${page.part} ${page.page}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: isSelected
                                    ? colorScheme.primary
                                    : colorScheme.onSurface,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
