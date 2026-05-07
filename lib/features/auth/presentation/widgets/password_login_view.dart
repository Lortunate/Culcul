import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:culcul/features/auth/presentation/hooks/use_geetest.dart';
import 'package:culcul/features/auth/presentation/widgets/auth_button.dart';
import 'package:culcul/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PasswordLoginView extends HookConsumerWidget {
  const PasswordLoginView({super.key, required this.onFeedback});

  final void Function(String message, {bool isSuccess}) onFeedback;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final theme = Theme.of(context);
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isObscure = useState(true);

    final geetest = useGeetest(
      ref: ref,
      onSuccess: (token, challenge, validate, seccode) async {
        await ref
            .read(authProvider.notifier)
            .loginWithPassword(
              usernameController.text,
              passwordController.text,
              token,
              challenge,
              validate,
              seccode,
            );
      },
      onError: (error) => onFeedback(error),
    );

    Future<void> login() async {
      final username = usernameController.text;
      final password = passwordController.text;

      if (username.isEmpty || password.isEmpty) {
        onFeedback(t.auth.please_enter_username_password);
        return;
      }
      geetest.start();
    }

    final isLoading = geetest.isLoading || ref.watch(authProvider.select((s) => s.isLoading));

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 12),
          AuthTextField(controller: usernameController, hintText: t.auth.username_hint),
          const SizedBox(height: 16),
          AuthTextField(
            controller: passwordController,
            hintText: t.auth.password,
            obscureText: isObscure.value,
            suffix: GestureDetector(
              onTap: () => isObscure.value = !isObscure.value,
              child: Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Icon(
                  isObscure.value
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                  size: 20,
                  color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                ),
              ),
            ),
          ),
          const SizedBox(height: 48),
          AuthButton(onPressed: login, text: t.auth.login, isLoading: isLoading),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
