import 'package:culcul/features/video/domain/entities/video_models.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CommentReplySheet extends HookWidget {
  final CommentItem comment;
  final void Function(String text) onSend;

  const CommentReplySheet({super.key, required this.comment, required this.onSend});

  static void show(
    BuildContext context, {
    required CommentItem comment,
    required void Function(String text) onSend,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: CommentReplySheet(comment: comment, onSend: onSend),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = useTextEditingController();
    final t = Translations.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                t.video.reply_to(name: comment.member.uname),
                style: theme.textTheme.titleMedium,
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  final text = controller.text.trim();
                  if (text.isNotEmpty) {
                    onSend(text);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
          TextField(
            controller: controller,
            autofocus: true,
            minLines: 1,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: t.video.comment.hint,
              border: InputBorder.none,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
