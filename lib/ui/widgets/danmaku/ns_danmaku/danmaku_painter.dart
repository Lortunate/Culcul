import 'package:flutter/material.dart';
import 'models/danmaku_item.dart';

class RenderDanmakuItem {
  final String id;
  final String text;
  final TextPainter textPainter;
  final DanmakuItemType type;
  int creationTime; // ms

  double x = 0;
  double y = 0;
  double width = 0;
  double height = 0;
  double velocity = 0; // pixels per ms
  bool isMeasure = false;

  RenderDanmakuItem({
    required this.id,
    required this.text,
    required this.textPainter,
    required this.type,
    required this.creationTime,
  });

  void measure() {
    if (isMeasure) return;
    textPainter.layout();
    width = textPainter.width;
    height = textPainter.height;
    isMeasure = true;
  }
}

class DanmakuPainter extends CustomPainter {
  final List<RenderDanmakuItem> items;
  final double opacity;

  DanmakuPainter({required this.items, required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    if (items.isEmpty) return;

    for (var item in items) {
      // Skip if off-screen (though controller should handle this)
      if (item.x > size.width || item.x + item.width < 0) continue;

      item.textPainter.paint(canvas, Offset(item.x, item.y));
    }
  }

  @override
  bool shouldRepaint(covariant DanmakuPainter oldDelegate) {
    return true; // Always repaint as positions change every frame
  }
}
