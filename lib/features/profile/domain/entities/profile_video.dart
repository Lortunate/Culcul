import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_video.freezed.dart';

@freezed
sealed class ProfileVideoOwner with _$ProfileVideoOwner {
  const factory ProfileVideoOwner({
    required int mid,
    required String name,
    required String face,
  }) = _ProfileVideoOwner;
}

@freezed
sealed class ProfileVideoStats with _$ProfileVideoStats {
  const factory ProfileVideoStats({
    required int view,
    required int danmaku,
    required int reply,
    required int like,
    required int coin,
    required int favorite,
    required int share,
  }) = _ProfileVideoStats;
}

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
    required ProfileVideoOwner owner,
    required ProfileVideoStats stats,
    required String reason,
    required bool interVideo,
  }) = _ProfileVideo;
}
