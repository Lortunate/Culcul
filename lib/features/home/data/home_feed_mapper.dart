import 'package:culcul/shared/contracts/video_model_contract.dart';
import 'package:culcul/features/home/data/dtos/weekly_model_dto.dart';
import 'package:culcul/features/home/domain/entities/home_video.dart';

extension HomeVideoOwnerMapper on Owner {
  HomeVideoOwner toHomeOwner() {
    return HomeVideoOwner(mid: mid, name: name, face: face);
  }
}

extension HomeVideoStatsMapper on Stat {
  HomeVideoStats toHomeStats() {
    return HomeVideoStats(
      view: view,
      danmaku: danmaku,
      reply: reply,
      like: like,
      coin: coin,
      favorite: favorite,
      share: share,
    );
  }
}

extension HomeVideoMapper on VideoModel {
  HomeVideo toDomain() {
    return HomeVideo(
      bvid: bvid,
      title: title,
      pic: pic,
      owner: owner.toHomeOwner(),
      stats: stat.toHomeStats(),
      duration: duration,
      pubDate: pubDate,
      desc: desc,
      rcmdReason: rcmdReason,
    );
  }
}

extension HomeWeeklyMapper on WeeklyModelDto {
  HomeWeeklyFeed toDomain() {
    return HomeWeeklyFeed(list: list.map((item) => item.toDomain()).toList());
  }
}
