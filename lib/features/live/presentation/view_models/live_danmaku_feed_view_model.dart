import 'dart:async';
import 'dart:collection';

import 'package:culcul/features/live/domain/entities/live_entities.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_danmaku_feed_view_model.freezed.dart';
part 'live_danmaku_feed_view_model.g.dart';

const int _maxDanmakuHistoryCount = 300;
const Duration _flushInterval = Duration(milliseconds: 33);

@freezed
sealed class LiveDanmakuFeedState with _$LiveDanmakuFeedState {
  const factory LiveDanmakuFeedState({
    @Default([]) List<LiveDanmakuItem> items,
    @Default(0) int revision,
    @Default(true) bool isEnabled,
    @Default(false) bool isConnected,
  }) = _LiveDanmakuFeedState;
}

@riverpod
LiveDanmakuFeedState liveDanmakuFeed(Ref ref, int roomId) {
  return ref.watch(liveDanmakuFeedControllerProvider(roomId));
}

@Riverpod(keepAlive: true)
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
