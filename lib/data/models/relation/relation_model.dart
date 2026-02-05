import 'package:freezed_annotation/freezed_annotation.dart';

part 'relation_model.freezed.dart';
part 'relation_model.g.dart';

@freezed
abstract class RelationResponseData with _$RelationResponseData {
  const factory RelationResponseData({
    @Default([]) List<RelationUser> list,
    @Default(0) int total,
  }) = _RelationResponseData;

  factory RelationResponseData.fromJson(Map<String, dynamic> json) =>
      _$RelationResponseDataFromJson(json);
}

@freezed
abstract class RelationUser with _$RelationUser {
  const factory RelationUser({
    required int mid,
    required String uname,
    required String face,
    @Default('') String sign,
    @Default(0) int attribute, // 0:未关注, 2:已关注, 6:已互粉
    @JsonKey(name: 'official_verify') OfficialVerify? officialVerify,
    VipInfo? vip,
    @Default(0) int mtime,
    @Default(0) int special, // 0:否, 1:是 (特别关注)
  }) = _RelationUser;

  factory RelationUser.fromJson(Map<String, dynamic> json) =>
      _$RelationUserFromJson(json);
}

@freezed
abstract class OfficialVerify with _$OfficialVerify {
  const factory OfficialVerify({
    @Default(-1) int type,
    @Default('') String desc,
  }) = _OfficialVerify;

  factory OfficialVerify.fromJson(Map<String, dynamic> json) =>
      _$OfficialVerifyFromJson(json);
}

@freezed
abstract class VipInfo with _$VipInfo {
  const factory VipInfo({
    @Default(0) int vipType,
    @Default(0) int vipStatus,
    @Default('') String nicknameColor,
  }) = _VipInfo;

  factory VipInfo.fromJson(Map<String, dynamic> json) =>
      _$VipInfoFromJson(json);
}
