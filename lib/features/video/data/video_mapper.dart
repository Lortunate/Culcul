import 'package:culcul/features/video/data/dtos/player_info_dto.dart' as player_dto;
import 'package:culcul/features/video/data/dtos/play_url_dto.dart' as play_dto;
import 'package:culcul/features/video/data/dtos/related_video_dto.dart' as related_dto;
import 'package:culcul/features/video/data/dtos/subtitle_dto.dart' as subtitle_dto;
import 'package:culcul/features/video/data/dtos/video_detail_dto.dart' as detail_dto;
import 'package:culcul/features/video/data/dtos/video_model_dto.dart' as model_dto;
import 'package:culcul/features/video/domain/entities/video_entities_exports.dart'
    as domain;

extension VideoModelMapper on model_dto.VideoModel {
  domain.VideoModel toDomain() {
    return domain.VideoModel(
      bvid: bvid,
      title: title,
      pic: pic,
      owner: owner.toDomain(),
      stat: stat.toDomain(),
      duration: duration,
      pubDate: pubDate,
      desc: desc,
      rcmdReason: rcmdReason,
    );
  }
}

extension VideoOwnerMapper on model_dto.Owner {
  domain.Owner toDomain() {
    return domain.Owner(mid: mid, name: name, face: face);
  }
}

extension VideoStatMapper on model_dto.Stat {
  domain.Stat toDomain() {
    return domain.Stat(
      view: view,
      danmaku: danmaku,
      reply: reply,
      like: like,
      coin: coin,
      favorite: favorite,
      share: share,
    );
  }
}

extension VideoDetailMapper on detail_dto.VideoDetail {
  domain.VideoDetail toDomain() {
    return domain.VideoDetail(
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
      owner: owner.toDomain(),
      stat: stat.toDomain(),
      dimension: dimension.toDomain(),
      pages: pages.map((item) => item.toDomain()).toList(),
      subtitle: subtitle?.toDomain(),
      tag: tag.map((item) => item.toDomain()).toList(),
      reqUser: reqUser?.toDomain(),
    );
  }
}

extension VideoReqUserMapper on detail_dto.ReqUser {
  domain.ReqUser toDomain() {
    return domain.ReqUser(attention: attention, guestAttention: guestAttention);
  }
}

extension VideoPageMapper on detail_dto.VideoPage {
  domain.VideoPage toDomain() {
    return domain.VideoPage(
      cid: cid,
      page: page,
      from: from,
      part: part,
      duration: duration,
      vid: vid,
      weblink: weblink,
      dimension: dimension.toDomain(),
    );
  }
}

extension VideoDimensionMapper on detail_dto.VideoDimension {
  domain.VideoDimension toDomain() {
    return domain.VideoDimension(width: width, height: height, rotate: rotate);
  }
}

extension VideoTagMapper on detail_dto.VideoTag {
  domain.VideoTag toDomain() {
    return domain.VideoTag(
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
      count: count.toDomain(),
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

extension VideoTagCountMapper on detail_dto.TagCount {
  domain.TagCount toDomain() {
    return domain.TagCount(view: view, use: use, atten: atten);
  }
}

extension PlayUrlMapper on play_dto.PlayUrl {
  domain.PlayUrl toDomain() {
    return domain.PlayUrl(
      format: format,
      quality: quality,
      timeLength: timeLength,
      acceptFormat: acceptFormat,
      acceptDescription: acceptDescription,
      acceptQuality: acceptQuality,
      videoCodecId: videoCodecId,
      durl: durl.map((item) => item.toDomain()).toList(),
      dash: dash?.toDomain(),
      supportFormats: supportFormats.map((item) => item.toDomain()).toList(),
    );
  }
}

extension PlayDashMapper on play_dto.DashInfo {
  domain.DashInfo toDomain() {
    return domain.DashInfo(audio: audio.map((item) => item.toDomain()).toList());
  }
}

extension PlayDashStreamMapper on play_dto.DashStream {
  domain.DashStream toDomain() {
    return domain.DashStream(
      id: id,
      baseUrl: baseUrl,
      backupUrl: backupUrl,
      bandwidth: bandwidth,
    );
  }
}

extension PlayDurlMapper on play_dto.Durl {
  domain.Durl toDomain() {
    return domain.Durl(
      order: order,
      length: length,
      size: size,
      url: url,
      backupUrl: backupUrl,
    );
  }
}

extension PlaySupportFormatMapper on play_dto.SupportFormat {
  domain.SupportFormat toDomain() {
    return domain.SupportFormat(
      quality: quality,
      format: format,
      newDescription: newDescription,
      displayDesc: displayDesc,
      superscript: superscript,
      codecs: codecs,
    );
  }
}

extension PlayerInfoMapper on player_dto.PlayerInfo {
  domain.PlayerInfo toDomain() {
    return domain.PlayerInfo(dmMask: dmMask?.toDomain());
  }
}

extension PlayerDmMaskMapper on player_dto.DmMask {
  domain.DmMask toDomain() {
    return domain.DmMask(maskUrl: maskUrl, fps: fps);
  }
}

extension RelatedVideoMapper on related_dto.RelatedVideo {
  domain.RelatedVideo toDomain() {
    return domain.RelatedVideo(
      aid: aid,
      bvid: bvid,
      cid: cid,
      title: title,
      pic: pic,
      owner: owner.toDomain(),
      stat: stat.toDomain(),
      duration: duration,
      pubDate: pubDate,
      desc: desc,
      shortLink: shortLink,
      rcmdReason: rcmdReason,
    );
  }
}

extension VideoSubtitleMapper on subtitle_dto.VideoSubtitle {
  domain.VideoSubtitle toDomain() {
    return domain.VideoSubtitle(list: list.map((item) => item.toDomain()).toList());
  }
}

extension SubtitleInfoMapper on subtitle_dto.SubtitleInfo {
  domain.SubtitleInfo toDomain() {
    return domain.SubtitleInfo(
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

extension SubtitleContentMapper on subtitle_dto.SubtitleContent {
  domain.SubtitleContent toDomain() {
    return domain.SubtitleContent(
      fontSize: fontSize,
      fontColor: fontColor,
      backgroundAlpha: backgroundAlpha,
      backgroundColor: backgroundColor,
      body: body.map((item) => item.toDomain()).toList(),
    );
  }
}

extension SubtitleItemMapper on subtitle_dto.SubtitleItem {
  domain.SubtitleItem toDomain() {
    return domain.SubtitleItem(from: from, to: to, location: location, content: content);
  }
}
