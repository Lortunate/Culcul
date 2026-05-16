import 'dart:async';

import 'package:culcul/features/auth/application/presentation_contracts/auth_repository_impl.dart';
import 'package:culcul/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_qr_login_view_model.freezed.dart';
part 'auth_qr_login_view_model.g.dart';

enum AuthQrLoginStatus { loading, success, scanned, expired, error }

@freezed
sealed class AuthQrLoginState with _$AuthQrLoginState {
  const factory AuthQrLoginState({
    String? qrUrl,
    @Default(AuthQrLoginStatus.loading) AuthQrLoginStatus status,
    @Default(0) int statusCode,
  }) = _AuthQrLoginState;
}

@riverpod
class AuthQrLoginController extends _$AuthQrLoginController {
  Timer? _pollTimer;

  @override
  AuthQrLoginState build() {
    ref.onDispose(() => _pollTimer?.cancel());
    unawaited(refresh());
    return const AuthQrLoginState();
  }

  Future<void> refresh() async {
    _pollTimer?.cancel();
    state = const AuthQrLoginState(status: AuthQrLoginStatus.loading, statusCode: 0);

    final result = await ref.read(authRepositoryProvider).getQrCode();
    result.when(
      success: (data) {
        state = AuthQrLoginState(
          qrUrl: data.url,
          status: AuthQrLoginStatus.loading,
          statusCode: 0,
        );
        _startPolling(data.key);
      },
      failure: (_) {
        state = const AuthQrLoginState(status: AuthQrLoginStatus.error, statusCode: -1);
      },
    );
  }

  void _startPolling(String key) {
    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(const Duration(seconds: 3), (_) async {
      final result = await ref.read(authRepositoryProvider).pollQrCode(key);
      result.when(
        success: (poll) {
          _updateStatus(poll.code);
        },
        failure: (_) {
          state = state.copyWith(status: AuthQrLoginStatus.error, statusCode: -1);
        },
      );
    });
  }

  void _updateStatus(int code) {
    final status = switch (code) {
      0 => AuthQrLoginStatus.success,
      86101 => AuthQrLoginStatus.loading,
      86090 => AuthQrLoginStatus.scanned,
      86038 => AuthQrLoginStatus.expired,
      _ => AuthQrLoginStatus.error,
    };

    state = state.copyWith(status: status, statusCode: code);

    if (code == 0) {
      _pollTimer?.cancel();
      unawaited(ref.read(authProvider.notifier).refreshUser());
    } else if (code == 86038) {
      _pollTimer?.cancel();
    }
  }
}
