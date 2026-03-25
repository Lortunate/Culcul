import 'package:culcul/data/models/live/index.dart';
import 'package:culcul/features/live/presentation/widgets/danmaku/live_danmaku_badge.dart';
import 'package:flutter/material.dart';

class LiveNormalMessage extends StatelessWidget {
  final LiveDanmakuItem item;

  const LiveNormalMessage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final spans = <InlineSpan>[];

    if (item.guardLevel > 0) {
      spans.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.only(right: 4),
            child: LiveGuardBadge(level: item.guardLevel),
          ),
        ),
      );
    }

    if (item.medal.length >= 2) {
      spans.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.only(right: 4),
            child: LiveMedalBadge(medal: item.medal),
          ),
        ),
      );
    }

    if (item.isadmin == 1) {
      spans.add(
        const WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Padding(padding: EdgeInsets.only(right: 4), child: LiveAdminBadge()),
        ),
      );
    }

    spans.add(
      TextSpan(
        text: '${item.nickname}：',
        style: TextStyle(
          color: colorScheme.onPrimary.withValues(alpha: 0.66),
          fontWeight: FontWeight.w500,
          fontSize: 13,
          height: 1.25,
        ),
      ),
    );

    spans.add(
      TextSpan(
        text: item.text,
        style: TextStyle(
          color: colorScheme.onPrimary.withValues(alpha: 0.92),
          fontSize: 13,
          height: 1.25,
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: RichText(
        text: TextSpan(children: spans),
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
