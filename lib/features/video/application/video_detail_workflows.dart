import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/profile/profile_providers.dart';
import 'package:culcul/features/video/domain/entities/video_entities.dart';
import 'package:culcul/features/profile/domain/repositories/relation_repository.dart';
import 'package:culcul/features/video/domain/repositories/video_repository.dart';
import 'package:culcul/features/video/video_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'video_detail_workflows.g.dart';

class VideoInitialData {
  final VideoDetail detail;
  final int currentCid;
  final PlayUrl? playUrl;
  final List<RelatedVideo> relatedVideos;
  final List<int> availableQualities;
  final int selectedQuality;

  const VideoInitialData({
    required this.detail,
    required this.currentCid,
    required this.playUrl,
    required this.relatedVideos,
    required this.availableQualities,
    required this.selectedQuality,
  });
}

class VideoPlayUrlCommand {
  final int aid;
  final int cid;
  final int quality;

  const VideoPlayUrlCommand({
    required this.aid,
    required this.cid,
    required this.quality,
  });
}

class VideoPlayUrlData {
  final PlayUrl playUrl;
  final List<int> availableQualities;
  final int selectedQuality;

  const VideoPlayUrlData({
    required this.playUrl,
    required this.availableQualities,
    required this.selectedQuality,
  });
}

class ToggleVideoFollowCommand {
  final int followMid;
  final bool wasFollowed;

  const ToggleVideoFollowCommand({required this.followMid, required this.wasFollowed});
}

class ReportVideoProgressCommand {
  final int aid;
  final int cid;
  final int progress;

  const ReportVideoProgressCommand({
    required this.aid,
    required this.cid,
    required this.progress,
  });
}

@riverpod
LoadVideoDetailWorkflow loadVideoDetailWorkflow(Ref ref) {
  return LoadVideoDetailWorkflow(ref.read(videoRepositoryProvider));
}

class LoadVideoDetailWorkflow {
  final VideoRepository _repository;

  const LoadVideoDetailWorkflow(this._repository);

  Future<Result<VideoInitialData, AppError>> call(String bvid) async {
    try {
      final detail = await _repository.fetchVideoView(bvid);
      final cid = detail.pages.isNotEmpty ? detail.pages.first.cid : 0;

      final relatedResult = await _guard(() => _repository.fetchRelatedVideos(bvid));
      final tagsResult = await _guard(() => _repository.fetchVideoTags(bvid));
      final Result<PlayUrl?, AppError> playResult;
      if (cid == 0) {
        playResult = const Success(null);
      } else {
        final loadedPlayUrl = await _guard(
          () => _repository.fetchVideoPlayUrl(aid: detail.aid, cid: cid),
        );
        playResult = loadedPlayUrl.map<PlayUrl?>((value) => value);
      }

      final mergedDetail = tagsResult.dataOrNull == null
          ? detail
          : detail.copyWith(tag: tagsResult.dataOrNull!);
      final playUrl = playResult.dataOrNull;

      return Success(
        VideoInitialData(
          detail: mergedDetail,
          currentCid: cid,
          playUrl: playUrl,
          relatedVideos: relatedResult.dataOrNull ?? const [],
          availableQualities: playUrl?.acceptQuality.toList() ?? const [],
          selectedQuality: playUrl?.quality ?? 80,
        ),
      );
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }
}

@riverpod
LoadVideoPlayUrlWorkflow loadVideoPlayUrlWorkflow(Ref ref) {
  return LoadVideoPlayUrlWorkflow(ref.read(videoRepositoryProvider));
}

class LoadVideoPlayUrlWorkflow {
  final VideoRepository _repository;

  const LoadVideoPlayUrlWorkflow(this._repository);

  Future<Result<VideoPlayUrlData, AppError>> call(VideoPlayUrlCommand command) async {
    try {
      final playUrl = await _repository.fetchVideoPlayUrl(
        aid: command.aid,
        cid: command.cid,
        quality: command.quality,
      );
      return Success(
        VideoPlayUrlData(
          playUrl: playUrl,
          availableQualities: playUrl.acceptQuality.toList(),
          selectedQuality: playUrl.quality,
        ),
      );
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }
}

@riverpod
ToggleVideoFollowWorkflow toggleVideoFollowWorkflow(Ref ref) {
  return ToggleVideoFollowWorkflow(ref.read(relationRepositoryProvider));
}

class ToggleVideoFollowWorkflow {
  final RelationRepository _repository;

  const ToggleVideoFollowWorkflow(this._repository);

  Future<Result<void, AppError>> call(ToggleVideoFollowCommand command) async {
    try {
      await _repository.modifyRelation(
        fid: command.followMid,
        act: command.wasFollowed ? 2 : 1,
      );
      return const Success(null);
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }
}

@riverpod
ReportVideoProgressWorkflow reportVideoProgressWorkflow(Ref ref) {
  return ReportVideoProgressWorkflow(ref.read(videoRepositoryProvider));
}

class ReportVideoProgressWorkflow {
  final VideoRepository _repository;

  const ReportVideoProgressWorkflow(this._repository);

  Future<Result<void, AppError>> call(ReportVideoProgressCommand command) async {
    try {
      await _repository.reportVideoProgress(
        aid: command.aid,
        cid: command.cid,
        progress: command.progress,
      );
      return const Success(null);
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }
}

Future<Result<T, AppError>> _guard<T>(Future<T> Function() action) async {
  try {
    return Success(await action());
  } catch (error) {
    return Failure(AppError.fromObject(error));
  }
}
