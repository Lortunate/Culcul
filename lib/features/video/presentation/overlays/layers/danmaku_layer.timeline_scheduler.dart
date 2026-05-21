part of 'danmaku_layer.dart';

void useDanmakuPlaybackScheduler({
  required WidgetRef ref,
  required Player player,
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
            DevLogger.log('video', 'danmaku.segment_load_failed', <String, Object?>{
              'segment': segmentIndex,
              'error': e,
            });
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
