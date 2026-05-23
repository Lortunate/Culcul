import 'package:culcul/features/favorites/domain/entities/favorite_folder.dart';
import 'package:culcul/features/favorites/presentation/pages/favorite_detail_page.dart';
import 'package:culcul/features/favorites/presentation/pages/favorites_page.dart';
import 'package:culcul/features/favorites/presentation/view_models/favorites_view_model.dart';
import 'package:culcul/features/favorites/presentation/widgets/video_favorite_picker_sheet.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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

Future<bool?> showVideoFavoritePicker({
  required BuildContext context,
  required int aid,
  required VoidCallback onLogin,
}) {
  final container = ProviderScope.containerOf(context, listen: false);
  if (!container.read(videoFavoriteUserLoggedInProvider)) {
    onLogin();
    return Future<bool?>.value();
  }

  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => VideoFavoritePickerSheet(aid: aid),
  );
}
