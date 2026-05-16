import 'package:culcul/features/live/application/presentation_contracts/dtos/live_history_danmaku_model.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class LiveSystemMessage extends StatelessWidget {
  final LiveDanmakuItem item;

  const LiveSystemMessage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.scrim.withValues(alpha: 0.86),
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
          color: colorScheme.onPrimary.withValues(alpha: 0.08),
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.live.danmaku.system_notice_colon,
            style: TextStyle(
              color: theme.colorScheme.primary.withValues(alpha: 0.88),
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item.text,
            style: TextStyle(
              color: colorScheme.onPrimary.withValues(alpha: 0.84),
              fontSize: 12,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
