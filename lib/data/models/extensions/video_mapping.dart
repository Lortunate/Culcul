import 'package:culcul/data/models/related_video.dart';
import 'package:culcul/data/models/video_model.dart';

extension RelatedVideoMapping on RelatedVideo {
  VideoModel toVideoModel() {
    return VideoModel(
      bvid: bvid,
      title: title,
      pic: pic,
      owner: Owner(mid: owner.mid, name: owner.name, face: owner.face),
      stat: Stat(
        view: stat.view,
        danmaku: stat.danmaku,
        reply: stat.reply,
        like: stat.like,
        coin: stat.coin,
        favorite: stat.favorite,
        share: stat.share,
      ),
      duration: duration,
      pubDate: pubDate,
      desc: desc,
      rcmd_reason: rcmdReason,
    );
  }
}
