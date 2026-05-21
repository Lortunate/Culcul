import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/features/video/data/dtos/play_url_dto.dart';
import 'package:culcul/features/video/application/video_detail_models.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_detail_state.freezed.dart';

@freezed
sealed class VideoDetailState with _$VideoDetailState {
  const factory VideoDetailState({
    @Default(true) bool isLoading,
    VideoDetailViewData? videoDetail,
    PlayUrl? playUrl,
    AppError? error,
    @Default(0) int currentCid,
    @Default([]) List<VideoModel> relatedVideos,
    @Default(80) int selectedQuality,
    @Default(1.0) double playbackSpeed,
    @Default([]) List<int> availableQualities,
  }) = _VideoDetailState;
}
