import 'package:flutter/material.dart';

class ChatTimeDivider extends StatelessWidget {
  final int timestamp;

  const ChatTimeDivider({super.key, required this.timestamp});

  @override
  Widget build(BuildContext context) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final now = DateTime.now();
    String timeStr;

    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      timeStr =
          '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (date.year == now.year) {
      timeStr =
          '${date.month}月${date.day}日 ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else {
      timeStr = '${date.year}年${date.month}月${date.day}日';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        timeStr,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
