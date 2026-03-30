import 'package:culcul/features/video/presentation/view_model/danmaku_view_model.dart';
import 'package:culcul/features/video/presentation/view_model/danmaku_settings_view_model.dart';
import 'package:culcul/features/video/providers/danmaku_mask_provider.dart';
import 'package:culcul/features/video/presentation/view_model/player_view_model.dart';
import 'package:culcul/features/video/presentation/view_model/video_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:culcul/ui/widgets/danmaku/ns_danmaku/danmaku_controller.dart';
import 'package:culcul/ui/widgets/danmaku/ns_danmaku/danmaku_view.dart';
import 'package:culcul/ui/widgets/danmaku/ns_danmaku/models/danmaku_item.dart';
import 'package:culcul/ui/widgets/danmaku/ns_danmaku/models/danmaku_option.dart';

const int _segmentDurationMs = 360000;

class DanmakuLayer extends HookConsumerWidget {
  final String bvid;

  const DanmakuLayer({super.key, required this.bvid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllerRef = useRef<DanmakuController?>(null);
    final currentCid = ref.watch(
      videoDetailControllerProvider(bvid).select((s) => s.currentCid),
    );
    final aid = ref.watch(
      videoDetailControllerProvider(bvid).select((s) => s.videoDetail?.aid),
    );
    final videoDimension = ref.watch(
      videoDetailControllerProvider(bvid).select((s) => s.videoDetail?.dimension),
    );

    final settings = ref.watch(danmakuSettingsControllerProvider);
    final maskProvider = ref.watch(danmakuMaskProvider(oid: currentCid, pid: aid ?? 0));
    final danmakuOption = _buildDanmakuOption(settings);

    final player = ref.read(playerControllerProvider.notifier).player;

    final timelineRef = useRef<_DanmakuTimelineBuffer>(_DanmakuTimelineBuffer());
    final maskPathNotifier = useRef<ValueNotifier<Path?>>(ValueNotifier(null));

    useEffect(() {
      final timeline = timelineRef.value;
      timeline.reset();
      controllerRef.value?.clear();

      final subPosition = player.stream.position.listen((pos) {
        final currentPosMs = pos.inMilliseconds;
        final segmentIndex = (currentPosMs / _segmentDurationMs).ceil();
        final index = segmentIndex < 1 ? 1 : segmentIndex;

        if (aid != null && currentCid != 0 && timeline.tryMarkSegmentLoading(index)) {
          ref
              .read(danmakuProviderProvider.notifier)
              .loadSegment(oid: currentCid, pid: aid, segmentIndex: index)
              .then((elems) {
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
                timeline.markSegmentLoadFailed(index);
                debugPrint('Failed to load danmaku segment $index: $e');
              });
        }

        if (timeline.hasLargeJump(currentPosMs)) {
          controllerRef.value?.clear();
          timeline.seek(currentPosMs);
        }

        if (player.state.playing) {
          final itemsToAdd = timeline.collectDueItems(currentPosMs);

          if (itemsToAdd.isNotEmpty) {
            controllerRef.value?.addItems(itemsToAdd);
          }
        }

        final nextMaskPath = _resolveMaskPath(
          settings: settings,
          maskProvider: maskProvider,
          currentPosMs: currentPosMs,
        );
        if (nextMaskPath != maskPathNotifier.value.value) {
          maskPathNotifier.value.value = nextMaskPath;
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

    useEffect(() {
      final controller = controllerRef.value;
      if (controller == null || !settings.isEnabled) return;

      controller.updateOption(danmakuOption);
      return null;
    }, [settings]);

    if (!settings.isEnabled) {
      controllerRef.value = null;
      return const SizedBox();
    }

    return RepaintBoundary(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ValueListenableBuilder<Path?>(
            valueListenable: maskPathNotifier.value,
            builder: (context, maskPath, child) {
              if (maskPath == null) return child!;
              return ClipPath(
                clipper: DanmakuMaskClipper(
                  maskPath: maskPath,
                  videoSize: Size(
                    (videoDimension?.width ?? 1920).toDouble(),
                    (videoDimension?.height ?? 1080).toDouble(),
                  ),
                ),
                child: child,
              );
            },
            child: DanmakuView(
              createdController: (controller) {
                controllerRef.value = controller;
                if (player.state.playing) controller.resume();
              },
              option: danmakuOption,
            ),
          );
        },
      ),
    );
  }
}

DanmakuOption _buildDanmakuOption(DanmakuSettings settings) {
  return DanmakuOption(
    opacity: settings.opacity,
    area: settings.area,
    fontSize: 15 * settings.fontSizeScale,
    duration: 10 / settings.speed,
    hideTop: !settings.showTop,
    hideBottom: !settings.showBottom,
    hideScroll: !settings.showScroll,
    strokeWidth: settings.strokeWidth == 0 ? 1.5 : settings.strokeWidth,
    fontWeight: FontWeight.w500,
  );
}

DanmakuItemType _toDanmakuItemType(int mode) {
  return switch (mode) {
    4 => DanmakuItemType.bottom,
    5 => DanmakuItemType.top,
    _ => DanmakuItemType.scroll,
  };
}

Color _toOpaqueDanmakuColor(int colorValue) {
  return Color.fromARGB(
    255,
    (colorValue >> 16) & 0xFF,
    (colorValue >> 8) & 0xFF,
    colorValue & 0xFF,
  );
}

Path? _resolveMaskPath({
  required DanmakuSettings settings,
  required AsyncValue<DanmakuMasks?> maskProvider,
  required int currentPosMs,
}) {
  if (!settings.enableAiMask || !maskProvider.hasValue || maskProvider.value == null) {
    return null;
  }
  return maskProvider.value!.getPath(currentPosMs);
}

class _DanmakuTimelineBuffer {
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
    _items.addAll(newItems);
    _items.sort((a, b) => a.time.compareTo(b.time));
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
    var left = 0;
    var right = _items.length - 1;
    var result = _items.length;

    while (left <= right) {
      final mid = left + (right - left) ~/ 2;
      if (_items[mid].time >= targetTime) {
        result = mid;
        right = mid - 1;
      } else {
        left = mid + 1;
      }
    }
    return result;
  }
}

class DanmakuMaskClipper extends CustomClipper<Path> {
  final Path? maskPath;
  final Size videoSize;

  DanmakuMaskClipper({required this.maskPath, required this.videoSize});

  @override
  Path getClip(Size size) {
    final rectPath = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    if (maskPath == null || videoSize.width == 0 || videoSize.height == 0) {
      return rectPath;
    }

    final scaleX = size.width / videoSize.width;
    final scaleY = size.height / videoSize.height;

    final matrix4 = Matrix4.diagonal3Values(scaleX, scaleY, 1.0);
    final scaledMask = maskPath!.transform(matrix4.storage);

    return Path.combine(PathOperation.difference, rectPath, scaledMask);
  }

  @override
  bool shouldReclip(covariant DanmakuMaskClipper oldClipper) {
    return oldClipper.maskPath != maskPath || oldClipper.videoSize != videoSize;
  }
}
