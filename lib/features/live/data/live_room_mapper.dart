import 'package:culcul/core/contracts/live_room_summary_contract.dart' as contract;
import 'package:culcul/features/live/data/dtos/live_dtos.dart' as dto;
import 'package:culcul/features/live/domain/entities/live_entities.dart' as domain;

extension WatchedShowMapper on dto.WatchedShow {
  domain.WatchedShow toDomain() {
    return domain.WatchedShow(
      switchStatus: switchStatus,
      num: this.num,
      textSmall: textSmall,
      textLarge: textLarge,
      icon: icon,
      iconWeb: iconWeb,
    );
  }

  contract.LiveWatchedShow toSummary() {
    return contract.LiveWatchedShow(
      switchStatus: switchStatus,
      num: this.num,
      textSmall: textSmall,
      textLarge: textLarge,
      icon: icon,
      iconWeb: iconWeb,
    );
  }
}

extension LiveRoomModelMapper on dto.LiveRoomModel {
  domain.LiveRoomModel toDomain() {
    return domain.LiveRoomModel(
      roomId: roomId,
      uid: uid,
      title: title,
      uname: uname,
      cover: cover,
      face: face,
      online: online,
      areaName: areaName,
      parentAreaName: parentAreaName,
      link: link,
      keyframe: keyframe,
      watchedShow: watchedShow?.toDomain(),
      isAutoPlay: isAutoPlay,
    );
  }

  contract.LiveRoomSummary toSummary() {
    return contract.LiveRoomSummary(
      roomId: roomId,
      uid: uid,
      title: title,
      uname: uname,
      cover: cover,
      face: face,
      online: online,
      areaName: areaName,
      parentAreaName: parentAreaName,
      link: link,
      keyframe: keyframe,
      watchedShow: watchedShow?.toSummary(),
      isAutoPlay: isAutoPlay,
    );
  }
}

extension LiveRoomDetailModelMapper on dto.LiveRoomDetailModel {
  domain.LiveRoomDetailModel toDomain() {
    return domain.LiveRoomDetailModel(
      uid: uid,
      roomId: roomId,
      shortId: shortId,
      attention: attention,
      online: online,
      isPortrait: isPortrait,
      description: description,
      liveStatus: liveStatus,
      areaId: areaId,
      parentAreaId: parentAreaId,
      parentAreaName: parentAreaName,
      oldAreaId: oldAreaId,
      background: background,
      title: title,
      userCover: userCover,
      keyframe: keyframe,
      isStrictRoom: isStrictRoom,
      liveTime: liveTime,
      tags: tags,
      isAnchor: isAnchor,
      roomSilentType: roomSilentType,
      roomSilentLevel: roomSilentLevel,
      roomSilentSecond: roomSilentSecond,
      areaName: areaName,
      pendants: pendants,
      areaPendants: areaPendants,
      hotWords: hotWords,
      hotWordsStatus: hotWordsStatus,
      verify: verify,
      newPendants: newPendants,
      upSession: upSession,
      pkStatus: pkStatus,
      pkId: pkId,
      battleId: battleId,
      allowChangeAreaTime: allowChangeAreaTime,
      allowUploadCoverTime: allowUploadCoverTime,
      studioInfo: studioInfo,
    );
  }
}

extension LivePlayUrlModelMapper on dto.LivePlayUrlModel {
  domain.LivePlayUrlModel toDomain() {
    return domain.LivePlayUrlModel(
      currentQuality: currentQuality,
      acceptQuality: acceptQuality,
      currentQn: currentQn,
      qualityDescription: qualityDescription.map((item) => item.toDomain()).toList(),
      durl: durl.map((item) => item.toDomain()).toList(),
    );
  }
}

extension LiveQualityDescriptionMapper on dto.LiveQualityDescription {
  domain.LiveQualityDescription toDomain() {
    return domain.LiveQualityDescription(qn: qn, desc: desc);
  }
}

extension LiveStreamUrlMapper on dto.LiveStreamUrl {
  domain.LiveStreamUrl toDomain() {
    return domain.LiveStreamUrl(
      url: url,
      length: length,
      order: order,
      streamType: streamType,
      p2pType: p2pType,
    );
  }
}

extension LiveDanmakuConfigModelMapper on dto.LiveDanmakuConfigModel {
  domain.LiveDanmakuConfigModel toDomain() {
    return domain.LiveDanmakuConfigModel(
      group: group.map((item) => item.toDomain()).toList(),
      mode: mode.map((item) => item.toDomain()).toList(),
    );
  }
}

extension LiveDanmakuGroupMapper on dto.LiveDanmakuGroup {
  domain.LiveDanmakuGroup toDomain() {
    return domain.LiveDanmakuGroup(
      name: name,
      sort: sort,
      color: color.map((item) => item.toDomain()).toList(),
    );
  }
}

extension LiveDanmakuColorMapper on dto.LiveDanmakuColor {
  domain.LiveDanmakuColor toDomain() {
    return domain.LiveDanmakuColor(
      name: name,
      color: color,
      colorHex: colorHex,
      status: status,
      weight: weight,
      colorId: colorId,
      origin: origin,
    );
  }
}

extension LiveDanmakuModeMapper on dto.LiveDanmakuMode {
  domain.LiveDanmakuMode toDomain() {
    return domain.LiveDanmakuMode(name: name, mode: mode, type: type, status: status);
  }
}

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

extension LiveDanmuInfoModelMapper on dto.LiveDanmuInfoModel {
  domain.LiveDanmuInfoModel toDomain() {
    return domain.LiveDanmuInfoModel(
      token: token,
      hostList: hostList.map((item) => item.toDomain()).toList(),
    );
  }
}

extension LiveDanmuHostMapper on dto.LiveDanmuHost {
  domain.LiveDanmuHost toDomain() {
    return domain.LiveDanmuHost(host: host, wssPort: wssPort, wsPort: wsPort);
  }
}

extension LiveAnchorInfoModelMapper on dto.LiveAnchorInfoModel {
  domain.LiveAnchorInfoModel toDomain() {
    return domain.LiveAnchorInfoModel(
      info: info.toDomain(),
      exp: exp.toDomain(),
      followerNum: followerNum,
      roomId: roomId,
      medalName: medalName,
      gloryCount: gloryCount,
      pendant: pendant,
    );
  }
}

extension LiveAnchorInfoMapper on dto.LiveAnchorInfo {
  domain.LiveAnchorInfo toDomain() {
    return domain.LiveAnchorInfo(
      uid: uid,
      uname: uname,
      face: face,
      officialVerify: officialVerify.toDomain(),
      gender: gender,
    );
  }
}

extension LiveAnchorVerifyMapper on dto.LiveAnchorVerify {
  domain.LiveAnchorVerify toDomain() {
    return domain.LiveAnchorVerify(type: type, desc: desc);
  }
}

extension LiveAnchorExpMapper on dto.LiveAnchorExp {
  domain.LiveAnchorExp toDomain() {
    return domain.LiveAnchorExp(masterLevel: masterLevel.toDomain());
  }
}

extension LiveMasterLevelMapper on dto.LiveMasterLevel {
  domain.LiveMasterLevel toDomain() {
    return domain.LiveMasterLevel(
      level: level,
      color: color,
      current: current,
      next: next,
    );
  }
}

extension LiveGoldRankModelMapper on dto.LiveGoldRankModel {
  domain.LiveGoldRankModel toDomain() {
    return domain.LiveGoldRankModel(
      onlineNum: onlineNum,
      list: list.map((item) => item.toDomain()).toList(),
    );
  }
}

extension LiveRankItemMapper on dto.LiveRankItem {
  domain.LiveRankItem toDomain() {
    return domain.LiveRankItem(
      userRank: userRank,
      uid: uid,
      name: name,
      face: face,
      score: score,
      medalInfo: medalInfo.toDomain(),
      guardLevel: guardLevel,
      wealthLevel: wealthLevel,
    );
  }
}

extension LiveRankMedalInfoMapper on dto.LiveRankMedalInfo {
  domain.LiveRankMedalInfo toDomain() {
    return domain.LiveRankMedalInfo(
      guardLevel: guardLevel,
      medalColorStart: medalColorStart,
      medalColorEnd: medalColorEnd,
      medalColorBorder: medalColorBorder,
      medalName: medalName,
      level: level,
      targetId: targetId,
      isLight: isLight,
    );
  }
}

extension LiveGuardListModelMapper on dto.LiveGuardListModel {
  domain.LiveGuardListModel toDomain() {
    return domain.LiveGuardListModel(
      info: info.toDomain(),
      top3: top3.map((item) => item.toDomain()).toList(),
      list: list.map((item) => item.toDomain()).toList(),
    );
  }
}

extension LiveGuardInfoMapper on dto.LiveGuardInfo {
  domain.LiveGuardInfo toDomain() {
    return domain.LiveGuardInfo(num: this.num, page: page, now: now);
  }
}

extension LiveGuardItemMapper on dto.LiveGuardItem {
  domain.LiveGuardItem toDomain() {
    return domain.LiveGuardItem(
      ruid: ruid,
      rank: rank,
      userInfo: userInfo.toDomain(),
      guardLevel: guardLevel,
    );
  }
}

extension LiveGuardUserInfoMapper on dto.LiveGuardUserInfo {
  domain.LiveGuardUserInfo toDomain() {
    return domain.LiveGuardUserInfo(uid: uid, base: base.toDomain());
  }
}

extension LiveGuardUserBaseMapper on dto.LiveGuardUserBase {
  domain.LiveGuardUserBase toDomain() {
    return domain.LiveGuardUserBase(name: name, face: face);
  }
}

extension LiveRecommendResponseMapper on dto.LiveRecommendResponse {
  domain.LiveRecommendResponse toDomain() {
    return domain.LiveRecommendResponse(
      roomList: roomList.map((item) => item.toDomain()).toList(),
    );
  }
}
