import 'package:culcul/features/favorites/models/favorite_models.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_folder.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_resource.dart';

extension FavUpperMapper on FavUpperModel {
  FavoriteOwner toDomain() {
    return FavoriteOwner(mid: mid, name: name, face: face);
  }
}

extension FavFolderMapper on FavFolderModel {
  FavoriteFolder toDomain() {
    return FavoriteFolder(
      id: id,
      fid: fid,
      mid: mid,
      attr: attr,
      title: title,
      favState: favState,
      mediaCount: mediaCount,
      cover: cover,
      upper: upper?.toDomain(),
      intro: intro,
      ctime: ctime,
      mtime: mtime,
      state: state,
    );
  }
}

extension FavFolderListMapper on FavFolderListResponse {
  FavoriteFolderPage toDomain() {
    return FavoriteFolderPage(
      count: count,
      folders: (list ?? const []).map((item) => item.toDomain()).toList(),
    );
  }
}

extension FavCntInfoMapper on FavCntInfoModel {
  FavoriteResourceStats toDomain() {
    return FavoriteResourceStats(collect: collect, play: play, danmaku: danmaku);
  }
}

extension FavFolderInfoMapper on FavFolderInfoModel {
  FavoriteFolderInfo toDomain() {
    return FavoriteFolderInfo(
      id: id,
      fid: fid,
      mid: mid,
      attr: attr,
      title: title,
      cover: cover,
      upper: upper.toDomain(),
      mediaCount: mediaCount,
    );
  }
}

extension FavResourceMapper on FavResourceModel {
  FavoriteResource toDomain() {
    return FavoriteResource(
      id: id,
      type: type,
      title: title,
      cover: cover,
      intro: intro,
      page: page,
      duration: duration,
      upper: upper.toDomain(),
      attr: attr,
      stats: cntInfo.toDomain(),
      link: link,
      ctime: ctime,
      pubtime: pubtime,
      favTime: favTime,
      bvId: bvId,
      bvid: bvid,
    );
  }
}

extension FavResourceListMapper on FavResourceListResponse {
  FavoriteResourcePage toDomain() {
    return FavoriteResourcePage(
      info: info.toDomain(),
      medias: (medias ?? const []).map((item) => item.toDomain()).toList(),
      hasMore: hasMore,
    );
  }
}
