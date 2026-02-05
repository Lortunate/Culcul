import 'package:culcul/providers/video/danmaku_provider.dart';
import 'package:culcul/providers/video/danmaku_settings_provider.dart';
import 'package:culcul/providers/video/player_controller.dart';
import 'package:culcul/providers/video/video_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../widgets/danmaku/ns_danmaku/danmaku_controller.dart';
import '../../../widgets/danmaku/ns_danmaku/danmaku_view.dart';
import '../../../widgets/danmaku/ns_danmaku/models/danmaku_item.dart';
import '../../../widgets/danmaku/ns_danmaku/models/danmaku_option.dart';

class DanmakuLayer extends HookConsumerWidget {
  final String bvid;

  const DanmakuLayer({super.key, required this.bvid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllerRef = useRef<DanmakuController?>(null);
    final videoState = ref.watch(videoDetailControllerProvider(bvid));
    final settings = ref.watch(danmakuSettingsControllerProvider);

    // Access player without watching state to avoid frequent rebuilds
    final player = ref.read(playerControllerProvider.notifier).player;

    final loadedSegments = useRef<Set<int>>({});
    final allItems = useRef<List<DanmakuItem>>([]);
    final cursor = useRef<int>(0);
    final lastPosition = useRef<int>(0);

    // Helper to find cursor position (Binary search)
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

    // Initialize loading logic and sync
    useEffect(() {
      final subPosition = player.stream.position.listen((pos) {
        final currentPosMs = pos.inMilliseconds;

        // 1. Segment Loading Logic
        final segmentIndex = (currentPosMs / 360000).ceil();
        final index = segmentIndex < 1 ? 1 : segmentIndex;

        if (videoState.videoDetail != null &&
            videoState.currentCid != 0 &&
            !loadedSegments.value.contains(index)) {
          final cid = videoState.currentCid;
          final aid = videoState.videoDetail!.aid;

          loadedSegments.value.add(index);
          ref
              .read(danmakuProviderProvider.notifier)
              .loadSegment(oid: cid, pid: aid, segmentIndex: index)
              .then((elems) {
                final newItems = elems.map((e) {
                  DanmakuItemType type = DanmakuItemType.scroll;
                  if (e.mode == 4) type = DanmakuItemType.bottom;
                  if (e.mode == 5) type = DanmakuItemType.top;

                  return DanmakuItem(
                    e.content,
                    time: e.progress, // ms
                    color: Color(0xFF000000 | e.color),
                    type: type,
                  );
                }).toList();

                // Merge and sort
                allItems.value.addAll(newItems);
                allItems.value.sort((a, b) => a.time.compareTo(b.time));

                // Re-calculate cursor because insertion might be before current cursor
                // Optimization: Only if inserted items affect current time range?
                // Simpler: just re-find cursor if we are currently playing.
                // But we don't want to skip items if we just loaded them.
                // Actually, loaded segment is usually future (or current).
                // If it's current, we might need to display some immediately.
                cursor.value = findCursor(allItems.value, currentPosMs);
              })
              .catchError((e) {
                loadedSegments.value.remove(index);
                debugPrint('Failed to load danmaku segment $index: $e');
              });
        }

        // 2. Seek Sync Logic
        // If difference is large (>1.5s), assume seek
        if ((currentPosMs - lastPosition.value).abs() > 1500) {
          controllerRef.value?.clear();
          cursor.value = findCursor(allItems.value, currentPosMs);
        }

        // 3. Dispatch items
        // Only if playing (or if we want to show static danmaku on pause? usually not)
        if (player.state.playing) {
          final itemsToAdd = <DanmakuItem>[];
          // Limit to 50 items per tick to prevent freeze on huge spikes
          int processed = 0;

          while (cursor.value < allItems.value.length && processed < 50) {
            final item = allItems.value[cursor.value];

            if (item.time <= currentPosMs) {
              // Only add if it's within last 3 seconds (avoid dumping old items after lag)
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
    }, [videoState.currentCid, videoState.videoDetail]); // Re-init if video changes

    // Update settings when they change
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

    return LayoutBuilder(
      builder: (context, constraints) {
        return DanmakuView(
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
        );
      },
    );
  }
}
