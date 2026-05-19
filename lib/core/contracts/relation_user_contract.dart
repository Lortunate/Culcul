import 'package:freezed_annotation/freezed_annotation.dart';

part 'relation_user_contract.freezed.dart';
part 'relation_user_contract.g.dart';

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

@freezed
sealed class ProfileRelationUser with _$ProfileRelationUser {
  const factory ProfileRelationUser({
    required int mid,
    required String uname,
    required String face,
    required String sign,
    required int attribute,
    @JsonKey(name: 'official_verify') OfficialVerify? officialVerify,
    VipInfo? vip,
    required int mtime,
    required int special,
  }) = _ProfileRelationUser;

  factory ProfileRelationUser.fromJson(Map<String, dynamic> json) =>
      _$ProfileRelationUserFromJson(json);
}
