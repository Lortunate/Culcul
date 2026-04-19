import 'dart:async';

import 'package:culcul/shared/errors/app_error.dart';
import 'package:culcul/shared/network/network_concurrency_executor.dart';
import 'package:culcul/shared/network/network_concurrency_profiles.dart';
import 'package:culcul/shared/perf/feature_flow_perf_logger.dart';
import 'package:culcul/features/live/feature_scope.dart';
import 'package:culcul/features/live/domain/entities/live_entities.dart';
import 'package:culcul/features/live/presentation/view_models/live_danmaku_feed_view_model.dart';
import 'package:culcul/features/live/presentation/view_models/live_room_state.dart';
import 'package:culcul/features/live/presentation/view_models/live_socket_service.dart';
import 'package:culcul/features/profile/feature_scope.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/foundation.dart';
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

  @override
  LiveRoomState build(int roomId) {
    ref.onDispose(() {
      _danmakuSubscription?.cancel();
      _socketService.dispose();
    });
    unawaited(Future<void>.microtask(() => _init(roomId)));
    return LiveRoomState(roomId: roomId);
  }
}
