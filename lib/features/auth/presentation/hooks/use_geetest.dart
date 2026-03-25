import 'package:culcul/features/auth/controllers/auth_controller.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gt3_flutter_plugin/gt3_flutter_plugin.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef GeetestSuccessCallback =
    Future<void> Function(
      String token,
      String challenge,
      String validate,
      String seccode,
    );

class UseGeetestResult {
  final Future<void> Function() start;
  final bool isLoading;

  UseGeetestResult({required this.start, required this.isLoading});
}

UseGeetestResult useGeetest({
  required WidgetRef ref,
  required GeetestSuccessCallback onSuccess,
  void Function(String error)? onError,
}) {
  final context = useContext();
  final isLoading = useState(false);

  final start = useCallback(() async {
    isLoading.value = true;
    try {
      final captchaMap = await ref.read(authProvider.notifier).getCaptcha();
      final geetest = captchaMap['geetest'] is Map ? captchaMap['geetest'] : null;
      final gt = geetest != null ? geetest['gt'] : captchaMap['gt'];
      final challenge = geetest != null ? geetest['challenge'] : captchaMap['challenge'];
      final token = captchaMap['token'] ?? '';

      if (gt == null || challenge == null) {
        throw Exception("Invalid Captcha Data");
      }

      final plugin = Gt3FlutterPlugin();
      plugin.addEventHandler(
        onResult: (Map<String, dynamic> message) async {
          if (message['code'] == '1') {
            final captchaResult = message['result'] as Map<dynamic, dynamic>;
            final Map<String, dynamic> result = captchaResult.cast<String, dynamic>();

            try {
              final validate =
                  result['geetest_validate'] as String? ??
                  result['pass_token'] as String? ??
                  '';
              final seccode =
                  result['geetest_seccode'] as String? ??
                  result['gen_time'] as String? ??
                  '';
              final resultChallenge = result['geetest_challenge'] as String? ?? challenge;

              await onSuccess(token, resultChallenge, validate, seccode);
            } catch (e) {
              onError?.call(e.toString());
            } finally {
              if (context.mounted) isLoading.value = false;
            }
          } else {
            if (context.mounted) isLoading.value = false;
          }
        },
        onError: (Map<String, dynamic> error) {
          onError?.call("Captcha Error: ${error['msg'] ?? error}");
          if (context.mounted) isLoading.value = false;
        },
      );
      plugin.startCaptcha(Gt3RegisterData(gt: gt, challenge: challenge, success: true));
    } catch (e) {
      onError?.call(e.toString());
      if (context.mounted) isLoading.value = false;
    }
  }, [ref, onSuccess, onError]);

  return UseGeetestResult(start: start, isLoading: isLoading.value);
}

