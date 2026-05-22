import 'dart:async';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/network_concurrency_executor.dart';
import 'package:culcul/core/data/network/network_concurrency_profiles.dart';
import 'package:culcul/core/perf/dev_logger.dart';
import 'package:culcul/core/runtime/runtime_performance_policy_provider.dart';
import 'package:culcul/core/services/relation_service.dart';
import 'package:culcul/features/live/data/live_repository_impl.dart';
import 'package:culcul/features/live/application/models/live_room_detail_model.dart';
import 'package:culcul/features/live/application/models/live_history_danmaku_model.dart';
import 'package:culcul/features/live/presentation/view_models/live_danmaku_feed_view_model.dart';
import 'package:culcul/features/live/presentation/view_models/live_room_state.dart';
import 'package:culcul/features/live/presentation/view_models/live_socket_service.dart';
import 'package:culcul/features/profile/application/profile_session_providers.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_room_view_model.g.dart';
part 'live_room_view_model.actions.dart';
part 'live_room_view_model.fetchers.dart';
part 'live_room_view_model.init.dart';

@riverpod
class LiveRoomController extends _$LiveRoomController
    with
        _LiveRoomControllerFetchersMixin,
        _LiveRoomControllerInitMixin,
        _LiveRoomControllerActionsMixin {
  @override
  final LiveSocketService _socketService = LiveSocketService();
  @override
  final NetworkConcurrencyExecutor _concurrencyExecutor =
      const NetworkConcurrencyExecutor();
  @override
  StreamSubscription<LiveDanmakuItem>? _danmakuSubscription;
  int _loadRequestToken = 0;
  bool _isDisposed = false;

  @override
  LiveRoomState build(int roomId) {
    _isDisposed = false;
    final runtimePolicy = ref.watch(runtimePerformancePolicyProvider);
    _socketService.applyRuntimePolicy(runtimePolicy);
    ref.onDispose(() {
      _isDisposed = true;
      _loadRequestToken++;
      _danmakuSubscription?.cancel();
      _socketService.dispose();
    });
    unawaited(Future<void>.microtask(() => _init(roomId)));
    return LiveRoomState(roomId: roomId);
  }

  @override
  int _beginLiveRoomRequest() => ++_loadRequestToken;

  @override
  bool _isActiveLiveRoomRequest(int requestToken) {
    return ref.mounted && !_isDisposed && requestToken == _loadRequestToken;
  }
}
