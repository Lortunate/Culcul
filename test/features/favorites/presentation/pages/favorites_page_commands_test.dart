import 'package:culcul/features/favorites/presentation/pages/favorites_page_commands.dart';
import 'package:culcul/features/favorites/presentation/widgets/fav_folder_dialog.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FavoritesPageCommands', () {
    test('handleCreateFolder invalidates on success', () async {
      var invalidated = 0;
      final commands = FavoritesPageCommands(
        presentCreateDialog: () async =>
            const FavFolderFormData(title: 't', intro: 'i', privacy: 1),
        createFolder: (_) async => null,
        invalidateCreatedFolders: () {
          invalidated++;
        },
        showError: (_) {},
      );

      final result = await commands.handleCreateFolder();

      expect(result, isTrue);
      expect(invalidated, 1);
    });

    test('handleCreateFolder reports error on failure', () async {
      final errors = <String>[];
      final commands = FavoritesPageCommands(
        presentCreateDialog: () async =>
            const FavFolderFormData(title: 't', intro: 'i', privacy: 1),
        createFolder: (_) async => 'boom',
        invalidateCreatedFolders: () {},
        showError: errors.add,
      );

      final result = await commands.handleCreateFolder();

      expect(result, isFalse);
      expect(errors, ['boom']);
    });
  });
}
