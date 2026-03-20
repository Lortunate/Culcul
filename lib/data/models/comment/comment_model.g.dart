// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CommentResponse _$CommentResponseFromJson(Map<String, dynamic> json) =>
    _CommentResponse(
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

Map<String, dynamic> _$CommentPageToJson(_CommentPage instance) =>
    <String, dynamic>{
      'num': instance.num,
      'size': instance.size,
      'count': instance.count,
      'acount': instance.acount,
    };

_CommentCursor _$CommentCursorFromJson(Map<String, dynamic> json) =>
    _CommentCursor(
      allCount: (json['all_count'] as num?)?.toInt() ?? 0,
      isBegin: json['is_begin'] as bool? ?? false,
      isEnd: json['is_end'] as bool? ?? false,
      mode: (json['mode'] as num?)?.toInt() ?? 0,
      name: json['name'] as String,
      next: (json['next'] as num?)?.toInt() ?? 0,
      prev: (json['prev'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CommentCursorToJson(_CommentCursor instance) =>
    <String, dynamic>{
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

Map<String, dynamic> _$CommentItemToJson(_CommentItem instance) =>
    <String, dynamic>{
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

_CommentMember _$CommentMemberFromJson(Map<String, dynamic> json) =>
    _CommentMember(
      mid: json['mid'] as String,
      uname: json['uname'] as String,
      sex: json['sex'] as String,
      sign: json['sign'] as String,
      avatar: json['avatar'] as String,
      rank: json['rank'] as String,
      displayRank: (json['DisplayRank'] as num?)?.toInt() ?? 0,
      levelInfo: CommentLevelInfo.fromJson(
        json['level_info'] as Map<String, dynamic>,
      ),
      pendant: CommentPendant.fromJson(json['pendant'] as Map<String, dynamic>),
      nameplate: CommentNameplate.fromJson(
        json['nameplate'] as Map<String, dynamic>,
      ),
      officialVerify: CommentOfficialVerify.fromJson(
        json['official_verify'] as Map<String, dynamic>,
      ),
      vip: CommentVip.fromJson(json['vip'] as Map<String, dynamic>),
      fansDetail: json['fans_detail'],
      following: (json['following'] as num?)?.toInt() ?? 0,
      isFollowed: (json['is_followed'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CommentMemberToJson(_CommentMember instance) =>
    <String, dynamic>{
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

_CommentPendant _$CommentPendantFromJson(Map<String, dynamic> json) =>
    _CommentPendant(
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

_CommentOfficialVerify _$CommentOfficialVerifyFromJson(
  Map<String, dynamic> json,
) => _CommentOfficialVerify(
  type: (json['type'] as num?)?.toInt() ?? -1,
  desc: json['desc'] as String? ?? '',
);

Map<String, dynamic> _$CommentOfficialVerifyToJson(
  _CommentOfficialVerify instance,
) => <String, dynamic>{'type': instance.type, 'desc': instance.desc};

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

Map<String, dynamic> _$CommentVipToJson(_CommentVip instance) =>
    <String, dynamic>{
      'vipType': instance.vipType,
      'vipDueDate': instance.vipDueDate,
      'dueRemark': instance.dueRemark,
      'accessStatus': instance.accessStatus,
      'vipStatus': instance.vipStatus,
      'vipStatusWarn': instance.vipStatusWarn,
      'themeType': instance.themeType,
      'label': instance.label,
    };

_CommentLabel _$CommentLabelFromJson(Map<String, dynamic> json) =>
    _CommentLabel(
      path: json['path'] as String,
      text: json['text'] as String,
      labelTheme: json['label_theme'] as String,
      textColor: json['text_color'] as String? ?? '',
      bgStyle: (json['bg_style'] as num?)?.toInt() ?? 0,
      bgColor: json['bg_color'] as String? ?? '',
      borderColor: json['border_color'] as String? ?? '',
      useImgLabel: json['use_img_label'] as bool? ?? false,
      imgLabelUriHans: json['img_label_uri_hans'] as String? ?? '',
      imgLabelUriHant: json['img_label_uri_hant'] as String? ?? '',
      imgLabelUriHansStatic: json['img_label_uri_hans_static'] as String? ?? '',
      imgLabelUriHantStatic: json['img_label_uri_hant_static'] as String? ?? '',
    );

Map<String, dynamic> _$CommentLabelToJson(_CommentLabel instance) =>
    <String, dynamic>{
      'path': instance.path,
      'text': instance.text,
      'label_theme': instance.labelTheme,
      'text_color': instance.textColor,
      'bg_style': instance.bgStyle,
      'bg_color': instance.bgColor,
      'border_color': instance.borderColor,
      'use_img_label': instance.useImgLabel,
      'img_label_uri_hans': instance.imgLabelUriHans,
      'img_label_uri_hant': instance.imgLabelUriHant,
      'img_label_uri_hans_static': instance.imgLabelUriHansStatic,
      'img_label_uri_hant_static': instance.imgLabelUriHantStatic,
    };

_CommentContent _$CommentContentFromJson(Map<String, dynamic> json) =>
    _CommentContent(
      message: json['message'] as String,
      plat: (json['plat'] as num?)?.toInt() ?? 0,
      device: json['device'] as String? ?? '',
      members:
          (json['members'] as List<dynamic>?)
              ?.map((e) => CommentMember.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      emote: (json['emote'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, CommentEmote.fromJson(e as Map<String, dynamic>)),
      ),
      pictures:
          (json['pictures'] as List<dynamic>?)
              ?.map((e) => CommentPicture.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      jumpUrl: json['jump_url'] as Map<String, dynamic>? ?? const {},
      maxLine: (json['max_line'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CommentContentToJson(_CommentContent instance) =>
    <String, dynamic>{
      'message': instance.message,
      'plat': instance.plat,
      'device': instance.device,
      'members': instance.members,
      'emote': instance.emote,
      'pictures': instance.pictures,
      'jump_url': instance.jumpUrl,
      'max_line': instance.maxLine,
    };

_CommentPicture _$CommentPictureFromJson(Map<String, dynamic> json) =>
    _CommentPicture(
      imgSrc: json['img_src'] as String,
      imgWidth: (json['img_width'] as num?)?.toDouble() ?? 0,
      imgHeight: (json['img_height'] as num?)?.toDouble() ?? 0,
      imgSize: (json['img_size'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$CommentPictureToJson(_CommentPicture instance) =>
    <String, dynamic>{
      'img_src': instance.imgSrc,
      'img_width': instance.imgWidth,
      'img_height': instance.imgHeight,
      'img_size': instance.imgSize,
    };

_CommentEmote _$CommentEmoteFromJson(Map<String, dynamic> json) =>
    _CommentEmote(
      id: (json['id'] as num).toInt(),
      packageId: (json['package_id'] as num?)?.toInt() ?? 0,
      state: (json['state'] as num?)?.toInt() ?? 0,
      type: (json['type'] as num?)?.toInt() ?? 0,
      attr: (json['attr'] as num?)?.toInt() ?? 0,
      text: json['text'] as String,
      url: json['url'] as String,
      mtime: (json['mtime'] as num?)?.toInt() ?? 0,
      jumpTitle: json['jump_title'] as String? ?? '',
    );

Map<String, dynamic> _$CommentEmoteToJson(_CommentEmote instance) =>
    <String, dynamic>{
      'id': instance.id,
      'package_id': instance.packageId,
      'state': instance.state,
      'type': instance.type,
      'attr': instance.attr,
      'text': instance.text,
      'url': instance.url,
      'mtime': instance.mtime,
      'jump_title': instance.jumpTitle,
    };
