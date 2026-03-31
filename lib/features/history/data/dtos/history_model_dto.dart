import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_model_dto.freezed.dart';
part 'history_model_dto.g.dart';

@freezed
sealed class HistoryResponseDataDto with _$HistoryResponseDataDto {
  const factory HistoryResponseDataDto({
    required HistoryCursorDto cursor,
    required List<HistoryTabDto> tab,
    required List<HistoryItemDto> list,
  }) = _HistoryResponseDataDto;

  factory HistoryResponseDataDto.fromJson(Map<String, dynamic> json) =>
      _$HistoryResponseDataDtoFromJson(json);
}

@freezed
sealed class HistoryCursorDto with _$HistoryCursorDto {
  const factory HistoryCursorDto({
    required int max,
    @JsonKey(name: 'view_at') required int viewAt,
    required String business,
    required int ps,
  }) = _HistoryCursorDto;

  factory HistoryCursorDto.fromJson(Map<String, dynamic> json) =>
      _$HistoryCursorDtoFromJson(json);
}

@freezed
sealed class HistoryTabDto with _$HistoryTabDto {
  const factory HistoryTabDto({required String type, required String name}) =
      _HistoryTabDto;

  factory HistoryTabDto.fromJson(Map<String, dynamic> json) =>
      _$HistoryTabDtoFromJson(json);
}

@freezed
sealed class HistoryItemDto with _$HistoryItemDto {
  const factory HistoryItemDto({
    required String title,
    @JsonKey(name: 'long_title') required String longTitle,
    required String cover,
    List<String>? covers,
    required String uri,
    required HistoryDetailDto history,
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
  }) = _HistoryItemDto;

  factory HistoryItemDto.fromJson(Map<String, dynamic> json) =>
      _$HistoryItemDtoFromJson(json);
}

@freezed
sealed class HistoryDetailDto with _$HistoryDetailDto {
  const factory HistoryDetailDto({
    required int oid,
    required int epid,
    required String bvid,
    required int page,
    required int cid,
    required String part,
    required String business,
    required int dt,
  }) = _HistoryDetailDto;

  factory HistoryDetailDto.fromJson(Map<String, dynamic> json) =>
      _$HistoryDetailDtoFromJson(json);
}
