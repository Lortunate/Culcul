import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:culcul/features/live/domain/entities/live_danmaku_item.dart';

part 'live_history_danmaku_model.freezed.dart';
part 'live_history_danmaku_model.g.dart';

@freezed
sealed class LiveHistoryDanmakuModel with _$LiveHistoryDanmakuModel {
  const factory LiveHistoryDanmakuModel({
    @JsonKey(fromJson: _itemsFromJson, toJson: _itemsToJson)
    required List<LiveDanmakuItem> admin,
    @JsonKey(fromJson: _itemsFromJson, toJson: _itemsToJson)
    required List<LiveDanmakuItem> room,
  }) = _LiveHistoryDanmakuModel;

  factory LiveHistoryDanmakuModel.fromJson(Map<String, dynamic> json) =>
      _$LiveHistoryDanmakuModelFromJson(json);
}

List<LiveDanmakuItem> _itemsFromJson(dynamic raw) {
  if (raw is! List) return const [];
  return [
    for (final item in raw)
      if (item is Map<String, dynamic>)
        _itemFromJson(item)
      else if (item is Map<Object?, Object?>)
        _itemFromJson(Map<String, dynamic>.from(item)),
  ];
}

List<Map<String, dynamic>> _itemsToJson(List<LiveDanmakuItem> items) {
  return items.map(_itemToJson).toList(growable: false);
}

LiveDanmakuItem _itemFromJson(Map<String, dynamic> json) {
  return LiveDanmakuItem(
    text: json['text']?.toString() ?? '',
    nickname: json['nickname']?.toString() ?? '',
    uid: _asInt(json['uid']),
    timeline: json['timeline']?.toString() ?? '',
    dmType: _asInt(json['dm_type']),
    isadmin: _asInt(json['isadmin']),
    vip: _asInt(json['vip']),
    svip: _asInt(json['svip']),
    medal: _medalFromJson(json['medal']),
    title: _titleFromJson(json['title']),
    userLevel: _userLevelFromJson(json['user_level']),
    rank: _asInt(json['rank']),
    teamid: _asInt(json['teamid']),
    rnd: json['rnd']?.toString() ?? '',
    userTitle: json['user_title']?.toString() ?? '',
    guardLevel: _asInt(json['guard_level']),
    bubble: _asInt(json['bubble']),
    checkInfo: _asStringKeyMap(json['check_info']),
  );
}

Map<String, dynamic> _itemToJson(LiveDanmakuItem item) {
  return <String, dynamic>{
    'text': item.text,
    'nickname': item.nickname,
    'uid': item.uid,
    'timeline': item.timeline,
    'dm_type': item.dmType,
    'isadmin': item.isadmin,
    'vip': item.vip,
    'svip': item.svip,
    'medal': _medalToJson(item.medal),
    'title': _titleToJson(item.title),
    'user_level': _userLevelToJson(item.userLevel),
    'rank': item.rank,
    'teamid': item.teamid,
    'rnd': item.rnd,
    'user_title': item.userTitle,
    'guard_level': item.guardLevel,
    'bubble': item.bubble,
    'check_info': item.checkInfo,
  };
}

// -- JSON converters for array-encoded sub-models --

LiveDanmakuMedal? _medalFromJson(dynamic raw) {
  if (raw is! List || raw.length < 2) return null;
  return LiveDanmakuMedal(
    level: raw.first is num ? (raw.first as num).toInt() : 0,
    name: raw[1]?.toString() ?? '',
    anchorRoomId: raw.length > 3 && raw[3] is num ? (raw[3] as num).toInt() : 0,
    color: raw.length > 4 && raw[4] is num ? (raw[4] as num).toInt() : 0,
  );
}

List<dynamic>? _medalToJson(LiveDanmakuMedal? medal) {
  if (medal == null) return null;
  return [medal.level, medal.name, '', medal.anchorRoomId, medal.color];
}

LiveDanmakuTitle? _titleFromJson(dynamic raw) {
  if (raw is! List || raw.isEmpty) return null;
  return LiveDanmakuTitle(
    title: raw.first?.toString() ?? '',
    skin: raw.length > 1 ? raw[1]?.toString() ?? '' : '',
  );
}

List<dynamic>? _titleToJson(LiveDanmakuTitle? title) {
  if (title == null) return null;
  return [title.title, title.skin];
}

LiveDanmakuUserLevel? _userLevelFromJson(dynamic raw) {
  if (raw is! List || raw.isEmpty) return null;
  return LiveDanmakuUserLevel(
    level: raw.first is num ? (raw.first as num).toInt() : 0,
    rank: raw.length > 1 && raw[1] is num ? (raw[1] as num).toInt() : 0,
  );
}

List<dynamic>? _userLevelToJson(LiveDanmakuUserLevel? userLevel) {
  if (userLevel == null) return null;
  return [userLevel.level, userLevel.rank];
}

int _asInt(dynamic value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value) ?? 0;
  return 0;
}

Map<String, dynamic> _asStringKeyMap(dynamic value) {
  if (value is Map<String, dynamic>) return value;
  if (value is Map) return Map<String, dynamic>.from(value);
  return const {};
}
