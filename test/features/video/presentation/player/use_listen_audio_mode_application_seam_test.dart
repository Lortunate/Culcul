import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/video/application/models/play_url.dart';
import 'package:culcul/features/video/application/video_detail_application_providers.dart';
import 'package:culcul/features/video/application/video_detail_port.dart';
import 'package:culcul/features/video/data/video_repository_impl.dart';
import 'package:culcul/features/video/presentation/player/hooks/use_listen_audio_mode.dart';
import 'package:culcul/features/video/presentation/player/player_view_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  testWidgets('listen audio mode fetches DASH audio through the detail port', (
    tester,
  ) async {
    const sessionId = 'listen-session';
    final port = _FakeVideoDetailPort(_dashAudioPlayUrl());
    final player = _FakePlayerController(sessionId);
    final fallbackPlayUrl = _durlPlayUrl();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          videoDetailPortProvider.overrideWithValue(port),
          playerControllerProvider.overrideWith(() => player),
          videoRepositoryProvider.overrideWith(
            (ref) => throw StateError(
              'videoRepositoryProvider should not be read by listen audio mode',
            ),
          ),
        ],
        child: _ListenAudioHarness(playUrl: fallbackPlayUrl),
      ),
    );

    await _pumpUntil(tester, () => player.loadCalls.isNotEmpty);

    expect(port.playUrlCalls, const [(aid: 100, cid: 200, quality: 80, fnval: 16)]);
    expect(player.loadCalls.single.urls, const ['https://example.test/audio.m4a']);
    expect(player.loadCalls.single.sessionId, sessionId);
    expect(player.loadCalls.single.isQualitySwitch, isTrue);

    await tester.pumpWidget(const SizedBox.shrink());
    await _pumpUntil(tester, () => player.loadCalls.length == 2);

    expect(player.loadCalls.last.urls, const ['https://example.test/video.mp4']);
    expect(player.loadCalls.last.sessionId, sessionId);
    expect(player.loadCalls.last.isQualitySwitch, isTrue);
  });

  testWidgets('listen audio cleanup does not restore into a different session', (
    tester,
  ) async {
    const sessionId = 'listen-session';
    final port = _FakeVideoDetailPort(_dashAudioPlayUrl());
    final player = _FakePlayerController(sessionId);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          videoDetailPortProvider.overrideWithValue(port),
          playerControllerProvider.overrideWith(() => player),
          videoRepositoryProvider.overrideWith(
            (ref) => throw StateError(
              'videoRepositoryProvider should not be read by listen audio mode',
            ),
          ),
        ],
        child: _ListenAudioHarness(playUrl: _durlPlayUrl()),
      ),
    );
    await _pumpUntil(tester, () => player.loadCalls.isNotEmpty);

    player.activateSession('next-session');
    await tester.pump();
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));

    expect(player.loadCalls.length, 1);
  });
}

final class _ListenAudioHarness extends HookConsumerWidget {
  const _ListenAudioHarness({required this.playUrl});

  final PlayUrl playUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useListenAudioMode(ref, (
      aid: 100,
      currentCid: 200,
      selectedQuality: 80,
      playUrl: playUrl,
    ));
    return const SizedBox.shrink();
  }
}

final class _FakePlayerController extends PlayerController {
  _FakePlayerController(this._activeSessionId);

  String _activeSessionId;
  final loadCalls = <({List<String> urls, String sessionId, bool isQualitySwitch})>[];

  @override
  PlayerUiState build() {
    return PlayerUiState(activeSessionId: _activeSessionId);
  }

  @override
  bool isSessionActive(String sessionId) {
    return sessionId == _activeSessionId;
  }

  void activateSession(String sessionId) {
    _activeSessionId = sessionId;
    state = PlayerUiState(activeSessionId: sessionId);
  }

  @override
  Future<void> loadVideo(
    List<String> urls, {
    required String sessionId,
    Map<String, String>? httpHeaders,
    bool isQualitySwitch = false,
    bool autoPlay = true,
    String? title,
    String? artist,
    String? coverUrl,
  }) async {
    loadCalls.add((
      urls: List<String>.of(urls),
      sessionId: sessionId,
      isQualitySwitch: isQualitySwitch,
    ));
  }
}

final class _FakeVideoDetailPort implements VideoDetailPort {
  _FakeVideoDetailPort(this.playUrl);

  final PlayUrl playUrl;
  final playUrlCalls = <({int aid, int cid, int quality, int fnval})>[];

  @override
  Future<Result<PlayUrl, AppError>> fetchVideoPlayUrl({
    required int aid,
    required int cid,
    int quality = 80,
    int fnval = 1,
    int fnver = 0,
    int fourk = 1,
    CancelToken? cancelToken,
  }) async {
    playUrlCalls.add((aid: aid, cid: cid, quality: quality, fnval: fnval));
    return Success(playUrl);
  }

  @override
  Future<Result<void, AppError>> setVideoLike({
    required int aid,
    required bool isLiked,
  }) async {
    throw StateError('setVideoLike should not be called by listen audio mode');
  }

  @override
  Future<Result<void, AppError>> addVideoCoin({
    required int aid,
    int count = 1,
    bool alsoLike = false,
  }) async {
    throw StateError('addVideoCoin should not be called by listen audio mode');
  }

  @override
  Future<Result<void, AppError>> reportVideoProgress({
    required int aid,
    required int cid,
    required int progress,
  }) async {
    throw StateError('reportVideoProgress should not be called by listen audio mode');
  }
}

PlayUrl _dashAudioPlayUrl() {
  return const PlayUrl(
    format: 'dash',
    quality: 80,
    timeLength: 1000,
    acceptFormat: 'dash',
    acceptDescription: ['80'],
    acceptQuality: [80],
    videoCodecId: 7,
    durl: [],
    dash: DashInfo(
      audio: [
        DashStream(
          id: 30280,
          baseUrl: 'https://example.test/audio.m4a',
          bandwidth: 128000,
        ),
      ],
    ),
  );
}

PlayUrl _durlPlayUrl() {
  return const PlayUrl(
    format: 'mp4',
    quality: 80,
    timeLength: 1000,
    acceptFormat: 'mp4',
    acceptDescription: ['80'],
    acceptQuality: [80],
    videoCodecId: 7,
    durl: [
      Durl(order: 1, length: 1000, size: 100, url: 'https://example.test/video.mp4'),
    ],
  );
}

Future<void> _pumpUntil(WidgetTester tester, bool Function() condition) async {
  for (var attempt = 0; attempt < 10; attempt++) {
    if (condition()) {
      return;
    }
    await tester.pump(const Duration(milliseconds: 1));
  }
}
