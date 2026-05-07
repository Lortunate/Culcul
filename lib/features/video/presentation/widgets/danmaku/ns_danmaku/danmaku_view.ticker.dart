part of 'danmaku_view.dart';

extension _DanmakuViewStateTicker on _DanmakuViewState {
  void _onTick(Duration elapsed) {
    final currentMs = elapsed.inMilliseconds;
    if (_lastFrameTime == 0) {
      _lastFrameTime = currentMs;
      return;
    }
    final delta = currentMs - _lastFrameTime;
    _lastFrameTime = currentMs;

    if (!_isReady || _isIdle) {
      return;
    }

    _processWaitingItems();
    _updateScrollingItems(delta);
    _removeExpiredStaticItems(currentMs);

    if (!mounted) return;
    _requestRepaint();
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
    for (final item in _activeItems) {
      if (item.type == DanmakuItemType.scroll) {
        item.x -= item.velocity * delta;
      }
    }
    _sweepCounter++;
    if (_sweepCounter >= 60) {
      _sweepCounter = 0;
      _activeItems.removeWhere((item) {
        if (item.type == DanmakuItemType.scroll) {
          return item.x + item.width < 0;
        }
        return false;
      });
    }
  }

  void _removeExpiredStaticItems(int currentMs) {
    const staticDuration = 5000;

    if (_sweepCounter != 0) return;
    _activeItems.removeWhere((item) {
      if (item.type == DanmakuItemType.scroll) {
        return false;
      }

      return (currentMs - item.creationTime) > staticDuration;
    });
  }
}
