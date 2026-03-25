import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_anchor_info_model.freezed.dart';
part 'live_anchor_info_model.g.dart';

@freezed
sealed class LiveAnchorInfoModel with _$LiveAnchorInfoModel {
  const factory LiveAnchorInfoModel({
    required LiveAnchorInfo info,
    required LiveAnchorExp exp,
    @JsonKey(name: 'follower_num') required int followerNum,
    @JsonKey(name: 'room_id') required int roomId,
    @JsonKey(name: 'medal_name') required String medalName,
    @JsonKey(name: 'glory_count') required int gloryCount,
    required String pendant,
  }) = _LiveAnchorInfoModel;

  factory LiveAnchorInfoModel.fromJson(Map<String, dynamic> json) =>
      _$LiveAnchorInfoModelFromJson(json);
}

@freezed
sealed class LiveAnchorInfo with _$LiveAnchorInfo {
  const factory LiveAnchorInfo({
    required int uid,
    required String uname,
    required String face,
    @JsonKey(name: 'official_verify') required LiveAnchorVerify officialVerify,
    required int gender,
  }) = _LiveAnchorInfo;

  factory LiveAnchorInfo.fromJson(Map<String, dynamic> json) =>
      _$LiveAnchorInfoFromJson(json);
}

@freezed
sealed class LiveAnchorVerify with _$LiveAnchorVerify {
  const factory LiveAnchorVerify({required int type, required String desc}) =
      _LiveAnchorVerify;

  factory LiveAnchorVerify.fromJson(Map<String, dynamic> json) =>
      _$LiveAnchorVerifyFromJson(json);
}

@freezed
sealed class LiveAnchorExp with _$LiveAnchorExp {
  const factory LiveAnchorExp({
    @JsonKey(name: 'master_level') required LiveMasterLevel masterLevel,
  }) = _LiveAnchorExp;

  factory LiveAnchorExp.fromJson(Map<String, dynamic> json) =>
      _$LiveAnchorExpFromJson(json);
}

@freezed
sealed class LiveMasterLevel with _$LiveMasterLevel {
  const factory LiveMasterLevel({
    required int level,
    required int color,
    required List<int> current,
    required List<int> next,
  }) = _LiveMasterLevel;

  factory LiveMasterLevel.fromJson(Map<String, dynamic> json) =>
      _$LiveMasterLevelFromJson(json);
}

