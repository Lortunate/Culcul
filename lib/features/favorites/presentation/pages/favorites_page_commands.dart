import 'package:culcul/features/favorites/presentation/widgets/fav_folder_dialog.dart';

class FavoritesPageCommands {
  const FavoritesPageCommands({
    required this.presentCreateDialog,
    required this.createFolder,
    required this.invalidateCreatedFolders,
    required this.showError,
  });

  final Future<FavFolderFormData?> Function() presentCreateDialog;
  final Future<String?> Function(FavFolderFormData data) createFolder;
  final void Function() invalidateCreatedFolders;
  final void Function(String message) showError;

  Future<bool> handleCreateFolder() async {
    final result = await presentCreateDialog();
    if (result == null) {
      return false;
    }

    final error = await createFolder(result);
    if (error == null) {
      invalidateCreatedFolders();
      return true;
    }

    showError(error);
    return false;
  }
}
