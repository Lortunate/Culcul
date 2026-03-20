import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_guard_list_model.freezed.dart';
part 'live_guard_list_model.g.dart';

@freezed
sealed class LiveGuardListModel with _$LiveGuardListModel {
  const factory LiveGuardListModel({
    required LiveGuardInfo info,
    @Default([]) List<LiveGuardItem> top3,
    @Default([]) List<LiveGuardItem> list,
  }) = _LiveGuardListModel;

  factory LiveGuardListModel.fromJson(Map<String, dynamic> json) =>
      _$LiveGuardListModelFromJson(json);
}

@freezed
sealed class LiveGuardInfo with _$LiveGuardInfo {
  const factory LiveGuardInfo({
    required int num,
    required int page,
    required int now,
  }) = _LiveGuardInfo;

  factory LiveGuardInfo.fromJson(Map<String, dynamic> json) =>
      _$LiveGuardInfoFromJson(json);
}

@freezed
sealed class LiveGuardItem with _$LiveGuardItem {
  const factory LiveGuardItem({
    required int ruid,
    required int rank,
    @JsonKey(name: 'uinfo') required LiveGuardUserInfo userInfo,
    @JsonKey(name: 'guard_level') required int guardLevel,
  }) = _LiveGuardItem;

  factory LiveGuardItem.fromJson(Map<String, dynamic> json) =>
      _$LiveGuardItemFromJson(json);
}

@freezed
sealed class LiveGuardUserInfo with _$LiveGuardUserInfo {
  const factory LiveGuardUserInfo({
    required int uid,
    @JsonKey(name: 'base') required LiveGuardUserBase base,
  }) = _LiveGuardUserInfo;

  factory LiveGuardUserInfo.fromJson(Map<String, dynamic> json) =>
      _$LiveGuardUserInfoFromJson(json);
}

@freezed
sealed class LiveGuardUserBase with _$LiveGuardUserBase {
  const factory LiveGuardUserBase({
    required String name,
    required String face,
  }) = _LiveGuardUserBase;

  factory LiveGuardUserBase.fromJson(Map<String, dynamic> json) =>
      _$LiveGuardUserBaseFromJson(json);
}
