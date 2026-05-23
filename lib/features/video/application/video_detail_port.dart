import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/video/application/models/play_url.dart';
import 'package:dio/dio.dart';

/// Application boundary for video detail interactions and playback refreshes.
abstract interface class VideoDetailPort {
  Future<Result<PlayUrl, AppError>> fetchVideoPlayUrl({
    required int aid,
    required int cid,
    int quality = 80,
    int fnval = 1,
    int fnver = 0,
    int fourk = 1,
    CancelToken? cancelToken,
  });

  Future<Result<void, AppError>> setVideoLike({required int aid, required bool isLiked});

  Future<Result<void, AppError>> addVideoCoin({
    required int aid,
    int count = 1,
    bool alsoLike = false,
  });

  Future<Result<void, AppError>> reportVideoProgress({
    required int aid,
    required int cid,
    required int progress,
  });
}
