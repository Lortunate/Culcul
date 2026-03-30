class ProfileVideoOwner {
  final int mid;
  final String name;
  final String face;

  const ProfileVideoOwner({required this.mid, required this.name, required this.face});
}

class ProfileVideoStats {
  final int view;
  final int danmaku;
  final int reply;
  final int like;
  final int coin;
  final int favorite;
  final int share;

  const ProfileVideoStats({
    required this.view,
    required this.danmaku,
    required this.reply,
    required this.like,
    required this.coin,
    required this.favorite,
    required this.share,
  });
}

class ProfileVideo {
  final int aid;
  final String bvid;
  final String title;
  final String pic;
  final String tname;
  final int duration;
  final int pubDate;
  final int ctime;
  final String desc;
  final int state;
  final int attribute;
  final int tid;
  final ProfileVideoOwner owner;
  final ProfileVideoStats stats;
  final String reason;
  final bool interVideo;

  const ProfileVideo({
    required this.aid,
    required this.bvid,
    required this.title,
    required this.pic,
    required this.tname,
    required this.duration,
    required this.pubDate,
    required this.ctime,
    required this.desc,
    required this.state,
    required this.attribute,
    required this.tid,
    required this.owner,
    required this.stats,
    required this.reason,
    required this.interVideo,
  });
}
