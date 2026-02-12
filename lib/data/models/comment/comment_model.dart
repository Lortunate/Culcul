import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_model.freezed.dart';
part 'comment_model.g.dart';

@freezed
abstract class CommentResponse with _$CommentResponse {
  const factory CommentResponse({
    @Default([]) List<CommentItem> replies,
    CommentCursor? cursor,
    CommentPage? page,
  }) = _CommentResponse;

  factory CommentResponse.fromJson(Map<String, dynamic> json) =>
      _$CommentResponseFromJson(json);
}

@freezed
abstract class CommentPage with _$CommentPage {
  const factory CommentPage({
    @Default(0) int num,
    @Default(0) int size,
    @Default(0) int count,
    @Default(0) int acount,
  }) = _CommentPage;

  factory CommentPage.fromJson(Map<String, dynamic> json) =>
      _$CommentPageFromJson(json);
}

@freezed
abstract class CommentCursor with _$CommentCursor {
  const factory CommentCursor({
    @Default(0) int all_count,
    @Default(false) bool is_begin,
    @Default(false) bool is_end,
    @Default(0) int mode,
    required String name,
    @Default(0) int next,
    @Default(0) int prev,
  }) = _CommentCursor;

  factory CommentCursor.fromJson(Map<String, dynamic> json) =>
      _$CommentCursorFromJson(json);
}

@freezed
abstract class CommentItem with _$CommentItem {
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
    @Default('') String rpid_str,
    @Default('') String root_str,
    @Default('') String parent_str,
    @Default(0) int like,
    @Default(0) int action,
    required CommentMember member,
    required CommentContent content,
    @Default([]) List<CommentItem> replies,
    @Default(false) bool show_follow,
    @Default(false) bool invisible,
  }) = _CommentItem;

  factory CommentItem.fromJson(Map<String, dynamic> json) =>
      _$CommentItemFromJson(json);
}

@freezed
abstract class CommentMember with _$CommentMember {
  const factory CommentMember({
    required String mid,
    required String uname,
    required String sex,
    required String sign,
    required String avatar,
    required String rank,
    @Default(0) int DisplayRank,
    required CommentLevelInfo level_info,
    required CommentPendant pendant,
    required CommentNameplate nameplate,
    required CommentOfficialVerify official_verify,
    required CommentVip vip,
    dynamic fans_detail,
    @Default(0) int following,
    @Default(0) int is_followed,
  }) = _CommentMember;

  factory CommentMember.fromJson(Map<String, dynamic> json) =>
      _$CommentMemberFromJson(json);
}

@freezed
abstract class CommentLevelInfo with _$CommentLevelInfo {
  const factory CommentLevelInfo({
    required int current_level,
    required int current_min,
    required int current_exp,
    required int next_exp,
  }) = _CommentLevelInfo;

  factory CommentLevelInfo.fromJson(Map<String, dynamic> json) =>
      _$CommentLevelInfoFromJson(json);
}

@freezed
abstract class CommentPendant with _$CommentPendant {
  const factory CommentPendant({
    required int pid,
    required String name,
    required String image,
    required int expire,
    @Default('') String image_enhance,
    @Default('') String image_enhance_frame,
  }) = _CommentPendant;

  factory CommentPendant.fromJson(Map<String, dynamic> json) =>
      _$CommentPendantFromJson(json);
}

@freezed
abstract class CommentNameplate with _$CommentNameplate {
  const factory CommentNameplate({
    required int nid,
    required String name,
    required String image,
    required String image_small,
    required String level,
    required String condition,
  }) = _CommentNameplate;

  factory CommentNameplate.fromJson(Map<String, dynamic> json) =>
      _$CommentNameplateFromJson(json);
}

@freezed
abstract class CommentOfficialVerify with _$CommentOfficialVerify {
  const factory CommentOfficialVerify({
    @Default(-1) int type,
    @Default('') String desc,
  }) = _CommentOfficialVerify;

  factory CommentOfficialVerify.fromJson(Map<String, dynamic> json) =>
      _$CommentOfficialVerifyFromJson(json);
}

@freezed
abstract class CommentVip with _$CommentVip {
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

  factory CommentVip.fromJson(Map<String, dynamic> json) =>
      _$CommentVipFromJson(json);
}

@freezed
abstract class CommentLabel with _$CommentLabel {
  const factory CommentLabel({
    required String path,
    required String text,
    required String label_theme,
    @Default('') String text_color,
    @Default(0) int bg_style,
    @Default('') String bg_color,
    @Default('') String border_color,
    @Default(false) bool use_img_label,
    @Default('') String img_label_uri_hans,
    @Default('') String img_label_uri_hant,
    @Default('') String img_label_uri_hans_static,
    @Default('') String img_label_uri_hant_static,
  }) = _CommentLabel;

  factory CommentLabel.fromJson(Map<String, dynamic> json) =>
      _$CommentLabelFromJson(json);
}

@freezed
abstract class CommentContent with _$CommentContent {
  const factory CommentContent({
    required String message,
    @Default(0) int plat,
    @Default('') String device,
    @Default([]) List<CommentMember> members,
    Map<String, CommentEmote>? emote,
    @Default([]) List<CommentPicture> pictures,
    @Default({}) Map<String, dynamic> jump_url,
    @Default(0) int max_line,
  }) = _CommentContent;

  factory CommentContent.fromJson(Map<String, dynamic> json) =>
      _$CommentContentFromJson(json);
}

@freezed
abstract class CommentPicture with _$CommentPicture {
  const factory CommentPicture({
    required String img_src,
    @Default(0) double img_width,
    @Default(0) double img_height,
    @Default(0) double img_size,
  }) = _CommentPicture;

  factory CommentPicture.fromJson(Map<String, dynamic> json) =>
      _$CommentPictureFromJson(json);
}

@freezed
abstract class CommentEmote with _$CommentEmote {
  const factory CommentEmote({
    required int id,
    @Default(0) int package_id,
    @Default(0) int state,
    @Default(0) int type,
    @Default(0) int attr,
    required String text,
    required String url,
    @Default(0) int mtime,
    @Default('') String jump_title,
  }) = _CommentEmote;

  factory CommentEmote.fromJson(Map<String, dynamic> json) =>
      _$CommentEmoteFromJson(json);
}
