enum SearchType {
  all('all'),
  video('video'),
  mediaBangumi('media_bangumi'),
  biliUser('bili_user'),
  article('article'),
  topic('topic');

  const SearchType(this.apiValue);

  final String apiValue;
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

final class SearchQuery {
  const SearchQuery({
    required this.keyword,
    required this.type,
    this.order = SearchOrder.totalrank,
    this.duration = SearchDuration.all,
    this.page = 1,
  });

  final String keyword;
  final SearchType type;
  final SearchOrder order;
  final SearchDuration duration;
  final int page;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other.runtimeType == runtimeType &&
            other is SearchQuery &&
            other.keyword == keyword &&
            other.type == type &&
            other.order == order &&
            other.duration == duration &&
            other.page == page;
  }

  @override
  int get hashCode => Object.hash(runtimeType, keyword, type, order, duration, page);

  @override
  String toString() {
    return 'SearchQuery(keyword: $keyword, type: $type, order: $order, '
        'duration: $duration, page: $page)';
  }
}
