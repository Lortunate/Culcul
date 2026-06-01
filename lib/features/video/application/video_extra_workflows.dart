import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/perf/dev_logger.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/video/data/danmaku_repository_impl.dart';
import 'package:culcul/features/video/data/video_repository_impl.dart';
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

@riverpod
Future<Result<DanmakuMasks?, AppError>> loadDanmakuMask(
  Ref ref, {
  required int oid,
  required int pid,
}) async {
  return ref.read(videoExtraWorkflowsProvider).loadDanmakuMask(oid: oid, pid: pid);
}

class VideoExtraWorkflows {
  final VideoRepositoryImpl videoRepository;
  final DanmakuRepositoryImpl danmakuRepository;

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

    final maskInfoResult = await videoRepository.fetchDanmakuMaskInfo(aid: pid, cid: oid);
    if (maskInfoResult.errorOrNull case final error?) {
      return Failure(error);
    }
    final maskInfo = maskInfoResult.dataOrNull;
    if (maskInfo == null) {
      return const Success(null);
    }

    return (await danmakuRepository.fetchMaskData(maskInfo.maskUrl)).when(
      success: (bytes) async {
        final paths = await compute(
          _parseMaskData,
          _ParseDanmakuMaskData(bytes, maskInfo.fps),
        );
        return Success(DanmakuMasks(paths, maskInfo.fps));
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
  final rawMasks = _parseRawDanmakuMasks(data.bytes, data.fps);

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
    DevLogger.log('video', 'danmaku.mask_svg_parse_failed', <String, Object?>{
      'error': error,
    });
  }
  return null;
}

Map<int, String> _parseRawDanmakuMasks(List<int> bytes, int fps) {
  final data = ByteData.sublistView(Uint8List.fromList(bytes));
  var offset = 0;

  final header = String.fromCharCodes(bytes.sublist(0, 4));
  if (header != 'MASK') throw const AppError.data('Invalid mask file');
  offset += 4;

  offset += 4; // Version.
  offset += 4; // Reserved.

  final segmentCount = data.getUint32(offset);
  offset += 4;

  final segments = <_MaskSegment>[];
  for (var index = 0; index < segmentCount; index++) {
    final time = data.getUint64(offset);
    offset += 8;
    final fileOffset = data.getUint64(offset);
    offset += 8;
    segments.add(_MaskSegment(time, fileOffset));
  }

  final result = <int, String>{};
  for (var index = 0; index < segmentCount; index++) {
    final segment = segments[index];
    final startOffset = segment.offset;
    final endOffset = index == segmentCount - 1
        ? bytes.length
        : segments[index + 1].offset;

    if (startOffset >= bytes.length || endOffset > bytes.length) continue;

    final compressedData = bytes.sublist(startOffset, endOffset);
    final decompressedData = gzip.decode(compressedData);
    if (decompressedData.length < 16) continue;

    final content = decompressedData.sublist(16);
    final contentString = String.fromCharCodes(content);
    final frames = contentString.split('data:image/svg+xml;base64,');

    var currentTime = segment.time;
    final frameDuration = (1000 / fps).round();

    for (var frameIndex = 1; frameIndex < frames.length; frameIndex++) {
      final svgBase64 = frames[frameIndex];
      if (svgBase64.isEmpty) continue;

      result[currentTime] = svgBase64;
      currentTime += frameDuration;
    }
  }

  return result;
}

class _MaskSegment {
  final int time;
  final int offset;

  const _MaskSegment(this.time, this.offset);
}
