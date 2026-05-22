import 'package:culcul/features/favorites/domain/entities/favorite_folder.dart';
import 'package:culcul/features/favorites/presentation/pages/favorite_detail_page.dart';
import 'package:culcul/features/favorites/presentation/pages/favorites_page.dart';
import 'package:flutter/widgets.dart';

Widget buildFavoritesRoutePage({
  required VoidCallback onLogin,
  required ValueChanged<FavoriteFolder> onOpenFolder,
}) {
  return FavoritesPage(onLogin: onLogin, onOpenFolder: onOpenFolder);
}

Widget buildFavoriteDetailRoutePage({
  required int mediaId,
  required String title,
  required int mid,
}) {
  return FavoriteDetailPage(mediaId: mediaId, title: title, mid: mid);
}
