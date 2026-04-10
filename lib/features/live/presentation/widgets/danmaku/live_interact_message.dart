import 'package:culcul/shared/theme/app_theme.dart';
import 'package:culcul/features/live/domain/entities/live_entities.dart';
import 'package:flutter/material.dart';

class LiveInteractMessage extends StatelessWidget {
  final LiveDanmakuItem item;

  const LiveInteractMessage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final semanticColors = context.semanticColors;

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: item.nickname,
            style: TextStyle(
              color: semanticColors.warning.withValues(alpha: 0.9),
              fontWeight: FontWeight.w600,
              fontSize: 12.5,
              height: 1.25,
            ),
          ),
          TextSpan(
            text: ' ${item.text}',
            style: TextStyle(
              color: colorScheme.onPrimary.withValues(alpha: 0.72),
              fontSize: 12.5,
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }
}
