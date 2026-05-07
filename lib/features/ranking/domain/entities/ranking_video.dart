class RankingVideo {
  final String bvid;
  final String title;
  final String coverUrl;
  final int duration;
  final String ownerName;
  final int viewCount;
  final int danmakuCount;

  const RankingVideo({
    required this.bvid,
    required this.title,
    required this.coverUrl,
    required this.duration,
    required this.ownerName,
    required this.viewCount,
    required this.danmakuCount,
  });
}
