import 'package:culcul/features/video/presentation/overlays/video_actions_bottom_sheet.dart';
import 'package:flutter/material.dart';

export 'package:culcul/features/video/data/video_repository_impl.dart'
    show videoRepositoryProvider;
export 'package:culcul/features/video/data/danmaku_repository_impl.dart'
    show danmakuRepositoryProvider;

typedef VideoActionSheetCallback = void Function(BuildContext sheetContext);

Future<void> showVideoActionsBottomSheet(
  BuildContext context, {
  required VideoActionSheetCallback onWatchLater,
  required VideoActionSheetCallback onDownloadCover,
}) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.transparent,
    isScrollControlled: true,
    builder: (sheetContext) => VideoActionsBottomSheet(
      onWatchLater: () => onWatchLater(sheetContext),
      onDownloadCover: () => onDownloadCover(sheetContext),
    ),
  );
}
