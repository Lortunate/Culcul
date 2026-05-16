import 'package:culcul/features/video/application/presentation_contracts/dtos/play_url_dto.dart';
import 'package:culcul/features/video/application/presentation_contracts/dtos/related_video_dto.dart';
import 'package:culcul/features/video/application/presentation_contracts/dtos/video_detail_dto.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_detail_state.freezed.dart';

@freezed
sealed class VideoDetailState with _$VideoDetailState {
  const factory VideoDetailState({
    @Default(true) bool isLoading,
    VideoDetail? videoDetail,
    PlayUrl? playUrl,
    AppError? error,
    @Default(0) int currentCid,
    @Default([]) List<RelatedVideo> relatedVideos,
    @Default(80) int selectedQuality,
    @Default(1.0) double playbackSpeed,
    @Default([]) List<int> availableQualities,
  }) = _VideoDetailState;
}
