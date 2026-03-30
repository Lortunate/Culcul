class HomeVideoOwner {
  final int mid;
  final String name;
  final String face;

  const HomeVideoOwner({required this.mid, required this.name, required this.face});
}

class HomeVideoStats {
  final int view;
  final int danmaku;
  final int reply;
  final int like;
  final int coin;
  final int favorite;
  final int share;

  const HomeVideoStats({
    required this.view,
    required this.danmaku,
    required this.reply,
    required this.like,
    required this.coin,
    required this.favorite,
    required this.share,
  });
}

class HomeVideo {
  final String bvid;
  final String title;
  final String pic;
  final HomeVideoOwner owner;
  final HomeVideoStats stats;
  final int duration;
  final int pubDate;
  final String desc;
  final String rcmdReason;

  const HomeVideo({
    required this.bvid,
    required this.title,
    required this.pic,
    required this.owner,
    required this.stats,
    required this.duration,
    required this.pubDate,
    required this.desc,
    required this.rcmdReason,
  });
}

class HomeWeeklyFeed {
  final List<HomeVideo> list;

  const HomeWeeklyFeed({required this.list});
}
