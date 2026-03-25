import 'package:flutter/material.dart';

enum DanmakuItemType { scroll, top, bottom }

class DanmakuItem {
  final String text;
  final Color color;
  final int time;
  final DanmakuItemType type;

  const DanmakuItem(
    this.text, {
    this.color = const Color.fromARGB(255, 255, 255, 255),
    this.time = 0,
    this.type = DanmakuItemType.scroll,
  });
}

