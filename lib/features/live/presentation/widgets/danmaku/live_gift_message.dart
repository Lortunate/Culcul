import 'package:culcul/features/live/domain/entities/live_history_danmaku_model.dart';
import 'package:flutter/material.dart';

class LiveGiftMessage extends StatelessWidget {
  final LiveDanmakuItem item;

  const LiveGiftMessage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.12),
        border: Border.all(
          color: colorScheme.primary.withValues(alpha: 0.22),
          width: 0.6,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: item.nickname,
                    style: TextStyle(
                      color: colorScheme.primary.withValues(alpha: 0.95),
                      fontWeight: FontWeight.w600,
                      fontSize: 12.5,
                      height: 1.2,
                    ),
                  ),
                  TextSpan(
                    text: ' ${item.text}',
                    style: TextStyle(
                      color: colorScheme.primary.withValues(alpha: 0.88),
                      fontSize: 12.5,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
