import 'package:flutter/material.dart';

class ChatSystemMessage extends StatelessWidget {
  final String content;

  const ChatSystemMessage({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            content,
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
