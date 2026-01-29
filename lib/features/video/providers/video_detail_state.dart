import 'package:cilixili/data/models/video/index.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_detail_state.freezed.dart';

@freezed
abstract class VideoDetailState with _$VideoDetailState {
  const factory VideoDetailState({
    @Default(true) bool isLoading,
    VideoDetail? videoDetail,
    PlayUrl? playUrl,
    Object? error,
    @Default(0) int currentCid,
    @Default([]) List<RelatedVideo> relatedVideos,
    @Default([]) List<CommentItem> comments,
    @Default(1) int commentSort,
    @Default(1) int commentPage,
    @Default(false) bool isCommentLoading,
    @Default(true) bool hasMoreComments,
    @Default(80) int selectedQuality,
    @Default(1.0) double playbackSpeed,
    @Default([]) List<int> availableQualities,
  }) = _VideoDetailState;
}
