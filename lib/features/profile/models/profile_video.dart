import 'package:culcul/core/models/video_model_contract.dart';

final class ProfileVideo {
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
    this.reason = '',
    this.interVideo = false,
  });

  factory ProfileVideo.fromJson(Map<String, dynamic> json) {
    final normalized = _normalizeProfileVideoJson(json);
    final pubDate = normalized['pubDate'] ?? normalized['pubdate'];
    return ProfileVideo(
      aid: (normalized['aid'] as num).toInt(),
      bvid: normalized['bvid'] as String,
      title: normalized['title'] as String,
      pic: normalized['pic'] as String,
      tname: normalized['tname'] as String,
      duration: (normalized['duration'] as num).toInt(),
      pubDate: (pubDate as num).toInt(),
      ctime: (normalized['ctime'] as num).toInt(),
      desc: normalized['desc'] as String,
      state: (normalized['state'] as num).toInt(),
      attribute: (normalized['attribute'] as num).toInt(),
      tid: (normalized['tid'] as num).toInt(),
      owner: VideoOwner.fromJson(normalized['owner'] as Map<String, dynamic>),
      stats: VideoStat.fromJson(normalized['stat'] as Map<String, dynamic>),
      reason: normalized['reason'] as String? ?? '',
      interVideo: normalized['inter_video'] as bool? ?? false,
    );
  }

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
  final VideoOwner owner;
  final VideoStat stats;
  final String reason;
  final bool interVideo;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ProfileVideo &&
            runtimeType == other.runtimeType &&
            aid == other.aid &&
            bvid == other.bvid &&
            title == other.title &&
            pic == other.pic &&
            tname == other.tname &&
            duration == other.duration &&
            pubDate == other.pubDate &&
            ctime == other.ctime &&
            desc == other.desc &&
            state == other.state &&
            attribute == other.attribute &&
            tid == other.tid &&
            owner == other.owner &&
            stats == other.stats &&
            reason == other.reason &&
            interVideo == other.interVideo;
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      aid,
      bvid,
      title,
      pic,
      tname,
      duration,
      pubDate,
      ctime,
      desc,
      state,
      attribute,
      tid,
      owner,
      stats,
      reason,
      interVideo,
    );
  }

  @override
  String toString() {
    return 'ProfileVideo('
        'aid: $aid, '
        'bvid: $bvid, '
        'title: $title, '
        'pic: $pic, '
        'tname: $tname, '
        'duration: $duration, '
        'pubDate: $pubDate, '
        'ctime: $ctime, '
        'desc: $desc, '
        'state: $state, '
        'attribute: $attribute, '
        'tid: $tid, '
        'owner: $owner, '
        'stats: $stats, '
        'reason: $reason, '
        'interVideo: $interVideo'
        ')';
  }
}

Map<String, dynamic> _normalizeProfileVideoJson(Map<String, dynamic> json) {
  if (json['owner'] != null || !json.containsKey('author')) {
    return json;
  }

  final adjusted = Map<String, dynamic>.from(json);

  adjusted['owner'] = {'mid': json['mid'] ?? 0, 'name': json['author'], 'face': ''};

  adjusted['stat'] = {
    'view': json['play'] ?? 0,
    'danmaku': json['video_review'] ?? 0,
    'reply': json['comment'] ?? 0,
    'like': 0,
    'coin': 0,
    'favorite': 0,
    'share': 0,
  };

  if (json['length'] is String) {
    final parts = (json['length'] as String).split(':');
    var seconds = 0;
    if (parts.length == 2) {
      seconds = (int.tryParse(parts[0]) ?? 0) * 60 + (int.tryParse(parts[1]) ?? 0);
    } else if (parts.length == 3) {
      seconds =
          (int.tryParse(parts[0]) ?? 0) * 3600 +
          (int.tryParse(parts[1]) ?? 0) * 60 +
          (int.tryParse(parts[2]) ?? 0);
    }
    adjusted['duration'] = seconds;
  }

  if (json.containsKey('created')) {
    adjusted['pubdate'] = json['created'];
    adjusted['pubDate'] = json['created'];
    adjusted['ctime'] = json['created'];
  }

  if (json.containsKey('description')) {
    adjusted['desc'] = json['description'];
  }

  if (json.containsKey('typeid')) {
    adjusted['tid'] = json['typeid'];
  }

  adjusted.putIfAbsent('tname', () => '');
  adjusted.putIfAbsent('desc', () => '');
  adjusted.putIfAbsent('state', () => 0);
  adjusted.putIfAbsent('attribute', () => 0);
  adjusted.putIfAbsent('reason', () => '');
  adjusted.putIfAbsent('inter_video', () => false);

  return adjusted;
}
