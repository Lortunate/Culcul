import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/core/utils/json_utils.dart';

final class ToViewEntry {
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

  final int aid;
  final String bvid;
  final String title;
  final String coverUrl;
  final int duration;
  final int progress;
  final String ownerName;
  final int viewCount;
  final int danmakuCount;

  factory ToViewEntry.fromJson(Map<String, dynamic> json) {
    final ownerJson = json['owner'];
    final owner = ownerJson == null
        ? null
        : VideoOwner.fromJson(ownerJson as Map<String, dynamic>);
    final statJson = json['stat'];
    final stat = statJson == null
        ? null
        : VideoStat.fromJson(statJson as Map<String, dynamic>);

    return ToViewEntry(
      aid: JsonUtils.parseIntWithDefault(json['aid']),
      bvid: json['bvid'] is String ? json['bvid'] as String : '',
      title: json['title'] is String ? json['title'] as String : '',
      coverUrl: json['pic'] is String ? json['pic'] as String : '',
      duration: JsonUtils.parseIntWithDefault(json['duration']),
      progress: JsonUtils.parseIntWithDefault(json['progress']),
      ownerName: owner?.name ?? '',
      viewCount: stat?.view ?? 0,
      danmakuCount: stat?.danmaku ?? 0,
    );
  }

  bool get hasProgress => progress > 0;

  double get progressRatio {
    final normalizedDuration = duration == 0 ? 1 : duration;
    return progress / normalizedDuration;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other.runtimeType == runtimeType &&
            other is ToViewEntry &&
            other.aid == aid &&
            other.bvid == bvid &&
            other.title == title &&
            other.coverUrl == coverUrl &&
            other.duration == duration &&
            other.progress == progress &&
            other.ownerName == ownerName &&
            other.viewCount == viewCount &&
            other.danmakuCount == danmakuCount;
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    aid,
    bvid,
    title,
    coverUrl,
    duration,
    progress,
    ownerName,
    viewCount,
    danmakuCount,
  );

  @override
  String toString() {
    return 'ToViewEntry(aid: $aid, bvid: $bvid, title: $title, '
        'coverUrl: $coverUrl, duration: $duration, progress: $progress, '
        'ownerName: $ownerName, viewCount: $viewCount, '
        'danmakuCount: $danmakuCount)';
  }
}
