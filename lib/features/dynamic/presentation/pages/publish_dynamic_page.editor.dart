part of 'publish_dynamic_page.dart';

class _PublishDynamicEditor extends StatelessWidget {
  const _PublishDynamicEditor({
    required this.theme,
    required this.t,
    required this.controller,
    required this.focusNode,
    required this.images,
    required this.maxImages,
    required this.onEditorChanged,
    required this.onPickImage,
    required this.onRemoveImageAt,
  });

  final ThemeData theme;
  final Translations t;
  final TextEditingController controller;
  final FocusNode focusNode;
  final List<File> images;
  final int maxImages;
  final VoidCallback onEditorChanged;
  final Future<void> Function() onPickImage;
  final ValueChanged<int> onRemoveImageAt;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        TextField(
          controller: controller,
          focusNode: focusNode,
          maxLines: null,
          minLines: 5,
          style: theme.textTheme.bodyLarge?.copyWith(fontSize: 16),
          decoration: InputDecoration(
            hintText: t.moments.publish_hint,
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.zero,
          ),
          onChanged: (_) => onEditorChanged(),
        ),
        const SizedBox(height: 12),
        PublishDynamicImageGrid(
          images: images,
          maxImages: maxImages,
          onAddTap: onPickImage,
          onRemoveAt: onRemoveImageAt,
        ),
      ],
    );
  }
}
