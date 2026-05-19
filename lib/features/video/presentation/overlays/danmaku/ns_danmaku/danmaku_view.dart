import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:culcul/features/video/presentation/overlays/danmaku/ns_danmaku/danmaku_controller.dart';
import 'package:culcul/features/video/presentation/overlays/danmaku/ns_danmaku/danmaku_painter.dart';
import 'package:culcul/features/video/presentation/overlays/danmaku/ns_danmaku/models/danmaku_item.dart';
import 'package:culcul/features/video/presentation/overlays/danmaku/ns_danmaku/models/danmaku_option.dart';

part 'danmaku_view.layout.dart';
part 'danmaku_view.render.dart';
part 'danmaku_view.ticker.dart';

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
  int _sweepCounter = 0;
  final ValueNotifier<int> _repaintTick = ValueNotifier<int>(0);

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
    _repaintTick.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(DanmakuView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.option != oldWidget.option) {
      _updateOption(widget.option);
    }
  }

  void _updateOption(DanmakuOption option) {
    if (!mounted) return;
    _option = option;
    _requestRepaint();
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
    _requestRepaint();
  }

  void _requestRepaint() {
    _repaintTick.value++;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _viewWidth = constraints.maxWidth;
        _viewHeight = constraints.maxHeight;

        return RepaintBoundary(
          child: CustomPaint(
            painter: DanmakuPainter(
              items: _activeItems,
              opacity: _option.opacity,
              repaintSignal: _repaintTick,
            ),
            size: Size.infinite,
          ),
        );
      },
    );
  }
}
