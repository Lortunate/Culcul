import 'package:culcul/features/favorites/presentation/pages/favorite_detail_page.dart';
import 'package:culcul/features/favorites/presentation/pages/favorites_page.dart';
import 'package:flutter/widgets.dart';

Widget buildFavoritesRoutePage() => const FavoritesPage();

Widget buildFavoriteDetailRoutePage({
  required int mediaId,
  required String title,
  required int mid,
}) {
  return FavoriteDetailPage(mediaId: mediaId, title: title, mid: mid);
}

