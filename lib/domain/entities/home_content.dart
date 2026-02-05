class HomeContent {
  final String id;
  final String title;
  final String? description;
  final String? imageUrl;
  final String contentType;
  final DateTime createdAt;

  HomeContent({
    required this.id,
    required this.title,
    this.description,
    this.imageUrl,
    required this.contentType,
    required this.createdAt,
  });

  HomeContent copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    String? contentType,
    DateTime? createdAt,
  }) {
    return HomeContent(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      contentType: contentType ?? this.contentType,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeContent &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          description == other.description &&
          imageUrl == other.imageUrl &&
          contentType == other.contentType &&
          createdAt == other.createdAt;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      imageUrl.hashCode ^
      contentType.hashCode ^
      createdAt.hashCode;
}
