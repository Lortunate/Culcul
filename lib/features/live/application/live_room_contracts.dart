import 'package:culcul/features/live/data/dtos/live_anchor_info_model.dart' as dto;
import 'package:culcul/features/live/data/dtos/live_danmaku_model.dart' as dto;
import 'package:culcul/features/live/data/dtos/live_danmu_info_model.dart' as dto;
import 'package:culcul/features/live/data/dtos/live_gold_rank_model.dart' as dto;
import 'package:culcul/features/live/data/dtos/live_guard_list_model.dart' as dto;
import 'package:culcul/features/live/data/dtos/live_play_url_model.dart' as dto;
import 'package:culcul/features/live/data/dtos/live_room_detail_model.dart' as dto;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_room_contracts.freezed.dart';

typedef LiveRoomDetailModel = LiveRoomDetail;
typedef LiveAnchorInfoModel = LiveAnchorProfile;
typedef LiveGoldRankModel = LiveGoldRank;
typedef LiveGuardListModel = LiveGuardList;
typedef LivePlayUrlModel = LivePlayUrl;
typedef LiveDanmakuConfigModel = LiveDanmakuConfig;
typedef LiveDanmuInfoModel = LiveDanmuInfo;

@freezed
sealed class LiveRoomDetail with _$LiveRoomDetail {
  const factory LiveRoomDetail({
    required int uid,
    required int roomId,
    required int attention,
    required int online,
    required String title,
    required String userCover,
    required String areaName,
    required int liveStatus,
  }) = _LiveRoomDetail;
}

@freezed
sealed class LiveAnchorProfile with _$LiveAnchorProfile {
  const factory LiveAnchorProfile({
    required LiveAnchorExp exp,
    required int followerNum,
  }) = _LiveAnchorProfile;
}

@freezed
sealed class LiveAnchorExp with _$LiveAnchorExp {
  const factory LiveAnchorExp({required LiveMasterLevel masterLevel}) = _LiveAnchorExp;
}

@freezed
sealed class LiveMasterLevel with _$LiveMasterLevel {
  const factory LiveMasterLevel({
    required int level,
    required int color,
    required List<int> current,
    required List<int> next,
  }) = _LiveMasterLevel;
}

@freezed
sealed class LiveGoldRank with _$LiveGoldRank {
  const factory LiveGoldRank({required int onlineNum, required List<LiveRankItem> list}) =
      _LiveGoldRank;
}

@freezed
sealed class LiveRankItem with _$LiveRankItem {
  const factory LiveRankItem({
    required int userRank,
    required int uid,
    required String name,
    required String face,
    required int score,
    required int guardLevel,
    required int wealthLevel,
  }) = _LiveRankItem;
}

@freezed
sealed class LiveGuardList with _$LiveGuardList {
  const factory LiveGuardList({
    required LiveGuardInfo info,
    @Default([]) List<LiveGuardItem> top3,
    @Default([]) List<LiveGuardItem> list,
  }) = _LiveGuardList;
}

@freezed
sealed class LiveGuardInfo with _$LiveGuardInfo {
  const factory LiveGuardInfo({required int num, required int page, required int now}) =
      _LiveGuardInfo;
}

@freezed
sealed class LiveGuardItem with _$LiveGuardItem {
  const factory LiveGuardItem({
    required int ruid,
    required int rank,
    required int guardLevel,
  }) = _LiveGuardItem;
}

@freezed
sealed class LivePlayUrl with _$LivePlayUrl {
  const factory LivePlayUrl({
    required int currentQuality,
    required List<String> acceptQuality,
    required int currentQn,
    required List<LiveQualityDescription> qualityDescription,
    required List<LiveStreamUrl> durl,
  }) = _LivePlayUrl;
}

@freezed
sealed class LiveQualityDescription with _$LiveQualityDescription {
  const factory LiveQualityDescription({required int qn, required String desc}) =
      _LiveQualityDescription;
}

@freezed
sealed class LiveStreamUrl with _$LiveStreamUrl {
  const factory LiveStreamUrl({
    required String url,
    required int length,
    required int order,
    required int streamType,
    required int p2pType,
  }) = _LiveStreamUrl;
}

@freezed
sealed class LiveDanmakuConfig with _$LiveDanmakuConfig {
  const factory LiveDanmakuConfig({
    required List<LiveDanmakuGroup> group,
    required List<LiveDanmakuMode> mode,
  }) = _LiveDanmakuConfig;
}

@freezed
sealed class LiveDanmakuGroup with _$LiveDanmakuGroup {
  const factory LiveDanmakuGroup({
    required String name,
    required int sort,
    required List<LiveDanmakuColor> color,
  }) = _LiveDanmakuGroup;
}

@freezed
sealed class LiveDanmakuColor with _$LiveDanmakuColor {
  const factory LiveDanmakuColor({
    required String name,
    required String color,
    required String colorHex,
    required int status,
    required int weight,
    required int colorId,
    required int origin,
  }) = _LiveDanmakuColor;
}

@freezed
sealed class LiveDanmakuMode with _$LiveDanmakuMode {
  const factory LiveDanmakuMode({
    required String name,
    required int mode,
    required String type,
    required int status,
  }) = _LiveDanmakuMode;
}

@freezed
sealed class LiveDanmuInfo with _$LiveDanmuInfo {
  const factory LiveDanmuInfo({
    required String token,
    required List<LiveDanmuHost> hostList,
  }) = _LiveDanmuInfo;
}

@freezed
sealed class LiveDanmuHost with _$LiveDanmuHost {
  const factory LiveDanmuHost({
    required String host,
    required int wssPort,
    required int wsPort,
  }) = _LiveDanmuHost;
}

extension LiveRoomDetailDtoMapper on dto.LiveRoomDetailModel {
  LiveRoomDetail toLiveRoomDetail() {
    return LiveRoomDetail(
      uid: uid,
      roomId: roomId,
      attention: attention,
      online: online,
      title: title,
      userCover: userCover,
      areaName: areaName,
      liveStatus: liveStatus,
    );
  }
}

extension LiveAnchorInfoDtoMapper on dto.LiveAnchorInfoModel {
  LiveAnchorProfile toLiveAnchorProfile() {
    return LiveAnchorProfile(exp: exp.toLiveAnchorExp(), followerNum: followerNum);
  }
}

extension LiveAnchorExpDtoMapper on dto.LiveAnchorExp {
  LiveAnchorExp toLiveAnchorExp() {
    return LiveAnchorExp(masterLevel: masterLevel.toLiveMasterLevel());
  }
}

extension LiveMasterLevelDtoMapper on dto.LiveMasterLevel {
  LiveMasterLevel toLiveMasterLevel() {
    return LiveMasterLevel(level: level, color: color, current: current, next: next);
  }
}

extension LiveGoldRankDtoMapper on dto.LiveGoldRankModel {
  LiveGoldRank toLiveGoldRank() {
    return LiveGoldRank(
      onlineNum: onlineNum,
      list: list.map((item) => item.toLiveRankItem()).toList(),
    );
  }
}

extension LiveRankItemDtoMapper on dto.LiveRankItem {
  LiveRankItem toLiveRankItem() {
    return LiveRankItem(
      userRank: userRank,
      uid: uid,
      name: name,
      face: face,
      score: score,
      guardLevel: guardLevel,
      wealthLevel: wealthLevel,
    );
  }
}

extension LiveGuardListDtoMapper on dto.LiveGuardListModel {
  LiveGuardList toLiveGuardList() {
    return LiveGuardList(
      info: info.toLiveGuardInfo(),
      top3: top3.map((item) => item.toLiveGuardItem()).toList(),
      list: list.map((item) => item.toLiveGuardItem()).toList(),
    );
  }
}

extension LiveGuardInfoDtoMapper on dto.LiveGuardInfo {
  LiveGuardInfo toLiveGuardInfo() {
    return LiveGuardInfo(num: num, page: page, now: now);
  }
}

extension LiveGuardItemDtoMapper on dto.LiveGuardItem {
  LiveGuardItem toLiveGuardItem() {
    return LiveGuardItem(ruid: ruid, rank: rank, guardLevel: guardLevel);
  }
}

extension LivePlayUrlDtoMapper on dto.LivePlayUrlModel {
  LivePlayUrl toLivePlayUrl() {
    return LivePlayUrl(
      currentQuality: currentQuality,
      acceptQuality: acceptQuality,
      currentQn: currentQn,
      qualityDescription: qualityDescription
          .map((item) => item.toLiveQualityDescription())
          .toList(),
      durl: durl.map((item) => item.toLiveStreamUrl()).toList(),
    );
  }
}

extension LiveQualityDescriptionDtoMapper on dto.LiveQualityDescription {
  LiveQualityDescription toLiveQualityDescription() {
    return LiveQualityDescription(qn: qn, desc: desc);
  }
}

extension LiveStreamUrlDtoMapper on dto.LiveStreamUrl {
  LiveStreamUrl toLiveStreamUrl() {
    return LiveStreamUrl(
      url: url,
      length: length,
      order: order,
      streamType: streamType,
      p2pType: p2pType,
    );
  }
}

extension LiveDanmakuConfigDtoMapper on dto.LiveDanmakuConfigModel {
  LiveDanmakuConfig toLiveDanmakuConfig() {
    return LiveDanmakuConfig(
      group: group.map((item) => item.toLiveDanmakuGroup()).toList(),
      mode: mode.map((item) => item.toLiveDanmakuMode()).toList(),
    );
  }
}

extension LiveDanmakuGroupDtoMapper on dto.LiveDanmakuGroup {
  LiveDanmakuGroup toLiveDanmakuGroup() {
    return LiveDanmakuGroup(
      name: name,
      sort: sort,
      color: color.map((item) => item.toLiveDanmakuColor()).toList(),
    );
  }
}

extension LiveDanmakuColorDtoMapper on dto.LiveDanmakuColor {
  LiveDanmakuColor toLiveDanmakuColor() {
    return LiveDanmakuColor(
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

extension LiveDanmakuModeDtoMapper on dto.LiveDanmakuMode {
  LiveDanmakuMode toLiveDanmakuMode() {
    return LiveDanmakuMode(name: name, mode: mode, type: type, status: status);
  }
}

extension LiveDanmuInfoDtoMapper on dto.LiveDanmuInfoModel {
  LiveDanmuInfo toLiveDanmuInfo() {
    return LiveDanmuInfo(
      token: token,
      hostList: hostList.map((item) => item.toLiveDanmuHost()).toList(),
    );
  }
}

extension LiveDanmuHostDtoMapper on dto.LiveDanmuHost {
  LiveDanmuHost toLiveDanmuHost() {
    return LiveDanmuHost(host: host, wssPort: wssPort, wsPort: wsPort);
  }
}
