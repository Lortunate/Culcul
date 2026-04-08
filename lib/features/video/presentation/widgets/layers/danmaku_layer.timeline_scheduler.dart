part of 'danmaku_layer.dart';

void useDanmakuPlaybackScheduler({
  required WidgetRef ref,
  required dynamic player,
  required int currentCid,
  required int? aid,
  required ObjectRef<DanmakuController?> controllerRef,
  required ObjectRef<DanmakuTimelineBuffer> timelineRef,
  required ObjectRef<DanmakuSettings> settingsRef,
  required ObjectRef<AsyncValue<Result<DanmakuMasks?, dynamic>>> maskResultRef,
  required ObjectRef<ValueNotifier<Path?>> maskPathNotifier,
}) {
  useEffect(() {
    final timeline = timelineRef.value;
    timeline.reset();
    controllerRef.value?.clear();
    var lastSegmentLoadCheckMs = -_segmentLoadCheckIntervalMs;
    var lastMaskRefreshMs = -_maskRefreshIntervalMs;
    var lastSegmentIndex = 0;
    var lastMaskBucket = -1;
    Path? cachedMaskPath;

    void loadSegmentIfNeeded(int segmentIndex, int currentPosMs) {
      if (segmentIndex < 1 || aid == null || currentCid == 0) {
        return;
      }
      if (!timeline.tryMarkSegmentLoading(segmentIndex)) {
        return;
      }

      ref
          .read(danmakuProviderProvider.notifier)
          .loadSegment(oid: currentCid, pid: aid, segmentIndex: segmentIndex)
          .then((result) {
            final elems = result.dataOrNull;
            if (elems == null) {
              timeline.markSegmentLoadFailed(segmentIndex);
              return;
            }
            final newItems = elems.map((e) {
              return DanmakuItem(
                e.content,
                time: e.progress,
                color: _toOpaqueDanmakuColor(e.color),
                type: _toDanmakuItemType(e.mode),
              );
            }).toList();
            timeline.appendItems(newItems, currentPosMs);
          })
          .catchError((e) {
            timeline.markSegmentLoadFailed(segmentIndex);
            debugPrint('Failed to load danmaku segment $segmentIndex: $e');
          });
    }

    final subPosition = player.stream.position.listen((pos) {
      final currentPosMs = pos.inMilliseconds;
      final segmentIndex = (currentPosMs / _segmentDurationMs).ceil();
      final index = segmentIndex < 1 ? 1 : segmentIndex;
      final hasLargeJump = timeline.hasLargeJump(currentPosMs);

      final shouldCheckSegmentLoad =
          hasLargeJump ||
          index != lastSegmentIndex ||
          (currentPosMs - lastSegmentLoadCheckMs) >= _segmentLoadCheckIntervalMs;
      if (shouldCheckSegmentLoad) {
        lastSegmentLoadCheckMs = currentPosMs;
        lastSegmentIndex = index;
        loadSegmentIfNeeded(index, currentPosMs);
        loadSegmentIfNeeded(index + _prefetchSegmentOffset, currentPosMs);
      }

      if (hasLargeJump) {
        controllerRef.value?.clear();
        timeline.seek(currentPosMs);
      }

      if (player.state.playing) {
        final itemsToAdd = timeline.collectDueItems(currentPosMs);
        if (itemsToAdd.isNotEmpty) {
          controllerRef.value?.addItems(itemsToAdd);
        }
      }

      final shouldRefreshMask =
          hasLargeJump || (currentPosMs - lastMaskRefreshMs) >= _maskRefreshIntervalMs;
      if (shouldRefreshMask) {
        lastMaskRefreshMs = currentPosMs;
        final activeSettings = settingsRef.value;
        final activeMaskResult = maskResultRef.value;
        Path? nextMaskPath;
        if (activeSettings.enableAiMask) {
          final maskBucket = currentPosMs ~/ _maskRefreshIntervalMs;
          if (!hasLargeJump && maskBucket == lastMaskBucket) {
            nextMaskPath = cachedMaskPath;
          } else {
            lastMaskBucket = maskBucket;
            nextMaskPath = _resolveMaskPath(
              settings: activeSettings,
              maskResultProvider: activeMaskResult,
              currentPosMs: currentPosMs,
            );
            cachedMaskPath = nextMaskPath;
          }
        } else {
          lastMaskBucket = -1;
          cachedMaskPath = null;
          nextMaskPath = null;
        }
        if (nextMaskPath != maskPathNotifier.value.value) {
          maskPathNotifier.value.value = nextMaskPath;
        }
      }

      timeline.updateLastPosition(currentPosMs);
    });

    final subPlaying = player.stream.playing.listen((isPlaying) {
      if (isPlaying) {
        controllerRef.value?.resume();
      } else {
        controllerRef.value?.pause();
      }
    });

    return () {
      subPosition.cancel();
      subPlaying.cancel();
    };
  }, [currentCid, aid]);
}

class DanmakuTimelineBuffer {
  static const int _seekToleranceMs = 1500;
  static const int _emitWindowMs = 3000;
  static const int _maxItemsPerTick = 50;

  final Set<int> _loadedSegments = <int>{};
  final List<DanmakuItem> _items = <DanmakuItem>[];

  int _cursor = 0;
  int _lastPosition = 0;

  void reset() {
    _loadedSegments.clear();
    _items.clear();
    _cursor = 0;
    _lastPosition = 0;
  }

  bool tryMarkSegmentLoading(int segmentIndex) {
    return _loadedSegments.add(segmentIndex);
  }

  void markSegmentLoadFailed(int segmentIndex) {
    _loadedSegments.remove(segmentIndex);
  }

  void appendItems(List<DanmakuItem> newItems, int currentPosMs) {
    if (newItems.isEmpty) return;
    final sortedNewItems = List<DanmakuItem>.from(newItems)
      ..sort((a, b) => a.time.compareTo(b.time));
    if (_items.isEmpty) {
      _items.addAll(sortedNewItems);
      _cursor = _findCursor(currentPosMs);
      return;
    }

    final lastExistingTime = _items.last.time;
    if (sortedNewItems.first.time >= lastExistingTime) {
      _items.addAll(sortedNewItems);
      _cursor = _findCursor(currentPosMs);
      return;
    }

    final mergeStart = _lowerBoundByTime(sortedNewItems.first.time);
    final existingTail = _items.sublist(mergeStart);
    final mergedTail = <DanmakuItem>[];
    var existingIndex = 0;
    var incomingIndex = 0;

    while (existingIndex < existingTail.length && incomingIndex < sortedNewItems.length) {
      final existingItem = existingTail[existingIndex];
      final incomingItem = sortedNewItems[incomingIndex];
      if (incomingItem.time <= existingItem.time) {
        mergedTail.add(incomingItem);
        incomingIndex++;
      } else {
        mergedTail.add(existingItem);
        existingIndex++;
      }
    }
    if (incomingIndex < sortedNewItems.length) {
      mergedTail.addAll(sortedNewItems.sublist(incomingIndex));
    }
    if (existingIndex < existingTail.length) {
      mergedTail.addAll(existingTail.sublist(existingIndex));
    }

    _items
      ..removeRange(mergeStart, _items.length)
      ..addAll(mergedTail);
    _cursor = _findCursor(currentPosMs);
  }

  bool hasLargeJump(int currentPosMs) {
    return (currentPosMs - _lastPosition).abs() > _seekToleranceMs;
  }

  void seek(int currentPosMs) {
    _cursor = _findCursor(currentPosMs);
  }

  List<DanmakuItem> collectDueItems(int currentPosMs) {
    final itemsToAdd = <DanmakuItem>[];
    var processed = 0;

    while (_cursor < _items.length && processed < _maxItemsPerTick) {
      final item = _items[_cursor];
      if (item.time > currentPosMs) break;

      if (currentPosMs - item.time < _emitWindowMs) {
        itemsToAdd.add(item);
      }
      _cursor++;
      processed++;
    }
    return itemsToAdd;
  }

  void updateLastPosition(int currentPosMs) {
    _lastPosition = currentPosMs;
  }

  int _findCursor(int targetTime) {
    return _lowerBoundByTime(targetTime);
  }

  int _lowerBoundByTime(int targetTime) {
    var left = 0;
    var right = _items.length;
    while (left < right) {
      final mid = left + ((right - left) >> 1);
      if (_items[mid].time < targetTime) {
        left = mid + 1;
      } else {
        right = mid;
      }
    }
    return left;
  }
}
