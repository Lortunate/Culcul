import 'package:culcul/features/to_view/presentation/view_models/to_view_view_model.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/shared/services/media_service.dart';
import 'package:culcul/shared/utils/id_utils.dart';
import 'package:culcul/shared/utils/toast_utils.dart';
import 'package:culcul/shared/widgets/video_actions_bottom_sheet.dart';
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
        ToastUtils.showError(t.home.video_more.invalid_video_id);
        return;
      }

      await ref.read(toViewListProvider.notifier).add(aid);
      ToastUtils.show(t.home.video_more.added_to_watch_later);
    } catch (e) {
      ToastUtils.showError(t.home.video_more.add_failed(error: e.toString()));
    }
  }

  Future<void> downloadCover(BuildContext sheetContext) async {
    Navigator.pop(sheetContext);

    try {
      await ref.read(mediaServiceProvider).saveImage(coverUrl);
      ToastUtils.show(t.common.save_success);
    } catch (e) {
      ToastUtils.showError(t.home.video_more.download_failed(error: e.toString()));
    }
  }

  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.transparent,
    isScrollControlled: true,
    builder: (sheetContext) => VideoActionsBottomSheet(
      onWatchLater: () => addToWatchLater(sheetContext),
      onDownloadCover: () => downloadCover(sheetContext),
    ),
  );
}
