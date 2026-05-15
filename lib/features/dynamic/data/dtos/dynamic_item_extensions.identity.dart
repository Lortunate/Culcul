part of 'dynamic_item_extensions.dart';

extension DynamicItemIdentityExtension on DynamicItem {
  String get id => idStr;
  String? get majorType => modules.moduleDynamic.major?.type;
  bool get isArticleType =>
      type == 'DYNAMIC_TYPE_ARTICLE' || majorType == 'MAJOR_TYPE_ARTICLE';
  bool get preferLinkCardDisplay => switch (majorType) {
    'MAJOR_TYPE_ARTICLE' ||
    'MAJOR_TYPE_COMMON' ||
    'MAJOR_TYPE_PGC' ||
    'MAJOR_TYPE_COURSES' ||
    'MAJOR_TYPE_MUSIC' ||
    'MAJOR_TYPE_LIVE' => true,
    _ => isArticleType,
  };

  int get authorMid => modules.moduleAuthor.mid;
  String get authorName => modules.moduleAuthor.name;
  String get authorAvatar => modules.moduleAuthor.avatar;
  String get timeText => modules.moduleAuthor.pubTime;

  int get likeCount => modules.moduleStat?.like.count ?? 0;
  bool get isLiked => modules.moduleStat?.like.status ?? false;
  int get commentCount => modules.moduleStat?.comment.count ?? 0;
  int get forwardCount => modules.moduleStat?.forward.count ?? 0;

  DynamicItem copyWithLike(bool isLiked) {
    final newLikeCount = isLiked ? likeCount + 1 : likeCount - 1;
    final moduleStat = modules.moduleStat;
    if (moduleStat == null) return this;

    final newStatLike = moduleStat.like.copyWith(count: newLikeCount, status: isLiked);
    final newModuleStat = moduleStat.copyWith(like: newStatLike);
    final newModules = modules.copyWith(moduleStat: newModuleStat);
    return copyWith(modules: newModules);
  }
}
