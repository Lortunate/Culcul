import 'package:culcul/ui/theme/culcul_tokens.dart';
import 'package:flutter/material.dart';

class ChatSystemMessage extends StatelessWidget {
  final String content;

  const ChatSystemMessage({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: CulculSpacing.md,
          vertical: CulculSpacing.xxs + CulculSpacing.xxs / 2,
        ),
        decoration: BoxDecoration(
          color: colorScheme.onSurfaceVariant.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(CulculRadius.lg),
        ),
        child: Text(
          content,
          style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
