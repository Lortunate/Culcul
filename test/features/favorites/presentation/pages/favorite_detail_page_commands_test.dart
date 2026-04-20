import 'package:culcul/features/favorites/presentation/pages/favorite_detail_page_commands.dart';
import 'package:culcul/features/favorites/presentation/widgets/fav_folder_dialog.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FavoriteDetailPageCommands', () {
    test('handleEditFolder invalidates after successful edit', () async {
      var invalidated = 0;
      final commands = FavoriteDetailPageCommands(
        presentEditDialog: () async =>
            const FavFolderFormData(title: 't', intro: 'i', privacy: 1),
        presentDeleteConfirmation: () async => false,
        editFolder: (_) async => null,
        deleteFolder: () async => null,
        deleteResources: (_) async => null,
        invalidateCreatedFolders: () {
          invalidated++;
        },
        exitPage: () {},
        showError: (_) {},
      );

      final result = await commands.handleEditFolder();

      expect(result, isTrue);
      expect(invalidated, 1);
    });

    test('handleDeleteFolder exits page after successful deletion', () async {
      var invalidated = 0;
      var exitCount = 0;
      final commands = FavoriteDetailPageCommands(
        presentEditDialog: () async => null,
        presentDeleteConfirmation: () async => true,
        editFolder: (_) async => null,
        deleteFolder: () async => null,
        deleteResources: (_) async => null,
        invalidateCreatedFolders: () {
          invalidated++;
        },
        exitPage: () {
          exitCount++;
        },
        showError: (_) {},
      );

      final result = await commands.handleDeleteFolder();

      expect(result, isTrue);
      expect(invalidated, 1);
      expect(exitCount, 1);
    });

    test('handleDeleteResources reports error and returns false on failure', () async {
      final errors = <String>[];
      final commands = FavoriteDetailPageCommands(
        presentEditDialog: () async => null,
        presentDeleteConfirmation: () async => false,
        editFolder: (_) async => null,
        deleteFolder: () async => null,
        deleteResources: (_) async => 'boom',
        invalidateCreatedFolders: () {},
        exitPage: () {},
        showError: errors.add,
      );

      final result = await commands.handleDeleteResources({1, 2});

      expect(result, isFalse);
      expect(errors, ['boom']);
    });
  });
}
