import 'package:culcul/core/utils/json_utils.dart';
import 'package:flutter/foundation.dart' show listEquals;

final class LiveGuardListModel {
  LiveGuardListModel({
    required this.info,
    List<LiveGuardItem> top3 = const [],
    List<LiveGuardItem> list = const [],
  }) : top3 = List<LiveGuardItem>.unmodifiable(top3),
       list = List<LiveGuardItem>.unmodifiable(list);

  factory LiveGuardListModel.fromJson(Map<String, dynamic> json) {
    return LiveGuardListModel(
      info: LiveGuardInfo.fromJson(json['info'] as Map<String, dynamic>),
      top3:
          (json['top3'] as List<dynamic>?)
              ?.map((e) => LiveGuardItem.fromJson(e as Map<String, dynamic>))
              .toList(growable: false) ??
          const [],
      list:
          (json['list'] as List<dynamic>?)
              ?.map((e) => LiveGuardItem.fromJson(e as Map<String, dynamic>))
              .toList(growable: false) ??
          const [],
    );
  }

  final LiveGuardInfo info;
  final List<LiveGuardItem> top3;
  final List<LiveGuardItem> list;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is LiveGuardListModel &&
            runtimeType == other.runtimeType &&
            info == other.info &&
            listEquals(top3, other.top3) &&
            listEquals(list, other.list);
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, info, Object.hashAll(top3), Object.hashAll(list));
  }

  @override
  String toString() {
    return 'LiveGuardListModel(info: $info, top3: $top3, list: $list)';
  }
}

final class LiveGuardInfo {
  const LiveGuardInfo({required this.num, required this.page, required this.now});

  factory LiveGuardInfo.fromJson(Map<String, dynamic> json) {
    return LiveGuardInfo(
      num:
          JsonUtils.parseInt(json['num']) ??
          (throw const FormatException('Expected numeric num')),
      page:
          JsonUtils.parseInt(json['page']) ??
          (throw const FormatException('Expected numeric page')),
      now:
          JsonUtils.parseInt(json['now']) ??
          (throw const FormatException('Expected numeric now')),
    );
  }

  final int num;
  final int page;
  final int now;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is LiveGuardInfo &&
            runtimeType == other.runtimeType &&
            num == other.num &&
            page == other.page &&
            now == other.now;
  }

  @override
  int get hashCode => Object.hash(runtimeType, num, page, now);

  @override
  String toString() => 'LiveGuardInfo(num: $num, page: $page, now: $now)';
}

final class LiveGuardItem {
  const LiveGuardItem({
    required this.ruid,
    required this.rank,
    required this.userInfo,
    required this.guardLevel,
  });

  factory LiveGuardItem.fromJson(Map<String, dynamic> json) {
    return LiveGuardItem(
      ruid:
          JsonUtils.parseInt(json['ruid']) ??
          (throw const FormatException('Expected numeric ruid')),
      rank:
          JsonUtils.parseInt(json['rank']) ??
          (throw const FormatException('Expected numeric rank')),
      userInfo: LiveGuardUserInfo.fromJson(json['uinfo'] as Map<String, dynamic>),
      guardLevel:
          JsonUtils.parseInt(json['guard_level']) ??
          (throw const FormatException('Expected numeric guard_level')),
    );
  }

  final int ruid;
  final int rank;
  final LiveGuardUserInfo userInfo;
  final int guardLevel;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is LiveGuardItem &&
            runtimeType == other.runtimeType &&
            ruid == other.ruid &&
            rank == other.rank &&
            userInfo == other.userInfo &&
            guardLevel == other.guardLevel;
  }

  @override
  int get hashCode => Object.hash(runtimeType, ruid, rank, userInfo, guardLevel);

  @override
  String toString() {
    return 'LiveGuardItem('
        'ruid: $ruid, '
        'rank: $rank, '
        'userInfo: $userInfo, '
        'guardLevel: $guardLevel'
        ')';
  }
}

final class LiveGuardUserInfo {
  const LiveGuardUserInfo({required this.uid, required this.base});

  factory LiveGuardUserInfo.fromJson(Map<String, dynamic> json) {
    return LiveGuardUserInfo(
      uid:
          JsonUtils.parseInt(json['uid']) ??
          (throw const FormatException('Expected numeric uid')),
      base: LiveGuardUserBase.fromJson(json['base'] as Map<String, dynamic>),
    );
  }

  final int uid;
  final LiveGuardUserBase base;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is LiveGuardUserInfo &&
            runtimeType == other.runtimeType &&
            uid == other.uid &&
            base == other.base;
  }

  @override
  int get hashCode => Object.hash(runtimeType, uid, base);

  @override
  String toString() => 'LiveGuardUserInfo(uid: $uid, base: $base)';
}

final class LiveGuardUserBase {
  const LiveGuardUserBase({required this.name, required this.face});

  factory LiveGuardUserBase.fromJson(Map<String, dynamic> json) {
    return LiveGuardUserBase(name: json['name'] as String, face: json['face'] as String);
  }

  final String name;
  final String face;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is LiveGuardUserBase &&
            runtimeType == other.runtimeType &&
            name == other.name &&
            face == other.face;
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, face);

  @override
  String toString() => 'LiveGuardUserBase(name: $name, face: $face)';
}
