class VideoRanking {
  final String title;
  final List<VideoItem> items;

  VideoRanking({required this.title, required this.items});
}

class VideoItem {
  final String id;
  final String coverUrl;
  final String title;
  final String upName;
  final int playCount;
  final int likeCount;
  final int danmakuCount;
  final int rank;
  final int? pts;

  VideoItem({
    required this.id,
    required this.coverUrl,
    required this.title,
    required this.upName,
    required this.playCount,
    required this.likeCount,
    required this.danmakuCount,
    required this.rank,
    this.pts,
  });
}
