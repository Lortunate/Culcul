import 'package:freezed_annotation/freezed_annotation.dart';

part 'default_search.freezed.dart';
part 'default_search.g.dart';

@freezed
abstract class DefaultSearch with _$DefaultSearch {
  const factory DefaultSearch({
    @JsonKey(name: 'show_name') required String showName,
    required String name,
    required int type,
    @JsonKey(name: 'search_type') required String searchType,
    @JsonKey(name: 'id') required int id,
  }) = _DefaultSearch;

  factory DefaultSearch.fromJson(Map<String, dynamic> json) =>
      _$DefaultSearchFromJson(json);
}

@freezed
abstract class DefaultSearchData with _$DefaultSearchData {
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
