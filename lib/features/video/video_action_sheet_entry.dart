import 'package:culcul/features/video/presentation/overlays/video_actions_bottom_sheet.dart';
import 'package:flutter/material.dart';

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
