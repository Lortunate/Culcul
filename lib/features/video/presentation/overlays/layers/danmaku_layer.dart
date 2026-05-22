import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/perf/dev_logger.dart';
import 'package:culcul/features/video/application/video_extra_workflows.dart';
import 'package:culcul/features/video/presentation/overlays/danmaku_mask_view_model.dart';
import 'package:culcul/features/video/presentation/overlays/danmaku_settings_view_model.dart';
import 'package:culcul/features/video/presentation/overlays/danmaku_view_model.dart';
import 'package:culcul/features/video/presentation/player/player_view_model.dart';
import 'package:culcul/features/video/presentation/detail/video_detail_view_model.dart';
import 'package:culcul/features/video/presentation/overlays/danmaku/ns_danmaku/danmaku_controller.dart';
import 'package:culcul/features/video/presentation/overlays/danmaku/ns_danmaku/danmaku_view.dart';
import 'package:culcul/features/video/presentation/overlays/danmaku/ns_danmaku/models/danmaku_item.dart';
import 'package:culcul/features/video/presentation/overlays/danmaku/ns_danmaku/models/danmaku_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_kit/media_kit.dart';

part 'danmaku_layer.render_bridge.dart';
part 'danmaku_layer.timeline_scheduler.dart';
part 'danmaku_layer.timeline_buffer.dart';

const int _segmentDurationMs = 360000;
const int _segmentLoadCheckIntervalMs = 400;
const int _maskRefreshIntervalMs = 250;
const int _prefetchSegmentOffset = 1;

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
    final isEnabled = settings.isEnabled;
    final canRunDanmaku = isEnabled && aid != null && currentCid != 0;
    final shouldLoadMask = canRunDanmaku && settings.enableAiMask;
    final maskResultProvider = shouldLoadMask
        ? ref.watch(danmakuMaskProvider(oid: currentCid, pid: aid))
        : const AsyncData<Result<DanmakuMasks?, AppError>>(
            Success<DanmakuMasks?, AppError>(null),
          );
    final settingsRef = useRef(settings);
    settingsRef.value = settings;
    final maskResultRef = useRef(maskResultProvider);
    maskResultRef.value = maskResultProvider;
    final danmakuOption = _buildDanmakuOption(settings);

    final player = canRunDanmaku
        ? ref.read(playerControllerProvider.notifier).player
        : null;

    final timelineRef = useRef<DanmakuTimelineBuffer>(DanmakuTimelineBuffer());
    final maskPathNotifier = useRef<ValueNotifier<Path?>>(ValueNotifier(null));
    useEffect(() {
      return maskPathNotifier.value.dispose;
    }, const []);
    useDanmakuPlaybackScheduler(
      ref: ref,
      player: player,
      isActive: canRunDanmaku,
      currentCid: currentCid,
      aid: aid,
      controllerRef: controllerRef,
      timelineRef: timelineRef,
      settingsRef: settingsRef,
      maskResultRef: maskResultRef,
      maskPathNotifier: maskPathNotifier,
    );

    useEffect(() {
      final controller = controllerRef.value;
      if (controller == null || !canRunDanmaku) return;
      controller.updateOption(danmakuOption);
      return null;
    }, [settings, canRunDanmaku]);

    final activePlayer = player;
    if (!canRunDanmaku || activePlayer == null) {
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
                if (activePlayer.state.playing) controller.resume();
              },
              option: danmakuOption,
            ),
          );
        },
      ),
    );
  }
}
