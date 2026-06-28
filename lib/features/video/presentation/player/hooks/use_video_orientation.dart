import 'package:culcul/features/video/application/video_entry_layout.dart';
import 'package:culcul/features/video/application/video_detail_models.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:culcul/features/video/presentation/player/player_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

VoidCallback useVideoOrientation(
  WidgetRef ref, {
  required VideoDetailViewData? videoDetail,
  required int currentCid,
}) {
  final playerController = ref.read(playerControllerProvider.notifier);
  final isFullscreen = ref.watch(
    playerControllerProvider.select((value) => value.isFullscreen),
  );

  void toggleFullscreen() {
    if (isFullscreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    } else {
      var width = 0;
      var height = 0;
      var rotate = 0;

      if (videoDetail != null) {
        VideoPartViewData? currentPage;
        for (final page in videoDetail.pages) {
          if (page.cid == currentCid) {
            currentPage = page;
            break;
          }
        }

        if (currentPage != null &&
            currentPage.dimension.width > 0 &&
            currentPage.dimension.height > 0) {
          width = currentPage.dimension.width;
          height = currentPage.dimension.height;
          rotate = currentPage.dimension.rotate;
        } else if (videoDetail.dimension.width > 0 && videoDetail.dimension.height > 0) {
          width = videoDetail.dimension.width;
          height = videoDetail.dimension.height;
          rotate = videoDetail.dimension.rotate;
        }
      }

      if (width == 0 || height == 0) {
        width = playerController.player.state.width ?? 0;
        height = playerController.player.state.height ?? 0;
        rotate = 0;
      }

      final dimensions = normalizeVideoDimension(
        width: width,
        height: height,
        rotate: rotate,
      );
      final isLandscape =
          (dimensions.width == 0 || dimensions.height == 0) ||
          (dimensions.width >= dimensions.height);

      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

      if (isLandscape) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
      } else {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
      }
    }
    playerController.toggleFullscreen();
  }

  useEffect(() {
    return () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    };
  }, const []);

  return toggleFullscreen;
}
