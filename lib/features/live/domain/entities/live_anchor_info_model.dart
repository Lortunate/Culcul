import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_anchor_info_model.freezed.dart';

@freezed
sealed class LiveAnchorInfoModel with _$LiveAnchorInfoModel {
  const factory LiveAnchorInfoModel({
    required LiveAnchorInfo info,
    required LiveAnchorExp exp,
    required int followerNum,
    required int roomId,
    required String medalName,
    required int gloryCount,
    required String pendant,
  }) = _LiveAnchorInfoModel;
}

@freezed
sealed class LiveAnchorInfo with _$LiveAnchorInfo {
  const factory LiveAnchorInfo({
    required int uid,
    required String uname,
    required String face,
    required LiveAnchorVerify officialVerify,
    required int gender,
  }) = _LiveAnchorInfo;
}

@freezed
sealed class LiveAnchorVerify with _$LiveAnchorVerify {
  const factory LiveAnchorVerify({required int type, required String desc}) =
      _LiveAnchorVerify;
}

@freezed
sealed class LiveAnchorExp with _$LiveAnchorExp {
  const factory LiveAnchorExp({required LiveMasterLevel masterLevel}) = _LiveAnchorExp;
}

@freezed
sealed class LiveMasterLevel with _$LiveMasterLevel {
  const factory LiveMasterLevel({
    required int level,
    required int color,
    required List<int> current,
    required List<int> next,
  }) = _LiveMasterLevel;
}
