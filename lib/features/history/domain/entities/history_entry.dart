class HistoryEntry {
  final String title;
  final String coverUrl;
  final String bvid;
  final String business;
  final String authorName;
  final int viewedAt;
  final int progress;
  final int duration;
  final String badge;

  const HistoryEntry({
    required this.title,
    required this.coverUrl,
    required this.bvid,
    required this.business,
    required this.authorName,
    required this.viewedAt,
    required this.progress,
    required this.duration,
    required this.badge,
  });
}
