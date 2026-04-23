import 'package:culcul/features/auth/domain/entities/auth_captcha_challenge.dart';
import 'package:culcul/features/auth/domain/entities/auth_qr_code.dart';
import 'package:culcul/features/auth/domain/entities/auth_qr_poll_result.dart';
import 'package:culcul/features/auth/domain/entities/country_code.dart';
import 'package:culcul/features/auth/domain/entities/user_entity.dart';
import 'package:culcul/features/auth/domain/repositories/auth_repository.dart';
import 'package:culcul/features/live/application/live_room_page_commands.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LiveRoomPageCommands', () {
    test('returns requiresLogin without toggling when user is not logged in', () async {
      var toggledRoomId = -1;
      final commands = LiveRoomPageCommands(
        authRepository: _FakeAuthRepository(
          currentUserResult: Failure(AppError.auth('no login')),
        ),
        toggleFollow: (roomId) async {
          toggledRoomId = roomId;
        },
      );

      final result = await commands.handleFollowTap(42);

      expect(result, LiveRoomFollowCommandResult.requiresLogin);
      expect(toggledRoomId, -1);
    });

    test('uses cached auth before hitting network', () async {
      var toggledRoomId = -1;
      final authRepository = _FakeAuthRepository(cachedUser: _user());
      final commands = LiveRoomPageCommands(
        authRepository: authRepository,
        toggleFollow: (roomId) async {
          toggledRoomId = roomId;
        },
      );

      final result = await commands.handleFollowTap(7);

      expect(result, LiveRoomFollowCommandResult.toggled);
      expect(toggledRoomId, 7);
      expect(authRepository.getCurrentUserCallCount, 0);
    });

    test('toggles follow after current user resolves successfully', () async {
      var toggledRoomId = -1;
      final authRepository = _FakeAuthRepository(
        currentUserResult: Success(_user(id: '2')),
      );
      final commands = LiveRoomPageCommands(
        authRepository: authRepository,
        toggleFollow: (roomId) async {
          toggledRoomId = roomId;
        },
      );

      final result = await commands.handleFollowTap(9);

      expect(result, LiveRoomFollowCommandResult.toggled);
      expect(toggledRoomId, 9);
      expect(authRepository.getCurrentUserCallCount, 1);
    });
  });
}

class _FakeAuthRepository implements AuthRepository {
  _FakeAuthRepository({this.cachedUser, Result<UserEntity, AppError>? currentUserResult})
    : _currentUserResult = currentUserResult ?? Success(_user());

  final UserEntity? cachedUser;

  final Result<UserEntity, AppError> _currentUserResult;
  int getCurrentUserCallCount = 0;

  @override
  UserEntity? getCachedUser() => cachedUser;

  @override
  Future<Result<UserEntity, AppError>> getCurrentUser() async {
    getCurrentUserCallCount += 1;
    return _currentUserResult;
  }

  @override
  Future<Result<void, AppError>> checkAndRefreshCookie() async {
    throw UnimplementedError();
  }

  @override
  Future<Result<List<CountryCode>, AppError>> getCountryList() async {
    throw UnimplementedError();
  }

  @override
  Future<Result<AuthCaptchaChallenge, AppError>> getCaptchaChallenge() async {
    throw UnimplementedError();
  }

  @override
  Future<Result<String, AppError>> sendSms(
    int cid,
    String phone,
    String token,
    String challenge,
    String validate,
    String seccode,
  ) async {
    throw UnimplementedError();
  }

  @override
  Future<Result<UserEntity, AppError>> loginWithPassword({
    required String username,
    required String password,
    required String token,
    required String challenge,
    required String validate,
    required String seccode,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<Result<UserEntity, AppError>> loginWithSms(
    int cid,
    String phone,
    String code,
    String captchaKey,
  ) async {
    throw UnimplementedError();
  }

  @override
  Future<Result<AuthQrCode, AppError>> getQrCode() async {
    throw UnimplementedError();
  }

  @override
  Future<Result<AuthQrPollResult, AppError>> pollQrCode(String authCode) async {
    throw UnimplementedError();
  }

  @override
  Future<Result<void, AppError>> logout() async {
    throw UnimplementedError();
  }
}

UserEntity _user({String id = '1'}) {
  return UserEntity(id: id, username: 'tester', createdAt: DateTime(2024, 1, 1));
}
