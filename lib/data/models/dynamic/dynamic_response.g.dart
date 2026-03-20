// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DynamicDetailData _$DynamicDetailDataFromJson(Map<String, dynamic> json) =>
    DynamicDetailData(
      item: DynamicItem.fromJson(json['item'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DynamicDetailDataToJson(DynamicDetailData instance) =>
    <String, dynamic>{'item': instance.item};

DynamicData _$DynamicDataFromJson(Map<String, dynamic> json) => DynamicData(
  hasMore: json['has_more'] as bool,
  items: (json['items'] as List<dynamic>)
      .map((e) => DynamicItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  offset: json['offset'] as String,
  updateBaseline: json['update_baseline'] as String,
  updateNum: JsonUtils.parseIntWithDefault(json['update_num']),
);

Map<String, dynamic> _$DynamicDataToJson(DynamicData instance) =>
    <String, dynamic>{
      'has_more': instance.hasMore,
      'items': instance.items,
      'offset': instance.offset,
      'update_baseline': instance.updateBaseline,
      'update_num': instance.updateNum,
    };

DynamicItem _$DynamicItemFromJson(Map<String, dynamic> json) => DynamicItem(
  idStr: json['id_str'] as String,
  type: json['type'] as String,
  visible: json['visible'] as bool,
  modules: DynamicModules.fromJson(json['modules'] as Map<String, dynamic>),
  orig: json['orig'] == null
      ? null
      : DynamicItem.fromJson(json['orig'] as Map<String, dynamic>),
  basic: json['basic'] == null
      ? null
      : DynamicBasic.fromJson(json['basic'] as Map<String, dynamic>),
);

Map<String, dynamic> _$DynamicItemToJson(DynamicItem instance) =>
    <String, dynamic>{
      'id_str': instance.idStr,
      'type': instance.type,
      'visible': instance.visible,
      'modules': instance.modules,
      'orig': instance.orig,
      'basic': instance.basic,
    };

DynamicBasic _$DynamicBasicFromJson(Map<String, dynamic> json) => DynamicBasic(
  commentIdStr: json['comment_id_str'] as String,
  commentType: (json['comment_type'] as num).toInt(),
  ridStr: json['rid_str'] as String,
);

Map<String, dynamic> _$DynamicBasicToJson(DynamicBasic instance) =>
    <String, dynamic>{
      'comment_id_str': instance.commentIdStr,
      'comment_type': instance.commentType,
      'rid_str': instance.ridStr,
    };

DynamicModules _$DynamicModulesFromJson(Map<String, dynamic> json) =>
    DynamicModules(
      moduleAuthor: ModuleAuthor.fromJson(
        json['module_author'] as Map<String, dynamic>,
      ),
      moduleDynamic: ModuleDynamic.fromJson(
        json['module_dynamic'] as Map<String, dynamic>,
      ),
      moduleStat: json['module_stat'] == null
          ? null
          : ModuleStat.fromJson(json['module_stat'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DynamicModulesToJson(DynamicModules instance) =>
    <String, dynamic>{
      'module_author': instance.moduleAuthor,
      'module_dynamic': instance.moduleDynamic,
      'module_stat': instance.moduleStat,
    };

ModuleAuthor _$ModuleAuthorFromJson(Map<String, dynamic> json) => ModuleAuthor(
  mid: (json['mid'] as num).toInt(),
  name: json['name'] as String,
  avatar: json['face'] as String,
  pubTime: json['pub_time'] as String,
  pubAction: json['pub_action'] as String,
);

Map<String, dynamic> _$ModuleAuthorToJson(ModuleAuthor instance) =>
    <String, dynamic>{
      'mid': instance.mid,
      'name': instance.name,
      'face': instance.avatar,
      'pub_time': instance.pubTime,
      'pub_action': instance.pubAction,
    };

ModuleDynamic _$ModuleDynamicFromJson(Map<String, dynamic> json) =>
    ModuleDynamic(
      desc: json['desc'] == null
          ? null
          : ModuleDesc.fromJson(json['desc'] as Map<String, dynamic>),
      major: json['major'] == null
          ? null
          : ModuleMajor.fromJson(json['major'] as Map<String, dynamic>),
      topic: json['topic'] == null
          ? null
          : ModuleTopic.fromJson(json['topic'] as Map<String, dynamic>),
      additional: json['additional'] == null
          ? null
          : ModuleAdditional.fromJson(
              json['additional'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$ModuleDynamicToJson(ModuleDynamic instance) =>
    <String, dynamic>{
      'desc': instance.desc,
      'major': instance.major,
      'topic': instance.topic,
      'additional': instance.additional,
    };

ModuleAdditional _$ModuleAdditionalFromJson(Map<String, dynamic> json) =>
    ModuleAdditional(
      type: json['type'] as String,
      common: json['common'] == null
          ? null
          : AdditionalCommon.fromJson(json['common'] as Map<String, dynamic>),
      reserve: json['reserve'] == null
          ? null
          : AdditionalReserve.fromJson(json['reserve'] as Map<String, dynamic>),
      goods: json['goods'] == null
          ? null
          : AdditionalGoods.fromJson(json['goods'] as Map<String, dynamic>),
      vote: json['vote'] == null
          ? null
          : AdditionalVote.fromJson(json['vote'] as Map<String, dynamic>),
      ugc: json['ugc'] == null
          ? null
          : AdditionalUgc.fromJson(json['ugc'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ModuleAdditionalToJson(ModuleAdditional instance) =>
    <String, dynamic>{
      'type': instance.type,
      'common': instance.common,
      'reserve': instance.reserve,
      'goods': instance.goods,
      'vote': instance.vote,
      'ugc': instance.ugc,
    };

AdditionalCommon _$AdditionalCommonFromJson(Map<String, dynamic> json) =>
    AdditionalCommon(
      title: json['title'] as String,
      desc1: json['desc1'] as String?,
      desc2: json['desc2'] as String?,
      cover: json['cover'] as String,
      jumpUrl: json['jump_url'] as String,
      subType: json['sub_type'] as String,
      headText: json['head_text'] as String?,
    );

Map<String, dynamic> _$AdditionalCommonToJson(AdditionalCommon instance) =>
    <String, dynamic>{
      'title': instance.title,
      'desc1': instance.desc1,
      'desc2': instance.desc2,
      'cover': instance.cover,
      'jump_url': instance.jumpUrl,
      'sub_type': instance.subType,
      'head_text': instance.headText,
    };

AdditionalReserve _$AdditionalReserveFromJson(Map<String, dynamic> json) =>
    AdditionalReserve(
      title: json['title'] as String,
      jumpUrl: json['jump_url'] as String,
      reserveTotal: (json['reserve_total'] as num).toInt(),
      state: (json['state'] as num).toInt(),
      desc1: json['desc1'] == null
          ? null
          : ReserveDesc.fromJson(json['desc1'] as Map<String, dynamic>),
      desc2: json['desc2'] == null
          ? null
          : ReserveDesc.fromJson(json['desc2'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AdditionalReserveToJson(AdditionalReserve instance) =>
    <String, dynamic>{
      'title': instance.title,
      'jump_url': instance.jumpUrl,
      'reserve_total': instance.reserveTotal,
      'state': instance.state,
      'desc1': instance.desc1,
      'desc2': instance.desc2,
    };

ReserveDesc _$ReserveDescFromJson(Map<String, dynamic> json) => ReserveDesc(
  text: json['text'] as String,
  style: (json['style'] as num).toInt(),
);

Map<String, dynamic> _$ReserveDescToJson(ReserveDesc instance) =>
    <String, dynamic>{'text': instance.text, 'style': instance.style};

AdditionalGoods _$AdditionalGoodsFromJson(Map<String, dynamic> json) =>
    AdditionalGoods(
      headText: json['head_text'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => GoodsItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      jumpUrl: json['jump_url'] as String,
    );

Map<String, dynamic> _$AdditionalGoodsToJson(AdditionalGoods instance) =>
    <String, dynamic>{
      'head_text': instance.headText,
      'items': instance.items,
      'jump_url': instance.jumpUrl,
    };

GoodsItem _$GoodsItemFromJson(Map<String, dynamic> json) => GoodsItem(
  name: json['name'] as String,
  price: json['price'] as String,
  cover: json['cover'] as String,
  jumpUrl: json['jump_url'] as String,
);

Map<String, dynamic> _$GoodsItemToJson(GoodsItem instance) => <String, dynamic>{
  'name': instance.name,
  'price': instance.price,
  'cover': instance.cover,
  'jump_url': instance.jumpUrl,
};

AdditionalVote _$AdditionalVoteFromJson(Map<String, dynamic> json) =>
    AdditionalVote(
      desc: json['desc'] as String,
      endTime: (json['end_time'] as num).toInt(),
      joinNum: (json['join_num'] as num).toInt(),
      voteId: (json['vote_id'] as num).toInt(),
      choice_cnt: (json['choice_cnt'] as num).toInt(),
      status: (json['status'] as num).toInt(),
    );

Map<String, dynamic> _$AdditionalVoteToJson(AdditionalVote instance) =>
    <String, dynamic>{
      'desc': instance.desc,
      'end_time': instance.endTime,
      'join_num': instance.joinNum,
      'vote_id': instance.voteId,
      'choice_cnt': instance.choice_cnt,
      'status': instance.status,
    };

AdditionalUgc _$AdditionalUgcFromJson(Map<String, dynamic> json) =>
    AdditionalUgc(
      title: json['title'] as String,
      cover: json['cover'] as String,
      descSecond: json['desc_second'] as String,
      duration: json['duration'] as String,
      jumpUrl: json['jump_url'] as String,
    );

Map<String, dynamic> _$AdditionalUgcToJson(AdditionalUgc instance) =>
    <String, dynamic>{
      'title': instance.title,
      'cover': instance.cover,
      'desc_second': instance.descSecond,
      'duration': instance.duration,
      'jump_url': instance.jumpUrl,
    };

ModuleDesc _$ModuleDescFromJson(Map<String, dynamic> json) => ModuleDesc(
  text: json['text'] as String,
  richTextNodes: json['rich_text_nodes'] as List<dynamic>?,
);

Map<String, dynamic> _$ModuleDescToJson(ModuleDesc instance) =>
    <String, dynamic>{
      'text': instance.text,
      'rich_text_nodes': instance.richTextNodes,
    };

ModuleMajor _$ModuleMajorFromJson(Map<String, dynamic> json) => ModuleMajor(
  type: json['type'] as String,
  archive: json['archive'] == null
      ? null
      : MajorArchive.fromJson(json['archive'] as Map<String, dynamic>),
  draw: json['draw'] == null
      ? null
      : MajorDraw.fromJson(json['draw'] as Map<String, dynamic>),
  ugc_season: json['ugc_season'] == null
      ? null
      : MajorArchive.fromJson(json['ugc_season'] as Map<String, dynamic>),
  article: json['article'] == null
      ? null
      : MajorArticle.fromJson(json['article'] as Map<String, dynamic>),
  common: json['common'] == null
      ? null
      : MajorCommon.fromJson(json['common'] as Map<String, dynamic>),
  pgc: json['pgc'] == null
      ? null
      : MajorPgc.fromJson(json['pgc'] as Map<String, dynamic>),
  courses: json['courses'] == null
      ? null
      : MajorCourses.fromJson(json['courses'] as Map<String, dynamic>),
  music: json['music'] == null
      ? null
      : MajorMusic.fromJson(json['music'] as Map<String, dynamic>),
  opus: json['opus'] == null
      ? null
      : MajorOpus.fromJson(json['opus'] as Map<String, dynamic>),
  live: json['live'] == null
      ? null
      : MajorLive.fromJson(json['live'] as Map<String, dynamic>),
  liveRcmd: json['live_rcmd'] == null
      ? null
      : MajorLiveRcmd.fromJson(json['live_rcmd'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ModuleMajorToJson(ModuleMajor instance) =>
    <String, dynamic>{
      'type': instance.type,
      'archive': instance.archive,
      'draw': instance.draw,
      'ugc_season': instance.ugc_season,
      'article': instance.article,
      'common': instance.common,
      'pgc': instance.pgc,
      'courses': instance.courses,
      'music': instance.music,
      'opus': instance.opus,
      'live': instance.live,
      'live_rcmd': instance.liveRcmd,
    };

MajorArchive _$MajorArchiveFromJson(Map<String, dynamic> json) => MajorArchive(
  cover: json['cover'] as String,
  title: json['title'] as String,
  desc: json['desc'] as String,
  durationText: json['duration_text'] as String,
  stat: MajorStat.fromJson(json['stat'] as Map<String, dynamic>),
  aid: json['aid'] as String,
  bvid: json['bvid'] as String,
  jumpUrl: json['jump_url'] as String,
);

Map<String, dynamic> _$MajorArchiveToJson(MajorArchive instance) =>
    <String, dynamic>{
      'cover': instance.cover,
      'title': instance.title,
      'desc': instance.desc,
      'duration_text': instance.durationText,
      'stat': instance.stat,
      'aid': instance.aid,
      'bvid': instance.bvid,
      'jump_url': instance.jumpUrl,
    };

MajorDraw _$MajorDrawFromJson(Map<String, dynamic> json) => MajorDraw(
  id: (json['id'] as num).toInt(),
  items: (json['items'] as List<dynamic>)
      .map((e) => DrawItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$MajorDrawToJson(MajorDraw instance) => <String, dynamic>{
  'id': instance.id,
  'items': instance.items,
};

DrawItem _$DrawItemFromJson(Map<String, dynamic> json) => DrawItem(
  src: json['src'] as String,
  width: (json['width'] as num).toInt(),
  height: (json['height'] as num).toInt(),
  size: (json['size'] as num).toInt(),
);

Map<String, dynamic> _$DrawItemToJson(DrawItem instance) => <String, dynamic>{
  'src': instance.src,
  'width': instance.width,
  'height': instance.height,
  'size': instance.size,
};

MajorArticle _$MajorArticleFromJson(Map<String, dynamic> json) => MajorArticle(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  desc: json['desc'] as String,
  covers: (json['covers'] as List<dynamic>).map((e) => e as String).toList(),
  label: json['label'] as String,
  jumpUrl: json['jump_url'] as String,
);

Map<String, dynamic> _$MajorArticleToJson(MajorArticle instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'desc': instance.desc,
      'covers': instance.covers,
      'label': instance.label,
      'jump_url': instance.jumpUrl,
    };

MajorCommon _$MajorCommonFromJson(Map<String, dynamic> json) => MajorCommon(
  title: json['title'] as String,
  desc: json['desc'] as String,
  cover: json['cover'] as String,
  jumpUrl: json['jump_url'] as String,
  label: json['label'] as String,
);

Map<String, dynamic> _$MajorCommonToJson(MajorCommon instance) =>
    <String, dynamic>{
      'title': instance.title,
      'desc': instance.desc,
      'cover': instance.cover,
      'jump_url': instance.jumpUrl,
      'label': instance.label,
    };

MajorStat _$MajorStatFromJson(Map<String, dynamic> json) =>
    MajorStat(play: json['play'] as String, danmaku: json['danmaku'] as String);

Map<String, dynamic> _$MajorStatToJson(MajorStat instance) => <String, dynamic>{
  'play': instance.play,
  'danmaku': instance.danmaku,
};

ModuleStat _$ModuleStatFromJson(Map<String, dynamic> json) => ModuleStat(
  like: StatLike.fromJson(json['like'] as Map<String, dynamic>),
  comment: StatCommon.fromJson(json['comment'] as Map<String, dynamic>),
  forward: StatCommon.fromJson(json['forward'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ModuleStatToJson(ModuleStat instance) =>
    <String, dynamic>{
      'like': instance.like,
      'comment': instance.comment,
      'forward': instance.forward,
    };

StatLike _$StatLikeFromJson(Map<String, dynamic> json) => StatLike(
  count: (json['count'] as num).toInt(),
  status: json['status'] as bool,
);

Map<String, dynamic> _$StatLikeToJson(StatLike instance) => <String, dynamic>{
  'count': instance.count,
  'status': instance.status,
};

StatCommon _$StatCommonFromJson(Map<String, dynamic> json) =>
    StatCommon(count: (json['count'] as num).toInt());

Map<String, dynamic> _$StatCommonToJson(StatCommon instance) =>
    <String, dynamic>{'count': instance.count};

ModuleTopic _$ModuleTopicFromJson(Map<String, dynamic> json) => ModuleTopic(
  name: json['name'] as String,
  jumpUrl: json['jump_url'] as String,
);

Map<String, dynamic> _$ModuleTopicToJson(ModuleTopic instance) =>
    <String, dynamic>{'name': instance.name, 'jump_url': instance.jumpUrl};

MajorPgc _$MajorPgcFromJson(Map<String, dynamic> json) => MajorPgc(
  cover: json['cover'] as String,
  title: json['title'] as String,
  jumpUrl: json['jump_url'] as String,
  stat: MajorStat.fromJson(json['stat'] as Map<String, dynamic>),
  seasonId: (json['season_id'] as num).toInt(),
  epid: (json['epid'] as num).toInt(),
  subType: (json['sub_type'] as num).toInt(),
  type: (json['type'] as num).toInt(),
);

Map<String, dynamic> _$MajorPgcToJson(MajorPgc instance) => <String, dynamic>{
  'cover': instance.cover,
  'title': instance.title,
  'jump_url': instance.jumpUrl,
  'stat': instance.stat,
  'season_id': instance.seasonId,
  'epid': instance.epid,
  'sub_type': instance.subType,
  'type': instance.type,
};

MajorCourses _$MajorCoursesFromJson(Map<String, dynamic> json) => MajorCourses(
  cover: json['cover'] as String,
  title: json['title'] as String,
  subTitle: json['sub_title'] as String,
  desc: json['desc'] as String,
  jumpUrl: json['jump_url'] as String,
  id: (json['id'] as num).toInt(),
);

Map<String, dynamic> _$MajorCoursesToJson(MajorCourses instance) =>
    <String, dynamic>{
      'cover': instance.cover,
      'title': instance.title,
      'sub_title': instance.subTitle,
      'desc': instance.desc,
      'jump_url': instance.jumpUrl,
      'id': instance.id,
    };

MajorMusic _$MajorMusicFromJson(Map<String, dynamic> json) => MajorMusic(
  cover: json['cover'] as String,
  title: json['title'] as String,
  label: json['label'] as String,
  jumpUrl: json['jump_url'] as String,
  id: (json['id'] as num).toInt(),
);

Map<String, dynamic> _$MajorMusicToJson(MajorMusic instance) =>
    <String, dynamic>{
      'cover': instance.cover,
      'title': instance.title,
      'label': instance.label,
      'jump_url': instance.jumpUrl,
      'id': instance.id,
    };

MajorOpus _$MajorOpusFromJson(Map<String, dynamic> json) => MajorOpus(
  title: json['title'] as String?,
  summary: json['summary'] == null
      ? null
      : OpusSummary.fromJson(json['summary'] as Map<String, dynamic>),
  pics: (json['pics'] as List<dynamic>?)
      ?.map((e) => OpusPic.fromJson(e as Map<String, dynamic>))
      .toList(),
  jumpUrl: json['jump_url'] as String?,
);

Map<String, dynamic> _$MajorOpusToJson(MajorOpus instance) => <String, dynamic>{
  'title': instance.title,
  'summary': instance.summary,
  'pics': instance.pics,
  'jump_url': instance.jumpUrl,
};

OpusSummary _$OpusSummaryFromJson(Map<String, dynamic> json) => OpusSummary(
  text: json['text'] as String?,
  richTextNodes: json['rich_text_nodes'] as List<dynamic>?,
);

Map<String, dynamic> _$OpusSummaryToJson(OpusSummary instance) =>
    <String, dynamic>{
      'text': instance.text,
      'rich_text_nodes': instance.richTextNodes,
    };

OpusPic _$OpusPicFromJson(Map<String, dynamic> json) => OpusPic(
  url: json['url'] as String?,
  width: (json['width'] as num?)?.toInt(),
  height: (json['height'] as num?)?.toInt(),
  size: (json['size'] as num?)?.toInt(),
);

Map<String, dynamic> _$OpusPicToJson(OpusPic instance) => <String, dynamic>{
  'url': instance.url,
  'width': instance.width,
  'height': instance.height,
  'size': instance.size,
};

MajorLive _$MajorLiveFromJson(Map<String, dynamic> json) => MajorLive(
  cover: json['cover'] as String,
  title: json['title'] as String,
  liveState: (json['live_state'] as num).toInt(),
  jumpUrl: json['jump_url'] as String,
  descFirst: json['desc_first'] as String,
  descSecond: json['desc_second'] as String,
);

Map<String, dynamic> _$MajorLiveToJson(MajorLive instance) => <String, dynamic>{
  'cover': instance.cover,
  'title': instance.title,
  'live_state': instance.liveState,
  'jump_url': instance.jumpUrl,
  'desc_first': instance.descFirst,
  'desc_second': instance.descSecond,
};

MajorLiveRcmd _$MajorLiveRcmdFromJson(Map<String, dynamic> json) =>
    MajorLiveRcmd(
      content: json['content'] as String,
      reserveType: (json['reserve_type'] as num).toInt(),
    );

Map<String, dynamic> _$MajorLiveRcmdToJson(MajorLiveRcmd instance) =>
    <String, dynamic>{
      'content': instance.content,
      'reserve_type': instance.reserveType,
    };

DynamicPublishData _$DynamicPublishDataFromJson(Map<String, dynamic> json) =>
    DynamicPublishData(dynIdStr: json['dyn_id_str'] as String);

Map<String, dynamic> _$DynamicPublishDataToJson(DynamicPublishData instance) =>
    <String, dynamic>{'dyn_id_str': instance.dynIdStr};

DynamicUploadImageData _$DynamicUploadImageDataFromJson(
  Map<String, dynamic> json,
) => DynamicUploadImageData(
  imageUrl: json['image_url'] as String,
  width: (json['image_width'] as num).toInt(),
  height: (json['image_height'] as num).toInt(),
);

Map<String, dynamic> _$DynamicUploadImageDataToJson(
  DynamicUploadImageData instance,
) => <String, dynamic>{
  'image_url': instance.imageUrl,
  'image_width': instance.width,
  'image_height': instance.height,
};
