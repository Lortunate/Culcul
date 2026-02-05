import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/providers/auth/auth_provider.dart';
import 'package:culcul/ui/pages/auth/hooks/use_geetest.dart';
import 'package:culcul/ui/pages/auth/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PasswordLoginView extends HookConsumerWidget {
  const PasswordLoginView({super.key});

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
      onError: (error) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error)));
        }
      },
    );

    Future<void> login() async {
      final username = usernameController.text;
      final password = passwordController.text;

      if (username.isEmpty || password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter username and password')),
        );
        return;
      }
      geetest.start();
    }

    final isLoading = geetest.isLoading || ref.watch(authProvider).isLoading;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          const SizedBox(height: 24),
          AuthTextField(
            controller: usernameController,
            hintText: t.auth.username_hint,
            prefixIcon: Icons.person_rounded,
          ),
          const SizedBox(height: 24),
          AuthTextField(
            controller: passwordController,
            hintText: t.auth.password,
            prefixIcon: Icons.lock_rounded,
            obscureText: isObscure.value,
            suffixIcon: IconButton(
              icon: Icon(
                isObscure.value
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              onPressed: () => isObscure.value = !isObscure.value,
            ),
          ),
          const SizedBox(height: 48),
          SizedBox(
            width: double.infinity,
            height: 64,
            child: FilledButton(
              onPressed: isLoading ? null : login,
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 8,
                shadowColor: theme.colorScheme.primary.withValues(alpha: 0.4),
              ),
              child: isLoading
                  ? SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: theme.colorScheme.onPrimary,
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
