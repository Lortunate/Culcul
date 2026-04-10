import 'dart:async';

import 'package:culcul/shared/errors/app_error.dart';
import 'package:culcul/shared/network/models/api_response.dart';
import 'package:culcul/shared/network/network_concurrency_executor.dart';
import 'package:culcul/shared/network/network_concurrency_profiles.dart';
import 'package:culcul/features/profile/data/profile_api.dart';
import 'package:culcul/features/profile/data/profile_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProfileRepositoryImpl.getProfileModel', () {
    test('runs profile requests concurrently with bounded max concurrency', () async {
      final api = _FakeProfileApi(
        infoDelay: const Duration(milliseconds: 120),
        relationDelay: const Duration(milliseconds: 120),
        upStatDelay: const Duration(milliseconds: 120),
        navNumDelay: const Duration(milliseconds: 120),
        cardDelay: const Duration(milliseconds: 120),
      );
      final repository = ProfileRepositoryImpl(
        api: api,
        concurrencyExecutor: const NetworkConcurrencyExecutor(),
      );

      final stopwatch = Stopwatch()..start();
      final result = await repository.getProfileModel(1001);
      stopwatch.stop();

      expect(result.isSuccess, isTrue);
      expect(
        api.maxInFlight,
        lessThanOrEqualTo(NetworkConcurrencyProfile.enrich.maxConcurrency),
      );
      expect(stopwatch.elapsedMilliseconds, lessThan(320));
    });

    test('degrades optional failures to default values', () async {
      final api = _FakeProfileApi(
        throwRelation: true,
        throwUpStat: true,
        throwNavNum: true,
        throwCard: true,
      );
      final repository = ProfileRepositoryImpl(
        api: api,
        concurrencyExecutor: const NetworkConcurrencyExecutor(),
      );

      final result = await repository.getProfileModel(1001);
      final data = result.dataOrNull;

      expect(data, isNotNull);
      expect(data!.followersCount, 0);
      expect(data.followingCount, 0);
      expect(data.likesCount, 0);
      expect(data.videosCount, 0);
      expect(data.bannerUrl, 'https://img/top.jpg');
    });

    test('fails when account info request fails', () async {
      final api = _FakeProfileApi(infoCode: -1, infoMessage: 'failed');
      final repository = ProfileRepositoryImpl(
        api: api,
        concurrencyExecutor: const NetworkConcurrencyExecutor(),
      );

      final result = await repository.getProfileModel(1001);

      expect(result.isFailure, isTrue);
      expect(result.errorOrNull, isA<ServerAppError>());
      expect(result.errorOrNull?.message, 'failed');
    });
  });
}

class _FakeProfileApi extends Fake implements ProfileApi {
  _FakeProfileApi({
    this.infoDelay = Duration.zero,
    this.relationDelay = Duration.zero,
    this.upStatDelay = Duration.zero,
    this.navNumDelay = Duration.zero,
    this.cardDelay = Duration.zero,
    this.throwRelation = false,
    this.throwUpStat = false,
    this.throwNavNum = false,
    this.throwCard = false,
    this.infoCode = 0,
    this.infoMessage = 'ok',
  });

  final Duration infoDelay;
  final Duration relationDelay;
  final Duration upStatDelay;
  final Duration navNumDelay;
  final Duration cardDelay;
  final bool throwRelation;
  final bool throwUpStat;
  final bool throwNavNum;
  final bool throwCard;
  final int infoCode;
  final String infoMessage;

  int _inFlight = 0;
  int maxInFlight = 0;

  Future<T> _withDelay<T>(Duration delay, FutureOr<T> Function() builder) async {
    _inFlight++;
    if (_inFlight > maxInFlight) {
      maxInFlight = _inFlight;
    }
    if (delay > Duration.zero) {
      await Future<void>.delayed(delay);
    }
    try {
      return await Future<T>.value(builder());
    } finally {
      _inFlight--;
    }
  }

  @override
  Future<ApiResponse<dynamic>> getAccountInfo(int mid) {
    return _withDelay(infoDelay, () {
      if (infoCode != 0) {
        return ApiResponse<dynamic>(code: infoCode, message: infoMessage, data: const {});
      }
      return ApiResponse<dynamic>(
        code: 0,
        message: 'ok',
        data: <String, dynamic>{
          'name': 'tester',
          'face': 'https://avatar.jpg',
          'sign': 'bio',
          'level': 6,
          'is_followed': true,
          'top_photo': 'https://img/top.jpg',
        },
      );
    });
  }

  @override
  Future<ApiResponse<dynamic>> getRelationStat(int vmid) {
    return _withDelay(relationDelay, () {
      if (throwRelation) {
        throw StateError('relation failed');
      }
      return ApiResponse<dynamic>(
        code: 0,
        message: 'ok',
        data: <String, dynamic>{'follower': 12, 'following': 8},
      );
    });
  }

  @override
  Future<ApiResponse<dynamic>> getUpStat(int mid) {
    return _withDelay(upStatDelay, () {
      if (throwUpStat) {
        throw StateError('upStat failed');
      }
      return ApiResponse<dynamic>(
        code: 0,
        message: 'ok',
        data: <String, dynamic>{'likes': 99},
      );
    });
  }

  @override
  Future<ApiResponse<dynamic>> getNavNum(int mid) {
    return _withDelay(navNumDelay, () {
      if (throwNavNum) {
        throw StateError('navNum failed');
      }
      return ApiResponse<dynamic>(
        code: 0,
        message: 'ok',
        data: <String, dynamic>{'video': 7},
      );
    });
  }

  @override
  Future<ApiResponse<dynamic>> getCard(int mid, {bool photo = true}) {
    return _withDelay(cardDelay, () {
      if (throwCard) {
        throw StateError('card failed');
      }
      return ApiResponse<dynamic>(
        code: 0,
        message: 'ok',
        data: <String, dynamic>{
          'space': <String, dynamic>{'l_img': 'https://img/banner.jpg'},
        },
      );
    });
  }
}
