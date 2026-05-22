import 'dart:async';
import 'dart:collection';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/data/network/network_quality_policy.dart';
import 'package:culcul/core/runtime/runtime_performance_policy.dart';
import 'package:culcul/core/runtime/runtime_performance_policy_provider.dart';
import 'package:culcul/features/live/application/models/live_anchor_info_model.dart';
import 'package:culcul/features/live/application/models/live_danmaku_model.dart';
import 'package:culcul/features/live/application/models/live_danmu_info_model.dart';
import 'package:culcul/features/live/application/models/live_gold_rank_model.dart';
import 'package:culcul/features/live/application/models/live_guard_list_model.dart';
import 'package:culcul/features/live/application/models/live_history_danmaku_model.dart';
import 'package:culcul/features/live/application/models/live_play_url_model.dart';
import 'package:culcul/features/live/application/models/live_room_detail_model.dart';
import 'package:culcul/features/live/data/live_api.dart';
import 'package:culcul/features/live/data/live_repository_impl.dart';
import 'package:culcul/features/live/presentation/view_models/live_room_view_model.dart';
import 'package:culcul/features/profile/application/profile_session_providers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('stale live room init completion does not overwrite refreshed state', () async {
    final repository = _QueuedLiveRepository();
    final firstRoomInfo = Completer<Result<LiveRoomDetailModel, AppError>>();
    final secondRoomInfo = Completer<Result<LiveRoomDetailModel, AppError>>();
    repository.roomInfoResults.addAll([firstRoomInfo, secondRoomInfo]);

    final container = ProviderContainer(
      overrides: [
        liveRepositoryProvider.overrideWithValue(repository),
        userProfileCardProvider(
          '100',
        ).overrideWith((ref) async => const Failure(AppError.data('profile skipped'))),
        runtimePerformancePolicyProvider.overrideWithValue(
          RuntimePerformancePolicy.interactive(NetworkQualityProfile.fast),
        ),
      ],
    );
    addTearDown(container.dispose);

    final provider = liveRoomControllerProvider(1);
    final subscription = container.listen(provider, (_, _) {});
    addTearDown(subscription.close);

    await pumpEventQueue(times: 2);
    expect(repository.roomInfoCalls, 1);

    final refresh = container.read(provider.notifier).refresh();
    await pumpEventQueue(times: 2);
    expect(repository.roomInfoCalls, 2);

    secondRoomInfo.complete(Success(_roomInfo(roomId: 1, title: 'fresh')));
    await refresh;
    expect(container.read(provider).roomInfo?.title, 'fresh');

    firstRoomInfo.complete(Success(_roomInfo(roomId: 1, title: 'stale')));
    await pumpEventQueue(times: 4);

    expect(container.read(provider).roomInfo?.title, 'fresh');
  });

  test('disposed live room ignores stale initial completion', () async {
    final repository = _QueuedLiveRepository();
    final roomInfo = Completer<Result<LiveRoomDetailModel, AppError>>();
    repository.roomInfoResults.add(roomInfo);

    final container = _liveRoomContainer(repository);
    final subscription = container.listen(liveRoomControllerProvider(1), (_, _) {});

    await pumpEventQueue(times: 2);
    expect(repository.roomInfoCalls, 1);

    subscription.close();
    container.dispose();
    roomInfo.complete(Success(_roomInfo(roomId: 1, title: 'after dispose')));
    await pumpEventQueue(times: 4);
  });
}

ProviderContainer _liveRoomContainer(_QueuedLiveRepository repository) {
  return ProviderContainer(
    overrides: [
      liveRepositoryProvider.overrideWithValue(repository),
      userProfileCardProvider(
        '100',
      ).overrideWith((ref) async => const Failure(AppError.data('profile skipped'))),
      runtimePerformancePolicyProvider.overrideWithValue(
        RuntimePerformancePolicy.interactive(NetworkQualityProfile.fast),
      ),
    ],
  );
}

class _QueuedLiveRepository extends LiveRepositoryImpl {
  _QueuedLiveRepository() : super(_UnsupportedLiveApi());

  final Queue<Completer<Result<LiveRoomDetailModel, AppError>>> roomInfoResults =
      Queue<Completer<Result<LiveRoomDetailModel, AppError>>>();
  int roomInfoCalls = 0;

  @override
  Future<Result<LiveRoomDetailModel, AppError>> getRoomInfo(int roomId) {
    roomInfoCalls++;
    return roomInfoResults.removeFirst().future;
  }

  @override
  Future<Result<LivePlayUrlModel, AppError>> getPlayUrl({
    required int roomId,
    int? qn,
  }) async {
    return const Success(
      LivePlayUrlModel(
        currentQuality: 80,
        acceptQuality: ['80'],
        currentQn: 80,
        qualityDescription: [LiveQualityDescription(qn: 80, desc: 'HD')],
        durl: [],
      ),
    );
  }

  @override
  Future<Result<LiveDanmakuConfigModel, AppError>> getDanmakuConfig(int roomId) async {
    return const Success(LiveDanmakuConfigModel(group: [], mode: []));
  }

  @override
  Future<Result<LiveHistoryDanmakuModel, AppError>> getHistoryDanmaku(int roomId) async {
    return const Failure(AppError.data('history skipped'));
  }

  @override
  Future<Result<LiveDanmuInfoModel, AppError>> getDanmuInfo(int roomId) async {
    return const Failure(AppError.data('danmaku skipped'));
  }

  @override
  Future<Result<LiveAnchorInfoModel, AppError>> getAnchorInfo(int uid) async {
    return const Failure(AppError.data('anchor skipped'));
  }

  @override
  Future<Result<LiveGoldRankModel, AppError>> getOnlineGoldRank({
    required int ruid,
    required int roomId,
    int page = 1,
  }) async {
    return const Failure(AppError.data('rank skipped'));
  }

  @override
  Future<Result<LiveGuardListModel, AppError>> getGuardList({
    required int ruid,
    required int roomId,
    int page = 1,
  }) async {
    return const Failure(AppError.data('guard skipped'));
  }
}

class _UnsupportedLiveApi implements LiveApi {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

LiveRoomDetailModel _roomInfo({required int roomId, required String title}) {
  return LiveRoomDetailModel(
    uid: 100,
    roomId: roomId,
    shortId: 0,
    attention: 0,
    online: 0,
    isPortrait: false,
    description: '',
    liveStatus: 1,
    areaId: 1,
    parentAreaId: 1,
    parentAreaName: 'parent',
    oldAreaId: 0,
    background: '',
    title: title,
    userCover: '',
    keyframe: '',
    isStrictRoom: false,
    liveTime: '',
    tags: '',
    isAnchor: 0,
    roomSilentType: '',
    roomSilentLevel: 0,
    roomSilentSecond: 0,
    areaName: 'area',
    pendants: '',
    areaPendants: '',
    hotWords: const [],
    hotWordsStatus: 0,
    verify: '',
    newPendants: const {},
    upSession: '',
    pkStatus: 0,
    pkId: 0,
    battleId: 0,
    allowChangeAreaTime: 0,
    allowUploadCoverTime: 0,
    studioInfo: const {},
  );
}
