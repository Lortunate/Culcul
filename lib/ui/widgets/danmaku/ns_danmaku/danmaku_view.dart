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

  final Map<int, RenderDanmakuItem> _scrollTracks = {};
  final Map<int, RenderDanmakuItem> _topTracks = {};
  final Map<int, RenderDanmakuItem> _bottomTracks = {};

  double _viewWidth = 0;
  double _viewHeight = 0;
  int _maxRows = 0;
  double _lineHeight = 0;

  int _lastFrameTime = 0;

  bool get _isReady => _viewWidth > 0 && _viewHeight > 0;

  bool get _isIdle => _activeItems.isEmpty && _waitingItems.isEmpty;

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
    _controller.dispose();
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
    final currentMs = elapsed.inMilliseconds;
    final delta = currentMs - _lastFrameTime;
    _lastFrameTime = currentMs;

    if (!_isReady || _isIdle) {
      return;
    }

    _processWaitingItems();
    _updateScrollingItems(delta);
    _removeExpiredStaticItems(currentMs);

    if (!mounted) return;
    setState(() {});
  }

  void _processWaitingItems() {
    if (_waitingItems.isEmpty) {
      return;
    }

    final waitingItems = List<RenderDanmakuItem>.from(_waitingItems);
    _waitingItems.clear();

    for (final item in waitingItems) {
      if (_layoutItem(item)) {
        _activeItems.add(item);
      }
    }
  }

  void _updateScrollingItems(int delta) {
    _activeItems.removeWhere((item) {
      if (item.type != DanmakuItemType.scroll) {
        return false;
      }

      item.x -= item.velocity * delta;
      return item.x + item.width < 0;
    });
  }

  void _removeExpiredStaticItems(int currentMs) {
    const staticDuration = 5000;

    _activeItems.removeWhere((item) {
      if (item.type == DanmakuItemType.scroll) {
        return false;
      }

      return (currentMs - item.creationTime) > staticDuration;
    });
  }

  void _addItems(List<DanmakuItem> items) {
    if (_viewWidth == 0) return;

    for (var item in items) {
      final renderItem = _createRenderItem(item);
      _waitingItems.add(renderItem);
    }
  }

  RenderDanmakuItem _createRenderItem(DanmakuItem item) {
    final fontSize = _option.fontSize;
    final color = item.color.withValues(alpha: item.color.a * _option.opacity);

    final strokePainter = _option.borderText
        ? _buildStrokePainter(item.text, fontSize)
        : null;
    final textPainter = _buildTextPainter(item.text, fontSize, color);
    final width = strokePainter?.width ?? textPainter.width;
    final distance = _viewWidth + width;
    final durationMs = _option.duration * 1000;
    final velocity = distance / durationMs;

    return RenderDanmakuItem(
        id: UniqueKey().toString(),
        text: item.text,
        textPainter: textPainter,
        strokePainter: strokePainter,
        type: item.type,
        creationTime: _lastFrameTime,
      )
      ..width = width
      ..height = textPainter.height
      ..velocity = velocity;
  }

  TextPainter _buildStrokePainter(String text, double fontSize) {
    return TextPainter(
      text: TextSpan(
        text: text,
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

  TextPainter _buildTextPainter(String text, double fontSize, Color color) {
    return TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: _option.fontWeight,
          fontFamily: 'PingFang SC',
          height: 1.1,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
  }

  bool _layoutItem(RenderDanmakuItem item) {
    _lineHeight = item.height * 1.1;
    _maxRows = (_viewHeight / _lineHeight).floor();

    if (_maxRows <= 0) return false;

    switch (item.type) {
      case DanmakuItemType.scroll:
        if (_option.hideScroll) return false;
        return _layoutScrollItem(item);
      case DanmakuItemType.top:
        if (_option.hideTop) return false;
        return _layoutTopItem(item);
      case DanmakuItemType.bottom:
        if (_option.hideBottom) return false;
        return _layoutBottomItem(item);
    }
  }

  bool _layoutScrollItem(RenderDanmakuItem item) {
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
        final spacing = 20.0;
        if (lastItem.x + lastItem.width + spacing < _viewWidth) {
          if (item.velocity <= lastItem.velocity) {
            canFit = true;
          } else {
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
        item.creationTime = _lastFrameTime;
        _scrollTracks[i] = item;
        return true;
      }
    }

    return false;
  }

  bool _layoutTopItem(RenderDanmakuItem item) {
    return _layoutStaticItem(
      item: item,
      tracks: _topTracks,
      rowToY: (row) => row * _lineHeight + (_lineHeight - item.height) / 2,
    );
  }

  bool _layoutBottomItem(RenderDanmakuItem item) {
    return _layoutStaticItem(
      item: item,
      tracks: _bottomTracks,
      rowToY: (row) =>
          _viewHeight - (row + 1) * _lineHeight + (_lineHeight - item.height) / 2,
    );
  }

  bool _layoutStaticItem({
    required RenderDanmakuItem item,
    required Map<int, RenderDanmakuItem> tracks,
    required double Function(int row) rowToY,
  }) {
    for (int i = 0; i < _maxRows; i++) {
      final lastItem = tracks[i];
      final isFree = lastItem == null || !_activeItems.contains(lastItem);

      if (isFree) {
        item.x = (_viewWidth - item.width) / 2;
        item.y = rowToY(i);
        item.creationTime = _lastFrameTime;
        tracks[i] = item;
        return true;
      }
    }
    return false;
  }

  void _updateOption(DanmakuOption option) {
    if (!mounted) return;
    setState(() {
      _option = option;
    });
  }

  void _pause() {
    _ticker.stop();
    widget.statusChanged?.call(false);
  }

  void _resume() {
    if (!_ticker.isActive) {
      _lastFrameTime = 0;
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
    if (!mounted) return;
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
