import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_contract.freezed.dart';

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
}

@freezed
sealed class CommentPage with _$CommentPage {
  const factory CommentPage({
    @Default(0) int num,
    @Default(0) int size,
    @Default(0) int count,
    @Default(0) int acount,
  }) = _CommentPage;
}

@freezed
sealed class CommentCursor with _$CommentCursor {
  const factory CommentCursor({
    @Default(0) int allCount,
    @Default(false) bool isBegin,
    @Default(false) bool isEnd,
    @Default(0) int mode,
    @Default('') String name,
    @Default(0) int next,
    @Default(0) int prev,
  }) = _CommentCursor;
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
    @Default('') String rpidStr,
    @Default('') String rootStr,
    @Default('') String parentStr,
    @Default(0) int like,
    @Default(0) int action,
    required CommentMember member,
    required CommentContent content,
    @Default([]) List<CommentItem> replies,
    @Default(false) bool showFollow,
    @Default(false) bool invisible,
  }) = _CommentItem;
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
    @Default(0) int displayRank,
    required CommentLevelInfo levelInfo,
    required CommentPendant pendant,
    required CommentNameplate nameplate,
    required CommentOfficialVerify officialVerify,
    required CommentVip vip,
    dynamic fansDetail,
    @Default(0) int following,
    @Default(0) int isFollowed,
  }) = _CommentMember;
}

@freezed
sealed class CommentLevelInfo with _$CommentLevelInfo {
  const factory CommentLevelInfo({
    required int currentLevel,
    required int currentMin,
    required int currentExp,
    required int nextExp,
  }) = _CommentLevelInfo;
}

@freezed
sealed class CommentPendant with _$CommentPendant {
  const factory CommentPendant({
    required int pid,
    required String name,
    required String image,
    required int expire,
    @Default('') String imageEnhance,
    @Default('') String imageEnhanceFrame,
  }) = _CommentPendant;
}

@freezed
sealed class CommentNameplate with _$CommentNameplate {
  const factory CommentNameplate({
    required int nid,
    required String name,
    required String image,
    required String imageSmall,
    required String level,
    required String condition,
  }) = _CommentNameplate;
}

@freezed
sealed class CommentOfficialVerify with _$CommentOfficialVerify {
  const factory CommentOfficialVerify({
    @Default(-1) int type,
    @Default('') String desc,
  }) = _CommentOfficialVerify;
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
}

@freezed
sealed class CommentLabel with _$CommentLabel {
  const factory CommentLabel({
    required String path,
    required String text,
    required String labelTheme,
    @Default('') String textColor,
    @Default(0) int bgStyle,
    @Default('') String bgColor,
    @Default('') String borderColor,
    @Default(false) bool useImgLabel,
    @Default('') String imgLabelUriHans,
    @Default('') String imgLabelUriHant,
    @Default('') String imgLabelUriHansStatic,
    @Default('') String imgLabelUriHantStatic,
  }) = _CommentLabel;
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
    @Default({}) Map<String, dynamic> jumpUrl,
    @Default(0) int maxLine,
  }) = _CommentContent;
}

@freezed
sealed class CommentPicture with _$CommentPicture {
  const factory CommentPicture({
    required String imgSrc,
    @Default(0) double imgWidth,
    @Default(0) double imgHeight,
    @Default(0) double imgSize,
  }) = _CommentPicture;
}

@freezed
sealed class CommentEmote with _$CommentEmote {
  const factory CommentEmote({
    required int id,
    @Default(0) int packageId,
    @Default(0) int state,
    @Default(0) int type,
    @Default(0) int attr,
    required String text,
    required String url,
    @Default(0) int mtime,
    @Default('') String jumpTitle,
  }) = _CommentEmote;
}
