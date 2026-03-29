import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_model.freezed.dart';
part 'history_model.g.dart';

@freezed
sealed class HistoryResponseData with _$HistoryResponseData {
  const factory HistoryResponseData({
    required HistoryCursor cursor,
    required List<HistoryTab> tab,
    required List<HistoryItem> list,
  }) = _HistoryResponseData;

  factory HistoryResponseData.fromJson(Map<String, dynamic> json) =>
      _$HistoryResponseDataFromJson(json);
}

@freezed
sealed class HistoryCursor with _$HistoryCursor {
  const factory HistoryCursor({
    required int max,
    @JsonKey(name: 'view_at') required int viewAt,
    required String business,
    required int ps,
  }) = _HistoryCursor;

  factory HistoryCursor.fromJson(Map<String, dynamic> json) =>
      _$HistoryCursorFromJson(json);
}

@freezed
sealed class HistoryTab with _$HistoryTab {
  const factory HistoryTab({required String type, required String name}) = _HistoryTab;

  factory HistoryTab.fromJson(Map<String, dynamic> json) => _$HistoryTabFromJson(json);
}

@freezed
sealed class HistoryItem with _$HistoryItem {
  const factory HistoryItem({
    required String title,
    @JsonKey(name: 'long_title') required String longTitle,
    required String cover,
    List<String>? covers,
    required String uri,
    required HistoryDetail history,
    required int videos,
    @JsonKey(name: 'author_name') required String authorName,
    @JsonKey(name: 'author_face') required String authorFace,
    @JsonKey(name: 'author_mid') required int authorMid,
    @JsonKey(name: 'view_at') required int viewAt,
    required int progress,
    required String badge,
    @JsonKey(name: 'show_title') required String showTitle,
    required int duration,
    required String current,
    required int total,
    @JsonKey(name: 'new_desc') required String newDesc,
    @JsonKey(name: 'is_finish') required int isFinish,
    @JsonKey(name: 'is_fav') required int isFav,
    required int kid,
    @JsonKey(name: 'tag_name') required String tagName,
    @JsonKey(name: 'live_status') required int liveStatus,
  }) = _HistoryItem;

  factory HistoryItem.fromJson(Map<String, dynamic> json) => _$HistoryItemFromJson(json);
}

@freezed
sealed class HistoryDetail with _$HistoryDetail {
  const factory HistoryDetail({
    required int oid,
    required int epid,
    required String bvid,
    required int page,
    required int cid,
    required String part,
    required String business,
    required int dt,
  }) = _HistoryDetail;

  factory HistoryDetail.fromJson(Map<String, dynamic> json) =>
      _$HistoryDetailFromJson(json);
}
