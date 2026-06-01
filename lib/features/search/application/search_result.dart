import 'dart:collection';

sealed class SearchResultEntry {
  const SearchResultEntry();
}

class SearchVideoEntry extends SearchResultEntry {
  final String bvid;
  final String title;
  final String author;
  final String coverUrl;
  final String durationText;
  final String typeName;
  final dynamic playCount;
  final dynamic viewCount;
  final int? videoReviewCount;
  final int? danmakuCount;

  const SearchVideoEntry({
    required this.bvid,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.durationText,
    required this.typeName,
    required this.playCount,
    required this.viewCount,
    required this.videoReviewCount,
    required this.danmakuCount,
  });
}

class SearchUserEntry extends SearchResultEntry {
  final int mid;
  final String name;
  final String avatarUrl;
  final String? sign;
  final int? fans;
  final int? videos;

  const SearchUserEntry({
    required this.mid,
    required this.name,
    required this.avatarUrl,
    required this.sign,
    required this.fans,
    required this.videos,
  });
}

class SearchBangumiEntry extends SearchResultEntry {
  final String title;
  final String coverUrl;
  final String seasonTypeName;
  final String areas;
  final String styles;
  final String? label;

  const SearchBangumiEntry({
    required this.title,
    required this.coverUrl,
    required this.seasonTypeName,
    required this.areas,
    required this.styles,
    required this.label,
  });
}

class SearchArticleEntry extends SearchResultEntry {
  final String title;
  final List<String> imageUrls;
  final String author;
  final dynamic viewCount;
  final int? reviewCount;

  const SearchArticleEntry({
    required this.title,
    required this.imageUrls,
    required this.author,
    required this.viewCount,
    required this.reviewCount,
  });
}

class SearchTopicEntry extends SearchResultEntry {
  final int topicId;
  final String title;
  final String? description;
  final String? coverUrl;
  final int? updateCount;

  const SearchTopicEntry({
    required this.topicId,
    required this.title,
    required this.description,
    required this.coverUrl,
    required this.updateCount,
  });
}

final class SearchResultPage {
  SearchResultPage({
    required this.page,
    required this.numPages,
    required List<SearchResultEntry> items,
  }) : _items = List<SearchResultEntry>.unmodifiable(items);

  final int page;
  final int numPages;
  final List<SearchResultEntry> _items;

  List<SearchResultEntry> get items => UnmodifiableListView(_items);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other.runtimeType == runtimeType &&
            other is SearchResultPage &&
            other.page == page &&
            other.numPages == numPages &&
            _items.length == other._items.length &&
            _items.asMap().entries.every(
              (entry) => entry.value == other._items[entry.key],
            );
  }

  @override
  int get hashCode => Object.hash(page, numPages, Object.hashAll(_items));

  @override
  String toString() =>
      'SearchResultPage(page: $page, numPages: $numPages, items: $items)';
}
