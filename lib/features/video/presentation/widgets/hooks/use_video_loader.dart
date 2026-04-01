import 'dart:async';

import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/core/network/bilibili_acceleration.dart';
import 'package:culcul/features/video/domain/entities/play_url.dart' as domain;
import 'package:culcul/features/video/presentation/view_models/player_view_model.dart';
import 'package:culcul/features/video/presentation/view_models/video_detail_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_kit/media_kit.dart';

typedef VideoLoaderInput = ({
  domain.PlayUrl? playUrl,
  int currentCid,
  double playbackSpeed,
  String? title,
  String? artist,
  String? coverUrl,
});

VideoLoaderInput watchVideoLoaderInput(WidgetRef ref, String bvid) {
  return ref.watch(
    videoDetailControllerProvider(bvid).select(
      (value) => (
        playUrl: value.playUrl,
        currentCid: value.currentCid,
        playbackSpeed: value.playbackSpeed,
        title: value.videoDetail?.title,
        artist: value.videoDetail?.owner.name,
        coverUrl: value.videoDetail?.pic,
      ),
    ),
  );
}

void useVideoLoader(
  WidgetRef ref,
  Player player,
  VideoLoaderInput input, {
  required String sessionId,
}) {
  final playerController = ref.read(playerControllerProvider.notifier);
  final activePresetId = ref.watch(
    bilibiliAccelerationControllerProvider.select((value) => value.activePresetId),
  );
  final sessionState = ref.watch(
    playerControllerProvider.select(
      (value) => (
        activeSessionId: value.activeSessionId,
        activationVersion: value.activationVersion,
      ),
    ),
  );
  final activePreset = biliPresetById(activePresetId);
  final lastLoadedCid = useRef<int?>(null);
  final lastPlayUrl = useRef<String?>(null);
  final lastActivationVersion = useRef<int?>(null);
  final currentLoadOperation = useRef<int>(0);
  final disposed = useRef<bool>(false);

  final isActiveSession = sessionState.activeSessionId == sessionId;
  final activationVersion = sessionState.activationVersion;

  useEffect(() {
    if (!isActiveSession) {
      return null;
    }
    if (input.playUrl != null && input.playUrl!.durl.isNotEmpty) {
      final urls = _buildPlayableUrls(input.playUrl!.durl.first, activePreset);
      if (urls.isEmpty) {
        return null;
      }
      final url = urls.first;
      if (kDebugMode) {
        debugPrint(
          'Video loader preset=$activePresetId candidates=${urls.map((e) => Uri.tryParse(e)?.host ?? e).toList()}',
        );
      }

      final reactivated =
          lastActivationVersion.value != null &&
          lastActivationVersion.value != activationVersion;
      final sameMedia =
          lastPlayUrl.value == url && lastLoadedCid.value == input.currentCid;
      if (sameMedia && !reactivated) {
        lastActivationVersion.value = activationVersion;
        return null;
      }

      final isQualitySwitch =
          !reactivated &&
          lastLoadedCid.value == input.currentCid &&
          lastPlayUrl.value != null &&
          lastPlayUrl.value != url;
      final opId = ++currentLoadOperation.value;

      unawaited(
        Future<void>(() async {
          if (disposed.value ||
              opId != currentLoadOperation.value ||
              !playerController.isSessionActive(sessionId)) {
            return;
          }
          try {
            await playerController.loadVideo(
              urls,
              sessionId: sessionId,
              httpHeaders: {
                'Referer': ApiConstants.referer,
                'User-Agent': ApiConstants.userAgent,
              },
              isQualitySwitch: isQualitySwitch,
              title: input.title,
              artist: input.artist,
              coverUrl: input.coverUrl,
            );

            if (disposed.value ||
                opId != currentLoadOperation.value ||
                !playerController.isSessionActive(sessionId)) {
              return;
            }

            player.setRate(input.playbackSpeed);
            lastLoadedCid.value = input.currentCid;
            lastPlayUrl.value = url;
            lastActivationVersion.value = activationVersion;
          } catch (error, stackTrace) {
            debugPrint(
              'useVideoLoader failed for session=$sessionId: $error\n$stackTrace',
            );
          }
        }),
      );
    }
    return null;
  }, [input.playUrl, input.currentCid, activePresetId, isActiveSession, activationVersion]);

  useEffect(() {
    if (isActiveSession) {
      player.setRate(input.playbackSpeed);
    }
    return null;
  }, [input.playbackSpeed, isActiveSession]);

  useEffect(() {
    disposed.value = false;
    return () {
      disposed.value = true;
      currentLoadOperation.value++;
    };
  }, const []);
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
