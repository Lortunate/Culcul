import 'dart:async';

import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/features/video/application/video_view_contracts.dart' as domain;
import 'package:culcul/features/video/presentation/player/playable_urls.dart';
import 'package:culcul/features/video/presentation/player/player_view_model.dart';
import 'package:culcul/features/video/presentation/detail/video_detail_view_model.dart';
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
  final sessionState = ref.watch(
    playerControllerProvider.select(
      (value) => (
        activeSessionId: value.activeSessionId,
        activationVersion: value.activationVersion,
      ),
    ),
  );
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
      final urls = buildPlayableUrlsFromDurl(input.playUrl!.durl.first);
      if (urls.isEmpty) {
        return null;
      }
      final url = urls.first;
      if (kDebugMode) {
        debugPrint(
          'Video loader candidates=${urls.map((e) => Uri.tryParse(e)?.host ?? e).toList()}',
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
  }, [input.playUrl, input.currentCid, isActiveSession, activationVersion]);

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
