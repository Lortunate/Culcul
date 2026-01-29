import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_suggestion.freezed.dart';
part 'search_suggestion.g.dart';

@freezed
abstract class SearchSuggestionResponse with _$SearchSuggestionResponse {
  const factory SearchSuggestionResponse({
    @JsonKey(name: 'result') SearchSuggestionResult? result,
  }) = _SearchSuggestionResponse;

  factory SearchSuggestionResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchSuggestionResponseFromJson(json);
}

@freezed
abstract class SearchSuggestionResult with _$SearchSuggestionResult {
  const factory SearchSuggestionResult({
    @JsonKey(name: 'tag') List<SearchSuggestionTag>? tags,
  }) = _SearchSuggestionResult;

  factory SearchSuggestionResult.fromJson(Map<String, dynamic> json) =>
      _$SearchSuggestionResultFromJson(json);
}

@freezed
abstract class SearchSuggestionTag with _$SearchSuggestionTag {
  const factory SearchSuggestionTag({
    required String value,
    required String term,
    @JsonKey(name: 'ref') int? ref,
    required String name,
    @JsonKey(name: 'spid') int? spid,
    String? type,
  }) = _SearchSuggestionTag;

  factory SearchSuggestionTag.fromJson(Map<String, dynamic> json) =>
      _$SearchSuggestionTagFromJson(json);
}
