import 'dart:math';

import 'package:culcul/core/feedback/app_feedback.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/core/services/media_service.dart';
import 'package:culcul/features/to_view/application/to_view_list_controller.dart';
import 'package:culcul/ui/widgets/media/adaptive_blur.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> showHomeVideoActionsBottomSheet(
  BuildContext context,
  WidgetRef ref, {
  required String bvid,
  required String coverUrl,
}) {
  final t = Translations.of(context);

  Future<void> addToWatchLater(BuildContext sheetContext) async {
    Navigator.pop(sheetContext);

    try {
      final aid = _bv2av(bvid);
      if (aid == 0) {
        context.showAppFeedback(
          t.home.video_more.invalid_video_id,
          level: AppFeedbackLevel.error,
        );
        return;
      }

      await ref.read(toViewListProvider.notifier).add(aid);
      if (!context.mounted) return;
      context.showAppFeedback(t.home.video_more.added_to_watch_later);
    } catch (e) {
      if (!context.mounted) return;
      context.showAppFeedback(
        t.home.video_more.add_failed(error: e.toString()),
        level: AppFeedbackLevel.error,
      );
    }
  }

  Future<void> downloadCover(BuildContext sheetContext) async {
    Navigator.pop(sheetContext);

    try {
      await ref.read(mediaServiceProvider).saveImage(coverUrl);
      if (!context.mounted) return;
      context.showAppFeedback(t.common.save_success);
    } catch (e) {
      if (!context.mounted) return;
      context.showAppFeedback(
        t.home.video_more.download_failed(error: e.toString()),
        level: AppFeedbackLevel.error,
      );
    }
  }

  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.transparent,
    isScrollControlled: true,
    builder: (sheetContext) => _HomeVideoActionsBottomSheet(
      onWatchLater: () => addToWatchLater(sheetContext),
      onDownloadCover: () => downloadCover(sheetContext),
    ),
  );
}

class _HomeVideoActionsBottomSheet extends StatelessWidget {
  final VoidCallback onWatchLater;
  final VoidCallback onDownloadCover;

  const _HomeVideoActionsBottomSheet({
    required this.onWatchLater,
    required this.onDownloadCover,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    const topRadius = BorderRadius.vertical(top: Radius.circular(16));

    return ClipRRect(
      borderRadius: topRadius,
      child: AdaptiveBlur(
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
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: colorScheme.onSurfaceVariant.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  InkWell(
                    onTap: onWatchLater,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      child: Row(
                        children: [
                          Icon(
                            Icons.watch_later_outlined,
                            size: 24,
                            color: colorScheme.onSurface,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              t.home.video_more.watch_later,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: colorScheme.onSurface,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: onDownloadCover,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      child: Row(
                        children: [
                          Icon(
                            Icons.image_outlined,
                            size: 24,
                            color: colorScheme.onSurface,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              t.home.video_more.download_cover,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: colorScheme.onSurface,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
}

const _bvTable = 'fZodR9XQDSUm21yCkr6zBqiveYah8bt4xsWpHnJE7jL5VG3guMTKNPAwcF';
const _bvPositions = [11, 10, 3, 8, 4, 6];
const _bvXor = 177451812;
const _bvAdd = 8728348608;

final _bvLookup = {
  for (var index = 0; index < _bvTable.length; index++) _bvTable[index]: index,
};

int _bv2av(String bvid) {
  var normalizedBvid = bvid;
  if (normalizedBvid.length < 12 && !normalizedBvid.startsWith('BV')) {
    normalizedBvid = 'BV$normalizedBvid';
  }

  if (normalizedBvid.length != 12) {
    return 0;
  }

  var result = 0;
  for (var index = 0; index < _bvPositions.length; index++) {
    final code = _bvLookup[normalizedBvid[_bvPositions[index]]];
    if (code == null) {
      return 0;
    }
    result += code * pow(58, index).toInt();
  }
  return (result - _bvAdd) ^ _bvXor;
}
