import 'package:culcul/features/favorites/domain/entities/favorite_folder.dart';

class FavoriteResourceStats {
  final int collect;
  final int play;
  final int danmaku;

  const FavoriteResourceStats({
    required this.collect,
    required this.play,
    required this.danmaku,
  });
}

class FavoriteResource {
  final int id;
  final int type;
  final String title;
  final String cover;
  final String intro;
  final int page;
  final int duration;
  final FavoriteOwner upper;
  final int attr;
  final FavoriteResourceStats stats;
  final String link;
  final int ctime;
  final int pubtime;
  final int favTime;
  final String? bvId;
  final String? bvid;

  const FavoriteResource({
    required this.id,
    required this.type,
    required this.title,
    required this.cover,
    required this.intro,
    required this.page,
    required this.duration,
    required this.upper,
    required this.attr,
    required this.stats,
    required this.link,
    required this.ctime,
    required this.pubtime,
    required this.favTime,
    required this.bvId,
    required this.bvid,
  });

  String? get preferredBvid => bvid ?? bvId;
}

class FavoriteFolderInfo {
  final int id;
  final int fid;
  final int mid;
  final int attr;
  final String title;
  final String cover;
  final FavoriteOwner upper;
  final int mediaCount;

  const FavoriteFolderInfo({
    required this.id,
    required this.fid,
    required this.mid,
    required this.attr,
    required this.title,
    required this.cover,
    required this.upper,
    required this.mediaCount,
  });
}

class FavoriteResourcePage {
  final FavoriteFolderInfo info;
  final List<FavoriteResource> medias;
  final bool hasMore;

  const FavoriteResourcePage({
    required this.info,
    required this.medias,
    required this.hasMore,
  });
}
