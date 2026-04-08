part of 'dynamic_extension.dart';

DynamicVideoContent? _dynamicMapVideoContent(ModuleMajor? major) {
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

  if (major.ugcSeason != null) {
    return DynamicVideoContent(
      title: major.ugcSeason!.title,
      cover: major.ugcSeason!.cover,
      duration: major.ugcSeason!.durationText,
      playCount: major.ugcSeason!.stat.play,
      danmakuCount: major.ugcSeason!.stat.danmaku,
      aid: major.ugcSeason!.aid,
      bvid: major.ugcSeason!.bvid,
    );
  }

  return null;
}

DynamicLinkCard? _dynamicMapLinkCard({
  required DynamicItem item,
  required ModuleMajor? major,
}) {
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

  if (major.opus != null && (major.opus!.jumpUrl?.isNotEmpty ?? false)) {
    final summaryText = major.opus!.summary?.text ?? '';
    final hasSummary = summaryText.isNotEmpty;
    final hasPics = major.opus!.pics?.isNotEmpty ?? false;
    if (!item.isArticleType && (hasSummary || hasPics)) return null;

    final cover =
        major.opus!.pics
            ?.map((e) => e.url ?? '')
            .where((e) => e.isNotEmpty)
            .firstOrNull ??
        '';
    return DynamicLinkCard(
      title: (major.opus!.title != null && major.opus!.title!.isNotEmpty)
          ? major.opus!.title!
          : 'Article Post',
      cover: cover,
      desc: major.opus!.summary?.text,
      url: major.opus!.jumpUrl!,
    );
  }

  return null;
}

DynamicAdditional? _dynamicMapAdditional(ModuleAdditional? additional) {
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
          .map(
            (e) => DynamicGoodsItem(
              name: e.name,
              price: e.price,
              cover: e.cover,
              jumpUrl: e.jumpUrl,
            ),
          )
          .toList(),
    );
  }

  if (additional.type == 'ADDITIONAL_TYPE_VOTE' && additional.vote != null) {
    return DynamicAdditional(
      type: additional.type,
      title: additional.vote!.desc,
      voteJoinNum: additional.vote!.joinNum,
      voteId: additional.vote!.voteId,
      voteChoiceCnt: additional.vote!.choiceCnt,
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
