import 'dart:io';

import 'package:culcul/core/feedback/app_feedback.dart';
import 'package:culcul/features/dynamic/presentation/view_models/publish_dynamic_view_model.dart';
import 'package:culcul/features/dynamic/presentation/widgets/emoji_picker.dart';
import 'package:culcul/features/dynamic/presentation/widgets/publish_dynamic_bottom_toolbar.dart';
import 'package:culcul/features/dynamic/presentation/widgets/publish_dynamic_image_grid.dart';
import 'package:culcul/features/dynamic/presentation/widgets/topic_picker.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

part 'publish_dynamic_page.widgets.dart';
part 'publish_dynamic_page.editor.dart';
part 'publish_dynamic_page.modals.dart';

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
  final ValueNotifier<bool> _hasDraftNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final hasDraft = _controller.text.trim().isNotEmpty || _images.isNotEmpty;
    if (_hasDraftNotifier.value != hasDraft) {
      _hasDraftNotifier.value = hasDraft;
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    _focusNode.dispose();
    _hasDraftNotifier.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    if (_images.length >= _maxImages) return;

    final picked = await _imagePicker.pickMultiImage(limit: _maxImages - _images.length);

    if (picked.isNotEmpty) {
      setState(() => _images.addAll(picked.map((item) => File(item.path))));
      _onTextChanged();
    }
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

  void _showEmojiPicker() {
    showPublishDynamicEmojiPicker(
      context: context,
      onEmojiSelected: (text) => _insertText(text),
    );
  }

  void _showTopicPicker() {
    showPublishDynamicTopicPicker(
      context: context,
      onTopicSelected: (topic) => _insertText('#$topic# '),
    );
  }

  Future<bool> _onWillPop() {
    return confirmDiscardDynamicDraft(context: context, hasDraft: _hasDraft);
  }

  Future<void> _publish() async {
    if (_controller.text.trim().isEmpty && _images.isEmpty) return;
    final t = Translations.of(context);
    final notifier = ref.read(publishDynamicViewModelProvider.notifier);

    final error = await notifier.publish(content: _controller.text, images: _images);
    if (error == null) {
      if (mounted) {
        Navigator.pop(context);
        context.showAppFeedback(t.moments.publish_success);
      }
      return;
    }
    if (mounted) {
      context.showAppFeedback(
        t.moments.publish_failed(error: error),
        level: AppFeedbackLevel.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);
    final isPublishing = ref.watch(
      publishDynamicViewModelProvider.select((state) => state.isPublishing),
    );

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await _onWillPop();
        if (shouldPop && context.mounted) {
          Navigator.pop(context);
        }
      },
      child: _PublishDynamicScaffold(
        theme: theme,
        colorScheme: colorScheme,
        t: t,
        isPublishing: isPublishing,
        hasDraftNotifier: _hasDraftNotifier,
        onClose: () async {
          if (await _onWillPop() && context.mounted) {
            Navigator.pop(context);
          }
        },
        onPublish: _publish,
        controller: _controller,
        focusNode: _focusNode,
        images: _images,
        maxImages: _maxImages,
        onEditorChanged: () {},
        onPickImage: _pickImage,
        onRemoveImageAt: (index) {
          setState(() => _images.removeAt(index));
          _onTextChanged();
        },
        onInsertMention: () => _insertText('@'),
        onPickTopic: _showTopicPicker,
        onPickEmoji: _showEmojiPicker,
      ),
    );
  }

  bool get _hasDraft => _controller.text.trim().isNotEmpty || _images.isNotEmpty;
}
