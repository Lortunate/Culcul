import 'dart:async';

import 'package:culcul/features/video/application/video_entry_layout.dart';
import 'package:culcul/features/video/data/video_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'video_entry_workflows.g.dart';

@riverpod
Future<VideoEntryLayout> resolveVideoEntryLayout(Ref ref, String bvid) async {
  final repository = ref.read(videoRepositoryProvider);
  try {
    final result = await repository
        .fetchVideoEntryDimension(bvid)
        .timeout(const Duration(seconds: 5));
    final dimension = result.dataOrNull;
    if (dimension == null) {
      return VideoEntryLayout.normal;
    }
    return inferVideoEntryLayoutFromDimension(
      width: dimension.width,
      height: dimension.height,
      rotate: dimension.rotate,
    );
  } on Object {
    return VideoEntryLayout.normal;
  }
}
