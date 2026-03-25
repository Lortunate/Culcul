import 'package:culcul/data/models/comment/comment_model.dart';
import 'package:culcul/data/models/video/play_url.dart';
import 'package:culcul/data/models/video/related_video.dart';
import 'package:culcul/data/models/video/video_detail.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_detail_state.freezed.dart';

@freezed
sealed class VideoDetailState with _$VideoDetailState {
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

