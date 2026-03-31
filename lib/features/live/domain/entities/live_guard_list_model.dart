import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_guard_list_model.freezed.dart';

@freezed
sealed class LiveGuardListModel with _$LiveGuardListModel {
  const factory LiveGuardListModel({
    required LiveGuardInfo info,
    @Default([]) List<LiveGuardItem> top3,
    @Default([]) List<LiveGuardItem> list,
  }) = _LiveGuardListModel;
}

@freezed
sealed class LiveGuardInfo with _$LiveGuardInfo {
  const factory LiveGuardInfo({required int num, required int page, required int now}) =
      _LiveGuardInfo;
}

@freezed
sealed class LiveGuardItem with _$LiveGuardItem {
  const factory LiveGuardItem({
    required int ruid,
    required int rank,
    required LiveGuardUserInfo userInfo,
    required int guardLevel,
  }) = _LiveGuardItem;
}

@freezed
sealed class LiveGuardUserInfo with _$LiveGuardUserInfo {
  const factory LiveGuardUserInfo({required int uid, required LiveGuardUserBase base}) =
      _LiveGuardUserInfo;
}

@freezed
sealed class LiveGuardUserBase with _$LiveGuardUserBase {
  const factory LiveGuardUserBase({required String name, required String face}) =
      _LiveGuardUserBase;
}
