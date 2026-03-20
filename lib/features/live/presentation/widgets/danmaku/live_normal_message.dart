import 'package:culcul/data/models/live/index.dart';
import 'package:culcul/features/live/presentation/widgets/danmaku/live_danmaku_badge.dart';
import 'package:flutter/material.dart';

class LiveNormalMessage extends StatelessWidget {
  final LiveDanmakuItem item;

  const LiveNormalMessage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
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
          child: Padding(
            padding: EdgeInsets.only(right: 4),
            child: LiveAdminBadge(),
          ),
        ),
      );
    }

    spans.add(
      TextSpan(
        text: '${item.nickname}：',
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.7),
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
    );

    spans.add(
      TextSpan(
        text: item.text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          height: 1.4,
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
