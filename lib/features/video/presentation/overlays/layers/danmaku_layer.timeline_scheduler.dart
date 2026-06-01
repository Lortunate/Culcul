part of 'danmaku_layer.dart';

void useDanmakuPlaybackScheduler({
  required WidgetRef ref,
  required Player? player,
  required bool isActive,
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
    maskPathNotifier.value.value = null;
    final activeAid = aid;
    final activePlayer = player;
    if (!isActive || activePlayer == null || activeAid == null || currentCid == 0) {
      return null;
    }

    var disposed = false;
    var lastSegmentLoadCheckMs = -_segmentLoadCheckIntervalMs;
    var lastMaskRefreshMs = -_maskRefreshIntervalMs;
    var lastSegmentIndex = 0;
    var lastMaskBucket = -1;
    Path? cachedMaskPath;

    void loadSegmentIfNeeded(int segmentIndex, int currentPosMs) {
      if (segmentIndex < 1) {
        return;
      }
      if (!timeline.tryMarkSegmentLoading(segmentIndex)) {
        return;
      }

      ref
          .read(danmakuRepositoryProvider)
          .fetchDanmakuSegment(
            oid: currentCid,
            pid: activeAid,
            segmentIndex: segmentIndex,
          )
          .then((result) {
            if (disposed) {
              return;
            }
            final segment = result.dataOrNull;
            if (segment == null) {
              timeline.markSegmentLoadFailed(segmentIndex);
              return;
            }
            final newItems = segment.entries.map((e) {
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
            if (disposed) {
              return;
            }
            timeline.markSegmentLoadFailed(segmentIndex);
            DevLogger.log('video', 'danmaku.segment_load_failed', <String, Object?>{
              'segment': segmentIndex,
              'error': e,
            });
          });
    }

    final subPosition = activePlayer.stream.position.listen((pos) {
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

      if (activePlayer.state.playing) {
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

    final subPlaying = activePlayer.stream.playing.listen((isPlaying) {
      if (isPlaying) {
        controllerRef.value?.resume();
      } else {
        controllerRef.value?.pause();
      }
    });

    return () {
      disposed = true;
      subPosition.cancel();
      subPlaying.cancel();
    };
  }, [currentCid, aid, isActive, player]);
}
