import 'package:flutter/material.dart';
import 'package:culcul/ui/theme/culcul_colors.dart';

class AppOverlayTag extends StatelessWidget {
  final String text;

  const AppOverlayTag({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final semanticColors = context.semanticColors;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: semanticColors.overlayBackground,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: semanticColors.overlayBorder, width: 0.5),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: semanticColors.overlayForeground,
          fontSize: 10,
          fontWeight: FontWeight.w500,
          height: 1,
        ),
      ),
    );
  }
}
