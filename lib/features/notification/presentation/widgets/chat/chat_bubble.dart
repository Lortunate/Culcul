import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final Widget child;
  final bool isSelf;
  final Color color;

  const ChatBubble({
    super.key,
    required this.child,
    required this.isSelf,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(16),
          topRight: const Radius.circular(16),
          bottomLeft: Radius.circular(isSelf ? 16 : 4),
          bottomRight: Radius.circular(isSelf ? 4 : 16),
        ),
      ),
      child: child,
    );
  }
}

