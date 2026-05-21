import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/features/video/application/video_detail_interactions.dart';
import 'package:culcul/features/video/application/video_detail_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('applyVideoLikeState', () {
    test('marks an unliked video as liked and increments the like count', () {
      final updated = applyVideoLikeState(_detail(like: 10), isLiked: true);

      expect(updated.reqUser.like, 1);
      expect(updated.stat.like, 11);
    });

    test('unmarks a liked video and does not decrement below zero', () {
      final updated = applyVideoLikeState(
        _detail(reqUser: const VideoRequestUserState(like: 1)),
        isLiked: false,
      );

      expect(updated.reqUser.like, 0);
      expect(updated.stat.like, 0);
    });
  });

  test('applyVideoCoinState records one successful coin and increments count', () {
    final updated = applyVideoCoinState(_detail(coin: 3));

    expect(updated.reqUser.coin, 1);
    expect(updated.stat.coin, 4);
  });
}

VideoDetailViewData _detail({
  int like = 0,
  int coin = 0,
  VideoRequestUserState reqUser = const VideoRequestUserState(),
}) {
  return VideoDetailViewData(
    bvid: 'BV1xx411c7mD',
    aid: 100,
    pic: '',
    title: 'Demo',
    pubDate: 0,
    desc: '',
    owner: const VideoOwner(mid: 1, name: 'owner'),
    stat: VideoStat(like: like, coin: coin),
    reqUser: reqUser,
  );
}
