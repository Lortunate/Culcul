import 'package:culcul/data/models/live/index.dart';
import 'package:flutter/material.dart';

class LiveGiftMessage extends StatelessWidget {
  final LiveDanmakuItem item;

  const LiveGiftMessage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.1),
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
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  TextSpan(
                    text: ' ${item.text}',
                    style: TextStyle(
                      color: colorScheme.primary,
                      fontSize: 13,
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
