import 'package:freezed_annotation/freezed_annotation.dart';

part 'relation_user_contract.freezed.dart';
part 'relation_user_contract.g.dart';

@freezed
sealed class RelationOfficialVerify with _$RelationOfficialVerify {
  const factory RelationOfficialVerify({
    required int type,
    required String desc,
  }) = _RelationOfficialVerify;

  factory RelationOfficialVerify.fromJson(Map<String, dynamic> json) =>
      _$RelationOfficialVerifyFromJson(json);
}

@freezed
sealed class RelationVipInfo with _$RelationVipInfo {
  const factory RelationVipInfo({
    required int vipType,
    required int vipStatus,
    required String nicknameColor,
  }) = _RelationVipInfo;

  factory RelationVipInfo.fromJson(Map<String, dynamic> json) =>
      _$RelationVipInfoFromJson(json);
}

@freezed
sealed class ProfileRelationUser with _$ProfileRelationUser {
  const factory ProfileRelationUser({
    required int mid,
    required String uname,
    required String face,
    required String sign,
    required int attribute,
    RelationOfficialVerify? officialVerify,
    RelationVipInfo? vip,
    required int mtime,
    required int special,
  }) = _ProfileRelationUser;

  factory ProfileRelationUser.fromJson(Map<String, dynamic> json) =>
      _$ProfileRelationUserFromJson(json);
}
