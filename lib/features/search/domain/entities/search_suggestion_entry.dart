import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_suggestion_entry.freezed.dart';

@freezed
sealed class SearchSuggestionEntry with _$SearchSuggestionEntry {
  const factory SearchSuggestionEntry({required String value}) = _SearchSuggestionEntry;
}
