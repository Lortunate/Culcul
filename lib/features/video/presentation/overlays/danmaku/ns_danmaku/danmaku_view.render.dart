part of 'danmaku_view.dart';

int _danmakuIdCounter = 0;

extension _DanmakuViewStateRender on _DanmakuViewState {
  void _addItems(List<DanmakuItem> items) {
    if (_viewWidth == 0) return;

    for (final item in items) {
      final renderItem = _createRenderItem(item);
      _waitingItems.add(renderItem);
    }
  }

  RenderDanmakuItem _createRenderItem(DanmakuItem item) {
    final fontSize = _option.fontSize;
    final color = item.color.withValues(alpha: item.color.a * _option.opacity);

    final strokePainter = _option.borderText
        ? (TextPainter(
            text: TextSpan(
              text: item.text,
              style: TextStyle(
                fontSize: fontSize,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = _option.strokeWidth
                  ..color = const Color.fromARGB(255, 0, 0, 0),
                fontWeight: _option.fontWeight,
                fontFamily: 'PingFang SC',
                height: 1.1,
              ),
            ),
            textDirection: TextDirection.ltr,
          )..layout())
        : null;
    final textPainter = TextPainter(
      text: TextSpan(
        text: item.text,
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
    final width = strokePainter?.width ?? textPainter.width;
    final distance = _viewWidth + width;
    final durationMs = _option.duration * 1000;
    final velocity = distance / durationMs;

    return RenderDanmakuItem(
        id: '${_danmakuIdCounter++}',
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
}
