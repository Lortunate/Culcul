import 'package:culcul/features/dynamic/data/dtos/dynamic_response.dart' as dto;
import 'package:culcul/features/dynamic/domain/entities/dynamic_response.dart' as domain;

extension DynamicDetailDataMapper on dto.DynamicDetailData {
  domain.DynamicDetailData toDomain() {
    return domain.DynamicDetailData(
      item: item.toDomain(),
    );
  }
}

extension DynamicDataMapper on dto.DynamicData {
  domain.DynamicData toDomain() {
    return domain.DynamicData(
      hasMore: hasMore,
      items: items.map((item) => item.toDomain()).toList(),
      offset: offset,
      updateBaseline: updateBaseline,
      updateNum: updateNum,
    );
  }
}

extension DynamicItemMapper on dto.DynamicItem {
  domain.DynamicItem toDomain() {
    return domain.DynamicItem(
      idStr: idStr,
      type: type,
      visible: visible,
      modules: modules.toDomain(),
      orig: orig?.toDomain(),
      basic: basic?.toDomain(),
    );
  }
}

extension DynamicBasicMapper on dto.DynamicBasic {
  domain.DynamicBasic toDomain() {
    return domain.DynamicBasic(
      commentIdStr: commentIdStr,
      commentType: commentType,
      ridStr: ridStr,
    );
  }
}

extension DynamicModulesMapper on dto.DynamicModules {
  domain.DynamicModules toDomain() {
    return domain.DynamicModules(
      moduleAuthor: moduleAuthor.toDomain(),
      moduleDynamic: moduleDynamic.toDomain(),
      moduleStat: moduleStat?.toDomain(),
    );
  }
}

extension ModuleAuthorMapper on dto.ModuleAuthor {
  domain.ModuleAuthor toDomain() {
    return domain.ModuleAuthor(
      mid: mid,
      name: name,
      avatar: avatar,
      pubTime: pubTime,
      pubAction: pubAction,
    );
  }
}

extension ModuleDynamicMapper on dto.ModuleDynamic {
  domain.ModuleDynamic toDomain() {
    return domain.ModuleDynamic(
      desc: desc?.toDomain(),
      major: major?.toDomain(),
      topic: topic?.toDomain(),
      additional: additional?.toDomain(),
    );
  }
}

extension ModuleAdditionalMapper on dto.ModuleAdditional {
  domain.ModuleAdditional toDomain() {
    return domain.ModuleAdditional(
      type: type,
      common: common?.toDomain(),
      reserve: reserve?.toDomain(),
      goods: goods?.toDomain(),
      vote: vote?.toDomain(),
      ugc: ugc?.toDomain(),
    );
  }
}

extension AdditionalCommonMapper on dto.AdditionalCommon {
  domain.AdditionalCommon toDomain() {
    return domain.AdditionalCommon(
      title: title,
      desc1: desc1,
      desc2: desc2,
      cover: cover,
      jumpUrl: jumpUrl,
      subType: subType,
      headText: headText,
    );
  }
}

extension AdditionalReserveMapper on dto.AdditionalReserve {
  domain.AdditionalReserve toDomain() {
    return domain.AdditionalReserve(
      title: title,
      jumpUrl: jumpUrl,
      reserveTotal: reserveTotal,
      state: state,
      desc1: desc1?.toDomain(),
      desc2: desc2?.toDomain(),
    );
  }
}

extension ReserveDescMapper on dto.ReserveDesc {
  domain.ReserveDesc toDomain() {
    return domain.ReserveDesc(
      text: text,
      style: style,
    );
  }
}

extension AdditionalGoodsMapper on dto.AdditionalGoods {
  domain.AdditionalGoods toDomain() {
    return domain.AdditionalGoods(
      headText: headText,
      items: items.map((item) => item.toDomain()).toList(),
      jumpUrl: jumpUrl,
    );
  }
}

extension GoodsItemMapper on dto.GoodsItem {
  domain.GoodsItem toDomain() {
    return domain.GoodsItem(
      name: name,
      price: price,
      cover: cover,
      jumpUrl: jumpUrl,
    );
  }
}

extension AdditionalVoteMapper on dto.AdditionalVote {
  domain.AdditionalVote toDomain() {
    return domain.AdditionalVote(
      desc: desc,
      endTime: endTime,
      joinNum: joinNum,
      voteId: voteId,
      choiceCnt: choiceCnt,
      status: status,
    );
  }
}

extension AdditionalUgcMapper on dto.AdditionalUgc {
  domain.AdditionalUgc toDomain() {
    return domain.AdditionalUgc(
      title: title,
      cover: cover,
      descSecond: descSecond,
      duration: duration,
      jumpUrl: jumpUrl,
    );
  }
}

extension ModuleDescMapper on dto.ModuleDesc {
  domain.ModuleDesc toDomain() {
    return domain.ModuleDesc(
      text: text,
      richTextNodes: richTextNodes,
    );
  }
}

extension ModuleMajorMapper on dto.ModuleMajor {
  domain.ModuleMajor toDomain() {
    return domain.ModuleMajor(
      type: type,
      archive: archive?.toDomain(),
      draw: draw?.toDomain(),
      ugcSeason: ugcSeason?.toDomain(),
      article: article?.toDomain(),
      common: common?.toDomain(),
      pgc: pgc?.toDomain(),
      courses: courses?.toDomain(),
      music: music?.toDomain(),
      opus: opus?.toDomain(),
      live: live?.toDomain(),
      liveRcmd: liveRcmd?.toDomain(),
    );
  }
}

extension MajorArchiveMapper on dto.MajorArchive {
  domain.MajorArchive toDomain() {
    return domain.MajorArchive(
      cover: cover,
      title: title,
      desc: desc,
      durationText: durationText,
      stat: stat.toDomain(),
      aid: aid,
      bvid: bvid,
      jumpUrl: jumpUrl,
    );
  }
}

extension MajorDrawMapper on dto.MajorDraw {
  domain.MajorDraw toDomain() {
    return domain.MajorDraw(
      id: id,
      items: items.map((item) => item.toDomain()).toList(),
    );
  }
}

extension DrawItemMapper on dto.DrawItem {
  domain.DrawItem toDomain() {
    return domain.DrawItem(
      src: src,
      width: width,
      height: height,
      size: size,
    );
  }
}

extension MajorArticleMapper on dto.MajorArticle {
  domain.MajorArticle toDomain() {
    return domain.MajorArticle(
      id: id,
      title: title,
      desc: desc,
      covers: covers,
      label: label,
      jumpUrl: jumpUrl,
    );
  }
}

extension MajorCommonMapper on dto.MajorCommon {
  domain.MajorCommon toDomain() {
    return domain.MajorCommon(
      title: title,
      desc: desc,
      cover: cover,
      jumpUrl: jumpUrl,
      label: label,
    );
  }
}

extension MajorStatMapper on dto.MajorStat {
  domain.MajorStat toDomain() {
    return domain.MajorStat(
      play: play,
      danmaku: danmaku,
    );
  }
}

extension ModuleStatMapper on dto.ModuleStat {
  domain.ModuleStat toDomain() {
    return domain.ModuleStat(
      like: like.toDomain(),
      comment: comment.toDomain(),
      forward: forward.toDomain(),
    );
  }
}

extension StatLikeMapper on dto.StatLike {
  domain.StatLike toDomain() {
    return domain.StatLike(
      count: count,
      status: status,
    );
  }
}

extension StatCommonMapper on dto.StatCommon {
  domain.StatCommon toDomain() {
    return domain.StatCommon(
      count: count,
    );
  }
}

extension ModuleTopicMapper on dto.ModuleTopic {
  domain.ModuleTopic toDomain() {
    return domain.ModuleTopic(
      name: name,
      jumpUrl: jumpUrl,
    );
  }
}

extension MajorPgcMapper on dto.MajorPgc {
  domain.MajorPgc toDomain() {
    return domain.MajorPgc(
      cover: cover,
      title: title,
      jumpUrl: jumpUrl,
      stat: stat.toDomain(),
      seasonId: seasonId,
      epid: epid,
      subType: subType,
      type: type,
    );
  }
}

extension MajorCoursesMapper on dto.MajorCourses {
  domain.MajorCourses toDomain() {
    return domain.MajorCourses(
      cover: cover,
      title: title,
      subTitle: subTitle,
      desc: desc,
      jumpUrl: jumpUrl,
      id: id,
    );
  }
}

extension MajorMusicMapper on dto.MajorMusic {
  domain.MajorMusic toDomain() {
    return domain.MajorMusic(
      cover: cover,
      title: title,
      label: label,
      jumpUrl: jumpUrl,
      id: id,
    );
  }
}

extension MajorOpusMapper on dto.MajorOpus {
  domain.MajorOpus toDomain() {
    return domain.MajorOpus(
      title: title,
      summary: summary?.toDomain(),
      pics: pics?.map((item) => item.toDomain()).toList(),
      jumpUrl: jumpUrl,
    );
  }
}

extension OpusSummaryMapper on dto.OpusSummary {
  domain.OpusSummary toDomain() {
    return domain.OpusSummary(
      text: text,
      richTextNodes: richTextNodes,
    );
  }
}

extension OpusPicMapper on dto.OpusPic {
  domain.OpusPic toDomain() {
    return domain.OpusPic(
      url: url,
      width: width,
      height: height,
      size: size,
    );
  }
}

extension MajorLiveMapper on dto.MajorLive {
  domain.MajorLive toDomain() {
    return domain.MajorLive(
      cover: cover,
      title: title,
      liveState: liveState,
      jumpUrl: jumpUrl,
      descFirst: descFirst,
      descSecond: descSecond,
    );
  }
}

extension MajorLiveRcmdMapper on dto.MajorLiveRcmd {
  domain.MajorLiveRcmd toDomain() {
    return domain.MajorLiveRcmd(
      content: content,
      reserveType: reserveType,
    );
  }
}

extension DynamicPublishDataMapper on dto.DynamicPublishData {
  domain.DynamicPublishData toDomain() {
    return domain.DynamicPublishData(
      dynIdStr: dynIdStr,
    );
  }
}

extension DynamicUploadImageDataMapper on dto.DynamicUploadImageData {
  domain.DynamicUploadImageData toDomain() {
    return domain.DynamicUploadImageData(
      imageUrl: imageUrl,
      width: width,
      height: height,
    );
  }
}
