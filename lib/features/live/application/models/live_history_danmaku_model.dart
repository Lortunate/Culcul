import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart' show listEquals, mapEquals;

final class LiveHistoryDanmakuModel {
  LiveHistoryDanmakuModel({
    required List<LiveDanmakuItem> admin,
    required List<LiveDanmakuItem> room,
  }) : admin = List<LiveDanmakuItem>.unmodifiable(admin),
       room = List<LiveDanmakuItem>.unmodifiable(room);

  factory LiveHistoryDanmakuModel.fromJson(Map<String, dynamic> json) {
    return LiveHistoryDanmakuModel(
      admin: (json['admin'] as List<dynamic>)
          .map((e) => LiveDanmakuItem.fromJson(e as Map<String, dynamic>))
          .toList(growable: false),
      room: (json['room'] as List<dynamic>)
          .map((e) => LiveDanmakuItem.fromJson(e as Map<String, dynamic>))
          .toList(growable: false),
    );
  }

  final List<LiveDanmakuItem> admin;
  final List<LiveDanmakuItem> room;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is LiveHistoryDanmakuModel &&
            runtimeType == other.runtimeType &&
            listEquals(admin, other.admin) &&
            listEquals(room, other.room);
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, Object.hashAll(admin), Object.hashAll(room));

  @override
  String toString() => 'LiveHistoryDanmakuModel(admin: $admin, room: $room)';
}

final class LiveDanmakuItem {
  LiveDanmakuItem({
    required this.text,
    required this.nickname,
    required this.uid,
    this.timeline = '',
    this.dmType = 0,
    this.isadmin = 0,
    this.vip = 0,
    this.svip = 0,
    this.medal,
    this.title,
    this.userLevel,
    this.rank = 0,
    this.teamid = 0,
    this.rnd = '',
    this.userTitle = '',
    this.guardLevel = 0,
    this.bubble = 0,
    Map<String, dynamic> checkInfo = const {},
  }) : checkInfo = Map<String, dynamic>.unmodifiable(checkInfo);

  factory LiveDanmakuItem.fromJson(Map<String, dynamic> json) {
    final medalRaw = json['medal'];
    final medal = medalRaw is List && medalRaw.length >= 2
        ? LiveDanmakuMedal(
            level: medalRaw.first is num ? (medalRaw.first as num).toInt() : 0,
            name: medalRaw[1]?.toString() ?? '',
            anchorRoomId: medalRaw.length > 3 && medalRaw[3] is num
                ? (medalRaw[3] as num).toInt()
                : 0,
            color: medalRaw.length > 4 && medalRaw[4] is num
                ? (medalRaw[4] as num).toInt()
                : 0,
          )
        : null;

    final titleRaw = json['title'];
    final title = titleRaw is List && titleRaw.isNotEmpty
        ? LiveDanmakuTitle(
            title: titleRaw.first?.toString() ?? '',
            skin: titleRaw.length > 1 ? titleRaw[1]?.toString() ?? '' : '',
          )
        : null;

    final userLevelRaw = json['user_level'];
    final userLevel = userLevelRaw is List && userLevelRaw.isNotEmpty
        ? LiveDanmakuUserLevel(
            level: userLevelRaw.first is num ? (userLevelRaw.first as num).toInt() : 0,
            rank: userLevelRaw.length > 1 && userLevelRaw[1] is num
                ? (userLevelRaw[1] as num).toInt()
                : 0,
          )
        : null;

    return LiveDanmakuItem(
      text: json['text'] as String,
      nickname: json['nickname'] as String,
      uid: (json['uid'] as num).toInt(),
      timeline: json['timeline'] as String? ?? '',
      dmType: (json['dm_type'] as num?)?.toInt() ?? 0,
      isadmin: (json['isadmin'] as num?)?.toInt() ?? 0,
      vip: (json['vip'] as num?)?.toInt() ?? 0,
      svip: (json['svip'] as num?)?.toInt() ?? 0,
      medal: medal,
      title: title,
      userLevel: userLevel,
      rank: (json['rank'] as num?)?.toInt() ?? 0,
      teamid: (json['teamid'] as num?)?.toInt() ?? 0,
      rnd: json['rnd'] as String? ?? '',
      userTitle: json['user_title'] as String? ?? '',
      guardLevel: (json['guard_level'] as num?)?.toInt() ?? 0,
      bubble: (json['bubble'] as num?)?.toInt() ?? 0,
      checkInfo: json['check_info'] as Map<String, dynamic>? ?? const {},
    );
  }

  final String text;
  final String nickname;
  final int uid;
  final String timeline;
  final int dmType;
  final int isadmin;
  final int vip;
  final int svip;
  final LiveDanmakuMedal? medal;
  final LiveDanmakuTitle? title;
  final LiveDanmakuUserLevel? userLevel;
  final int rank;
  final int teamid;
  final String rnd;
  final String userTitle;
  final int guardLevel;
  final int bubble;
  final Map<String, dynamic> checkInfo;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is LiveDanmakuItem &&
            runtimeType == other.runtimeType &&
            text == other.text &&
            nickname == other.nickname &&
            uid == other.uid &&
            timeline == other.timeline &&
            dmType == other.dmType &&
            isadmin == other.isadmin &&
            vip == other.vip &&
            svip == other.svip &&
            medal == other.medal &&
            title == other.title &&
            userLevel == other.userLevel &&
            rank == other.rank &&
            teamid == other.teamid &&
            rnd == other.rnd &&
            userTitle == other.userTitle &&
            guardLevel == other.guardLevel &&
            bubble == other.bubble &&
            mapEquals(checkInfo, other.checkInfo);
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      text,
      nickname,
      uid,
      timeline,
      dmType,
      isadmin,
      vip,
      svip,
      medal,
      title,
      userLevel,
      rank,
      teamid,
      rnd,
      userTitle,
      guardLevel,
      bubble,
      const MapEquality<String, dynamic>().hash(checkInfo),
    );
  }

  @override
  String toString() {
    return 'LiveDanmakuItem('
        'text: $text, '
        'nickname: $nickname, '
        'uid: $uid, '
        'timeline: $timeline, '
        'dmType: $dmType, '
        'isadmin: $isadmin, '
        'vip: $vip, '
        'svip: $svip, '
        'medal: $medal, '
        'title: $title, '
        'userLevel: $userLevel, '
        'rank: $rank, '
        'teamid: $teamid, '
        'rnd: $rnd, '
        'userTitle: $userTitle, '
        'guardLevel: $guardLevel, '
        'bubble: $bubble, '
        'checkInfo: $checkInfo'
        ')';
  }
}

final class LiveDanmakuMedal {
  const LiveDanmakuMedal({
    this.level = 0,
    this.name = '',
    this.anchorRoomId = 0,
    this.color = 0,
  });

  final int level;
  final String name;
  final int anchorRoomId;
  final int color;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is LiveDanmakuMedal &&
            runtimeType == other.runtimeType &&
            level == other.level &&
            name == other.name &&
            anchorRoomId == other.anchorRoomId &&
            color == other.color;
  }

  @override
  int get hashCode => Object.hash(runtimeType, level, name, anchorRoomId, color);

  @override
  String toString() {
    return 'LiveDanmakuMedal('
        'level: $level, '
        'name: $name, '
        'anchorRoomId: $anchorRoomId, '
        'color: $color'
        ')';
  }
}

final class LiveDanmakuTitle {
  const LiveDanmakuTitle({this.title = '', this.skin = ''});

  final String title;
  final String skin;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is LiveDanmakuTitle &&
            runtimeType == other.runtimeType &&
            title == other.title &&
            skin == other.skin;
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, skin);

  @override
  String toString() => 'LiveDanmakuTitle(title: $title, skin: $skin)';
}

final class LiveDanmakuUserLevel {
  const LiveDanmakuUserLevel({this.level = 0, this.rank = 0});

  final int level;
  final int rank;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is LiveDanmakuUserLevel &&
            runtimeType == other.runtimeType &&
            level == other.level &&
            rank == other.rank;
  }

  @override
  int get hashCode => Object.hash(runtimeType, level, rank);

  @override
  String toString() => 'LiveDanmakuUserLevel(level: $level, rank: $rank)';
}
