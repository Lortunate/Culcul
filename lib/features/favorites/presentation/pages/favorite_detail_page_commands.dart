import 'package:culcul/features/favorites/presentation/widgets/fav_folder_dialog.dart';

class FavoriteDetailPageCommands {
  const FavoriteDetailPageCommands({
    required this.presentEditDialog,
    required this.presentDeleteConfirmation,
    required this.editFolder,
    required this.deleteFolder,
    required this.deleteResources,
    required this.invalidateCreatedFolders,
    required this.exitPage,
    required this.showError,
  });

  final Future<FavFolderFormData?> Function() presentEditDialog;
  final Future<bool> Function() presentDeleteConfirmation;
  final Future<String?> Function(FavFolderFormData data) editFolder;
  final Future<String?> Function() deleteFolder;
  final Future<String?> Function(Set<int> resourceIds) deleteResources;
  final void Function() invalidateCreatedFolders;
  final void Function() exitPage;
  final void Function(String message) showError;

  Future<bool> handleEditFolder() async {
    final result = await presentEditDialog();
    if (result == null) {
      return false;
    }

    final error = await editFolder(result);
    if (error == null) {
      invalidateCreatedFolders();
      return true;
    }

    showError(error);
    return false;
  }

  Future<bool> handleDeleteFolder() async {
    final confirmed = await presentDeleteConfirmation();
    if (!confirmed) {
      return false;
    }

    final error = await deleteFolder();
    if (error == null) {
      invalidateCreatedFolders();
      exitPage();
      return true;
    }

    showError(error);
    return false;
  }

  Future<bool> handleDeleteResources(Set<int> resourceIds) async {
    final error = await deleteResources(resourceIds);
    if (error == null) {
      return true;
    }

    showError(error);
    return false;
  }
}
