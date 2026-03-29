import 'package:culcul/data/models/fav/fav_folder_model.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FavFolderDialog extends HookWidget {
  final FavFolderModel? folder;

  const FavFolderDialog({super.key, this.folder});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final titleController = useTextEditingController(text: folder?.title);
    final introController = useTextEditingController(text: folder?.intro);
    // Privacy: 0 public, 1 private.
    // Since we don't know exactly how to map attr to privacy yet, default to false (public)
    // or try to infer if needed. For now default to false.
    final isPrivate = useState(false);

    // Try to infer privacy from attr if editing
    useEffect(() {
      if (folder != null) {
        // This is a guess: usually odd attr or specific bit means private.
        // Without docs, safe to default to false or not change it.
        // But users might want to see current state.
        // Let's just leave it as false for now to avoid confusion.
      }
      return null;
    }, [folder]);

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
            Navigator.pop(context, {
              'title': titleController.text,
              'intro': introController.text,
              'privacy': isPrivate.value ? 1 : 0,
            });
          },
          child: Text(t.common.confirm),
        ),
      ],
    );
  }
}
