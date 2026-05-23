import 'dart:async';

import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/core/perf/dev_logger.dart';
import 'package:culcul/features/video/application/models/play_url.dart' as domain;
import 'package:culcul/features/video/application/video_detail_application_providers.dart';
import 'package:culcul/features/video/presentation/player/playable_urls.dart';
import 'package:culcul/features/video/presentation/player/player_view_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef ListenAudioModeInput = ({
  int? aid,
  int currentCid,
  int selectedQuality,
  domain.PlayUrl? playUrl,
});

void useListenAudioMode(WidgetRef ref, ListenAudioModeInput input) {
  final playerController = ref.read(playerControllerProvider.notifier);
  final activeSessionId = ref.watch(
    playerControllerProvider.select((state) => state.activeSessionId),
  );
  final switchedTokenRef = useRef<String?>(null);
  final switchedToAudioRef = useRef<bool>(false);
  final switchedSessionIdRef = useRef<String?>(null);
  final lastVideoUrlsRef = useRef<List<String>>(const []);

  final fallbackVideoUrls = buildFallbackVideoUrlsFromPlayUrl(input.playUrl);
  if (fallbackVideoUrls.isNotEmpty) {
    lastVideoUrlsRef.value = fallbackVideoUrls;
  }

  useEffect(
    () {
      final aid = input.aid;
      if (aid == null || input.currentCid <= 0) {
        return null;
      }

      final sessionId = activeSessionId;
      if (sessionId == null || !playerController.isSessionActive(sessionId)) {
        return null;
      }

      final switchToken = '$sessionId:$aid:${input.currentCid}:${input.selectedQuality}';
      if (switchedTokenRef.value == switchToken) {
        return null;
      }
      switchedTokenRef.value = switchToken;

      final detailPort = ref.read(videoDetailPortProvider);
      var disposed = false;
      unawaited(
        Future<void>(() async {
          if (disposed || !playerController.isSessionActive(sessionId)) {
            return;
          }

          try {
            final dashPlayUrl = await detailPort.fetchVideoPlayUrl(
              aid: aid,
              cid: input.currentCid,
              quality: input.selectedQuality,
              fnval: 16,
            );
            if (dashPlayUrl.errorOrNull != null) {
              return;
            }
            final playUrl = dashPlayUrl.dataOrNull;
            if (playUrl == null) {
              return;
            }

            final fallbackDurl = input.playUrl?.durl.isNotEmpty == true
                ? input.playUrl!.durl.first
                : null;
            final audioUrls = buildListenAudioCandidateUrls(
              dash: playUrl.dash,
              fallbackDurl: fallbackDurl,
            );
            if (disposed || audioUrls.isEmpty) {
              return;
            }

            await playerController.loadVideo(
              audioUrls,
              sessionId: sessionId,
              httpHeaders: const {
                'Referer': ApiConstants.referer,
                'User-Agent': ApiConstants.userAgent,
              },
              isQualitySwitch: true,
            );
            if (!disposed) {
              switchedToAudioRef.value = true;
              switchedSessionIdRef.value = sessionId;
            }
          } catch (error, stackTrace) {
            DevLogger.log('video', 'listen_audio.switch_failed', <String, Object?>{
              'aid': aid,
              'cid': input.currentCid,
              'quality': input.selectedQuality,
              'error': error,
              'stack': stackTrace,
            });
          }
        }),
      );

      return () {
        disposed = true;
      };
    },
    [activeSessionId, input.aid, input.currentCid, input.selectedQuality, input.playUrl],
  );

  useEffect(() {
    return () {
      if (!switchedToAudioRef.value) {
        return;
      }
      final sessionId = switchedSessionIdRef.value;
      final restoreUrls = lastVideoUrlsRef.value;
      if (sessionId == null ||
          restoreUrls.isEmpty ||
          !playerController.isSessionActive(sessionId)) {
        return;
      }

      unawaited(
        playerController.loadVideo(
          restoreUrls,
          sessionId: sessionId,
          httpHeaders: const {
            'Referer': ApiConstants.referer,
            'User-Agent': ApiConstants.userAgent,
          },
          isQualitySwitch: true,
        ),
      );
    };
  }, const []);
}
