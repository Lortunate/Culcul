import 'dart:async';

import 'package:culcul/features/auth/application/auth_controller.dart';
import 'package:culcul/features/auth/data/auth_repository_impl.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

enum _AuthQrLoginStatus { loading, success, scanned, expired, error }

final _authQrLoginControllerProvider =
    NotifierProvider.autoDispose<_AuthQrLoginController, _AuthQrLoginState>(
      _AuthQrLoginController.new,
    );

class _AuthQrLoginState {
  const _AuthQrLoginState({
    this.qrUrl,
    this.status = _AuthQrLoginStatus.loading,
    this.statusCode = 0,
  });

  final String? qrUrl;
  final _AuthQrLoginStatus status;
  final int statusCode;

  _AuthQrLoginState copyWith({
    String? qrUrl,
    _AuthQrLoginStatus? status,
    int? statusCode,
  }) {
    return _AuthQrLoginState(
      qrUrl: qrUrl ?? this.qrUrl,
      status: status ?? this.status,
      statusCode: statusCode ?? this.statusCode,
    );
  }
}

class _AuthQrLoginController extends Notifier<_AuthQrLoginState> {
  Timer? _pollTimer;

  @override
  _AuthQrLoginState build() {
    ref.onDispose(() => _pollTimer?.cancel());
    unawaited(refresh());
    return const _AuthQrLoginState();
  }

  Future<void> refresh() async {
    _pollTimer?.cancel();
    state = const _AuthQrLoginState();

    final result = await ref.read(authRepositoryProvider).getQrCode();
    result.when(
      success: (data) {
        state = _AuthQrLoginState(qrUrl: data.url);
        _pollTimer?.cancel();
        _pollTimer = Timer.periodic(const Duration(seconds: 3), (_) async {
          final result = await ref.read(authRepositoryProvider).pollQrCode(data.key);
          result.when(
            success: (poll) {
              final status = switch (poll.code) {
                0 => _AuthQrLoginStatus.success,
                86101 => _AuthQrLoginStatus.loading,
                86090 => _AuthQrLoginStatus.scanned,
                86038 => _AuthQrLoginStatus.expired,
                _ => _AuthQrLoginStatus.error,
              };

              state = state.copyWith(status: status, statusCode: poll.code);

              if (poll.code == 0) {
                _pollTimer?.cancel();
                unawaited(ref.read(authProvider.notifier).refreshUser());
              } else if (poll.code == 86038) {
                _pollTimer?.cancel();
              }
            },
            failure: (_) {
              state = state.copyWith(status: _AuthQrLoginStatus.error, statusCode: -1);
            },
          );
        });
      },
      failure: (_) {
        state = const _AuthQrLoginState(status: _AuthQrLoginStatus.error, statusCode: -1);
      },
    );
  }
}

class QrLoginView extends ConsumerWidget {
  const QrLoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final qrState = ref.watch(_authQrLoginControllerProvider);
    final qrController = ref.read(_authQrLoginControllerProvider.notifier);

    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 12),
            if (qrState.qrUrl != null)
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(12),
                child: QrImageView(
                  data: qrState.qrUrl!,
                  size: 180,
                  eyeStyle: QrEyeStyle(
                    eyeShape: QrEyeShape.square,
                    color: colorScheme.scrim,
                  ),
                  dataModuleStyle: QrDataModuleStyle(
                    dataModuleShape: QrDataModuleShape.square,
                    color: colorScheme.scrim,
                  ),
                  padding: EdgeInsets.zero,
                ),
              )
            else
              SizedBox(
                height: 180,
                width: 180,
                child: Center(
                  child: CircularProgressIndicator(
                    color: theme.colorScheme.primary,
                    strokeWidth: 3,
                  ),
                ),
              ),
            const SizedBox(height: 20),
            Text(
              switch (qrState.status) {
                _AuthQrLoginStatus.loading => t.auth.qr_status.loading,
                _AuthQrLoginStatus.success => t.auth.qr_status.success,
                _AuthQrLoginStatus.scanned => t.auth.qr_status.scanned,
                _AuthQrLoginStatus.expired => t.auth.qr_status.expired,
                _AuthQrLoginStatus.error => t.auth.qr_status.error,
              },
              textAlign: TextAlign.center,
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            if (qrState.statusCode == 86038 ||
                qrState.status == _AuthQrLoginStatus.error) ...[
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: qrController.refresh,
                icon: const Icon(Icons.refresh_rounded, size: 18),
                label: Text(t.auth.qr_refresh),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  shape: const StadiumBorder(),
                ),
              ),
            ],
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
