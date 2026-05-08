import 'dart:convert';
import 'dart:ui';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/utils/danmaku_mask_parser.dart';
import 'package:culcul/features/video/domain/repositories/danmaku_repository.dart';
import 'package:culcul/features/video/domain/repositories/video_repository.dart';
import 'package:culcul/features/video/feature_scope.dart';
import 'package:flutter/foundation.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'video_extra_workflows.g.dart';

@riverpod
VideoExtraWorkflows videoExtraWorkflows(Ref ref) {
  return VideoExtraWorkflows(
    videoRepository: ref.read(videoRepositoryProvider),
    danmakuRepository: ref.read(danmakuRepositoryProvider),
  );
}

class VideoExtraWorkflows {
  final VideoRepository videoRepository;
  final DanmakuRepository danmakuRepository;

  const VideoExtraWorkflows({
    required this.videoRepository,
    required this.danmakuRepository,
  });

  Future<Result<DanmakuMasks?, AppError>> loadDanmakuMask({
    required int oid,
    required int pid,
  }) async {
    if (oid <= 0 || pid <= 0) {
      return const Success(null);
    }

    final playerInfoResult = await videoRepository.fetchPlayerInfo(aid: pid, cid: oid);
    if (playerInfoResult.errorOrNull case final error?) {
      return Failure(error);
    }
    final playerInfo = playerInfoResult.dataOrNull;
    if (playerInfo == null) {
      return const Success(null);
    }

    final dmMask = playerInfo.dmMask;
    if (dmMask == null) {
      return const Success(null);
    }

    return (await danmakuRepository.fetchMaskData(dmMask.maskUrl)).when(
      success: (bytes) async {
        final paths = await compute(
          _parseMaskData,
          _ParseDanmakuMaskData(bytes, dmMask.fps),
        );
        return Success(DanmakuMasks(paths, dmMask.fps));
      },
      failure: (error) async => Failure(error),
    );
  }
}

class DanmakuMasks {
  final Map<int, Path> _paths;
  final List<int> _sortedKeys;
  final int fps;
  final int frameDuration;

  DanmakuMasks(this._paths, this.fps)
    : _sortedKeys = _paths.keys.toList()..sort(),
      frameDuration = (1000 / fps).round();

  Path? getPath(int time) {
    if (_sortedKeys.isEmpty) return null;

    var left = 0;
    var right = _sortedKeys.length - 1;
    var index = -1;

    while (left <= right) {
      final mid = left + (right - left) ~/ 2;
      if (_sortedKeys[mid] <= time) {
        index = mid;
        left = mid + 1;
      } else {
        right = mid - 1;
      }
    }

    if (index == -1) return null;

    final key = _sortedKeys[index];
    if (time - key < frameDuration) {
      return _paths[key];
    }
    return null;
  }
}

class _ParseDanmakuMaskData {
  final List<int> bytes;
  final int fps;

  _ParseDanmakuMaskData(this.bytes, this.fps);
}

Map<int, Path> _parseMaskData(_ParseDanmakuMaskData data) {
  final parser = DanmakuMaskParser(data.bytes, data.fps);
  final rawMasks = parser.parse();

  final result = <int, Path>{};
  for (final entry in rawMasks.entries) {
    final path = _parsePath(entry.value);
    if (path != null) {
      result[entry.key] = path;
    }
  }
  return result;
}

Path? _parsePath(String base64Svg) {
  try {
    final svgString = utf8.decode(base64Decode(base64Svg));
    final match = RegExp(r'd=\"([^\"]+)\"').firstMatch(svgString);
    if (match != null) {
      return parseSvgPathData(match.group(1)!);
    }
  } catch (error) {
    debugPrint('Error parsing SVG path: $error');
  }
  return null;
}
