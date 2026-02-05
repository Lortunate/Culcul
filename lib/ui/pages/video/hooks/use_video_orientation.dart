import 'package:culcul/data/models/index.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:culcul/providers/video/player_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

VoidCallback useVideoOrientation(
  WidgetRef ref, {
  required VideoDetail? videoDetail,
  required int currentCid,
}) {
  final playerController = ref.watch(playerControllerProvider.notifier);
  final playerState = ref.watch(playerControllerProvider);

  // Toggle fullscreen logic
  void toggleFullscreen() {
    if (playerState.isFullscreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    } else {
      int width = 0;
      int height = 0;
      int rotate = 0;

      // 1. Try to get dimensions from API data (most reliable)
      if (videoDetail != null) {
        // Find current page
        VideoPage? currentPage;
        for (final page in videoDetail.pages) {
          if (page.cid == currentCid) {
            currentPage = page;
            break;
          }
        }
        
        if (currentPage != null && currentPage.dimension.width > 0 && currentPage.dimension.height > 0) {
          width = currentPage.dimension.width;
          height = currentPage.dimension.height;
          rotate = currentPage.dimension.rotate;
        } else if (videoDetail.dimension.width > 0 && videoDetail.dimension.height > 0) {
          // Fallback to video detail dimension
          width = videoDetail.dimension.width;
          height = videoDetail.dimension.height;
          rotate = videoDetail.dimension.rotate;
        }
      }

      // 2. Fallback to player state if API dimensions are missing
      if (width == 0 || height == 0) {
        width = playerController.player.state.width ?? 0;
        height = playerController.player.state.height ?? 0;
        // Player state dimensions are usually already rotated by the player engine if needed
        rotate = 0; 
      }
      
      // Handle rotation for API dimensions
      if (rotate == 90 || rotate == 270) {
        final temp = width;
        width = height;
        height = temp;
      }
      
      // Default to landscape if dimensions are not available or video is landscape
      final isLandscape = (width == 0 || height == 0) || (width >= height);

      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

      if (isLandscape) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
      } else {
        // For portrait videos, prefer portrait but allow rotation
        // This prevents locking in portrait if the detection was wrong or user wants to rotate
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
      }
    }
    playerController.toggleFullscreen();
  }

  // Handle cleanup
  useEffect(() {
    return () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    };
  }, const []);

  return toggleFullscreen;
}
