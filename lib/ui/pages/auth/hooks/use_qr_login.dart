import 'dart:async';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/providers/auth/auth_provider.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UseQrLoginResult {
  final String? qrUrl;
  final String status;
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
  final context = useContext();
  final t = Translations.of(context);
  final qrUrl = useState<String?>(null);
  final status = useState<String>(t.auth.qr_status.loading);
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
          status.value = t.auth.qr_status.success;
          timer.cancel();
          ref.read(authProvider.notifier).refreshUser();
        } else if (code == 86101) {
          status.value = t.auth.qr_status.loading;
        } else if (code == 86090) {
          status.value = t.auth.qr_status.scanned;
        } else if (code == 86038) {
          status.value = t.auth.qr_status.expired;
          timer.cancel();
        }
      } catch (_) {}
    });
  }, [t]);

  final refresh = useCallback(() async {
    statusCode.value = 0;
    status.value = t.auth.qr_status.loading;
    qrUrl.value = null;
    timerRef.value?.cancel();

    try {
      final data = await ref.read(authProvider.notifier).getQrCode();
      qrUrl.value = data['url'];
      if (data['qrcode_key'] != null) {
        startPolling(data['qrcode_key']);
      }
    } catch (e) {
      status.value = t.auth.qr_status.error;
    }
  }, [t, startPolling]);

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
