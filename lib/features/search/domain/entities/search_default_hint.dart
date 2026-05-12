import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_default_hint.freezed.dart';

@freezed
sealed class SearchDefaultHint with _$SearchDefaultHint {
  const factory SearchDefaultHint({required String text}) = _SearchDefaultHint;
}
