import 'package:culcul/data/models/live/index.dart';
import 'package:flutter/material.dart';

class LiveInteractMessage extends StatelessWidget {
  final LiveDanmakuItem item;

  const LiveInteractMessage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: item.nickname,
              style: const TextStyle(
                color: Color(0xFFFFB74D), // Orange for username
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
            TextSpan(
              text: ' ${item.text}',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
