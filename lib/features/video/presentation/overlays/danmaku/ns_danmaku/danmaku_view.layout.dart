part of 'danmaku_view.dart';

extension _DanmakuViewStateLayout on _DanmakuViewState {
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
    var endRow = _maxRows;
    if (_option.area < 1.0) {
      endRow = (_maxRows * _option.area).floor();
    }

    for (var i = 0; i < endRow; i++) {
      final lastItem = _scrollTracks[i];
      var canFit = false;
      if (lastItem == null) {
        canFit = true;
      } else {
        const spacing = 20.0;
        if (lastItem.x + lastItem.width + spacing < _viewWidth) {
          if (item.velocity <= lastItem.velocity) {
            canFit = true;
          } else {
            final gap = _viewWidth - (lastItem.x + lastItem.width);
            final relativeVelocity = item.velocity - lastItem.velocity;
            final catchUpTime = gap / relativeVelocity;
            final exitTime = (lastItem.x + lastItem.width) / lastItem.velocity;
            if (catchUpTime > exitTime) {
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
    for (var i = 0; i < _maxRows; i++) {
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
}
