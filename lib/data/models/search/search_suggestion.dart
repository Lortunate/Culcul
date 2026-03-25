import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_suggestion.freezed.dart';
part 'search_suggestion.g.dart';

@freezed
sealed class SearchSuggestionResponse with _$SearchSuggestionResponse {
  const factory SearchSuggestionResponse({
    int? code,
    @JsonKey(name: 'exp_str') String? expStr,
    @SearchSuggestionResultConverter() SearchSuggestionResult? result,
  }) = _SearchSuggestionResponse;

  factory SearchSuggestionResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchSuggestionResponseFromJson(json);
}

@freezed
sealed class SearchSuggestionResult with _$SearchSuggestionResult {
  const factory SearchSuggestionResult({
    @JsonKey(name: 'tag') List<SearchSuggestionTag>? tags,
  }) = _SearchSuggestionResult;

  factory SearchSuggestionResult.fromJson(Map<String, dynamic> json) =>
      _$SearchSuggestionResultFromJson(json);
}

@freezed
sealed class SearchSuggestionTag with _$SearchSuggestionTag {
  const factory SearchSuggestionTag({
    String? value,
    String? term,
    @JsonKey(name: 'ref') dynamic ref,
    String? name,
    @JsonKey(name: 'spid') dynamic spid,
    String? type,
  }) = _SearchSuggestionTag;

  factory SearchSuggestionTag.fromJson(Map<String, dynamic> json) =>
      _$SearchSuggestionTagFromJson(json);
}

class SearchSuggestionResultConverter
    implements JsonConverter<SearchSuggestionResult?, dynamic> {
  const SearchSuggestionResultConverter();

  @override
  SearchSuggestionResult? fromJson(dynamic json) {
    if (json == null || json is! Map<String, dynamic>) {
      return null;
    }
    return SearchSuggestionResult.fromJson(json);
  }

  @override
  dynamic toJson(SearchSuggestionResult? object) => object?.toJson();
}

