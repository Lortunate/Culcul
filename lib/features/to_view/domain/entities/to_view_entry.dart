class ToViewEntry {
  final int aid;
  final String bvid;
  final String title;
  final String coverUrl;
  final int duration;
  final int progress;
  final String ownerName;
  final int viewCount;
  final int danmakuCount;

  const ToViewEntry({
    required this.aid,
    required this.bvid,
    required this.title,
    required this.coverUrl,
    required this.duration,
    required this.progress,
    required this.ownerName,
    required this.viewCount,
    required this.danmakuCount,
  });

  bool get hasProgress => progress > 0;

  double get progressRatio {
    final normalizedDuration = duration == 0 ? 1 : duration;
    return progress / normalizedDuration;
  }
}
