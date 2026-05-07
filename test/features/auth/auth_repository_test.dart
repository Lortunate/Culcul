import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/core/data/network/models/api_response.dart';
import 'package:culcul/core/bootstrap/providers/storage_provider.dart';
import 'package:culcul/features/auth/data/auth_api.dart';
import 'package:culcul/features/auth/data/auth_repository_impl.dart';

void main() {
  group('AuthRepositoryImpl', () {
    late _FakeAuthApi fakeApi;
    late _FakeBox fakeBox;

    setUp(() {
      fakeApi = _FakeAuthApi();
      fakeBox = _FakeBox();
    });

    test('getCachedUser() returns null when cache is empty', () {
      final repo = AuthRepositoryImpl(fakeApi, fakeBox);
      final result = repo.getCachedUser();
      expect(result, isNull);
    });

    test('getCachedUser() returns user when cache has data', () {
      final cachedJson = jsonEncode({
        'mid': '123',
        'uname': 'testuser',
        'face': 'https://example.com/avatar.png',
        'email': 'test@example.com',
        'created_at': '2025-01-01T00:00:00.000',
        'level_info': {
          'current_level': 5,
          'current_exp': 1000,
          'next_exp': 2000,
        },
      });
      fakeBox.data[StorageKeys.authUserCache] = cachedJson;

      final repo = AuthRepositoryImpl(fakeApi, fakeBox);
      final result = repo.getCachedUser();

      expect(result, isNotNull);
      expect(result!.id, '123');
      expect(result.username, 'testuser');
      expect(result.avatarUrl, 'https://example.com/avatar.png');
      expect(result.email, 'test@example.com');
    });

    test('getCurrentUser() returns user from API', () async {
      fakeApi.getCurrentUserFn = () async {
        return ApiResponse<dynamic>(
          code: 0,
          message: 'ok',
          data: {
            'mid': 456,
            'uname': 'apiuser',
            'face': 'https://example.com/api_avatar.png',
            'email': 'api@example.com',
            'isLogin': true,
            'level_info': {
              'current_level': 3,
              'current_exp': 500,
              'next_exp': 1000,
            },
          },
        );
      };

      final repo = AuthRepositoryImpl(fakeApi, fakeBox);
      final result = await repo.getCurrentUser();

      expect(result.isSuccess, isTrue);
      final user = result.dataOrNull;
      expect(user, isNotNull);
      expect(user!.id, '456');
      expect(user.username, 'apiuser');
    });

    test('logout() clears cache', () async {
      final cachedJson = jsonEncode({
        'mid': '789',
        'uname': 'cacheduser',
        'created_at': '2025-01-01T00:00:00.000',
        'level_info': {},
      });
      fakeBox.data[StorageKeys.authUserCache] = cachedJson;

      fakeApi.logoutFn = () async {
        fakeBox.data.remove(StorageKeys.authUserCache);
        return ApiResponse<dynamic>(code: 0, message: 'ok');
      };

      final repo = AuthRepositoryImpl(fakeApi, fakeBox);
      final result = await repo.logout();

      expect(result.isSuccess, isTrue);
      expect(fakeBox.data.containsKey(StorageKeys.authUserCache), isFalse);
      expect(repo.getCachedUser(), isNull);
    });
  });
}

// ---------------------------------------------------------------------------
// Fakes
// ---------------------------------------------------------------------------

class _FakeAuthApi implements AuthApi {
  Future<ApiResponse<dynamic>> Function()? getCurrentUserFn;
  Future<ApiResponse<dynamic>> Function()? logoutFn;

  @override
  Future<ApiResponse<dynamic>> getCurrentUser() async {
    if (getCurrentUserFn != null) return getCurrentUserFn!();
    throw const AuthException('getCurrentUser not configured');
  }

  @override
  Future<ApiResponse<dynamic>> logout() async {
    if (logoutFn != null) return logoutFn!();
    throw const AuthException('logout not configured');
  }

  @override
  Future<ApiResponse<dynamic>> getCaptcha() async => throw UnimplementedError();

  @override
  Future<ApiResponse<dynamic>> getCountryList() async =>
      throw UnimplementedError();

  @override
  Future<ApiResponse<dynamic>> getKey() async => throw UnimplementedError();

  @override
  Future<ApiResponse<dynamic>> getQrCode() async => throw UnimplementedError();

  @override
  Future<ApiResponse<dynamic>> loginWithPassword(
    String username,
    String password,
    int keep,
    String token,
    String challenge,
    String validate,
    String seccode,
    String source,
  ) async =>
      throw UnimplementedError();

  @override
  Future<ApiResponse<dynamic>> loginWithSms(
    int cid,
    String phone,
    String code,
    String source,
    String? captchaKey,
  ) async =>
      throw UnimplementedError();

  @override
  Future<ApiResponse<dynamic>> pollQrCode(String authCode) async =>
      throw UnimplementedError();

  @override
  Future<ApiResponse<dynamic>> sendSms(
    int cid,
    String phone,
    String source,
    String token,
    String challenge,
    String validate,
    String seccode,
  ) async =>
      throw UnimplementedError();
}

class _FakeBox implements Box<dynamic> {
  final Map<dynamic, dynamic> data = {};

  @override
  dynamic get(dynamic key, {dynamic defaultValue}) {
    return data.containsKey(key) ? data[key] : defaultValue;
  }

  @override
  dynamic getAt(int index) => data.values.elementAt(index);

  @override
  dynamic keyAt(int index) => data.keys.elementAt(index);

  @override
  Future<void> put(dynamic key, dynamic value) async {
    data[key] = value;
  }

  @override
  Future<void> putAt(int index, dynamic value) async {}

  @override
  Future<void> putAll(Map<dynamic, dynamic> entries) async {
    data.addAll(entries);
  }

  @override
  Future<int> add(dynamic value) async {
    final key = data.length;
    data[key] = value;
    return key;
  }

  @override
  Future<Iterable<int>> addAll(Iterable<dynamic> values) async {
    final keys = <int>[];
    for (final value in values) {
      keys.add(await add(value));
    }
    return keys;
  }

  @override
  Future<void> delete(dynamic key) async {
    data.remove(key);
  }

  @override
  Future<void> deleteAt(int index) async {}

  @override
  Future<void> deleteAll(Iterable<dynamic> keys) async {
    for (final key in keys) {
      data.remove(key);
    }
  }

  @override
  Future<void> compact() async {}

  @override
  Future<int> clear() async {
    final count = data.length;
    data.clear();
    return count;
  }

  @override
  Future<void> close() async {}

  @override
  Future<void> deleteFromDisk() async {}

  @override
  Future<void> flush() async {}

  @override
  bool containsKey(dynamic key) => data.containsKey(key);

  @override
  int get length => data.length;

  @override
  bool get isEmpty => data.isEmpty;

  @override
  bool get isNotEmpty => data.isNotEmpty;

  @override
  Iterable<dynamic> get keys => data.keys;

  @override
  Iterable<dynamic> get values => data.values;

  @override
  Iterable<dynamic> valuesBetween({dynamic startKey, dynamic endKey}) =>
      data.values;

  @override
  Map<dynamic, dynamic> toMap() => Map.from(data);

  @override
  String get name => 'fake_box';

  @override
  bool get isOpen => true;

  @override
  String? get path => null;

  @override
  bool get lazy => false;

  @override
  Stream<BoxEvent> watch({dynamic key}) => const Stream.empty();
}
