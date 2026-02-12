import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/providers/auth/auth_provider.dart';
import 'package:culcul/ui/pages/auth/hooks/use_geetest.dart';
import 'package:culcul/ui/pages/auth/widgets/auth_button.dart';
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

    // Animation Controller for staggered entry
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 600),
    );

    useEffect(() {
      animationController.forward();
      return null;
    }, []);

    Animation<Offset> getSlideAnimation(double start, double end) {
      return Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Interval(start, end, curve: Curves.easeOutCubic),
        ),
      );
    }

    Animation<double> getFadeAnimation(double start, double end) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Interval(start, end, curve: Curves.easeOut),
        ),
      );
    }

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
              label: 'OK',
              textColor: theme.colorScheme.onInverseSurface,
              onPressed: () {},
            ),
          ),
        );
      }
    }

    final geetest = useGeetest(
      ref: ref,
      onSuccess: (token, challenge, validate, seccode) async {
        await ref.read(authProvider.notifier).loginWithPassword(
              usernameController.text,
              passwordController.text,
              token,
              challenge,
              validate,
              seccode,
            );
      },
      onError: (error) => showAuthSnackBar(error),
    );

    Future<void> login() async {
      final username = usernameController.text;
      final password = passwordController.text;

      if (username.isEmpty || password.isEmpty) {
        showAuthSnackBar('Please enter username and password');
        return;
      }
      geetest.start();
    }

    final isLoading = geetest.isLoading || ref.watch(authProvider).isLoading;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        children: [
          const SizedBox(height: 24),
          FadeTransition(
            opacity: getFadeAnimation(0.0, 0.6),
            child: SlideTransition(
              position: getSlideAnimation(0.0, 0.6),
              child: AuthTextField(
                controller: usernameController,
                hintText: t.auth.username_hint,
              ),
            ),
          ),
          const SizedBox(height: 20),
          FadeTransition(
            opacity: getFadeAnimation(0.2, 0.8),
            child: SlideTransition(
              position: getSlideAnimation(0.2, 0.8),
              child: AuthTextField(
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
            ),
          ),
          const SizedBox(height: 56),
          FadeTransition(
            opacity: getFadeAnimation(0.4, 1.0),
            child: SlideTransition(
              position: getSlideAnimation(0.4, 1.0),
              child: AuthButton(
                onPressed: login,
                text: t.auth.login,
                isLoading: isLoading,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
