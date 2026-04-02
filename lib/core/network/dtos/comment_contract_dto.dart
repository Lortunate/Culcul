import 'package:culcul/core/contracts/comment_contract.dart' as contract;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_contract_dto.freezed.dart';
part 'comment_contract_dto.g.dart';

@freezed
sealed class CommentResponseDto with _$CommentResponseDto {
  const factory CommentResponseDto({
    @Default([]) List<CommentItemDto> replies,
    CommentCursorDto? cursor,
    CommentPageDto? page,
  }) = _CommentResponseDto;

  factory CommentResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CommentResponseDtoFromJson(json);
}

@freezed
sealed class CommentPageDto with _$CommentPageDto {
  const factory CommentPageDto({
    @Default(0) int num,
    @Default(0) int size,
    @JsonKey(name: 'count') @Default(0) int totalCount,
    @Default(0) int acount,
  }) = _CommentPageDto;

  factory CommentPageDto.fromJson(Map<String, dynamic> json) =>
      _$CommentPageDtoFromJson(json);
}

@freezed
sealed class CommentCursorDto with _$CommentCursorDto {
  const factory CommentCursorDto({
    @JsonKey(name: 'all_count') @Default(0) int allCount,
    @JsonKey(name: 'is_begin') @Default(false) bool isBegin,
    @JsonKey(name: 'is_end') @Default(false) bool isEnd,
    @Default(0) int mode,
    @Default('') String name,
    @Default(0) int next,
    @Default(0) int prev,
  }) = _CommentCursorDto;

  factory CommentCursorDto.fromJson(Map<String, dynamic> json) =>
      _$CommentCursorDtoFromJson(json);
}

@freezed
sealed class CommentItemDto with _$CommentItemDto {
  const factory CommentItemDto({
    required int rpid,
    required int oid,
    required int type,
    required int mid,
    required int root,
    required int parent,
    @Default(0) int dialog,
    @Default(0) int count,
    @Default(0) int rcount,
    @Default(0) int floor,
    @Default(0) int state,
    @Default(0) int fansgrade,
    @Default(0) int attr,
    required int ctime,
    @JsonKey(name: 'rpid_str') @Default('') String rpidStr,
    @JsonKey(name: 'root_str') @Default('') String rootStr,
    @JsonKey(name: 'parent_str') @Default('') String parentStr,
    @Default(0) int like,
    @Default(0) int action,
    required CommentMemberDto member,
    required CommentContentDto content,
    @Default([]) List<CommentItemDto> replies,
    @JsonKey(name: 'show_follow') @Default(false) bool showFollow,
    @Default(false) bool invisible,
  }) = _CommentItemDto;

  factory CommentItemDto.fromJson(Map<String, dynamic> json) =>
      _$CommentItemDtoFromJson(json);
}

@freezed
sealed class CommentMemberDto with _$CommentMemberDto {
  const factory CommentMemberDto({
    required String mid,
    required String uname,
    required String sex,
    required String sign,
    required String avatar,
    required String rank,
    @JsonKey(name: 'DisplayRank') @Default(0) int displayRank,
    @JsonKey(name: 'level_info') required CommentLevelInfoDto levelInfo,
    required CommentPendantDto pendant,
    required CommentNameplateDto nameplate,
    @JsonKey(name: 'official_verify') required CommentOfficialVerifyDto officialVerify,
    required CommentVipDto vip,
    @JsonKey(name: 'fans_detail') dynamic fansDetail,
    @Default(0) int following,
    @JsonKey(name: 'is_followed') @Default(0) int isFollowed,
  }) = _CommentMemberDto;

  factory CommentMemberDto.fromJson(Map<String, dynamic> json) =>
      _$CommentMemberDtoFromJson(json);
}

@freezed
sealed class CommentLevelInfoDto with _$CommentLevelInfoDto {
  const factory CommentLevelInfoDto({
    @JsonKey(name: 'current_level') required int currentLevel,
    @JsonKey(name: 'current_min') required int currentMin,
    @JsonKey(name: 'current_exp') required int currentExp,
    @JsonKey(name: 'next_exp') required int nextExp,
  }) = _CommentLevelInfoDto;

  factory CommentLevelInfoDto.fromJson(Map<String, dynamic> json) =>
      _$CommentLevelInfoDtoFromJson(json);
}

@freezed
sealed class CommentPendantDto with _$CommentPendantDto {
  const factory CommentPendantDto({
    required int pid,
    required String name,
    required String image,
    required int expire,
    @JsonKey(name: 'image_enhance') @Default('') String imageEnhance,
    @JsonKey(name: 'image_enhance_frame') @Default('') String imageEnhanceFrame,
  }) = _CommentPendantDto;

  factory CommentPendantDto.fromJson(Map<String, dynamic> json) =>
      _$CommentPendantDtoFromJson(json);
}

@freezed
sealed class CommentNameplateDto with _$CommentNameplateDto {
  const factory CommentNameplateDto({
    required int nid,
    required String name,
    required String image,
    @JsonKey(name: 'image_small') required String imageSmall,
    required String level,
    required String condition,
  }) = _CommentNameplateDto;

  factory CommentNameplateDto.fromJson(Map<String, dynamic> json) =>
      _$CommentNameplateDtoFromJson(json);
}

@freezed
sealed class CommentOfficialVerifyDto with _$CommentOfficialVerifyDto {
  const factory CommentOfficialVerifyDto({
    @Default(-1) int type,
    @Default('') String desc,
  }) = _CommentOfficialVerifyDto;

  factory CommentOfficialVerifyDto.fromJson(Map<String, dynamic> json) =>
      _$CommentOfficialVerifyDtoFromJson(json);
}

@freezed
sealed class CommentVipDto with _$CommentVipDto {
  const factory CommentVipDto({
    @Default(0) int vipType,
    @Default(0) int vipDueDate,
    @Default('') String dueRemark,
    @Default(0) int accessStatus,
    @Default(0) int vipStatus,
    @Default('') String vipStatusWarn,
    @Default(0) int themeType,
    dynamic label,
  }) = _CommentVipDto;

  factory CommentVipDto.fromJson(Map<String, dynamic> json) =>
      _$CommentVipDtoFromJson(json);
}

@freezed
sealed class CommentLabelDto with _$CommentLabelDto {
  const factory CommentLabelDto({
    required String path,
    required String text,
    @JsonKey(name: 'label_theme') required String labelTheme,
    @JsonKey(name: 'text_color') @Default('') String textColor,
    @JsonKey(name: 'bg_style') @Default(0) int bgStyle,
    @JsonKey(name: 'bg_color') @Default('') String bgColor,
    @JsonKey(name: 'border_color') @Default('') String borderColor,
    @JsonKey(name: 'use_img_label') @Default(false) bool useImgLabel,
    @JsonKey(name: 'img_label_uri_hans') @Default('') String imgLabelUriHans,
    @JsonKey(name: 'img_label_uri_hant') @Default('') String imgLabelUriHant,
    @JsonKey(name: 'img_label_uri_hans_static') @Default('') String imgLabelUriHansStatic,
    @JsonKey(name: 'img_label_uri_hant_static') @Default('') String imgLabelUriHantStatic,
  }) = _CommentLabelDto;

  factory CommentLabelDto.fromJson(Map<String, dynamic> json) =>
      _$CommentLabelDtoFromJson(json);
}

@freezed
sealed class CommentContentDto with _$CommentContentDto {
  const factory CommentContentDto({
    required String message,
    @Default(0) int plat,
    @Default('') String device,
    @Default([]) List<CommentMemberDto> members,
    Map<String, CommentEmoteDto>? emote,
    @Default([]) List<CommentPictureDto> pictures,
    @JsonKey(name: 'jump_url') @Default({}) Map<String, dynamic> jumpUrl,
    @JsonKey(name: 'max_line') @Default(0) int maxLine,
  }) = _CommentContentDto;

  factory CommentContentDto.fromJson(Map<String, dynamic> json) =>
      _$CommentContentDtoFromJson(json);
}

@freezed
sealed class CommentPictureDto with _$CommentPictureDto {
  const factory CommentPictureDto({
    @JsonKey(name: 'img_src') required String imgSrc,
    @JsonKey(name: 'img_width') @Default(0) double imgWidth,
    @JsonKey(name: 'img_height') @Default(0) double imgHeight,
    @JsonKey(name: 'img_size') @Default(0) double imgSize,
  }) = _CommentPictureDto;

  factory CommentPictureDto.fromJson(Map<String, dynamic> json) =>
      _$CommentPictureDtoFromJson(json);
}

@freezed
sealed class CommentEmoteDto with _$CommentEmoteDto {
  const factory CommentEmoteDto({
    required int id,
    @JsonKey(name: 'package_id') @Default(0) int packageId,
    @Default(0) int state,
    @Default(0) int type,
    @Default(0) int attr,
    required String text,
    required String url,
    @Default(0) int mtime,
    @JsonKey(name: 'jump_title') @Default('') String jumpTitle,
  }) = _CommentEmoteDto;

  factory CommentEmoteDto.fromJson(Map<String, dynamic> json) =>
      _$CommentEmoteDtoFromJson(json);
}

extension CommentResponseDtoMapper on CommentResponseDto {
  contract.CommentResponse toContract() {
    return contract.CommentResponse(
      replies: replies.map((item) => item.toContract()).toList(),
      cursor: cursor?.toContract(),
      page: page?.toContract(),
    );
  }
}

extension CommentPageDtoMapper on CommentPageDto {
  contract.CommentPage toContract() {
    final pageNumber = this.num;
    return contract.CommentPage(
      num: pageNumber,
      size: size,
      count: totalCount,
      acount: acount,
    );
  }
}

extension CommentCursorDtoMapper on CommentCursorDto {
  contract.CommentCursor toContract() {
    return contract.CommentCursor(
      allCount: allCount,
      isBegin: isBegin,
      isEnd: isEnd,
      mode: mode,
      name: name,
      next: next,
      prev: prev,
    );
  }
}

extension CommentItemDtoMapper on CommentItemDto {
  contract.CommentItem toContract() {
    return contract.CommentItem(
      rpid: rpid,
      oid: oid,
      type: type,
      mid: mid,
      root: root,
      parent: parent,
      dialog: dialog,
      count: count,
      rcount: rcount,
      floor: floor,
      state: state,
      fansgrade: fansgrade,
      attr: attr,
      ctime: ctime,
      rpidStr: rpidStr,
      rootStr: rootStr,
      parentStr: parentStr,
      like: like,
      action: action,
      member: member.toContract(),
      content: content.toContract(),
      replies: replies.map((item) => item.toContract()).toList(),
      showFollow: showFollow,
      invisible: invisible,
    );
  }
}

extension CommentMemberDtoMapper on CommentMemberDto {
  contract.CommentMember toContract() {
    return contract.CommentMember(
      mid: mid,
      uname: uname,
      sex: sex,
      sign: sign,
      avatar: avatar,
      rank: rank,
      displayRank: displayRank,
      levelInfo: levelInfo.toContract(),
      pendant: pendant.toContract(),
      nameplate: nameplate.toContract(),
      officialVerify: officialVerify.toContract(),
      vip: vip.toContract(),
      fansDetail: fansDetail,
      following: following,
      isFollowed: isFollowed,
    );
  }
}

extension CommentLevelInfoDtoMapper on CommentLevelInfoDto {
  contract.CommentLevelInfo toContract() {
    return contract.CommentLevelInfo(
      currentLevel: currentLevel,
      currentMin: currentMin,
      currentExp: currentExp,
      nextExp: nextExp,
    );
  }
}

extension CommentPendantDtoMapper on CommentPendantDto {
  contract.CommentPendant toContract() {
    return contract.CommentPendant(
      pid: pid,
      name: name,
      image: image,
      expire: expire,
      imageEnhance: imageEnhance,
      imageEnhanceFrame: imageEnhanceFrame,
    );
  }
}

extension CommentNameplateDtoMapper on CommentNameplateDto {
  contract.CommentNameplate toContract() {
    return contract.CommentNameplate(
      nid: nid,
      name: name,
      image: image,
      imageSmall: imageSmall,
      level: level,
      condition: condition,
    );
  }
}

extension CommentOfficialVerifyDtoMapper on CommentOfficialVerifyDto {
  contract.CommentOfficialVerify toContract() {
    return contract.CommentOfficialVerify(type: type, desc: desc);
  }
}

extension CommentVipDtoMapper on CommentVipDto {
  contract.CommentVip toContract() {
    return contract.CommentVip(
      vipType: vipType,
      vipDueDate: vipDueDate,
      dueRemark: dueRemark,
      accessStatus: accessStatus,
      vipStatus: vipStatus,
      vipStatusWarn: vipStatusWarn,
      themeType: themeType,
      label: label,
    );
  }
}

extension CommentContentDtoMapper on CommentContentDto {
  contract.CommentContent toContract() {
    return contract.CommentContent(
      message: message,
      plat: plat,
      device: device,
      members: members.map((item) => item.toContract()).toList(),
      emote: emote?.map((key, value) => MapEntry(key, value.toContract())),
      pictures: pictures.map((item) => item.toContract()).toList(),
      jumpUrl: jumpUrl,
      maxLine: maxLine,
    );
  }
}

extension CommentPictureDtoMapper on CommentPictureDto {
  contract.CommentPicture toContract() {
    return contract.CommentPicture(
      imgSrc: imgSrc,
      imgWidth: imgWidth,
      imgHeight: imgHeight,
      imgSize: imgSize,
    );
  }
}

extension CommentEmoteDtoMapper on CommentEmoteDto {
  contract.CommentEmote toContract() {
    return contract.CommentEmote(
      id: id,
      packageId: packageId,
      state: state,
      type: type,
      attr: attr,
      text: text,
      url: url,
      mtime: mtime,
      jumpTitle: jumpTitle,
    );
  }
}
