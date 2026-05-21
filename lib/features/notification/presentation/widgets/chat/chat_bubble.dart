import 'package:culcul/ui/theme/culcul_tokens.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: CulculSpacing.sm, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: CulculRadius.radiusLg,
          topRight: CulculRadius.radiusLg,
          bottomLeft: isSelf ? CulculRadius.radiusLg : CulculRadius.radiusXs,
          bottomRight: isSelf ? CulculRadius.radiusXs : CulculRadius.radiusLg,
        ),
      ),
      child: child,
    );
  }
}
