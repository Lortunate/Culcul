import 'package:culcul/core/feedback/app_feedback.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/core/services/media_service.dart';
import 'package:culcul/core/utils/id_utils.dart';
import 'package:culcul/features/to_view/application/watch_later_port_provider.dart';
import 'package:culcul/features/video/video_action_sheet_entry.dart';
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
      final aid = IdUtils.bv2av(bvid);
      if (aid == 0) {
        context.showAppFeedback(
          t.home.video_more.invalid_video_id,
          level: AppFeedbackLevel.error,
        );
        return;
      }

      await ref.read(watchLaterPortProvider).addToWatchLater(aid);
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

  return showVideoActionsBottomSheet(
    context,
    onWatchLater: addToWatchLater,
    onDownloadCover: downloadCover,
  );
}
