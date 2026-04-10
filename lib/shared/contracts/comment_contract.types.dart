part of 'comment_contract.dart';

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
