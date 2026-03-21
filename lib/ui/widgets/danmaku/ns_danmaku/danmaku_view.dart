import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'danmaku_controller.dart';
import 'danmaku_painter.dart';
import 'models/danmaku_item.dart';
import 'models/danmaku_option.dart';

class DanmakuView extends StatefulWidget {
  final Function(DanmakuController) createdController;
  final DanmakuOption option;
  final Function(bool)? statusChanged;

  const DanmakuView({
    required this.createdController,
    required this.option,
    this.statusChanged,
    super.key,
  });

  @override
  State<DanmakuView> createState() => _DanmakuViewState();
}

class _DanmakuViewState extends State<DanmakuView> with SingleTickerProviderStateMixin {
  late DanmakuController _controller;
  late Ticker _ticker;
  late DanmakuOption _option;

  final List<RenderDanmakuItem> _activeItems = [];
  final List<RenderDanmakuItem> _waitingItems = [];

  // Track management
  // Stores the last item added to each track
  final Map<int, RenderDanmakuItem> _scrollTracks = {};
  final Map<int, RenderDanmakuItem> _topTracks = {};
  final Map<int, RenderDanmakuItem> _bottomTracks = {};

  double _viewWidth = 0;
  double _viewHeight = 0;
  int _maxRows = 0;
  double _lineHeight = 0;

  // Performance metrics
  int _lastFrameTime = 0;

  @override
  void initState() {
    super.initState();
    _option = widget.option;

    _controller = DanmakuController(
      onAddItems: _addItems,
      onUpdateOption: _updateOption,
      onPause: _pause,
      onResume: _resume,
      onClear: _clear,
    );

    _ticker = createTicker(_onTick);

    widget.createdController(_controller);
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(DanmakuView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.option != oldWidget.option) {
      _updateOption(widget.option);
    }
  }

  void _onTick(Duration elapsed) {
    final int currentMs = elapsed.inMilliseconds;
    final int delta = currentMs - _lastFrameTime;
    _lastFrameTime = currentMs;

    if (_viewWidth == 0 || _viewHeight == 0) return;

    // Optimization: Skip processing if idle
    if (_activeItems.isEmpty && _waitingItems.isEmpty) {
      return;
    }

    // 1. Process waiting items
    if (_waitingItems.isNotEmpty) {
      final List<RenderDanmakuItem> failed = [];
      for (var item in _waitingItems) {
        if (!_layoutItem(item)) {
          // If it's too old, discard? Or keep trying?
          // For now, discard if older than 500ms to avoid backlog
          // But here 'creationTime' is when it was added to view.
          // Let's just try next frame.
          failed.add(item);
        } else {
          _activeItems.add(item);
        }
      }
      _waitingItems.clear();
      if (failed.isNotEmpty) {
        // Only keep recent ones
        // _waitingItems.addAll(failed);
        // Discarding failed items to prevent memory leak and lag is safer for performance
      }
    }

    // 2. Update active items
    _activeItems.removeWhere((item) {
      // Update position
      if (item.type == DanmakuItemType.scroll) {
        item.x -= item.velocity * delta;
        return item.x + item.width < 0; // Remove if off-screen
      } else {
        // Top/Bottom: Check duration
        // Simple duration check:
        // We can use a 'remainingTime' field or check creationTime against current runtime?
        // Since we don't track absolute time, let's use a countdown or similar.
        // Actually, let's assume fixed duration for static items (e.g. 4s)
        // We need to track how long it's been alive.
        // Let's add 'elapsedTime' to RenderDanmakuItem?
        // Or just use velocity=0 and manage 'life'.
        // Let's use x as a timer for static items? No, that's hacky.
        // I'll add 'life' to RenderDanmakuItem in painter if needed, but for now:
        // Let's check item creation vs now? Ticker elapsed is monotonous.
        // But items are added at different Ticker times.
        // I need to store 'startTime' relative to Ticker.

        // Wait, RenderDanmakuItem has 'creationTime'.
        // But that was 'ms'. Ticker is also 'ms'.
        // So:
        // if (currentMs - item.startTime > duration) remove.
        // But 'creationTime' in my previous code was just passed from DanmakuItem.time?
        // No, I should set 'startTime' when layout happens using Ticker time.
      }
      return false;
    });

    // For static items removal:
    final staticDuration = 5000; // 5s
    _activeItems.removeWhere((item) {
      if (item.type != DanmakuItemType.scroll) {
        // We need to store when it started showing.
        // I'll misuse 'x' or add a field.
        // Let's rely on a new field in RenderDanmakuItem later?
        // For now, let's assume I can cast or extend.
        // I'll use a map for start times or just add it to RenderDanmakuItem.
        // Let's modify RenderDanmakuItem in a bit.
        // For now, hack: creationTime is used as start time (if I set it to currentMs)
        return (currentMs - item.creationTime) > staticDuration;
      }
      return false;
    });

    setState(() {}); // Trigger repaint
  }

  void _addItems(List<DanmakuItem> items) {
    if (_viewWidth == 0) return; // Not ready

    for (var item in items) {
      final renderItem = _createRenderItem(item);
      _waitingItems.add(renderItem);
    }
  }

  RenderDanmakuItem _createRenderItem(DanmakuItem item) {
    // Style preparation
    final fontSize = _option.fontSize;
    final color = item.color.withValues(alpha: item.color.a * _option.opacity);

    TextPainter? strokePainter;
    if (_option.borderText) {
      strokePainter = TextPainter(
        text: TextSpan(
          text: item.text,
          style: TextStyle(
            fontSize: fontSize,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = _option.strokeWidth
              ..color = Colors.black,
            fontWeight: _option.fontWeight,
            fontFamily: 'PingFang SC',
            height: 1.1,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
    }

    final textSpan = TextSpan(
      text: item.text,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: _option.fontWeight,
        fontFamily: 'PingFang SC',
        height: 1.1, // Tighter line height
      ),
    );

    final textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr)
      ..layout();

    // Velocity calculation
    // Distance = Screen Width + Text Width
    // Time = Duration
    // V = D / T
    final width = strokePainter?.width ?? textPainter.width;
    final distance = _viewWidth + width;
    final durationMs = _option.duration * 1000;
    final velocity = distance / durationMs; // pixels / ms

    return RenderDanmakuItem(
        id: UniqueKey().toString(),
        text: item.text,
        textPainter: textPainter,
        strokePainter: strokePainter,
        type: item.type,
        creationTime: _lastFrameTime, // Will be updated on layout
      )
      ..width = width
      ..height = textPainter.height
      ..velocity = velocity;
  }

  bool _layoutItem(RenderDanmakuItem item) {
    // Determine track height
    _lineHeight = item.height * 1.1; // Add some padding
    _maxRows = (_viewHeight / _lineHeight).floor();

    if (_maxRows <= 0) return false;

    if (item.type == DanmakuItemType.scroll) {
      if (_option.hideScroll) return false;
      return _layoutScrollItem(item);
    } else if (item.type == DanmakuItemType.top) {
      if (_option.hideTop) return false;
      return _layoutTopItem(item);
    } else if (item.type == DanmakuItemType.bottom) {
      if (_option.hideBottom) return false;
      return _layoutBottomItem(item);
    }
    return false;
  }

  bool _layoutScrollItem(RenderDanmakuItem item) {
    // Simple strategy: Find first available track
    // Or random? Sequential is better for reading.

    // Available area check
    int startRow = 0;
    int endRow = _maxRows;

    if (_option.area < 1.0) {
      endRow = (_maxRows * _option.area).floor();
    }

    for (int i = startRow; i < endRow; i++) {
      final lastItem = _scrollTracks[i];

      bool canFit = false;
      if (lastItem == null) {
        canFit = true;
      } else {
        // Check 1: Space condition
        // The last item must have moved enough to fit the new item
        // lastItem.x + lastItem.width + spacing < _viewWidth
        // Since we are in 'layout', lastItem.x is current position.
        // Wait, lastItem.x is changing every tick.
        // We need to access the *current* x of lastItem.
        // The item object is the same reference in _activeItems.

        final spacing = 20.0; // minimum gap
        if (lastItem.x + lastItem.width + spacing < _viewWidth) {
          // Check 2: Speed condition (avoid catching up)
          // If new item is faster, it might catch up.
          // Time for last item to leave screen: t1 = (lastItem.x + lastItem.width) / lastItem.velocity (assuming x is distance to left edge... wait, x is position)
          // Remaining distance for last item: d1 = _viewWidth - lastItem.x (No, it moves left. x goes from Width to -Width)
          // So lastItem is at x. It needs to travel (x + width) pixels to disappear? No.
          // It disappears when x + width < 0.
          // Distance to finish: x + width.

          // Time for new item to reach end:
          // New item starts at _viewWidth.
          // It needs to travel (_viewWidth + item.width) to finish.

          // Collision check:
          // Will they collide before lastItem finishes?
          // Detailed math omitted for simplicity, implementing simplified check:
          // If new item is slower or same speed, no catch up (since it starts behind).
          // If new item is faster, check if it catches up before lastItem exits.

          if (item.velocity <= lastItem.velocity) {
            canFit = true;
          } else {
            // Calculate catch up time
            // Relative velocity: v_rel = v_new - v_old
            // Initial distance gap: gap = _viewWidth - (lastItem.x + lastItem.width)
            // Time to close gap: t_catch = gap / v_rel

            // Time for last item to exit: t_exit = (lastItem.x + lastItem.width) / lastItem.velocity
            // If t_catch > t_exit, then it's safe (catches up after exit)

            final gap = _viewWidth - (lastItem.x + lastItem.width);
            final vRel = item.velocity - lastItem.velocity;
            final tCatch = gap / vRel;
            final tExit = (lastItem.x + lastItem.width) / lastItem.velocity;

            if (tCatch > tExit) {
              canFit = true;
            }
          }
        }
      }

      if (canFit) {
        item.x = _viewWidth;
        item.y = i * _lineHeight + (_lineHeight - item.height) / 2;
        item.creationTime = _lastFrameTime; // Reset creation time to now
        _scrollTracks[i] = item;
        return true;
      }
    }

    return false;
  }

  bool _layoutTopItem(RenderDanmakuItem item) {
    for (int i = 0; i < _maxRows; i++) {
      final lastItem = _topTracks[i];
      bool isFree = false;
      if (lastItem == null) {
        isFree = true;
      } else {
        // Check if last item is gone or expired?
        // For static items, we just check if the slot is occupied.
        // But we remove them from _topTracks when they expire?
        // Better: check if lastItem is still in _activeItems.
        if (!_activeItems.contains(lastItem)) {
          isFree = true;
        }
      }

      if (isFree) {
        item.x = (_viewWidth - item.width) / 2;
        item.y = i * _lineHeight + (_lineHeight - item.height) / 2;
        item.creationTime = _lastFrameTime;
        _topTracks[i] = item;
        return true;
      }
    }
    return false;
  }

  bool _layoutBottomItem(RenderDanmakuItem item) {
    for (int i = 0; i < _maxRows; i++) {
      final lastItem = _bottomTracks[i];
      bool isFree = false;
      if (lastItem == null) {
        isFree = true;
      } else {
        if (!_activeItems.contains(lastItem)) {
          isFree = true;
        }
      }

      if (isFree) {
        item.x = (_viewWidth - item.width) / 2;
        item.y =
            _viewHeight -
            (i + 1) * _lineHeight +
            (_lineHeight - item.height) / 2; // From bottom
        item.creationTime = _lastFrameTime;
        _bottomTracks[i] = item;
        return true;
      }
    }
    return false;
  }

  void _updateOption(DanmakuOption option) {
    setState(() {
      _option = option;
      // Recalculate styles for waiting items?
      // Existing active items will keep their style (performance tradeoff)
    });
  }

  void _pause() {
    _ticker.stop();
    widget.statusChanged?.call(false);
  }

  void _resume() {
    if (!_ticker.isActive) {
      _lastFrameTime = 0; // Reset delta
      _ticker.start();
      widget.statusChanged?.call(true);
    }
  }

  void _clear() {
    _activeItems.clear();
    _waitingItems.clear();
    _scrollTracks.clear();
    _topTracks.clear();
    _bottomTracks.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _viewWidth = constraints.maxWidth;
        _viewHeight = constraints.maxHeight;

        return RepaintBoundary(
          child: CustomPaint(
            painter: DanmakuPainter(items: _activeItems, opacity: _option.opacity),
            size: Size.infinite,
          ),
        );
      },
    );
  }
}
