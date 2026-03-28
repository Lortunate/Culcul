import 'dart:async';
import 'package:culcul/domain/entities/country_code.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/auth/controllers/auth_controller.dart';
import 'package:culcul/features/auth/presentation/country_code_selection_page.dart';
import 'package:culcul/features/auth/presentation/hooks/use_geetest.dart';
import 'package:culcul/features/auth/presentation/widgets/auth_button.dart';
import 'package:culcul/features/auth/presentation/widgets/auth_text_field.dart';
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
    final selectedCountry = useState<CountryCode>(defaultCountryCodes.first);

    void showAuthSnackBar(String message) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.all(16),
            backgroundColor: theme.colorScheme.inverseSurface,
            action: SnackBarAction(
              label: t.auth.ok,
              textColor: theme.colorScheme.onInverseSurface,
              onPressed: () {},
            ),
          ),
        );
      }
    }

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
              selectedCountry.value.id,
              phoneController.text,
              token,
              challenge,
              validate,
              seccode,
            );
        captchaKey.value = key;
        showAuthSnackBar(t.auth.sms_sent);
        countdown.value = 60;
      },
      onError: (error) => showAuthSnackBar(error),
    );

    Future<void> getCode() async {
      final phone = phoneController.text;
      if (phone.isEmpty) {
        showAuthSnackBar(t.auth.phone);
        return;
      }
      geetest.start();
    }

    void onLogin() {
      if (phoneController.text.isNotEmpty && codeController.text.isNotEmpty) {
        if (captchaKey.value.isEmpty) {
          showAuthSnackBar(t.auth.get_code);
          return;
        }
        ref
            .read(authProvider.notifier)
            .loginWithSms(
              selectedCountry.value.id,
              phoneController.text,
              codeController.text,
              captchaKey.value,
            );
      }
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 12),
          AuthTextField(
            controller: phoneController,
            hintText: t.auth.phone,
            keyboardType: TextInputType.phone,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            leading: GestureDetector(
              onTap: () async {
                final result = await Navigator.of(context).push<CountryCode>(
                  MaterialPageRoute(
                    builder: (context) => const CountryCodeSelectionPage(),
                  ),
                );
                if (result != null) {
                  selectedCountry.value = result;
                }
              },
              child: Container(
                width: 65,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(right: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      selectedCountry.value.code,
                      style: TextStyle(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 1,
                      height: 14,
                      color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          AuthTextField(
            controller: codeController,
            hintText: t.auth.sms_code,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            suffix: TextButton(
              onPressed: countdown.value == 0 ? getCode : null,
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                foregroundColor: theme.colorScheme.primary,
                disabledForegroundColor: theme.colorScheme.onSurface.withValues(
                  alpha: 0.38,
                ),
              ),
              child: Text(
                countdown.value == 0 ? t.auth.get_code : "${countdown.value}s",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: countdown.value == 0
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                ),
              ),
            ),
          ),
          const SizedBox(height: 48),
          AuthButton(
            onPressed: onLogin,
            text: t.auth.login,
            isLoading: ref.watch(authProvider).isLoading,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
