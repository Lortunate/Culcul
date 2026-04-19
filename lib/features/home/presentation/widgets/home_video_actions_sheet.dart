import 'package:culcul/features/home/domain/entities/home_video.dart';
import 'package:culcul/features/to_view/presentation/view_models/to_view_view_model.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/shared/services/media_service.dart';
import 'package:culcul/shared/utils/id_utils.dart';
import 'package:culcul/shared/utils/toast_utils.dart';
import 'package:culcul/shared/widgets/video_actions_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> showHomeVideoActionsSheet(
  BuildContext context,
  WidgetRef ref, {
  required HomeVideo video,
}) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.transparent,
    isScrollControlled: true,
    builder: (sheetContext) {
      final t = Translations.of(sheetContext);
      return VideoActionsBottomSheet(
        watchLaterLabel: t.home.video_more.watch_later,
        downloadCoverLabel: t.home.video_more.download_cover,
        onWatchLaterTap: () => _addToWatchLater(sheetContext, ref, video: video),
        onDownloadCoverTap: () => _downloadCover(sheetContext, ref, video: video),
      );
    },
  );
}

Future<void> _addToWatchLater(
  BuildContext context,
  WidgetRef ref, {
  required HomeVideo video,
}) async {
  final notifier = ref.read(toViewListProvider.notifier);
  final t = Translations.of(context);
  Navigator.of(context).pop();

  try {
    if (video.bvid.isEmpty) {
      ToastUtils.showError(t.home.video_more.invalid_video_id);
      return;
    }
    final aid = IdUtils.bv2av(video.bvid);
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

Future<void> _downloadCover(
  BuildContext context,
  WidgetRef ref, {
  required HomeVideo video,
}) async {
  final mediaService = ref.read(mediaServiceProvider);
  final t = Translations.of(context);
  Navigator.of(context).pop();

  try {
    if (video.pic.isEmpty) {
      ToastUtils.showError(t.home.video_more.download_failed(error: 'empty cover'));
      return;
    }
    await mediaService.saveImage(video.pic);
    ToastUtils.show(t.common.save_success);
  } catch (e) {
    ToastUtils.showError(t.home.video_more.download_failed(error: e.toString()));
  }
}
