import 'dart:async';
import 'dart:collection';

import 'package:culcul/features/live/application/models/live_history_danmaku_model.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_danmaku_feed_view_model.g.dart';

const int _maxDanmakuHistoryCount = 300;
const Duration _flushInterval = Duration(milliseconds: 33);

final class LiveDanmakuFeedState {
  const LiveDanmakuFeedState({
    this.items = const [],
    this.revision = 0,
    this.isEnabled = true,
    this.isConnected = false,
  });

  final List<LiveDanmakuItem> items;
  final int revision;
  final bool isEnabled;
  final bool isConnected;

  LiveDanmakuFeedState copyWith({
    List<LiveDanmakuItem>? items,
    int? revision,
    bool? isEnabled,
    bool? isConnected,
  }) {
    return LiveDanmakuFeedState(
      items: items ?? this.items,
      revision: revision ?? this.revision,
      isEnabled: isEnabled ?? this.isEnabled,
      isConnected: isConnected ?? this.isConnected,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is LiveDanmakuFeedState &&
            listEquals(other.items, items) &&
            other.revision == revision &&
            other.isEnabled == isEnabled &&
            other.isConnected == isConnected;
  }

  @override
  int get hashCode =>
      Object.hash(Object.hashAll(items), revision, isEnabled, isConnected);

  @override
  String toString() {
    return 'LiveDanmakuFeedState('
        'items: $items, '
        'revision: $revision, '
        'isEnabled: $isEnabled, '
        'isConnected: $isConnected'
        ')';
  }
}

@riverpod
class LiveDanmakuFeedController extends _$LiveDanmakuFeedController {
  final ListQueue<LiveDanmakuItem> _buffer = ListQueue<LiveDanmakuItem>();
  final List<LiveDanmakuItem> _pending = <LiveDanmakuItem>[];
  Timer? _flushTimer;

  @override
  LiveDanmakuFeedState build(int roomId) {
    ref.onDispose(() {
      _flushTimer?.cancel();
    });
    return const LiveDanmakuFeedState();
  }

  void clear() {
    _pending.clear();
    _buffer.clear();
    _flushTimer?.cancel();
    _flushTimer = null;
    _publish();
  }

  void seed(Iterable<LiveDanmakuItem> items) {
    _pending.clear();
    _buffer.clear();
    for (final item in items.take(_maxDanmakuHistoryCount)) {
      _buffer.addLast(item);
    }
    _publish();
  }

  void enqueue(LiveDanmakuItem item) {
    _pending.add(item);
    _scheduleFlush();
  }

  void enqueueMany(Iterable<LiveDanmakuItem> items) {
    _pending.addAll(items);
    _scheduleFlush();
  }

  void setConnected(bool connected) {
    if (state.isConnected == connected) return;
    state = state.copyWith(isConnected: connected);
  }

  void toggleEnabled() {
    state = state.copyWith(isEnabled: !state.isEnabled);
  }

  void _scheduleFlush() {
    if (_flushTimer != null) return;
    _flushTimer = Timer(_flushInterval, _flushPending);
  }

  void _flushPending() {
    _flushTimer?.cancel();
    _flushTimer = null;
    if (_pending.isEmpty) return;

    for (final item in _pending) {
      _buffer.addFirst(item);
      if (_buffer.length > _maxDanmakuHistoryCount) {
        _buffer.removeLast();
      }
    }
    _pending.clear();
    _publish();
  }

  void _publish() {
    state = state.copyWith(
      items: List<LiveDanmakuItem>.unmodifiable(_buffer),
      revision: state.revision + 1,
    );
  }
}
