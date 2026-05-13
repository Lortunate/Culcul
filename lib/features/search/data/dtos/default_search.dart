import 'package:freezed_annotation/freezed_annotation.dart';

part 'default_search.freezed.dart';
part 'default_search.g.dart';

@freezed
sealed class DefaultSearchDto with _$DefaultSearchDto {
  const factory DefaultSearchDto({
    @JsonKey(name: 'show_name') required String showName,
    required String name,
    required int type,
    @JsonKey(name: 'search_type') required String searchType,
    @JsonKey(name: 'id') required int id,
  }) = _DefaultSearchDto;

  factory DefaultSearchDto.fromJson(Map<String, dynamic> json) =>
      _$DefaultSearchDtoFromJson(json);
}

@freezed
sealed class DefaultSearchData with _$DefaultSearchData {
  const factory DefaultSearchData({
    @JsonKey(name: 'show_name') required String showName,
    required String name,
    @JsonKey(name: 'id') required int id,
    @Default('') String url,
    @Default('') String seid,
    @Default(0) int type,
    @JsonKey(name: 'goto_type') @Default(0) int gotoType,
    @JsonKey(name: 'goto_value') @Default('') String gotoValue,
  }) = _DefaultSearchData;

  factory DefaultSearchData.fromJson(Map<String, dynamic> json) =>
      _$DefaultSearchDataFromJson(json);
}
