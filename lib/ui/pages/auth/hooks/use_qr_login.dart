import 'dart:async';
import 'package:culcul/features/auth/controllers/auth_controller.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum QrLoginStatus {
  loading,
  success,
  scanned,
  expired,
  error,
}

class UseQrLoginResult {
  final String? qrUrl;
  final QrLoginStatus status;
  final int statusCode;
  final Future<void> Function() refresh;

  UseQrLoginResult({
    required this.qrUrl,
    required this.status,
    required this.statusCode,
    required this.refresh,
  });
}

UseQrLoginResult useQrLogin(WidgetRef ref) {
  final qrUrl = useState<String?>(null);
  final status = useState<QrLoginStatus>(QrLoginStatus.loading);
  final statusCode = useState<int>(0);
  final timerRef = useRef<Timer?>(null);

  final startPolling = useCallback((String key) {
    timerRef.value?.cancel();
    timerRef.value = Timer.periodic(const Duration(seconds: 3), (timer) async {
      try {
        final result = await ref.read(authProvider.notifier).pollQrCode(key);
        final code = result['code'] as int;
        statusCode.value = code;

        if (code == 0) {
          status.value = QrLoginStatus.success;
          timer.cancel();
          ref.read(authProvider.notifier).refreshUser();
        } else if (code == 86101) {
          status.value = QrLoginStatus.loading;
        } else if (code == 86090) {
          status.value = QrLoginStatus.scanned;
        } else if (code == 86038) {
          status.value = QrLoginStatus.expired;
          timer.cancel();
        }
      } catch (_) {}
    });
  }, []);

  final refresh = useCallback(() async {
    statusCode.value = 0;
    status.value = QrLoginStatus.loading;
    qrUrl.value = null;
    timerRef.value?.cancel();

    try {
      final data = await ref.read(authProvider.notifier).getQrCode();
      qrUrl.value = data['url'];
      if (data['qrcode_key'] != null) {
        startPolling(data['qrcode_key']);
      }
    } catch (e) {
      status.value = QrLoginStatus.error;
    }
  }, [startPolling]);

  useEffect(() {
    refresh();
    return () => timerRef.value?.cancel();
  }, []);

  return UseQrLoginResult(
    qrUrl: qrUrl.value,
    status: status.value,
    statusCode: statusCode.value,
    refresh: refresh,
  );
}
