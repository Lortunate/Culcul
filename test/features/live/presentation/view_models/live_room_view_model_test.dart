import 'package:culcul/core/contracts/user_card_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/shared/network/request_cancel_token.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/live/feature_scope.dart';
import 'package:culcul/features/live/domain/entities/live_entities.dart';
import 'package:culcul/features/live/domain/repositories/live_repository.dart';
import 'package:culcul/features/live/presentation/view_models/live_room_state.dart';
import 'package:culcul/features/live/presentation/view_models/live_room_view_model.dart';
import 'package:culcul/features/profile/domain/entities/profile_user.dart';
import 'package:culcul/features/profile/domain/entities/profile_video.dart';
import 'package:culcul/features/profile/domain/repositories/profile_repository.dart';
import 'package:culcul/features/profile/feature_scope.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test(
    'LiveRoomController finishes loading after critical group before optional',
    () async {
      final optionalCounter = _InFlightCounter();
      final liveRepository = _FakeLiveRepository(optionalCounter: optionalCounter);
      final profileRepository = _FakeProfileRepository(optionalCounter: optionalCounter);
      final container = ProviderContainer(
        overrides: [
          liveRepositoryProvider.overrideWithValue(liveRepository),
          profileRepositoryProvider.overrideWithValue(profileRepository),
        ],
      );
      addTearDown(container.dispose);

      final provider = liveRoomControllerProvider(1);
      final keepAlive = container.listen<LiveRoomState>(
        provider,
        (_, _) {},
        fireImmediately: true,
      );
      addTearDown(keepAlive.close);
      final start = Stopwatch()..start();
      final firstState = container.read(provider);
      expect(firstState.isLoading, isTrue);

      final loadedState = await _waitForState(
        container: container,
        provider: provider,
        predicate: (state) =>
            !state.isLoading && state.playUrl != null && state.danmakuConfig != null,
      );
      start.stop();

      expect(start.elapsedMilliseconds, lessThan(180));
      expect(loadedState.roomInfo, isNotNull);
      expect(loadedState.anchorInfo, isNull);

      await Future<void>.delayed(const Duration(milliseconds: 920));
      final finalState = container.read(provider);
      expect(finalState.anchorInfo, isNotNull);
      expect(finalState.liveAnchorInfo, isNotNull);
      expect(finalState.goldRank, isNotNull);
      expect(finalState.guardList, isNotNull);
      expect(optionalCounter.maxInFlight, lessThanOrEqualTo(2));
    },
  );
}

Future<LiveRoomState> _waitForState({
  required ProviderContainer container,
  required dynamic provider,
  required bool Function(LiveRoomState state) predicate,
  Duration timeout = const Duration(seconds: 2),
}) async {
  final end = DateTime.now().add(timeout);
  while (DateTime.now().isBefore(end)) {
    final state = container.read(provider) as LiveRoomState;
    if (predicate(state)) {
      return state;
    }
    await Future<void>.delayed(const Duration(milliseconds: 10));
  }
  throw StateError('Timeout waiting for live room state');
}

class _InFlightCounter {
  int inFlight = 0;
  int maxInFlight = 0;
}

class _FakeLiveRepository extends Fake implements LiveRepository {
  _FakeLiveRepository({required this.optionalCounter});

  final _InFlightCounter optionalCounter;

  Future<T> _runOptional<T>(Future<T> Function() action) async {
    optionalCounter.inFlight++;
    if (optionalCounter.inFlight > optionalCounter.maxInFlight) {
      optionalCounter.maxInFlight = optionalCounter.inFlight;
    }
    try {
      await Future<void>.delayed(const Duration(milliseconds: 220));
      return await action();
    } finally {
      optionalCounter.inFlight--;
    }
  }

  @override
  Future<Result<LiveRoomDetailModel, AppError>> getRoomInfo(int roomId) async {
    await Future<void>.delayed(const Duration(milliseconds: 20));
    return Success(_roomDetail(roomId: roomId));
  }

  @override
  Future<Result<LivePlayUrlModel, AppError>> getPlayUrl({
    required int roomId,
    int? qn,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 40));
    return Success(_playUrl());
  }

  @override
  Future<Result<LiveDanmakuConfigModel, AppError>> getDanmakuConfig(int roomId) async {
    await Future<void>.delayed(const Duration(milliseconds: 40));
    return const Success(
      LiveDanmakuConfigModel(group: <LiveDanmakuGroup>[], mode: <LiveDanmakuMode>[]),
    );
  }

  @override
  Future<Result<LiveHistoryDanmakuModel, AppError>> getHistoryDanmaku(int roomId) async {
    return _runOptional(
      () async => const Success(
        LiveHistoryDanmakuModel(admin: <LiveDanmakuItem>[], room: <LiveDanmakuItem>[]),
      ),
    );
  }

  @override
  Future<Result<LiveDanmuInfoModel, AppError>> getDanmuInfo(int roomId) async {
    return _runOptional(() async => Failure(AppError.data('danmu unavailable')));
  }

  @override
  Future<Result<List<LiveRoomSummary>, AppError>> getRecommendList({int page = 1}) async {
    return const Success(<LiveRoomSummary>[]);
  }

  @override
  Future<Result<LiveAnchorInfoModel, AppError>> getAnchorInfo(int uid) async {
    return _runOptional(() async => Success(_liveAnchorInfo(uid)));
  }

  @override
  Future<Result<LiveGoldRankModel, AppError>> getOnlineGoldRank({
    required int ruid,
    required int roomId,
    int page = 1,
  }) async {
    return _runOptional(
      () async => const Success(LiveGoldRankModel(onlineNum: 1, list: <LiveRankItem>[])),
    );
  }

  @override
  Future<Result<LiveGuardListModel, AppError>> getGuardList({
    required int ruid,
    required int roomId,
    int page = 1,
  }) async {
    return _runOptional(
      () async => const Success(
        LiveGuardListModel(
          info: LiveGuardInfo(num: 0, page: 1, now: 0),
          top3: <LiveGuardItem>[],
          list: <LiveGuardItem>[],
        ),
      ),
    );
  }

  @override
  Future<Result<void, AppError>> sendDanmaku({
    required int roomId,
    required String msg,
  }) async {
    return const Success(null);
  }
}

class _FakeProfileRepository extends Fake implements ProfileRepository {
  _FakeProfileRepository({required this.optionalCounter});

  final _InFlightCounter optionalCounter;

  @override
  Future<Result<UserCardModel, AppError>> getUserCard(int mid) async {
    optionalCounter.inFlight++;
    if (optionalCounter.inFlight > optionalCounter.maxInFlight) {
      optionalCounter.maxInFlight = optionalCounter.inFlight;
    }
    try {
      await Future<void>.delayed(const Duration(milliseconds: 220));
      return const Success(
        UserCardModel(mid: '1', name: 'anchor', face: 'https://avatar.png'),
      );
    } finally {
      optionalCounter.inFlight--;
    }
  }

  @override
  Future<Result<ProfileUser, AppError>> getProfile(int userId) async {
    throw UnimplementedError();
  }

  @override
  Future<Result<List<ProfileVideo>, AppError>> getSpaceVideos({
    required int mid,
    int page = 1,
    String order = 'pubdate',
    bool forceRefresh = false,
    RequestCancelToken? cancelToken,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<Result<ProfileVideo?, AppError>> getStickyVideo(int vmid) async {
    throw UnimplementedError();
  }

  @override
  Future<Result<List<ProfileVideo>, AppError>> getMasterpiece(int vmid) async {
    throw UnimplementedError();
  }

  @override
  Future<Result<void, AppError>> modifyRelation({
    required int mid,
    required bool isFollow,
  }) async {
    return const Success(null);
  }
}

LiveRoomDetailModel _roomDetail({required int roomId}) {
  return LiveRoomDetailModel(
    uid: 2,
    roomId: roomId,
    shortId: roomId,
    attention: 1,
    online: 100,
    isPortrait: false,
    description: '',
    liveStatus: 1,
    areaId: 1,
    parentAreaId: 1,
    parentAreaName: 'parent',
    oldAreaId: 1,
    background: '',
    title: 'room',
    userCover: '',
    keyframe: '',
    isStrictRoom: false,
    liveTime: '',
    tags: '',
    isAnchor: 1,
    roomSilentType: '',
    roomSilentLevel: 0,
    roomSilentSecond: 0,
    areaName: 'area',
    pendants: '',
    areaPendants: '',
    hotWords: const <String>[],
    hotWordsStatus: 0,
    verify: '',
    newPendants: const <String, dynamic>{},
    upSession: '',
    pkStatus: 0,
    pkId: 0,
    battleId: 0,
    allowChangeAreaTime: 0,
    allowUploadCoverTime: 0,
    studioInfo: const <String, dynamic>{},
  );
}

LivePlayUrlModel _playUrl() {
  return const LivePlayUrlModel(
    currentQuality: 4,
    acceptQuality: <String>['4'],
    currentQn: 4,
    qualityDescription: <LiveQualityDescription>[
      LiveQualityDescription(qn: 4, desc: 'HD'),
    ],
    durl: <LiveStreamUrl>[
      LiveStreamUrl(
        url: 'https://live.flv',
        length: 0,
        order: 1,
        streamType: 0,
        p2pType: 0,
      ),
    ],
  );
}

LiveAnchorInfoModel _liveAnchorInfo(int uid) {
  return LiveAnchorInfoModel(
    info: LiveAnchorInfo(
      uid: uid,
      uname: 'anchor',
      face: 'https://avatar.png',
      officialVerify: const LiveAnchorVerify(type: 0, desc: ''),
      gender: 0,
    ),
    exp: const LiveAnchorExp(
      masterLevel: LiveMasterLevel(level: 1, color: 0, current: <int>[0], next: <int>[1]),
    ),
    followerNum: 10,
    roomId: 1,
    medalName: '',
    gloryCount: 0,
    pendant: '',
  );
}
