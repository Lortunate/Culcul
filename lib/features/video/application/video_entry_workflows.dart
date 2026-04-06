import 'dart:async';

import 'package:culcul/features/video/application/video_entry_layout.dart';
import 'package:culcul/features/video/domain/repositories/video_repository.dart';
import 'package:culcul/features/video/feature_scope.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final resolveVideoEntryLayoutWorkflowProvider = Provider<ResolveVideoEntryLayoutWorkflow>(
  (ref) => ResolveVideoEntryLayoutWorkflow(ref.read(videoRepositoryProvider)),
);

class ResolveVideoEntryLayoutWorkflow {
  final VideoRepository _repository;

  const ResolveVideoEntryLayoutWorkflow(this._repository);

  Future<VideoEntryLayout> call(String bvid) async {
    try {
      final result = await _repository
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
}
