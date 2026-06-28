import 'package:culcul/core/utils/json_utils.dart';

final class HistoryEntry {
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

  final String title;
  final String coverUrl;
  final String bvid;
  final String business;
  final String authorName;
  final int viewedAt;
  final int progress;
  final int duration;
  final String badge;

  factory HistoryEntry.fromJson(Map<String, dynamic> json) {
    final historyJson = json['history'];
    final history = historyJson == null ? null : historyJson as Map<String, dynamic>;
    return HistoryEntry(
      title: json['title'] is String ? json['title'] as String : '',
      coverUrl: json['cover'] is String ? json['cover'] as String : '',
      bvid: history?['bvid'] is String ? history!['bvid'] as String : '',
      business: history?['business'] is String ? history!['business'] as String : '',
      authorName: json['author_name'] is String ? json['author_name'] as String : '',
      viewedAt: JsonUtils.parseIntWithDefault(json['view_at']),
      progress: JsonUtils.parseIntWithDefault(json['progress']),
      duration: JsonUtils.parseIntWithDefault(json['duration']),
      badge: json['badge'] is String ? json['badge'] as String : '',
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other.runtimeType == runtimeType &&
            other is HistoryEntry &&
            other.title == title &&
            other.coverUrl == coverUrl &&
            other.bvid == bvid &&
            other.business == business &&
            other.authorName == authorName &&
            other.viewedAt == viewedAt &&
            other.progress == progress &&
            other.duration == duration &&
            other.badge == badge;
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    title,
    coverUrl,
    bvid,
    business,
    authorName,
    viewedAt,
    progress,
    duration,
    badge,
  );

  @override
  String toString() {
    return 'HistoryEntry(title: $title, coverUrl: $coverUrl, bvid: $bvid, '
        'business: $business, authorName: $authorName, viewedAt: $viewedAt, '
        'progress: $progress, duration: $duration, badge: $badge)';
  }
}
