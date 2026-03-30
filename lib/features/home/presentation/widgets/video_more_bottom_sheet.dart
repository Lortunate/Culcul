import 'dart:ui';

import 'package:culcul/core/services/media_service.dart';
import 'package:culcul/core/utils/id_utils.dart';
import 'package:culcul/core/utils/toast_utils.dart';
import 'package:culcul/features/home/domain/entities/home_video.dart';
import 'package:culcul/features/to_view/presentation/view_models/to_view_view_model.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VideoMoreBottomSheet extends ConsumerWidget {
  final String? bvid;
  final String? coverUrl;

  const VideoMoreBottomSheet({super.key, this.bvid, this.coverUrl});

  VideoMoreBottomSheet.homeVideo({super.key, required HomeVideo video})
    : bvid = video.bvid,
      coverUrl = video.pic;

  String get _resolvedBvid => bvid ?? '';
  String get _resolvedCoverUrl => coverUrl ?? '';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

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
                    text: t.home.video_more.watch_later,
                    onTap: () => _addToWatchLater(context, ref),
                  ),
                  _ActionItem(
                    icon: Icons.image_outlined,
                    text: t.home.video_more.download_cover,
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
    final t = Translations.of(context);
    Navigator.pop(context);

    try {
      if (_resolvedBvid.isEmpty) {
        ToastUtils.showError(t.home.video_more.invalid_video_id);
        return;
      }
      final aid = IdUtils.bv2av(_resolvedBvid);
      if (aid == 0) {
        ToastUtils.showError(t.home.video_more.invalid_video_id);
        return;
      }
      await notifier.add(aid);
      ToastUtils.show(t.home.video_more.added_to_watch_later);
    } catch (e) {
      ToastUtils.showError(t.home.video_more.add_failed(error: e.toString()));
    }
  }

  Future<void> _downloadCover(BuildContext context, WidgetRef ref) async {
    final mediaService = ref.read(mediaServiceProvider);
    final t = Translations.of(context);
    Navigator.pop(context);

    try {
      if (_resolvedCoverUrl.isEmpty) {
        ToastUtils.showError(t.home.video_more.download_failed(error: 'empty cover'));
        return;
      }
      await mediaService.saveImage(_resolvedCoverUrl);
      ToastUtils.show(t.common.save_success);
    } catch (e) {
      ToastUtils.showError(t.home.video_more.download_failed(error: e.toString()));
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
