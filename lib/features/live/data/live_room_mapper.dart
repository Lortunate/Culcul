import 'package:culcul/features/live/data/dtos/live_dtos.dart' as dto;
import 'package:culcul/features/live/domain/entities/live_entities.dart' as domain;

extension LiveHistoryDanmakuModelMapper on dto.LiveHistoryDanmakuModel {
  domain.LiveHistoryDanmakuModel toDomain() {
    return domain.LiveHistoryDanmakuModel(
      admin: admin.map((item) => item.toDomain()).toList(),
      room: room.map((item) => item.toDomain()).toList(),
    );
  }
}

domain.LiveDanmakuMedal? _toDanmakuMedal(List<dynamic>? raw) {
  if (raw == null || raw.length < 2) return null;
  return domain.LiveDanmakuMedal(
    level: raw.first is num ? (raw.first as num).toInt() : 0,
    name: raw[1]?.toString() ?? '',
    anchorRoomId: raw.length > 3 && raw[3] is num ? (raw[3] as num).toInt() : 0,
    color: raw.length > 4 && raw[4] is num ? (raw[4] as num).toInt() : 0,
  );
}

domain.LiveDanmakuTitle? _toDanmakuTitle(List<dynamic>? raw) {
  if (raw == null || raw.isEmpty) return null;
  return domain.LiveDanmakuTitle(
    title: raw.first?.toString() ?? '',
    skin: raw.length > 1 ? raw[1]?.toString() ?? '' : '',
  );
}

domain.LiveDanmakuUserLevel? _toDanmakuUserLevel(List<dynamic>? raw) {
  if (raw == null || raw.isEmpty) return null;
  return domain.LiveDanmakuUserLevel(
    level: raw.first is num ? (raw.first as num).toInt() : 0,
    rank: raw.length > 1 && raw[1] is num ? (raw[1] as num).toInt() : 0,
  );
}

extension LiveDanmakuItemMapper on dto.LiveDanmakuItem {
  domain.LiveDanmakuItem toDomain() {
    return domain.LiveDanmakuItem(
      text: text,
      nickname: nickname,
      uid: uid,
      timeline: timeline,
      dmType: dmType,
      isadmin: isadmin,
      vip: vip,
      svip: svip,
      medal: _toDanmakuMedal(medal),
      title: _toDanmakuTitle(title),
      userLevel: _toDanmakuUserLevel(userLevel),
      rank: rank,
      teamid: teamid,
      rnd: rnd,
      userTitle: userTitle,
      guardLevel: guardLevel,
      bubble: bubble,
      checkInfo: checkInfo,
    );
  }
}
