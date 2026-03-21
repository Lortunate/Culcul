import 'dart:ui';

import 'package:culcul/core/services/media_service.dart';
import 'package:culcul/core/utils/id_utils.dart';
import 'package:culcul/core/utils/toast_utils.dart';
import 'package:culcul/data/models/video/video_model.dart';
import 'package:culcul/features/to_view/controllers/to_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VideoMoreBottomSheet extends ConsumerWidget {
  final VideoModel video;

  const VideoMoreBottomSheet({super.key, required this.video});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    const topRadius = BorderRadius.vertical(top: Radius.circular(16));

    return ClipRRect(
      borderRadius: topRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colorScheme.surface.withValues(alpha: 0.8),
            borderRadius: topRadius,
            border: Border(
              top: BorderSide(
                color: colorScheme.outlineVariant.withValues(alpha: 0.2),
                width: 0.5,
              ),
            ),
          ),
          child: SafeArea(
            child: Material(
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildDragHandle(colorScheme),
                  _ActionItem(
                    icon: Icons.watch_later_outlined,
                    text: '稍后再看',
                    onTap: () => _addToWatchLater(context, ref),
                  ),
                  _ActionItem(
                    icon: Icons.image_outlined,
                    text: '下载封面',
                    onTap: () => _downloadCover(context, ref),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDragHandle(ColorScheme colorScheme) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      width: 36,
      height: 4,
      decoration: BoxDecoration(
        color: colorScheme.onSurfaceVariant.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Future<void> _addToWatchLater(BuildContext context, WidgetRef ref) async {
    final notifier = ref.read(toViewListProvider.notifier);
    Navigator.pop(context);

    try {
      final aid = IdUtils.bv2av(video.bvid);
      if (aid == 0) {
        ToastUtils.showError('无法获取视频ID');
        return;
      }
      await notifier.add(aid);
      ToastUtils.show('已添加至稍后再看');
    } catch (e) {
      ToastUtils.showError('添加失败: $e');
    }
  }

  Future<void> _downloadCover(BuildContext context, WidgetRef ref) async {
    final mediaService = ref.read(mediaServiceProvider);
    Navigator.pop(context);

    try {
      await mediaService.saveImage(video.pic);
      ToastUtils.show('封面已保存到相册');
    } catch (e) {
      ToastUtils.showError('下载失败: $e');
    }
  }
}

class _ActionItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const _ActionItem({required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 24, color: colorScheme.onSurface),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
