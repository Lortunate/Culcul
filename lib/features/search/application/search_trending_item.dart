final class SearchTrendingItem {
  const SearchTrendingItem({
    required this.position,
    required this.keyword,
    required this.label,
  });

  factory SearchTrendingItem.fromJson(Map<String, dynamic> json) {
    return SearchTrendingItem(
      position: (json['position'] as num).toInt(),
      keyword: json['keyword'] as String,
      label: json['show_name'] as String,
    );
  }

  final int position;
  final String keyword;
  final String label;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other.runtimeType == runtimeType &&
            other is SearchTrendingItem &&
            other.position == position &&
            other.keyword == keyword &&
            other.label == label;
  }

  @override
  int get hashCode => Object.hash(runtimeType, position, keyword, label);

  @override
  String toString() {
    return 'SearchTrendingItem(position: $position, keyword: $keyword, '
        'label: $label)';
  }
}
