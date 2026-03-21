import 'package:culcul/features/video/controllers/danmaku_controller.dart';
import 'package:culcul/features/video/controllers/danmaku_settings_controller.dart';
import 'package:culcul/features/video/providers/danmaku_mask_provider.dart';
import 'package:culcul/features/video/controllers/player_controller.dart';
import 'package:culcul/features/video/controllers/video_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:culcul/ui/widgets/danmaku/ns_danmaku/danmaku_controller.dart';
import 'package:culcul/ui/widgets/danmaku/ns_danmaku/danmaku_view.dart';
import 'package:culcul/ui/widgets/danmaku/ns_danmaku/models/danmaku_item.dart';
import 'package:culcul/ui/widgets/danmaku/ns_danmaku/models/danmaku_option.dart';

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

    final player = ref.read(playerControllerProvider.notifier).player;

    final loadedSegments = useRef<Set<int>>({});
    final allItems = useRef<List<DanmakuItem>>([]);
    final cursor = useRef<int>(0);
    final lastPosition = useRef<int>(0);
    final maskPathNotifier = useRef<ValueNotifier<Path?>>(ValueNotifier(null));

    int findCursor(List<DanmakuItem> items, int targetTime) {
      int left = 0;
      int right = items.length - 1;
      int result = items.length;

      while (left <= right) {
        int mid = left + (right - left) ~/ 2;
        if (items[mid].time >= targetTime) {
          result = mid;
          right = mid - 1;
        } else {
          left = mid + 1;
        }
      }
      return result;
    }

    useEffect(() {
      final subPosition = player.stream.position.listen((pos) {
        final currentPosMs = pos.inMilliseconds;
        final segmentIndex = (currentPosMs / 360000).ceil();
        final index = segmentIndex < 1 ? 1 : segmentIndex;

        if (aid != null && currentCid != 0 && !loadedSegments.value.contains(index)) {
          loadedSegments.value.add(index);
          ref
              .read(danmakuProviderProvider.notifier)
              .loadSegment(oid: currentCid, pid: aid, segmentIndex: index)
              .then((elems) {
                final newItems = elems.map((e) {
                  DanmakuItemType type = DanmakuItemType.scroll;
                  if (e.mode == 4) type = DanmakuItemType.bottom;
                  if (e.mode == 5) type = DanmakuItemType.top;

                  return DanmakuItem(
                    e.content,
                    time: e.progress,
                    color: Color(0xFF000000 | e.color),
                    type: type,
                  );
                }).toList();

                allItems.value.addAll(newItems);
                allItems.value.sort((a, b) => a.time.compareTo(b.time));
                cursor.value = findCursor(allItems.value, currentPosMs);
              })
              .catchError((e) {
                loadedSegments.value.remove(index);
                debugPrint('Failed to load danmaku segment $index: $e');
              });
        }

        if ((currentPosMs - lastPosition.value).abs() > 1500) {
          controllerRef.value?.clear();
          cursor.value = findCursor(allItems.value, currentPosMs);
        }

        if (player.state.playing) {
          final itemsToAdd = <DanmakuItem>[];
          int processed = 0;

          while (cursor.value < allItems.value.length && processed < 50) {
            final item = allItems.value[cursor.value];

            if (item.time <= currentPosMs) {
              if (currentPosMs - item.time < 3000) {
                itemsToAdd.add(item);
              }
              cursor.value++;
              processed++;
            } else {
              break;
            }
          }

          if (itemsToAdd.isNotEmpty) {
            controllerRef.value?.addItems(itemsToAdd);
          }
        }

        if (settings.enableAiMask &&
            maskProvider.hasValue &&
            maskProvider.value != null) {
          final path = maskProvider.value!.getPath(currentPosMs);
          if (path != maskPathNotifier.value.value) {
            maskPathNotifier.value.value = path;
          }
        } else {
          if (maskPathNotifier.value.value != null) {
            maskPathNotifier.value.value = null;
          }
        }

        lastPosition.value = currentPosMs;
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
      if (controller == null) return;

      controller.updateOption(
        DanmakuOption(
          opacity: settings.opacity,
          area: settings.area,
          fontSize: 15 * settings.fontSizeScale,
          duration: 10 / settings.speed,
          hideTop: !settings.showTop,
          hideBottom: !settings.showBottom,
          hideScroll: !settings.showScroll,
          strokeWidth: settings.strokeWidth == 0 ? 1.5 : settings.strokeWidth,
          fontWeight: FontWeight.w500,
        ),
      );
      return null;
    }, [settings]);

    if (!settings.isEnabled) return const SizedBox();

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
                  viewSize: Size(constraints.maxWidth, constraints.maxHeight),
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
              option: DanmakuOption(
                opacity: settings.opacity,
                area: settings.area,
                fontSize: (15 * settings.fontSizeScale).toDouble(),
                duration: (10 / settings.speed).toDouble(),
                hideTop: !settings.showTop,
                hideBottom: !settings.showBottom,
                hideScroll: !settings.showScroll,
                strokeWidth: settings.strokeWidth == 0 ? 1.5 : settings.strokeWidth,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        },
      ),
    );
  }
}

class DanmakuMaskClipper extends CustomClipper<Path> {
  final Path? maskPath;
  final Size viewSize;
  final Size videoSize;

  DanmakuMaskClipper({
    required this.maskPath,
    required this.viewSize,
    required this.videoSize,
  });

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
    return oldClipper.maskPath != maskPath ||
        oldClipper.viewSize != viewSize ||
        oldClipper.videoSize != videoSize;
  }
}
