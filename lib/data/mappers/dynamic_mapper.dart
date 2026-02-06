import 'package:culcul/data/models/dynamic/dynamic_response.dart';
import 'package:culcul/domain/entities/dynamic_post.dart';

class DynamicMapper {
  static DynamicPost mapToEntity(DynamicItem item) {
    final modules = item.modules;
    final author = modules.moduleAuthor;
    final dynamicModule = modules.moduleDynamic;
    final stat = modules.moduleStat;

    return DynamicPost(
      id: item.idStr,
      type: item.type,
      authorMid: author.mid,
      authorName: author.name,
      authorAvatar: author.avatar,
      timeText: author.pubTime,
      description: dynamicModule.desc?.text,
      images: dynamicModule.major?.draw?.items.map((e) => e.src).toList() ?? 
             dynamicModule.major?.opus?.pics?.map((e) => e.url ?? '').where((e) => e.isNotEmpty).toList(),
      likeCount: stat?.like.count ?? 0,
      isLiked: stat?.like.status ?? false,
      commentCount: stat?.comment.count ?? 0,
      forwardCount: stat?.forward.count ?? 0,
      video: _mapVideoContent(dynamicModule.major),
      orig: item.orig != null ? mapToEntity(item.orig!) : null,
      topicName: dynamicModule.topic?.name,
      topicId: _extractTopicId(dynamicModule.topic?.jumpUrl),
      linkCard: _mapLinkCard(dynamicModule.major),
      commentId: item.basic?.commentIdStr,
      commentType: item.basic?.commentType,
      additional: _mapAdditional(dynamicModule.additional),
    );
  }

  static int? _extractTopicId(String? url) {
    if (url == null) return null;
    try {
      final uri = Uri.parse(url);
      final topicIdStr = uri.queryParameters['topic_id'];
      if (topicIdStr != null) {
        return int.tryParse(topicIdStr);
      }
    } catch (e) {
      // ignore
    }
    return null;
  }

  static DynamicAdditional? _mapAdditional(ModuleAdditional? additional) {
    if (additional == null) return null;

    if (additional.type == 'ADDITIONAL_TYPE_COMMON' && additional.common != null) {
      return DynamicAdditional(
        type: additional.type,
        title: additional.common!.title,
        cover: additional.common!.cover,
        desc1: additional.common!.desc1,
        desc2: additional.common!.desc2,
        jumpUrl: additional.common!.jumpUrl,
        headText: additional.common!.headText,
      );
    }

    if (additional.type == 'ADDITIONAL_TYPE_RESERVE' && additional.reserve != null) {
      return DynamicAdditional(
        type: additional.type,
        title: additional.reserve!.title,
        jumpUrl: additional.reserve!.jumpUrl,
        reserveTotal: additional.reserve!.reserveTotal,
        state: additional.reserve!.state,
        desc1: additional.reserve!.desc1?.text,
        desc2: additional.reserve!.desc2?.text,
      );
    }

    if (additional.type == 'ADDITIONAL_TYPE_GOODS' && additional.goods != null) {
      return DynamicAdditional(
        type: additional.type,
        headText: additional.goods!.headText,
        jumpUrl: additional.goods!.jumpUrl,
        goodsItems: additional.goods!.items
            .map((e) => DynamicGoodsItem(
                  name: e.name,
                  price: e.price,
                  cover: e.cover,
                  jumpUrl: e.jumpUrl,
                ))
            .toList(),
      );
    }

    if (additional.type == 'ADDITIONAL_TYPE_VOTE' && additional.vote != null) {
      return DynamicAdditional(
        type: additional.type,
        title: additional.vote!.desc,
        voteJoinNum: additional.vote!.joinNum,
        voteId: additional.vote!.voteId,
        voteChoiceCnt: additional.vote!.choice_cnt,
        voteStatus: additional.vote!.status,
      );
    }

    if (additional.type == 'ADDITIONAL_TYPE_UGC' && additional.ugc != null) {
      return DynamicAdditional(
        type: additional.type,
        title: additional.ugc!.title,
        cover: additional.ugc!.cover,
        desc2: additional.ugc!.descSecond,
        jumpUrl: additional.ugc!.jumpUrl,
      );
    }

    return null;
  }

  static DynamicVideoContent? _mapVideoContent(ModuleMajor? major) {
    if (major == null) return null;

    if (major.archive != null) {
      return DynamicVideoContent(
        title: major.archive!.title,
        cover: major.archive!.cover,
        duration: major.archive!.durationText,
        playCount: major.archive!.stat.play,
        danmakuCount: major.archive!.stat.danmaku,
        aid: major.archive!.aid,
        bvid: major.archive!.bvid,
      );
    }

    if (major.ugc_season != null) {
      return DynamicVideoContent(
        title: major.ugc_season!.title,
        cover: major.ugc_season!.cover,
        duration: major.ugc_season!.durationText,
        playCount: major.ugc_season!.stat.play,
        danmakuCount: major.ugc_season!.stat.danmaku,
        aid: major.ugc_season!.aid,
        bvid: major.ugc_season!.bvid,
      );
    }
    
    return null;
  }

  static DynamicLinkCard? _mapLinkCard(ModuleMajor? major) {
    if (major == null) return null;

    if (major.article != null) {
      return DynamicLinkCard(
        title: major.article!.title,
        cover: major.article!.covers.isNotEmpty ? major.article!.covers.first : '',
        desc: major.article!.desc,
        url: major.article!.jumpUrl,
      );
    }

    if (major.common != null) {
      return DynamicLinkCard(
        title: major.common!.title,
        cover: major.common!.cover,
        desc: major.common!.desc,
        url: major.common!.jumpUrl,
      );
    }

    if (major.pgc != null) {
      return DynamicLinkCard(
        title: major.pgc!.title,
        cover: major.pgc!.cover,
        desc: major.pgc!.stat.play,
        url: major.pgc!.jumpUrl,
      );
    }
    
    if (major.courses != null) {
      return DynamicLinkCard(
        title: major.courses!.title,
        cover: major.courses!.cover,
        desc: major.courses!.desc,
        url: major.courses!.jumpUrl,
      );
    }
    
    if (major.music != null) {
      return DynamicLinkCard(
        title: major.music!.title,
        cover: major.music!.cover,
        desc: major.music!.label,
        url: major.music!.jumpUrl,
      );
    }

    if (major.live != null) {
       return DynamicLinkCard(
        title: major.live!.title,
        cover: major.live!.cover,
        desc: major.live!.descSecond,
        url: major.live!.jumpUrl,
      );
    }

    return null;
  }
}
