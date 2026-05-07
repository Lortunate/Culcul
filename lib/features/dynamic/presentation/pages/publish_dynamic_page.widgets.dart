part of 'publish_dynamic_page.dart';

class _PublishDynamicScaffold extends StatelessWidget {
  final ThemeData theme;
  final ColorScheme colorScheme;
  final Translations t;
  final bool isPublishing;
  final ValueNotifier<bool> hasDraftNotifier;
  final Future<void> Function() onClose;
  final Future<void> Function() onPublish;
  final TextEditingController controller;
  final FocusNode focusNode;
  final List<File> images;
  final int maxImages;
  final VoidCallback onEditorChanged;
  final Future<void> Function() onPickImage;
  final ValueChanged<int> onRemoveImageAt;
  final VoidCallback onInsertMention;
  final VoidCallback onPickTopic;
  final VoidCallback onPickEmoji;

  const _PublishDynamicScaffold({
    required this.theme,
    required this.colorScheme,
    required this.t,
    required this.isPublishing,
    required this.hasDraftNotifier,
    required this.onClose,
    required this.onPublish,
    required this.controller,
    required this.focusNode,
    required this.images,
    required this.maxImages,
    required this.onEditorChanged,
    required this.onPickImage,
    required this.onRemoveImageAt,
    required this.onInsertMention,
    required this.onPickTopic,
    required this.onPickEmoji,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: _PublishDynamicAppBar(
        theme: theme,
        colorScheme: colorScheme,
        t: t,
        isPublishing: isPublishing,
        hasDraftNotifier: hasDraftNotifier,
        onClose: onClose,
        onPublish: onPublish,
      ),
      body: Column(
        children: [
          Expanded(
            child: _PublishDynamicEditor(
              theme: theme,
              t: t,
              controller: controller,
              focusNode: focusNode,
              images: images,
              maxImages: maxImages,
              onEditorChanged: onEditorChanged,
              onPickImage: onPickImage,
              onRemoveImageAt: onRemoveImageAt,
            ),
          ),
          PublishDynamicBottomToolbar(
            charCount: controller.text.length,
            onPickImage: onPickImage,
            onInsertMention: onInsertMention,
            onPickTopic: onPickTopic,
            onPickEmoji: onPickEmoji,
          ),
        ],
      ),
    );
  }
}

class _PublishDynamicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ThemeData theme;
  final ColorScheme colorScheme;
  final Translations t;
  final bool isPublishing;
  final ValueNotifier<bool> hasDraftNotifier;
  final Future<void> Function() onClose;
  final Future<void> Function() onPublish;

  const _PublishDynamicAppBar({
    required this.theme,
    required this.colorScheme,
    required this.t,
    required this.isPublishing,
    required this.hasDraftNotifier,
    required this.onClose,
    required this.onPublish,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      scrolledUnderElevation: 0,
      leading: IconButton(icon: const Icon(Icons.close), onPressed: onClose),
      title: Text(
        t.moments.publish_title,
        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: ValueListenableBuilder<bool>(
            valueListenable: hasDraftNotifier,
            builder: (context, isPostable, _) {
              final enabled = !isPublishing && isPostable;
              return TextButton(
                onPressed: enabled ? onPublish : null,
                style: TextButton.styleFrom(
                  backgroundColor: enabled
                      ? colorScheme.primary
                      : colorScheme.surfaceContainerHighest,
                  foregroundColor: enabled
                      ? colorScheme.onPrimary
                      : colorScheme.onSurfaceVariant,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: isPublishing
                    ? SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      )
                    : Text(
                        t.moments.publish_action,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
