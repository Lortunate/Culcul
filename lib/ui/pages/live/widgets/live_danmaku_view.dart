import 'package:culcul/data/models/live/index.dart';
import 'package:flutter/material.dart';

class LiveDanmakuView extends StatelessWidget {
  final List<LiveDanmakuItem> history;

  const LiveDanmakuView({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      reverse: true, // Show newest at bottom usually, but history is list. 
      // If history is chronological, we might want reverse=false or scroll to bottom.
      // Usually chat starts from bottom.
      itemCount: history.length,
      itemBuilder: (context, index) {
        // history is likely newest first or oldest first? 
        // Let's assume API returns sorted by time.
        final item = history[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 14, color: Colors.black),
              children: [
                TextSpan(
                  text: '${item.nickname}: ',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: item.text,
                  style: const TextStyle(
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
