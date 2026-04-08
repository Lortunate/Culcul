part of 'publish_dynamic_page.dart';

void showPublishDynamicEmojiPicker({
  required BuildContext context,
  required ValueChanged<String> onEmojiSelected,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: EmojiPicker(
          onEmojiSelected: (text) {
            onEmojiSelected(text);
            Navigator.pop(context);
          },
        ),
      );
    },
  );
}

void showPublishDynamicTopicPicker({
  required BuildContext context,
  required ValueChanged<String> onTopicSelected,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return TopicPicker(
        onTopicSelected: (topic) {
          onTopicSelected(topic);
          Navigator.pop(context);
        },
      );
    },
  );
}

Future<bool> confirmDiscardDynamicDraft({
  required BuildContext context,
  required bool hasDraft,
}) async {
  if (!hasDraft) return true;
  final t = Translations.of(context);
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(t.moments.discard_title),
      content: Text(t.moments.discard_confirm),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(t.common.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(t.moments.discard_action),
        ),
      ],
    ),
  );
  return result == true;
}
