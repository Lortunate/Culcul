// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_contract.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CommentResponse _$CommentResponseFromJson(Map<String, dynamic> json) => _CommentResponse(
  replies:
      (json['replies'] as List<dynamic>?)
          ?.map((e) => CommentItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  cursor: json['cursor'] == null
      ? null
      : CommentCursor.fromJson(json['cursor'] as Map<String, dynamic>),
  page: json['page'] == null
      ? null
      : CommentPage.fromJson(json['page'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CommentResponseToJson(_CommentResponse instance) =>
    <String, dynamic>{
      'replies': instance.replies,
      'cursor': instance.cursor,
      'page': instance.page,
    };

_CommentPage _$CommentPageFromJson(Map<String, dynamic> json) => _CommentPage(
  num: (json['num'] as num?)?.toInt() ?? 0,
  size: (json['size'] as num?)?.toInt() ?? 0,
  count: (json['count'] as num?)?.toInt() ?? 0,
  acount: (json['acount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$CommentPageToJson(_CommentPage instance) => <String, dynamic>{
  'num': instance.num,
  'size': instance.size,
  'count': instance.count,
  'acount': instance.acount,
};

_CommentCursor _$CommentCursorFromJson(Map<String, dynamic> json) => _CommentCursor(
  allCount: (json['all_count'] as num?)?.toInt() ?? 0,
  isBegin: json['is_begin'] as bool? ?? false,
  isEnd: json['is_end'] as bool? ?? false,
  mode: (json['mode'] as num?)?.toInt() ?? 0,
  name: json['name'] as String? ?? '',
  next: (json['next'] as num?)?.toInt() ?? 0,
  prev: (json['prev'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$CommentCursorToJson(_CommentCursor instance) => <String, dynamic>{
  'all_count': instance.allCount,
  'is_begin': instance.isBegin,
  'is_end': instance.isEnd,
  'mode': instance.mode,
  'name': instance.name,
  'next': instance.next,
  'prev': instance.prev,
};

_CommentItem _$CommentItemFromJson(Map<String, dynamic> json) => _CommentItem(
  rpid: (json['rpid'] as num).toInt(),
  oid: (json['oid'] as num).toInt(),
  type: (json['type'] as num).toInt(),
  mid: (json['mid'] as num).toInt(),
  root: (json['root'] as num).toInt(),
  parent: (json['parent'] as num).toInt(),
  dialog: (json['dialog'] as num?)?.toInt() ?? 0,
  count: (json['count'] as num?)?.toInt() ?? 0,
  rcount: (json['rcount'] as num?)?.toInt() ?? 0,
  floor: (json['floor'] as num?)?.toInt() ?? 0,
  state: (json['state'] as num?)?.toInt() ?? 0,
  fansgrade: (json['fansgrade'] as num?)?.toInt() ?? 0,
  attr: (json['attr'] as num?)?.toInt() ?? 0,
  ctime: (json['ctime'] as num).toInt(),
  rpidStr: json['rpid_str'] as String? ?? '',
  rootStr: json['root_str'] as String? ?? '',
  parentStr: json['parent_str'] as String? ?? '',
  like: (json['like'] as num?)?.toInt() ?? 0,
  action: (json['action'] as num?)?.toInt() ?? 0,
  member: CommentMember.fromJson(json['member'] as Map<String, dynamic>),
  content: CommentContent.fromJson(json['content'] as Map<String, dynamic>),
  replies:
      (json['replies'] as List<dynamic>?)
          ?.map((e) => CommentItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  showFollow: json['show_follow'] as bool? ?? false,
  invisible: json['invisible'] as bool? ?? false,
);

Map<String, dynamic> _$CommentItemToJson(_CommentItem instance) => <String, dynamic>{
  'rpid': instance.rpid,
  'oid': instance.oid,
  'type': instance.type,
  'mid': instance.mid,
  'root': instance.root,
  'parent': instance.parent,
  'dialog': instance.dialog,
  'count': instance.count,
  'rcount': instance.rcount,
  'floor': instance.floor,
  'state': instance.state,
  'fansgrade': instance.fansgrade,
  'attr': instance.attr,
  'ctime': instance.ctime,
  'rpid_str': instance.rpidStr,
  'root_str': instance.rootStr,
  'parent_str': instance.parentStr,
  'like': instance.like,
  'action': instance.action,
  'member': instance.member,
  'content': instance.content,
  'replies': instance.replies,
  'show_follow': instance.showFollow,
  'invisible': instance.invisible,
};

_CommentMember _$CommentMemberFromJson(Map<String, dynamic> json) => _CommentMember(
  mid: json['mid'] as String,
  uname: json['uname'] as String,
  sex: json['sex'] as String,
  sign: json['sign'] as String,
  avatar: json['avatar'] as String,
  rank: json['rank'] as String,
  displayRank: (json['DisplayRank'] as num?)?.toInt() ?? 0,
  levelInfo: CommentLevelInfo.fromJson(json['level_info'] as Map<String, dynamic>),
  pendant: CommentPendant.fromJson(json['pendant'] as Map<String, dynamic>),
  nameplate: CommentNameplate.fromJson(json['nameplate'] as Map<String, dynamic>),
  officialVerify: OfficialVerify.fromJson(
    json['official_verify'] as Map<String, dynamic>,
  ),
  vip: CommentVip.fromJson(json['vip'] as Map<String, dynamic>),
  fansDetail: json['fans_detail'],
  following: (json['following'] as num?)?.toInt() ?? 0,
  isFollowed: (json['is_followed'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$CommentMemberToJson(_CommentMember instance) => <String, dynamic>{
  'mid': instance.mid,
  'uname': instance.uname,
  'sex': instance.sex,
  'sign': instance.sign,
  'avatar': instance.avatar,
  'rank': instance.rank,
  'DisplayRank': instance.displayRank,
  'level_info': instance.levelInfo,
  'pendant': instance.pendant,
  'nameplate': instance.nameplate,
  'official_verify': instance.officialVerify,
  'vip': instance.vip,
  'fans_detail': instance.fansDetail,
  'following': instance.following,
  'is_followed': instance.isFollowed,
};

_CommentLevelInfo _$CommentLevelInfoFromJson(Map<String, dynamic> json) =>
    _CommentLevelInfo(
      currentLevel: (json['current_level'] as num).toInt(),
      currentMin: (json['current_min'] as num).toInt(),
      currentExp: (json['current_exp'] as num).toInt(),
      nextExp: (json['next_exp'] as num).toInt(),
    );

Map<String, dynamic> _$CommentLevelInfoToJson(_CommentLevelInfo instance) =>
    <String, dynamic>{
      'current_level': instance.currentLevel,
      'current_min': instance.currentMin,
      'current_exp': instance.currentExp,
      'next_exp': instance.nextExp,
    };

_CommentPendant _$CommentPendantFromJson(Map<String, dynamic> json) => _CommentPendant(
  pid: (json['pid'] as num).toInt(),
  name: json['name'] as String,
  image: json['image'] as String,
  expire: (json['expire'] as num).toInt(),
  imageEnhance: json['image_enhance'] as String? ?? '',
  imageEnhanceFrame: json['image_enhance_frame'] as String? ?? '',
);

Map<String, dynamic> _$CommentPendantToJson(_CommentPendant instance) =>
    <String, dynamic>{
      'pid': instance.pid,
      'name': instance.name,
      'image': instance.image,
      'expire': instance.expire,
      'image_enhance': instance.imageEnhance,
      'image_enhance_frame': instance.imageEnhanceFrame,
    };

_CommentNameplate _$CommentNameplateFromJson(Map<String, dynamic> json) =>
    _CommentNameplate(
      nid: (json['nid'] as num).toInt(),
      name: json['name'] as String,
      image: json['image'] as String,
      imageSmall: json['image_small'] as String,
      level: json['level'] as String,
      condition: json['condition'] as String,
    );

Map<String, dynamic> _$CommentNameplateToJson(_CommentNameplate instance) =>
    <String, dynamic>{
      'nid': instance.nid,
      'name': instance.name,
      'image': instance.image,
      'image_small': instance.imageSmall,
      'level': instance.level,
      'condition': instance.condition,
    };

_CommentVip _$CommentVipFromJson(Map<String, dynamic> json) => _CommentVip(
  vipType: (json['vipType'] as num?)?.toInt() ?? 0,
  vipDueDate: (json['vipDueDate'] as num?)?.toInt() ?? 0,
  dueRemark: json['dueRemark'] as String? ?? '',
  accessStatus: (json['accessStatus'] as num?)?.toInt() ?? 0,
  vipStatus: (json['vipStatus'] as num?)?.toInt() ?? 0,
  vipStatusWarn: json['vipStatusWarn'] as String? ?? '',
  themeType: (json['themeType'] as num?)?.toInt() ?? 0,
  label: json['label'],
);

Map<String, dynamic> _$CommentVipToJson(_CommentVip instance) => <String, dynamic>{
  'vipType': instance.vipType,
  'vipDueDate': instance.vipDueDate,
  'dueRemark': instance.dueRemark,
  'accessStatus': instance.accessStatus,
  'vipStatus': instance.vipStatus,
  'vipStatusWarn': instance.vipStatusWarn,
  'themeType': instance.themeType,
  'label': instance.label,
};
