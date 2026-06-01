import 'package:flutter/foundation.dart' show listEquals;

final class LiveGoldRankModel {
  LiveGoldRankModel({required this.onlineNum, required List<LiveRankItem> list})
    : list = List.unmodifiable(list);

  factory LiveGoldRankModel.fromJson(Map<String, dynamic> json) {
    return LiveGoldRankModel(
      onlineNum: (json['onlineNum'] as num).toInt(),
      list: (json['OnlineRankItem'] as List<dynamic>)
          .map((item) => LiveRankItem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  final int onlineNum;
  final List<LiveRankItem> list;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is LiveGoldRankModel &&
            other.onlineNum == onlineNum &&
            listEquals(other.list, list);
  }

  @override
  int get hashCode => Object.hash(onlineNum, Object.hashAll(list));

  @override
  String toString() {
    return 'LiveGoldRankModel(onlineNum: $onlineNum, list: $list)';
  }
}

final class LiveRankItem {
  const LiveRankItem({
    required this.userRank,
    required this.uid,
    required this.name,
    required this.face,
    required this.score,
    required this.medalInfo,
    required this.guardLevel,
    required this.wealthLevel,
  });

  factory LiveRankItem.fromJson(Map<String, dynamic> json) {
    return LiveRankItem(
      userRank: (json['userRank'] as num).toInt(),
      uid: (json['uid'] as num).toInt(),
      name: json['name'] as String,
      face: json['face'] as String,
      score: (json['score'] as num).toInt(),
      medalInfo: LiveRankMedalInfo.fromJson(json['medalInfo'] as Map<String, dynamic>),
      guardLevel: (json['guard_level'] as num).toInt(),
      wealthLevel: (json['wealth_level'] as num).toInt(),
    );
  }

  final int userRank;
  final int uid;
  final String name;
  final String face;
  final int score;
  final LiveRankMedalInfo medalInfo;
  final int guardLevel;
  final int wealthLevel;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is LiveRankItem &&
            other.userRank == userRank &&
            other.uid == uid &&
            other.name == name &&
            other.face == face &&
            other.score == score &&
            other.medalInfo == medalInfo &&
            other.guardLevel == guardLevel &&
            other.wealthLevel == wealthLevel;
  }

  @override
  int get hashCode {
    return Object.hash(
      userRank,
      uid,
      name,
      face,
      score,
      medalInfo,
      guardLevel,
      wealthLevel,
    );
  }

  @override
  String toString() {
    return 'LiveRankItem('
        'userRank: $userRank, '
        'uid: $uid, '
        'name: $name, '
        'face: $face, '
        'score: $score, '
        'medalInfo: $medalInfo, '
        'guardLevel: $guardLevel, '
        'wealthLevel: $wealthLevel'
        ')';
  }
}

final class LiveRankMedalInfo {
  const LiveRankMedalInfo({
    required this.guardLevel,
    required this.medalColorStart,
    required this.medalColorEnd,
    required this.medalColorBorder,
    required this.medalName,
    required this.level,
    required this.targetId,
    required this.isLight,
  });

  factory LiveRankMedalInfo.fromJson(Map<String, dynamic> json) {
    return LiveRankMedalInfo(
      guardLevel: (json['guardLevel'] as num).toInt(),
      medalColorStart: (json['medalColorStart'] as num).toInt(),
      medalColorEnd: (json['medalColorEnd'] as num).toInt(),
      medalColorBorder: (json['medalColorBorder'] as num).toInt(),
      medalName: json['medalName'] as String,
      level: (json['level'] as num).toInt(),
      targetId: (json['targetId'] as num).toInt(),
      isLight: (json['isLight'] as num).toInt(),
    );
  }

  final int guardLevel;
  final int medalColorStart;
  final int medalColorEnd;
  final int medalColorBorder;
  final String medalName;
  final int level;
  final int targetId;
  final int isLight;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is LiveRankMedalInfo &&
            other.guardLevel == guardLevel &&
            other.medalColorStart == medalColorStart &&
            other.medalColorEnd == medalColorEnd &&
            other.medalColorBorder == medalColorBorder &&
            other.medalName == medalName &&
            other.level == level &&
            other.targetId == targetId &&
            other.isLight == isLight;
  }

  @override
  int get hashCode {
    return Object.hash(
      guardLevel,
      medalColorStart,
      medalColorEnd,
      medalColorBorder,
      medalName,
      level,
      targetId,
      isLight,
    );
  }

  @override
  String toString() {
    return 'LiveRankMedalInfo('
        'guardLevel: $guardLevel, '
        'medalColorStart: $medalColorStart, '
        'medalColorEnd: $medalColorEnd, '
        'medalColorBorder: $medalColorBorder, '
        'medalName: $medalName, '
        'level: $level, '
        'targetId: $targetId, '
        'isLight: $isLight'
        ')';
  }
}
