import 'package:culcul/features/live/domain/entities/live_entities.dart';
import 'package:culcul/features/live/presentation/widgets/danmaku/live_danmaku_badge.dart';
import 'package:flutter/material.dart';

class LiveNormalMessage extends StatelessWidget {
  final LiveDanmakuItem item;

  const LiveNormalMessage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
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
                if (item.guardLevel > 0) LiveGuardBadge(level: item.guardLevel),
                if (item.medal != null) LiveMedalBadge(medal: item.medal!),
                if (item.isadmin == 1) const LiveAdminBadge(),
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
