import 'package:culcul/features/live/application/models/live_history_danmaku_model.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/core/theme/culcul_colors.dart';
import 'package:flutter/material.dart';

class LiveNormalMessage extends StatelessWidget {
  final LiveDanmakuItem item;

  const LiveNormalMessage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final semanticColors = context.semanticColors;
    final guardColor = item.guardLevel == 1
        ? semanticColors.warning
        : item.guardLevel == 2
        ? colorScheme.secondary
        : semanticColors.info;
    final guardIcon = item.guardLevel == 1
        ? Icons.local_police
        : item.guardLevel == 2
        ? Icons.star
        : Icons.shield;
    final medal = item.medal;
    final medalColor = medal == null
        ? null
        : medal.color != 0
        ? Color.fromARGB(
            255,
            (medal.color >> 16) & 0xFF,
            (medal.color >> 8) & 0xFF,
            medal.color & 0xFF,
          )
        : colorScheme.primary;
    final hasBadge = item.guardLevel > 0 || item.medal != null || item.isadmin == 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasBadge)
          Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Wrap(
              spacing: 4,
              runSpacing: 2,
              children: [
                if (item.guardLevel > 0)
                  Container(
                    padding: const EdgeInsets.all(1.5),
                    decoration: BoxDecoration(
                      color: guardColor.withValues(alpha: 0.15),
                      border: Border.all(
                        color: guardColor.withValues(alpha: 0.8),
                        width: 0.8,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(
                      guardIcon,
                      size: 9,
                      color: guardColor.withValues(alpha: 0.92),
                    ),
                  ),
                if (medal != null)
                  Container(
                    decoration: BoxDecoration(
                      color: medalColor!.withValues(alpha: 0.12),
                      border: Border.all(
                        color: medalColor.withValues(alpha: 0.75),
                        width: 0.7,
                      ),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 1.5,
                          ),
                          child: Text(
                            medal.name,
                            style: TextStyle(
                              color: medalColor.withValues(alpha: 0.92),
                              fontSize: 9.5,
                              fontWeight: FontWeight.w600,
                              height: 1.1,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 1.5,
                          ),
                          decoration: BoxDecoration(
                            color: medalColor.withValues(alpha: 0.78),
                            borderRadius: const BorderRadius.horizontal(
                              right: Radius.circular(2),
                            ),
                          ),
                          child: Text(
                            medal.level.toString(),
                            style: TextStyle(
                              color: colorScheme.onPrimary,
                              fontSize: 9.5,
                              fontWeight: FontWeight.bold,
                              height: 1.1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (item.isadmin == 1)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 3.5, vertical: 1.2),
                    decoration: BoxDecoration(
                      color: colorScheme.error.withValues(alpha: 0.82),
                      border: Border.all(
                        color: colorScheme.error.withValues(alpha: 0.9),
                        width: 0.7,
                      ),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      t.live.danmaku.admin,
                      style: TextStyle(
                        color: colorScheme.onError,
                        fontSize: 9.5,
                        fontWeight: FontWeight.bold,
                        height: 1.1,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '${item.nickname}：',
                style: TextStyle(
                  color: colorScheme.onPrimary.withValues(alpha: 0.66),
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  height: 1.25,
                ),
              ),
              TextSpan(
                text: item.text,
                style: TextStyle(
                  color: colorScheme.onPrimary.withValues(alpha: 0.92),
                  fontSize: 13,
                  height: 1.25,
                ),
              ),
            ],
          ),
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
