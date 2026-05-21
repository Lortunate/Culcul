import 'package:culcul/features/video/application/video_detail_models.dart';

VideoDetailViewData applyVideoLikeState(
  VideoDetailViewData detail, {
  required bool isLiked,
}) {
  final wasLiked = detail.reqUser.like == 1;
  final delta = isLiked == wasLiked ? 0 : (isLiked ? 1 : -1);
  final nextLike = (detail.stat.like + delta).clamp(0, 1 << 31);

  return detail.copyWith(
    reqUser: detail.reqUser.copyWith(like: isLiked ? 1 : 0),
    stat: detail.stat.copyWith(like: nextLike),
  );
}

VideoDetailViewData applyVideoCoinState(VideoDetailViewData detail, {int count = 1}) {
  if (count <= 0) {
    return detail;
  }

  return detail.copyWith(
    reqUser: detail.reqUser.copyWith(coin: detail.reqUser.coin + count),
    stat: detail.stat.copyWith(coin: detail.stat.coin + count),
  );
}
