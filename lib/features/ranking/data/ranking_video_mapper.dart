import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/features/ranking/data/models/ranking_video.dart';

extension RankingVideoMapper on VideoModel {
  RankingVideo toDomain() {
    return RankingVideo(
      bvid: bvid,
      title: title,
      coverUrl: pic,
      duration: duration,
      ownerName: owner.name,
      viewCount: stat.view,
      danmakuCount: stat.danmaku,
    );
  }
}
