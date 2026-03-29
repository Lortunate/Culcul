import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'guest_view/illustration.dart';
part 'guest_view/login_button.dart';
part 'guest_view/message.dart';

class GuestView extends StatelessWidget {
  final String title;
  final String? message;
  final VoidCallback? onLogin;
  final bool showLoginButton;

  const GuestView({
    super.key,
    required this.title,
    this.message,
    this.onLogin,
    this.showLoginButton = true,
  });

  VoidCallback _resolveLoginAction(BuildContext context) {
    return onLogin ?? () => context.push('/login');
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const _GuestIllustration(),
              const SizedBox(height: 24),
              _GuestMessage(title: title, message: message),
              if (showLoginButton) ...[
                const SizedBox(height: 40),
                _GuestLoginButton(
                  label: t.auth.login,
                  onPressed: _resolveLoginAction(context),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
