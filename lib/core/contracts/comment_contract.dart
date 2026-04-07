import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_contract.freezed.dart';
part 'comment_contract.g.dart';

enum CommentSort {
  latest(0),
  hot(1);

  const CommentSort(this.apiValue);

  final int apiValue;
}

@freezed
sealed class CommentResponse with _$CommentResponse {
  const factory CommentResponse({
    @Default([]) List<CommentItem> replies,
    CommentCursor? cursor,
    CommentPage? page,
  }) = _CommentResponse;

  factory CommentResponse.fromJson(Map<String, dynamic> json) =>
      _$CommentResponseFromJson(json);
}

@freezed
sealed class CommentPage with _$CommentPage {
  const factory CommentPage({
    @Default(0) int num,
    @Default(0) int size,
    @JsonKey(name: 'count') @Default(0) int count,
    @Default(0) int acount,
  }) = _CommentPage;

  factory CommentPage.fromJson(Map<String, dynamic> json) => _$CommentPageFromJson(json);
}

@freezed
sealed class CommentCursor with _$CommentCursor {
  const factory CommentCursor({
    @JsonKey(name: 'all_count') @Default(0) int allCount,
    @JsonKey(name: 'is_begin') @Default(false) bool isBegin,
    @JsonKey(name: 'is_end') @Default(false) bool isEnd,
    @Default(0) int mode,
    @Default('') String name,
    @Default(0) int next,
    @Default(0) int prev,
  }) = _CommentCursor;

  factory CommentCursor.fromJson(Map<String, dynamic> json) =>
      _$CommentCursorFromJson(json);
}

@freezed
sealed class CommentItem with _$CommentItem {
  const factory CommentItem({
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
    required CommentMember member,
    required CommentContent content,
    @Default([]) List<CommentItem> replies,
    @JsonKey(name: 'show_follow') @Default(false) bool showFollow,
    @Default(false) bool invisible,
  }) = _CommentItem;

  factory CommentItem.fromJson(Map<String, dynamic> json) => _$CommentItemFromJson(json);
}

@freezed
sealed class CommentMember with _$CommentMember {
  const factory CommentMember({
    required String mid,
    required String uname,
    required String sex,
    required String sign,
    required String avatar,
    required String rank,
    @JsonKey(name: 'DisplayRank') @Default(0) int displayRank,
    @JsonKey(name: 'level_info') required CommentLevelInfo levelInfo,
    required CommentPendant pendant,
    required CommentNameplate nameplate,
    @JsonKey(name: 'official_verify') required CommentOfficialVerify officialVerify,
    required CommentVip vip,
    @JsonKey(name: 'fans_detail') dynamic fansDetail,
    @Default(0) int following,
    @JsonKey(name: 'is_followed') @Default(0) int isFollowed,
  }) = _CommentMember;

  factory CommentMember.fromJson(Map<String, dynamic> json) =>
      _$CommentMemberFromJson(json);
}

@freezed
sealed class CommentLevelInfo with _$CommentLevelInfo {
  const factory CommentLevelInfo({
    @JsonKey(name: 'current_level') required int currentLevel,
    @JsonKey(name: 'current_min') required int currentMin,
    @JsonKey(name: 'current_exp') required int currentExp,
    @JsonKey(name: 'next_exp') required int nextExp,
  }) = _CommentLevelInfo;

  factory CommentLevelInfo.fromJson(Map<String, dynamic> json) =>
      _$CommentLevelInfoFromJson(json);
}

@freezed
sealed class CommentPendant with _$CommentPendant {
  const factory CommentPendant({
    required int pid,
    required String name,
    required String image,
    required int expire,
    @JsonKey(name: 'image_enhance') @Default('') String imageEnhance,
    @JsonKey(name: 'image_enhance_frame') @Default('') String imageEnhanceFrame,
  }) = _CommentPendant;

  factory CommentPendant.fromJson(Map<String, dynamic> json) =>
      _$CommentPendantFromJson(json);
}

@freezed
sealed class CommentNameplate with _$CommentNameplate {
  const factory CommentNameplate({
    required int nid,
    required String name,
    required String image,
    @JsonKey(name: 'image_small') required String imageSmall,
    required String level,
    required String condition,
  }) = _CommentNameplate;

  factory CommentNameplate.fromJson(Map<String, dynamic> json) =>
      _$CommentNameplateFromJson(json);
}

@freezed
sealed class CommentOfficialVerify with _$CommentOfficialVerify {
  const factory CommentOfficialVerify({@Default(-1) int type, @Default('') String desc}) =
      _CommentOfficialVerify;

  factory CommentOfficialVerify.fromJson(Map<String, dynamic> json) =>
      _$CommentOfficialVerifyFromJson(json);
}

@freezed
sealed class CommentVip with _$CommentVip {
  const factory CommentVip({
    @Default(0) int vipType,
    @Default(0) int vipDueDate,
    @Default('') String dueRemark,
    @Default(0) int accessStatus,
    @Default(0) int vipStatus,
    @Default('') String vipStatusWarn,
    @Default(0) int themeType,
    dynamic label,
  }) = _CommentVip;

  factory CommentVip.fromJson(Map<String, dynamic> json) => _$CommentVipFromJson(json);
}

@freezed
sealed class CommentLabel with _$CommentLabel {
  const factory CommentLabel({
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
  }) = _CommentLabel;

  factory CommentLabel.fromJson(Map<String, dynamic> json) =>
      _$CommentLabelFromJson(json);
}

@freezed
sealed class CommentContent with _$CommentContent {
  const factory CommentContent({
    required String message,
    @Default(0) int plat,
    @Default('') String device,
    @Default([]) List<CommentMember> members,
    Map<String, CommentEmote>? emote,
    @Default([]) List<CommentPicture> pictures,
    @JsonKey(name: 'jump_url') @Default({}) Map<String, dynamic> jumpUrl,
    @JsonKey(name: 'max_line') @Default(0) int maxLine,
  }) = _CommentContent;

  factory CommentContent.fromJson(Map<String, dynamic> json) =>
      _$CommentContentFromJson(json);
}

@freezed
sealed class CommentPicture with _$CommentPicture {
  const factory CommentPicture({
    @JsonKey(name: 'img_src') required String imgSrc,
    @JsonKey(name: 'img_width') @Default(0) double imgWidth,
    @JsonKey(name: 'img_height') @Default(0) double imgHeight,
    @JsonKey(name: 'img_size') @Default(0) double imgSize,
  }) = _CommentPicture;

  factory CommentPicture.fromJson(Map<String, dynamic> json) =>
      _$CommentPictureFromJson(json);
}

@freezed
sealed class CommentEmote with _$CommentEmote {
  const factory CommentEmote({
    required int id,
    @JsonKey(name: 'package_id') @Default(0) int packageId,
    @Default(0) int state,
    @Default(0) int type,
    @Default(0) int attr,
    required String text,
    required String url,
    @Default(0) int mtime,
    @JsonKey(name: 'jump_title') @Default('') String jumpTitle,
  }) = _CommentEmote;

  factory CommentEmote.fromJson(Map<String, dynamic> json) =>
      _$CommentEmoteFromJson(json);
}
