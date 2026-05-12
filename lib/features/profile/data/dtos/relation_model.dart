import 'package:culcul/core/contracts/relation_user_contract.dart';
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
