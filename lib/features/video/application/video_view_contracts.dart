import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/features/video/data/dtos/danmaku_model.dart' as dto;
import 'package:culcul/features/video/data/dtos/play_url_dto.dart' as dto;
import 'package:culcul/features/video/data/dtos/related_video_dto.dart' as dto;
import 'package:culcul/features/video/data/dtos/subtitle_dto.dart' as dto;
import 'package:culcul/features/video/data/dtos/video_detail_dto.dart' as dto;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_view_contracts.freezed.dart';

@freezed
sealed class VideoDetail with _$VideoDetail {
  const factory VideoDetail({
    required String bvid,
    required int aid,
    required int videos,
    required int tid,
    required String tname,
    required dynamic copyright,
    required String pic,
    required String title,
    required int pubDate,
    required int ctime,
    required String desc,
    required VideoOwner owner,
    required VideoStat stat,
    @Default(VideoDimension()) VideoDimension dimension,
    @Default([]) List<VideoPage> pages,
    VideoSubtitle? subtitle,
    @Default([]) List<VideoTag> tag,
    ReqUser? reqUser,
  }) = _VideoDetail;
}

@freezed
sealed class ReqUser with _$ReqUser {
  const factory ReqUser({@Default(0) int attention, @Default(0) int guestAttention}) =
      _ReqUser;
}

@freezed
sealed class VideoPage with _$VideoPage {
  const factory VideoPage({
    required int cid,
    @Default(0) int page,
    @Default('') String from,
    @Default('') String part,
    @Default(0) int duration,
    @Default('') String vid,
    @Default('') String weblink,
    @Default(VideoDimension()) VideoDimension dimension,
  }) = _VideoPage;
}

@freezed
sealed class VideoDimension with _$VideoDimension {
  const factory VideoDimension({
    @Default(0) int width,
    @Default(0) int height,
    @Default(0) int rotate,
  }) = _VideoDimension;
}

@freezed
sealed class VideoTag with _$VideoTag {
  const factory VideoTag({
    @Default(0) int tagId,
    @Default('') String tagName,
    @Default('') String cover,
    @Default(0) int likes,
    @Default(0) int hates,
    @Default(0) int liked,
    @Default(0) int hated,
    @Default(0) int attribute,
    @Default(0) int isActivity,
    @Default('') String uri,
    @Default('') String tagType,
    @Default(TagCount()) TagCount count,
    @Default(0) int type,
    @Default(0) int state,
    @Default(0) int ctime,
    @Default(0) int mtime,
    @Default(0) int atime,
    @Default(0) int isAtten,
    @Default(0) int extraAttr,
    @Default('') String musicId,
    @Default('') String content,
    @Default('') String shortContent,
    @Default('') String headCover,
  }) = _VideoTag;
}

@freezed
sealed class TagCount with _$TagCount {
  const factory TagCount({
    @Default(0) int view,
    @Default(0) int use,
    @Default(0) int atten,
  }) = _TagCount;
}

@freezed
sealed class PlayUrl with _$PlayUrl {
  const factory PlayUrl({
    required String format,
    required int quality,
    required int timeLength,
    required String acceptFormat,
    required List<String> acceptDescription,
    required List<int> acceptQuality,
    required int videoCodecId,
    required List<Durl> durl,
    DashInfo? dash,
    @Default([]) List<SupportFormat> supportFormats,
  }) = _PlayUrl;
}

@freezed
sealed class DashInfo with _$DashInfo {
  const factory DashInfo({@Default([]) List<DashStream> audio}) = _DashInfo;
}

@freezed
sealed class DashStream with _$DashStream {
  const factory DashStream({
    required int id,
    required String baseUrl,
    @Default([]) List<String> backupUrl,
    @Default(0) int bandwidth,
  }) = _DashStream;
}

@freezed
sealed class Durl with _$Durl {
  const factory Durl({
    required int order,
    required int length,
    required int size,
    required String url,
    @Default([]) List<String> backupUrl,
  }) = _Durl;
}

@freezed
sealed class SupportFormat with _$SupportFormat {
  const factory SupportFormat({
    required int quality,
    required String format,
    required String newDescription,
    required String displayDesc,
    required String superscript,
    @Default([]) List<String> codecs,
  }) = _SupportFormat;
}

@freezed
sealed class RelatedVideo with _$RelatedVideo {
  const factory RelatedVideo({
    required int aid,
    required String bvid,
    @Default(0) int cid,
    required String title,
    required String pic,
    required VideoOwner owner,
    required VideoStat stat,
    required int duration,
    required int pubDate,
    @Default('') String desc,
    @Default('') String shortLink,
    @Default('') String rcmdReason,
  }) = _RelatedVideo;
}

@freezed
sealed class VideoSubtitle with _$VideoSubtitle {
  const factory VideoSubtitle({@Default([]) List<SubtitleInfo> list}) = _VideoSubtitle;
}

@freezed
sealed class SubtitleInfo with _$SubtitleInfo {
  const factory SubtitleInfo({
    required int id,
    required String lan,
    required String lanDoc,
    required String subtitleUrl,
    @Default(false) bool isLock,
    String? idStr,
    @Default(0) int type,
  }) = _SubtitleInfo;
}

@freezed
sealed class SubtitleItem with _$SubtitleItem {
  const factory SubtitleItem({
    required double from,
    required double to,
    required int location,
    required String content,
  }) = _SubtitleItem;
}

@freezed
sealed class DanmakuEntry with _$DanmakuEntry {
  const factory DanmakuEntry({
    required String content,
    required int progress,
    required int color,
    required int mode,
  }) = _DanmakuEntry;
}

extension VideoDetailDtoMapper on dto.VideoDetail {
  VideoDetail toVideoDetail() {
    return VideoDetail(
      bvid: bvid,
      aid: aid,
      videos: videos,
      tid: tid,
      tname: tname,
      copyright: copyright,
      pic: pic,
      title: title,
      pubDate: pubDate,
      ctime: ctime,
      desc: desc,
      owner: owner,
      stat: stat,
      dimension: dimension.toVideoDimension(),
      pages: pages.map((item) => item.toVideoPage()).toList(),
      subtitle: subtitle?.toVideoSubtitle(),
      tag: tag.map((item) => item.toVideoTag()).toList(),
      reqUser: reqUser?.toReqUser(),
    );
  }
}

extension ReqUserDtoMapper on dto.ReqUser {
  ReqUser toReqUser() {
    return ReqUser(attention: attention, guestAttention: guestAttention);
  }
}

extension VideoPageDtoMapper on dto.VideoPage {
  VideoPage toVideoPage() {
    return VideoPage(
      cid: cid,
      page: page,
      from: from,
      part: part,
      duration: duration,
      vid: vid,
      weblink: weblink,
      dimension: dimension.toVideoDimension(),
    );
  }
}

extension VideoDimensionDtoMapper on dto.VideoDimension {
  VideoDimension toVideoDimension() {
    return VideoDimension(width: width, height: height, rotate: rotate);
  }
}

extension VideoTagDtoMapper on dto.VideoTag {
  VideoTag toVideoTag() {
    return VideoTag(
      tagId: tagId,
      tagName: tagName,
      cover: cover,
      likes: likes,
      hates: hates,
      liked: liked,
      hated: hated,
      attribute: attribute,
      isActivity: isActivity,
      uri: uri,
      tagType: tagType,
      count: count.toTagCount(),
      type: type,
      state: state,
      ctime: ctime,
      mtime: mtime,
      atime: atime,
      isAtten: isAtten,
      extraAttr: extraAttr,
      musicId: musicId,
      content: content,
      shortContent: shortContent,
      headCover: headCover,
    );
  }
}

extension TagCountDtoMapper on dto.TagCount {
  TagCount toTagCount() {
    return TagCount(view: view, use: use, atten: atten);
  }
}

extension PlayUrlDtoMapper on dto.PlayUrl {
  PlayUrl toPlayUrl() {
    return PlayUrl(
      format: format,
      quality: quality,
      timeLength: timeLength,
      acceptFormat: acceptFormat,
      acceptDescription: acceptDescription,
      acceptQuality: acceptQuality,
      videoCodecId: videoCodecId,
      durl: durl.map((item) => item.toDurl()).toList(),
      dash: dash?.toDashInfo(),
      supportFormats: supportFormats.map((item) => item.toSupportFormat()).toList(),
    );
  }
}

extension DashInfoDtoMapper on dto.DashInfo {
  DashInfo toDashInfo() {
    return DashInfo(audio: audio.map((item) => item.toDashStream()).toList());
  }
}

extension DashStreamDtoMapper on dto.DashStream {
  DashStream toDashStream() {
    return DashStream(
      id: id,
      baseUrl: baseUrl,
      backupUrl: backupUrl,
      bandwidth: bandwidth,
    );
  }
}

extension DurlDtoMapper on dto.Durl {
  Durl toDurl() {
    return Durl(order: order, length: length, size: size, url: url, backupUrl: backupUrl);
  }
}

extension SupportFormatDtoMapper on dto.SupportFormat {
  SupportFormat toSupportFormat() {
    return SupportFormat(
      quality: quality,
      format: format,
      newDescription: newDescription,
      displayDesc: displayDesc,
      superscript: superscript,
      codecs: codecs,
    );
  }
}

extension RelatedVideoDtoMapper on dto.RelatedVideo {
  RelatedVideo toRelatedVideo() {
    return RelatedVideo(
      aid: aid,
      bvid: bvid,
      cid: cid,
      title: title,
      pic: pic,
      owner: owner,
      stat: stat,
      duration: duration,
      pubDate: pubDate,
      desc: desc,
      shortLink: shortLink,
      rcmdReason: rcmdReason,
    );
  }
}

extension RelatedVideoDtoListMapper on Iterable<dto.RelatedVideo> {
  List<RelatedVideo> toRelatedVideos() {
    return map((item) => item.toRelatedVideo()).toList();
  }
}

extension VideoSubtitleDtoMapper on dto.VideoSubtitleDto {
  VideoSubtitle toVideoSubtitle() {
    return VideoSubtitle(list: list.map((item) => item.toSubtitleInfo()).toList());
  }
}

extension SubtitleInfoDtoMapper on dto.SubtitleInfo {
  SubtitleInfo toSubtitleInfo() {
    return SubtitleInfo(
      id: id,
      lan: lan,
      lanDoc: lanDoc,
      subtitleUrl: subtitleUrl,
      isLock: isLock,
      idStr: idStr,
      type: type,
    );
  }
}

extension SubtitleItemDtoMapper on dto.SubtitleItem {
  SubtitleItem toSubtitleItem() {
    return SubtitleItem(from: from, to: to, location: location, content: content);
  }
}

extension SubtitleItemDtoListMapper on Iterable<dto.SubtitleItem> {
  List<SubtitleItem> toSubtitleItems() {
    return map((item) => item.toSubtitleItem()).toList();
  }
}

extension DanmakuEntryDtoMapper on dto.DanmakuEntry {
  DanmakuEntry toDanmakuEntry() {
    return DanmakuEntry(content: content, progress: progress, color: color, mode: mode);
  }
}

extension DanmakuEntryDtoListMapper on Iterable<dto.DanmakuEntry> {
  List<DanmakuEntry> toDanmakuEntries() {
    return map((item) => item.toDanmakuEntry()).toList();
  }
}
