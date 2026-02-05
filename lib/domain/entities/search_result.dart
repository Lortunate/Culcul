class SearchResult {
  final String id;
  final String title;
  final String? description;
  final String type;
  final String? imageUrl;
  final String? userId;
  final String? username;
  final DateTime createdAt;

  SearchResult({
    required this.id,
    required this.title,
    this.description,
    required this.type,
    this.imageUrl,
    this.userId,
    this.username,
    required this.createdAt,
  });

  SearchResult copyWith({
    String? id,
    String? title,
    String? description,
    String? type,
    String? imageUrl,
    String? userId,
    String? username,
    DateTime? createdAt,
  }) {
    return SearchResult(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      imageUrl: imageUrl ?? this.imageUrl,
      userId: userId ?? this.userId,
      username: username ?? this.username,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchResult &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          description == other.description &&
          type == other.type &&
          imageUrl == other.imageUrl &&
          userId == other.userId &&
          username == other.username &&
          createdAt == other.createdAt;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      type.hashCode ^
      imageUrl.hashCode ^
      userId.hashCode ^
      username.hashCode ^
      createdAt.hashCode;
}
