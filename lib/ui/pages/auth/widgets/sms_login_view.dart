import 'dart:async';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/providers/auth/auth_provider.dart';
import 'package:culcul/ui/pages/auth/hooks/use_geetest.dart';
import 'package:culcul/ui/pages/auth/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SmsLoginView extends HookConsumerWidget {
  const SmsLoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final theme = Theme.of(context);
    final phoneController = useTextEditingController();
    final codeController = useTextEditingController();
    final countdown = useState(0);
    final captchaKey = useState<String>('');

    useEffect(() {
      Timer? timer;
      if (countdown.value > 0) {
        timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (countdown.value > 0) {
            countdown.value--;
          } else {
            timer.cancel();
          }
        });
      }
      return () => timer?.cancel();
    }, [countdown.value]);

    final geetest = useGeetest(
      ref: ref,
      onSuccess: (token, challenge, validate, seccode) async {
        final key = await ref
            .read(authProvider.notifier)
            .sendSms(
              86,
              phoneController.text,
              token,
              challenge,
              validate,
              seccode,
            );
        captchaKey.value = key;
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(t.auth.sms_sent)));
          countdown.value = 60;
        }
      },
      onError: (error) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error)));
        }
      },
    );

    Future<void> getCode() async {
      final phone = phoneController.text;
      if (phone.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(t.auth.phone)));
        return;
      }
      geetest.start();
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          const SizedBox(height: 24),
          AuthTextField(
            controller: phoneController,
            hintText: t.auth.phone,
            keyboardType: TextInputType.phone,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            prefix: Padding(
              padding: const EdgeInsets.only(left: 16, right: 8),
              child: Text(
                "+86",
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: AuthTextField(
                  controller: codeController,
                  hintText: t.auth.sms_code,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  prefixIcon: Icons.security_rounded,
                ),
              ),
              const SizedBox(width: 16),
              FilledButton(
                onPressed: countdown.value == 0 ? getCode : null,
                style: FilledButton.styleFrom(
                  minimumSize: const Size(0, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                ),
                child: Text(
                  countdown.value == 0
                      ? t.auth.get_code
                      : "${countdown.value}s",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 48),
          SizedBox(
            width: double.infinity,
            height: 64,
            child: FilledButton(
              onPressed: () {
                if (phoneController.text.isNotEmpty &&
                    codeController.text.isNotEmpty) {
                  if (captchaKey.value.isEmpty) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(t.auth.get_code)));
                    return;
                  }
                  ref
                      .read(authProvider.notifier)
                      .loginWithSms(
                        86,
                        phoneController.text,
                        codeController.text,
                        captchaKey.value,
                      );
                }
              },
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 8,
                shadowColor: theme.colorScheme.primary.withValues(alpha: 0.4),
              ),
              child: ref.watch(authProvider).isLoading
                  ? SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: theme.colorScheme.onPrimary,
                        strokeWidth: 2.5,
                      ),
                    )
                  : Text(
                      t.auth.login,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
