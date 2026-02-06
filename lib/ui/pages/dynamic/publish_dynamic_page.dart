import 'dart:io';

import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/types/result.dart';
import 'package:culcul/data/models/dynamic/dynamic_response.dart';
import 'package:culcul/providers/dynamic/dynamic_provider.dart';
import 'package:culcul/ui/pages/dynamic/widgets/emoji_picker.dart';
import 'package:culcul/ui/pages/dynamic/widgets/topic_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class PublishDynamicPage extends ConsumerStatefulWidget {
  const PublishDynamicPage({super.key});

  @override
  ConsumerState<PublishDynamicPage> createState() => _PublishDynamicPageState();
}

class _PublishDynamicPageState extends ConsumerState<PublishDynamicPage> {
  final TextEditingController _controller = TextEditingController();
  final List<File> _images = [];
  bool _isPublishing = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    if (_images.length >= 9) return;
    
    final picker = ImagePicker();
    final picked = await picker.pickMultiImage(
      limit: 9 - _images.length,
    );
    
    if (picked.isNotEmpty) {
      setState(() {
        _images.addAll(picked.map((e) => File(e.path)));
      });
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
      _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
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

    setState(() => _isPublishing = true);

    try {
      final List<DynamicUploadImageData> uploadedImages = [];
      if (_images.isNotEmpty) {
        for (var img in _images) {
          final result = await ref.read(dynamicRepositoryProvider).uploadImage(img);
          result.when(
            success: (data) => uploadedImages.add(data),
            failure: (e) => throw e,
          );
        }
      }

      final result = await ref.read(dynamicRepositoryProvider).publishDynamic(
            content: _controller.text,
            images: uploadedImages,
          );

      result.when(
        success: (_) {},
        failure: (e) => throw e,
      );

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('发布成功')),
        );
        ref.invalidate(dynamicProvider);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('发布失败: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isPublishing = false);
    }
  }

  Future<bool> _onWillPop() async {
    if (_controller.text.isNotEmpty || _images.isNotEmpty) {
      final result = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('提示'),
          content: const Text('确定要放弃编辑吗？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('放弃'),
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
    final isPostable = _controller.text.trim().isNotEmpty || _images.isNotEmpty;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
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
            '发布动态',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: TextButton(
                onPressed: _isPublishing || !isPostable ? null : _publish,
                style: TextButton.styleFrom(
                  backgroundColor: _isPublishing || !isPostable
                      ? colorScheme.surfaceContainerHighest
                      : colorScheme.primary,
                  foregroundColor: _isPublishing || !isPostable
                      ? colorScheme.onSurfaceVariant
                      : colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: _isPublishing
                    ? SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      )
                    : const Text('发布', style: TextStyle(fontWeight: FontWeight.bold)),
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
                    decoration: const InputDecoration(
                      hintText: '分享你的新鲜事...',
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 12),
                  if (_images.isNotEmpty)
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: _images.length + (_images.length < 9 ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == _images.length) {
                          return _buildAddImageButton(colorScheme);
                        }
                        return _buildImageItem(index, colorScheme);
                      },
                    ),
                ],
              ),
            ),
            _buildBottomToolbar(colorScheme),
          ],
        ),
      ),
    );
  }

  Widget _buildImageItem(int index, ColorScheme colorScheme) {
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(
              _images[index],
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: () => setState(() => _images.removeAt(index)),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, size: 16, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddImageButton(ColorScheme colorScheme) {
    return InkWell(
      onTap: _pickImage,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(Icons.add, size: 32, color: colorScheme.onSurfaceVariant),
      ),
    );
  }

  Widget _buildBottomToolbar(ColorScheme colorScheme) {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 12,
        bottom: MediaQuery.of(context).padding.bottom + 12,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(color: colorScheme.outlineVariant.withOpacity(0.2)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _ToolbarAction(
                icon: Icons.image_outlined,
                onTap: _pickImage,
              ),
              const SizedBox(width: 24),
              _ToolbarAction(
                icon: Icons.alternate_email,
                onTap: () => _insertText('@'),
              ),
              const SizedBox(width: 24),
              _ToolbarAction(
                icon: Icons.tag,
                onTap: _showTopicPicker,
              ),
              const SizedBox(width: 24),
              _ToolbarAction(
                icon: Icons.sentiment_satisfied_alt,
                onTap: _showEmojiPicker,
              ),
            ],
          ),
          Text(
            '${_controller.text.length}字',
            style: TextStyle(
              color: colorScheme.outline,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _ToolbarAction extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ToolbarAction({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Icon(
          icon,
          size: 26,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}
