import 'dart:async';

import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/core/network/bilibili_acceleration.dart';
import 'package:culcul/features/video/domain/entities/play_url.dart' as domain;
import 'package:culcul/features/video/presentation/view_models/player_view_model.dart';
import 'package:culcul/features/video/presentation/view_models/video_detail_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_kit/media_kit.dart';

void useVideoLoader(WidgetRef ref, Player player, VideoDetailState state) {
  final playerController = ref.read(playerControllerProvider.notifier);
  final activePresetId = ref.watch(
    bilibiliAccelerationControllerProvider.select((value) => value.activePresetId),
  );
  final activePreset = biliPresetById(activePresetId);
  final lastLoadedCid = useRef<int?>(null);
  final lastPlayUrl = useRef<String?>(null);

  useEffect(() {
    if (state.playUrl != null && state.playUrl!.durl.isNotEmpty) {
      final urls = _buildPlayableUrls(state.playUrl!.durl.first, activePreset);
      if (urls.isEmpty) {
        return null;
      }
      final url = urls.first;
      if (kDebugMode) {
        debugPrint(
          'Video loader preset=$activePresetId candidates=${urls.map((e) => Uri.tryParse(e)?.host ?? e).toList()}',
        );
      }

      if (lastPlayUrl.value == url) return null;

      final bool isQualitySwitch =
          lastLoadedCid.value == state.currentCid && lastPlayUrl.value != null;

      unawaited(() async {
        await playerController.loadVideo(
          urls,
          httpHeaders: {
            'Referer': ApiConstants.referer,
            'User-Agent': ApiConstants.userAgent,
          },
          isQualitySwitch: isQualitySwitch,
          title: state.videoDetail?.title,
          artist: state.videoDetail?.owner.name,
          coverUrl: state.videoDetail?.pic,
        );

        player.setRate(state.playbackSpeed);

        lastLoadedCid.value = state.currentCid;
        lastPlayUrl.value = url;
      }());
    }
    return null;
  }, [state.playUrl, activePresetId]);

  useEffect(() {
    player.setRate(state.playbackSpeed);
    return null;
  }, [state.playbackSpeed]);
}

List<String> _buildPlayableUrls(domain.Durl durl, BiliAccelerationPreset preset) {
  final seen = <String>{};
  final candidates = <String>[];
  for (final raw in <String>[durl.url, ...durl.backupUrl]) {
    final normalized = _normalizeMediaUrl(raw);
    if (normalized == null) {
      continue;
    }
    if (seen.add(normalized)) {
      candidates.add(normalized);
    }
  }
  return _sortByPresetPreference(candidates, preset);
}

String? _normalizeMediaUrl(String raw) {
  final value = raw.trim();
  if (value.isEmpty) {
    return null;
  }
  final withScheme = value.startsWith('//') ? 'https:$value' : value;
  final uri = Uri.tryParse(withScheme);
  if (uri == null) {
    return withScheme;
  }

  final host = uri.host.toLowerCase();
  final isBiliVideoHost =
      host.endsWith('.bilivideo.com') ||
      host.endsWith('.bilivideo.cn') ||
      host.endsWith('.akamaized.net');
  if (uri.scheme == 'http' && isBiliVideoHost) {
    return uri.replace(scheme: 'https').toString();
  }

  return withScheme;
}

List<String> _sortByPresetPreference(
  List<String> candidates,
  BiliAccelerationPreset preset,
) {
  final preferredHost = preset.videoCdnHost;
  if (preferredHost == null || candidates.length < 2) {
    return candidates;
  }

  final exactMatches = <String>[];
  final providerMatches = <String>[];
  final others = <String>[];
  final providerHint = _extractProviderHint(preferredHost);

  for (final url in candidates) {
    final host = Uri.tryParse(url)?.host.toLowerCase();
    if (host == null || host.isEmpty) {
      others.add(url);
      continue;
    }

    if (host == preferredHost) {
      exactMatches.add(url);
      continue;
    }

    if (providerHint != null &&
        (host.contains('mirror$providerHint') || host.contains(providerHint))) {
      providerMatches.add(url);
      continue;
    }

    others.add(url);
  }

  return <String>[...exactMatches, ...providerMatches, ...others];
}

String? _extractProviderHint(String host) {
  final lower = host.toLowerCase();
  final mirrorIdx = lower.indexOf('mirror');
  if (mirrorIdx < 0) {
    return null;
  }
  final start = mirrorIdx + 'mirror'.length;
  if (start >= lower.length) {
    return null;
  }
  final end = lower.indexOf('.', start);
  final raw = (end < 0 ? lower.substring(start) : lower.substring(start, end)).trim();
  if (raw.isEmpty) {
    return null;
  }
  final normalized = raw.replaceAll(RegExp(r'[^a-z]'), '');
  return normalized.isEmpty ? raw : normalized;
}
