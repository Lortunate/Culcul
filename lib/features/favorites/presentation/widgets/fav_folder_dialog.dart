import 'package:culcul/features/favorites/domain/entities/favorite_folder.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FavFolderDialog extends HookWidget {
  final FavoriteFolder? folder;

  const FavFolderDialog({super.key, this.folder});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final titleController = useTextEditingController(text: folder?.title);
    final introController = useTextEditingController(text: folder?.intro);
    // Privacy: 0 public, 1 private.
    // Since we don't know exactly how to map attr to privacy yet, default to false (public)
    // or try to infer if needed. For now default to false.
    final isPrivate = useState(folder?.isPrivate ?? false);

    // Try to infer privacy from attr if editing
    return AlertDialog(
      title: Text(folder == null ? t.favorites.new_folder : t.favorites.edit_folder),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: t.favorites.folder_title),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: introController,
            decoration: InputDecoration(labelText: t.favorites.folder_intro),
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            title: Text(t.favorites.only_visible_to_me),
            value: isPrivate.value,
            onChanged: (value) => isPrivate.value = value,
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text(t.common.cancel)),
        TextButton(
          onPressed: () {
            if (titleController.text.isEmpty) return;
            Navigator.pop(context, (
              title: titleController.text,
              intro: introController.text,
              privacy: isPrivate.value ? 1 : 0,
            ));
          },
          child: Text(t.common.confirm),
        ),
      ],
    );
  }
}
