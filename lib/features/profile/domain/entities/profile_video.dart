import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_video.freezed.dart';

@freezed
sealed class ProfileVideo with _$ProfileVideo {
  const factory ProfileVideo({
    required int aid,
    required String bvid,
    required String title,
    required String pic,
    required String tname,
    required int duration,
    required int pubDate,
    required int ctime,
    required String desc,
    required int state,
    required int attribute,
    required int tid,
    required VideoOwner owner,
    required VideoStat stats,
    required String reason,
    required bool interVideo,
  }) = _ProfileVideo;
}
