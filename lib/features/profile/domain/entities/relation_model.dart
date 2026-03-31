import 'package:freezed_annotation/freezed_annotation.dart';

part 'relation_model.freezed.dart';
part 'relation_model.g.dart';

@freezed
sealed class RelationResponseData with _$RelationResponseData {
  const factory RelationResponseData({
    @Default([]) List<RelationUser> list,
    @Default(0) int total,
  }) = _RelationResponseData;

  factory RelationResponseData.fromJson(Map<String, dynamic> json) =>
      _$RelationResponseDataFromJson(json);
}

@freezed
sealed class RelationUser with _$RelationUser {
  const factory RelationUser({
    required int mid,
    required String uname,
    required String face,
    @Default('') String sign,
    @Default(0) int attribute, // 0: not following, 2: following, 6: mutual
    @JsonKey(name: 'official_verify') OfficialVerify? officialVerify,
    VipInfo? vip,
    @Default(0) int mtime,
    @Default(0) int special, // 0: no, 1: yes (special follow)
  }) = _RelationUser;

  factory RelationUser.fromJson(Map<String, dynamic> json) =>
      _$RelationUserFromJson(json);
}

@freezed
sealed class OfficialVerify with _$OfficialVerify {
  const factory OfficialVerify({@Default(-1) int type, @Default('') String desc}) =
      _OfficialVerify;

  factory OfficialVerify.fromJson(Map<String, dynamic> json) =>
      _$OfficialVerifyFromJson(json);
}

@freezed
sealed class VipInfo with _$VipInfo {
  const factory VipInfo({
    @Default(0) int vipType,
    @Default(0) int vipStatus,
    @Default('') String nicknameColor,
  }) = _VipInfo;

  factory VipInfo.fromJson(Map<String, dynamic> json) => _$VipInfoFromJson(json);
}
