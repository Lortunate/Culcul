import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:culcul/features/video/presentation/view_models/player_view_model.dart';
import 'package:culcul/features/video/presentation/view_models/video_detail_view_model.dart';

part 'video_page_view_model.freezed.dart';
part 'video_page_view_model.g.dart';

@freezed
sealed class VideoPageState with _$VideoPageState {
  const factory VideoPageState({
    @Default(false) bool isFullscreen,
    @Default(false) bool shouldUseVerticalLayout,
  }) = _VideoPageState;
}

@riverpod
VideoPageState videoPageViewModel(Ref ref, String bvid) {
  final detailState = ref.watch(videoDetailControllerProvider(bvid));
  final isFullscreen = ref.watch(playerControllerProvider).isFullscreen;
  final detail = detailState.videoDetail;
  final shouldUseVerticalLayout =
      detail != null &&
      detail.dimension.width != 0 &&
      detail.dimension.height != 0 &&
      detail.dimension.width < detail.dimension.height;

  return VideoPageState(
    isFullscreen: isFullscreen,
    shouldUseVerticalLayout: shouldUseVerticalLayout,
  );
}
