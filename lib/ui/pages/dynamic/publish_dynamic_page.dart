import 'dart:io';

import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/data/models/dynamic/dynamic_response.dart';
import 'package:culcul/providers/dynamic/dynamic_provider.dart';
import 'package:culcul/ui/pages/dynamic/widgets/emoji_picker.dart';
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
      builder: (context) {
        return EmojiPicker(
          onEmojiSelected: (text) {
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
            Navigator.pop(context);
          },
        );
      },
    );
  }

  Future<void> _publish() async {
    if (_controller.text.trim().isEmpty && _images.isEmpty) return;

    setState(() => _isPublishing = true);

    try {
      final List<DynamicUploadImageData> uploadedImages = [];
      for (var img in _images) {
        final data = await ref.read(dynamicRepositoryProvider).uploadImage(img);
        uploadedImages.add(data);
      }

      await ref.read(dynamicRepositoryProvider).publishDynamic(
            content: _controller.text,
            images: uploadedImages,
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text('发布动态', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: TextButton(
              onPressed: _isPublishing || (_controller.text.isEmpty && _images.isEmpty) 
                  ? null 
                  : _publish,
              style: TextButton.styleFrom(
                backgroundColor: _isPublishing || (_controller.text.isEmpty && _images.isEmpty)
                    ? colorScheme.surfaceContainerHighest
                    : colorScheme.primary,
                foregroundColor: _isPublishing || (_controller.text.isEmpty && _images.isEmpty)
                    ? colorScheme.onSurfaceVariant
                    : colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                minimumSize: const Size(60, 32),
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
                  : const Text('发布'),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  maxLines: null,
                  minLines: 3,
                  decoration: const InputDecoration(
                    hintText: '分享你的新鲜事...',
                    border: InputBorder.none,
                    isDense: true,
                  ),
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 16),
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
                  )
                else if (_images.isEmpty)
                   const SizedBox.shrink(),
              ],
            ),
          ),
          _buildBottomToolbar(colorScheme),
        ],
      ),
    );
  }

  Widget _buildImageItem(int index, ColorScheme colorScheme) {
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
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
              child: const Icon(Icons.close, size: 14, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddImageButton(ColorScheme colorScheme) {
    return InkWell(
      onTap: _pickImage,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(Icons.add, color: colorScheme.onSurfaceVariant),
      ),
    );
  }

  Widget _buildBottomToolbar(ColorScheme colorScheme) {
    return Container(
      padding: EdgeInsets.only(
        left: 16, 
        right: 16, 
        top: 8, 
        bottom: MediaQuery.of(context).padding.bottom + 8
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(top: BorderSide(color: colorScheme.outlineVariant.withOpacity(0.5))),
      ),
      child: Row(
        children: [
          _ToolbarAction(
            icon: Icons.image_outlined, 
            onTap: _pickImage,
          ),
          const SizedBox(width: 24),
          _ToolbarAction(
            icon: Icons.alternate_email, 
            onTap: () {
               _controller.text += '@';
               _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
            },
          ),
          const SizedBox(width: 24),
          _ToolbarAction(
            icon: Icons.tag, 
            onTap: () {
              _controller.text += '#';
               _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
            },
          ),
          const SizedBox(width: 24),
          _ToolbarAction(
            icon: Icons.sentiment_satisfied_alt, 
            onTap: _showEmojiPicker,
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
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon, size: 28, color: Theme.of(context).colorScheme.onSurfaceVariant),
    );
  }
}
