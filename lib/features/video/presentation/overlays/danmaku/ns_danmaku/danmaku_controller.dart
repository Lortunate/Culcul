import 'package:culcul/features/video/presentation/overlays/danmaku/ns_danmaku/models/danmaku_option.dart';
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

class DanmakuController {
  final void Function(List<DanmakuItem>) onAddItems;
  final void Function(DanmakuOption) onUpdateOption;
  final void Function() onPause;
  final void Function() onResume;
  final void Function() onClear;
  DanmakuController({
    required this.onAddItems,
    required this.onUpdateOption,
    required this.onPause,
    required this.onResume,
    required this.onClear,
  });

  bool _disposed = false;

  void dispose() {
    _disposed = true;
  }

  void pause() {
    if (_disposed) return;
    onPause.call();
  }

  void resume() {
    if (_disposed) return;
    onResume.call();
  }

  void clear() {
    if (_disposed) return;
    onClear.call();
  }

  void addItems(List<DanmakuItem> items) {
    if (_disposed) return;
    onAddItems.call(items);
  }

  void updateOption(DanmakuOption option) {
    if (_disposed) return;
    onUpdateOption.call(option);
  }
}
