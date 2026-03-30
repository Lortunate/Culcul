import 'dart:io';

import 'package:culcul/features/dynamic/presentation/view_model/publish_dynamic_view_model.dart';
import 'package:culcul/features/dynamic/presentation/widgets/emoji_picker.dart';
import 'package:culcul/features/dynamic/presentation/widgets/publish_dynamic_bottom_toolbar.dart';
import 'package:culcul/features/dynamic/presentation/widgets/publish_dynamic_image_grid.dart';
import 'package:culcul/features/dynamic/presentation/widgets/topic_picker.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class PublishDynamicPage extends ConsumerStatefulWidget {
  const PublishDynamicPage({super.key});

  @override
  ConsumerState<PublishDynamicPage> createState() => _PublishDynamicPageState();
}

class _PublishDynamicPageState extends ConsumerState<PublishDynamicPage> {
  static const _maxImages = 9;

  final TextEditingController _controller = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  final List<File> _images = [];
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    if (_images.length >= _maxImages) return;

    final picked = await _imagePicker.pickMultiImage(limit: _maxImages - _images.length);

    if (picked.isNotEmpty) {
      setState(() => _images.addAll(picked.map((item) => File(item.path))));
    }
  }

  void _showEmojiPicker() {
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
              _insertText(text);
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  void _showTopicPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return TopicPicker(
          onTopicSelected: (topic) {
            _insertText('#$topic# ');
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void _insertText(String text) {
    if (!_controller.selection.isValid) {
      _controller.text += text;
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    } else {
      final textSelection = _controller.selection;
      final newText = _controller.text.replaceRange(
        textSelection.start,
        textSelection.end,
        text,
      );
      final myTextLength = text.length;
      _controller.text = newText;
      _controller.selection = textSelection.copyWith(
        baseOffset: textSelection.start + myTextLength,
        extentOffset: textSelection.start + myTextLength,
      );
    }
  }

  Future<void> _publish() async {
    if (_controller.text.trim().isEmpty && _images.isEmpty) return;
    final t = Translations.of(context);
    final notifier = ref.read(publishDynamicViewModelProvider.notifier);

    try {
      final error = await notifier.publish(content: _controller.text, images: _images);
      if (error != null) {
        throw Exception(error);
      }

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(t.moments.publish_success)));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.moments.publish_failed(error: e.toString()))),
        );
      }
    }
  }

  Future<bool> _onWillPop() async {
    final t = Translations.of(context);
    if (_controller.text.isNotEmpty || _images.isNotEmpty) {
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
      return result ?? false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);
    final isPublishing = ref.watch(
      publishDynamicViewModelProvider.select((state) => state.isPublishing),
    );
    final isPostable = _hasDraft;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await _onWillPop();
        if (shouldPop && context.mounted) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: theme.scaffoldBackgroundColor,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () async {
              if (await _onWillPop() && context.mounted) {
                Navigator.pop(context);
              }
            },
          ),
          title: Text(
            t.moments.publish_title,
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: TextButton(
                onPressed: isPublishing || !isPostable ? null : _publish,
                style: TextButton.styleFrom(
                  backgroundColor: isPublishing || !isPostable
                      ? colorScheme.surfaceContainerHighest
                      : colorScheme.primary,
                  foregroundColor: isPublishing || !isPostable
                      ? colorScheme.onSurfaceVariant
                      : colorScheme.onPrimary,
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
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                children: [
                  TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    maxLines: null,
                    minLines: 5,
                    style: theme.textTheme.bodyLarge?.copyWith(fontSize: 16),
                    decoration: InputDecoration(
                      hintText: t.moments.publish_hint,
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 12),
                  PublishDynamicImageGrid(
                    images: _images,
                    maxImages: _maxImages,
                    onAddTap: _pickImage,
                    onRemoveAt: (index) => setState(() => _images.removeAt(index)),
                  ),
                ],
              ),
            ),
            PublishDynamicBottomToolbar(
              charCount: _controller.text.length,
              onPickImage: _pickImage,
              onInsertMention: () => _insertText('@'),
              onPickTopic: _showTopicPicker,
              onPickEmoji: _showEmojiPicker,
            ),
          ],
        ),
      ),
    );
  }

  bool get _hasDraft => _controller.text.trim().isNotEmpty || _images.isNotEmpty;
}
