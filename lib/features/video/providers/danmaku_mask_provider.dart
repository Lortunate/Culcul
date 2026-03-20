import 'dart:convert';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/result.dart';
import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/data/models/video/player_info.dart';
import 'package:culcul/features/video/data/video_repository.dart';
import 'package:culcul/core/utils/danmaku_mask_parser.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'danmaku_mask_provider.g.dart';

@riverpod
Future<DanmakuMasks?> danmakuMask(
  Ref ref, {
  required int oid,
  required int pid,
}) async {
  // 1. Fetch Player Info to get Mask URL
  final videoRepo = ref.read(videoRepositoryProvider);
  final playerInfoResult = await videoRepo.fetchPlayerInfo(aid: pid, cid: oid);

  if (playerInfoResult is Failure) {
    return null;
  }

  // Cast to Success to access data
  final playerInfo =
      (playerInfoResult as Success<PlayerInfo, AppException>).value;
  final dmMask = playerInfo.dmMask;

  if (dmMask == null) {
    return null;
  }

  // 2. Fetch Mask Data
  final danmakuRepo = ref.read(danmakuRepositoryProvider);
  final result = await danmakuRepo.fetchMaskData(dmMask.maskUrl);

  if (result case Success(value: final bytes)) {
    // 3. Parse
    try {
      final paths = await compute(
        _parseMaskData,
        _ParseData(bytes, dmMask.fps),
      );
      return DanmakuMasks(paths, dmMask.fps);
    } catch (e) {
      debugPrint('Failed to parse mask data: $e');
      return null;
    }
  }

  debugPrint('Failed to fetch mask data');
  return null;
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

    // Binary search
    int left = 0;
    int right = _sortedKeys.length - 1;
    int index = -1;

    while (left <= right) {
      int mid = left + (right - left) ~/ 2;
      if (_sortedKeys[mid] <= time) {
        index = mid;
        left = mid + 1;
      } else {
        right = mid - 1;
      }
    }

    if (index == -1) return null;

    final key = _sortedKeys[index];
    // Check if within duration
    if (time - key < frameDuration) {
      return _paths[key];
    }
    return null;
  }
}

class _ParseData {
  final List<int> bytes;
  final int fps;
  _ParseData(this.bytes, this.fps);
}

Map<int, Path> _parseMaskData(_ParseData data) {
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
    final match = RegExp(r'd="([^"]+)"').firstMatch(svgString);
    if (match != null) {
      return parseSvgPathData(match.group(1)!);
    }
  } catch (e) {
    debugPrint('Error parsing SVG path: $e');
  }
  return null;
}
