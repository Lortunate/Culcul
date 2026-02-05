class Video {
  final String id;
  final String title;
  final String? description;
  final String? thumbnailUrl;
  final String videoUrl;
  final String userId;
  final String username;
  final String? avatarUrl;
  final int duration;
  final int viewsCount;
  final int likesCount;
  final int commentsCount;
  final int sharesCount;
  final bool isLiked;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Video({
    required this.id,
    required this.title,
    this.description,
    this.thumbnailUrl,
    required this.videoUrl,
    required this.userId,
    required this.username,
    this.avatarUrl,
    required this.duration,
    required this.viewsCount,
    required this.likesCount,
    required this.commentsCount,
    required this.sharesCount,
    required this.isLiked,
    required this.tags,
    required this.createdAt,
    this.updatedAt,
  });

  Video copyWith({
    String? id,
    String? title,
    String? description,
    String? thumbnailUrl,
    String? videoUrl,
    String? userId,
    String? username,
    String? avatarUrl,
    int? duration,
    int? viewsCount,
    int? likesCount,
    int? commentsCount,
    int? sharesCount,
    bool? isLiked,
    List<String>? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Video(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      videoUrl: videoUrl ?? this.videoUrl,
      userId: userId ?? this.userId,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      duration: duration ?? this.duration,
      viewsCount: viewsCount ?? this.viewsCount,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      sharesCount: sharesCount ?? this.sharesCount,
      isLiked: isLiked ?? this.isLiked,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Video &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          description == other.description &&
          thumbnailUrl == other.thumbnailUrl &&
          videoUrl == other.videoUrl &&
          userId == other.userId &&
          username == other.username &&
          avatarUrl == other.avatarUrl &&
          duration == other.duration &&
          viewsCount == other.viewsCount &&
          likesCount == other.likesCount &&
          commentsCount == other.commentsCount &&
          sharesCount == other.sharesCount &&
          isLiked == other.isLiked &&
          tags == other.tags &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      thumbnailUrl.hashCode ^
      videoUrl.hashCode ^
      userId.hashCode ^
      username.hashCode ^
      avatarUrl.hashCode ^
      duration.hashCode ^
      viewsCount.hashCode ^
      likesCount.hashCode ^
      commentsCount.hashCode ^
      sharesCount.hashCode ^
      isLiked.hashCode ^
      tags.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}
