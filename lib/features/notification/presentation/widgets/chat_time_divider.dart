import 'package:culcul/core/utils/format_extensions.dart';
import 'package:culcul/ui/theme/culcul_tokens.dart';
import 'package:flutter/material.dart';

class ChatTimeDivider extends StatelessWidget {
  final int timestamp;

  const ChatTimeDivider({super.key, required this.timestamp});

  @override
  Widget build(BuildContext context) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final timeStr = date.toChatTime();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: CulculSpacing.md),
      child: Text(
        timeStr,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
