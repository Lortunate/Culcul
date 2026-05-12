import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_query_contract.freezed.dart';

enum SearchType {
  all('all'),
  video('video'),
  mediaBangumi('media_bangumi'),
  biliUser('bili_user'),
  article('article'),
  topic('topic');

  const SearchType(this.apiValue);

  final String apiValue;

  bool get supportsDuration => this == SearchType.video;
}

enum SearchOrder {
  totalrank('totalrank'),
  pubdate('pubdate'),
  click('click'),
  dm('dm'),
  stow('stow');

  const SearchOrder(this.apiValue);

  final String apiValue;
}

enum SearchDuration {
  all(0),
  short(1),
  medium(2),
  long(3),
  extraLong(4);

  const SearchDuration(this.apiValue);

  final int apiValue;
}

@freezed
sealed class SearchQuery with _$SearchQuery {
  const factory SearchQuery({
    required String keyword,
    @Default(SearchType.all) SearchType type,
    @Default(SearchOrder.totalrank) SearchOrder order,
    @Default(SearchDuration.all) SearchDuration duration,
    @Default(1) int page,
  }) = _SearchQuery;
}
