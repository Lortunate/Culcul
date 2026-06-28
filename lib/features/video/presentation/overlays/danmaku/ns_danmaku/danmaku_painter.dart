import 'package:flutter/material.dart';
import 'package:culcul/features/video/presentation/overlays/danmaku/ns_danmaku/danmaku_controller.dart';

class RenderDanmakuItem {
  final String id;
  final String text;
  final TextPainter textPainter;
  final TextPainter? strokePainter;
  final DanmakuItemType type;
  int creationTime;

  double x = 0;
  double y = 0;
  double width = 0;
  double height = 0;
  double velocity = 0;
  bool isMeasure = false;

  RenderDanmakuItem({
    required this.id,
    required this.text,
    required this.textPainter,
    this.strokePainter,
    required this.type,
    required this.creationTime,
  });

  void measure() {
    if (isMeasure) return;
    textPainter.layout();
    strokePainter?.layout();
    width = textPainter.width;
    height = textPainter.height;
    isMeasure = true;
  }
}

class DanmakuPainter extends CustomPainter {
  final List<RenderDanmakuItem> items;
  final double opacity;
  final Listenable? repaintSignal;

  DanmakuPainter({required this.items, required this.opacity, this.repaintSignal})
    : super(repaint: repaintSignal);

  @override
  void paint(Canvas canvas, Size size) {
    if (items.isEmpty) return;

    for (var item in items) {
      if (item.x > size.width || item.x + item.width < 0) continue;
      final offset = Offset(item.x, item.y);
      item.strokePainter?.paint(canvas, offset);
      item.textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(covariant DanmakuPainter oldDelegate) {
    return oldDelegate.opacity != opacity || oldDelegate.items != items;
  }
}
