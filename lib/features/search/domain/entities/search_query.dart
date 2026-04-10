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

class SearchQuery {
  const SearchQuery({
    required this.keyword,
    this.type = SearchType.all,
    this.order = SearchOrder.totalrank,
    this.duration = SearchDuration.all,
    this.page = 1,
  });

  final String keyword;
  final SearchType type;
  final SearchOrder order;
  final SearchDuration duration;
  final int page;

  SearchQuery copyWith({
    String? keyword,
    SearchType? type,
    SearchOrder? order,
    SearchDuration? duration,
    int? page,
  }) {
    return SearchQuery(
      keyword: keyword ?? this.keyword,
      type: type ?? this.type,
      order: order ?? this.order,
      duration: duration ?? this.duration,
      page: page ?? this.page,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SearchQuery &&
        other.keyword == keyword &&
        other.type == type &&
        other.order == order &&
        other.duration == duration &&
        other.page == page;
  }

  @override
  int get hashCode => Object.hash(keyword, type, order, duration, page);
}
