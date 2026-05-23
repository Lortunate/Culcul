import 'dart:async';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/auth/application/auth_qr_login_port.dart';
import 'package:culcul/features/auth/application/auth_qr_login_providers.dart';
import 'package:culcul/features/auth/data/auth_api.dart';
import 'package:culcul/features/auth/data/auth_repository_impl.dart';
import 'package:culcul/features/auth/domain/entities/auth_qr_code.dart';
import 'package:culcul/features/auth/domain/entities/auth_qr_poll_result.dart';
import 'package:culcul/features/auth/presentation/view_models/auth_qr_login_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('QR refresh reads through the auth QR application port', () async {
    final port = _FakeAuthQrLoginPort(
      qrCode: const AuthQrCode(url: 'https://example.test/qr', key: 'qr-key'),
    );
    final repository = await _ThrowingAuthRepository.create();
    final container = ProviderContainer(
      overrides: [
        authQrLoginPortProvider.overrideWithValue(port),
        authRepositoryProvider.overrideWithValue(repository),
      ],
    );
    final subscription = container.listen(
      authQrLoginControllerProvider,
      (_, _) {},
      fireImmediately: true,
    );
    addTearDown(() {
      subscription.close();
      container.dispose();
    });

    await _flushAsync();

    expect(
      container.read(authQrLoginControllerProvider).qrUrl,
      'https://example.test/qr',
    );
    expect(port.qrRequestCount, 1);
  });

  test('QR polling reads through the auth QR application port', () async {
    void Function(Timer)? pollCallback;
    final port = _FakeAuthQrLoginPort(
      qrCode: const AuthQrCode(url: 'https://example.test/qr', key: 'qr-key'),
      pollResult: const AuthQrPollResult(code: 86090, message: 'scanned'),
    );
    final repository = await _ThrowingAuthRepository.create();

    late ProviderSubscription<AuthQrLoginState> subscription;
    final container = runZoned(
      () {
        final container = ProviderContainer(
          overrides: [
            authQrLoginPortProvider.overrideWithValue(port),
            authRepositoryProvider.overrideWithValue(repository),
          ],
        );
        subscription = container.listen(
          authQrLoginControllerProvider,
          (_, _) {},
          fireImmediately: true,
        );
        return container;
      },
      zoneSpecification: ZoneSpecification(
        createPeriodicTimer: (self, parent, zone, duration, callback) {
          expect(duration, const Duration(seconds: 3));
          pollCallback = callback;
          return _FakeTimer();
        },
      ),
    );
    addTearDown(() {
      subscription.close();
      container.dispose();
    });
    await _flushAsync();

    final callback = pollCallback;
    expect(callback, isNotNull);
    callback!(_FakeTimer());
    await Future<void>.delayed(Duration.zero);

    expect(port.pollKeys, const ['qr-key']);
    expect(
      container.read(authQrLoginControllerProvider).status,
      AuthQrLoginStatus.scanned,
    );
  });
}

Future<void> _flushAsync() async {
  await Future<void>.delayed(Duration.zero);
  await Future<void>.delayed(Duration.zero);
}

final class _FakeAuthQrLoginPort implements AuthQrLoginPort {
  _FakeAuthQrLoginPort({
    required this.qrCode,
    this.pollResult = const AuthQrPollResult(code: 86101, message: 'waiting'),
  });

  final AuthQrCode qrCode;
  final AuthQrPollResult pollResult;
  final List<String> pollKeys = [];
  int qrRequestCount = 0;

  @override
  Future<Result<AuthQrCode, AppError>> getQrCode() async {
    qrRequestCount++;
    return Success(qrCode);
  }

  @override
  Future<Result<AuthQrPollResult, AppError>> pollQrCode(String authCode) async {
    pollKeys.add(authCode);
    return Success(pollResult);
  }
}

final class _ThrowingAuthRepository extends AuthRepositoryImpl {
  _ThrowingAuthRepository._(super.api, super.prefs);

  static Future<_ThrowingAuthRepository> create() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    return _ThrowingAuthRepository._(_UnsupportedAuthApi(), prefs);
  }

  @override
  Future<Result<AuthQrCode, AppError>> getQrCode() {
    throw StateError('authRepositoryProvider should not be read by QR login state');
  }

  @override
  Future<Result<AuthQrPollResult, AppError>> pollQrCode(String authCode) {
    throw StateError('authRepositoryProvider should not be read by QR login state');
  }
}

final class _FakeTimer implements Timer {
  @override
  bool get isActive => true;

  @override
  int get tick => 0;

  @override
  void cancel() {}
}

final class _UnsupportedAuthApi implements AuthApi {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}
