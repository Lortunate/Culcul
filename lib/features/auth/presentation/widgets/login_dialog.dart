import 'package:culcul/features/auth/presentation/widgets/login_panel.dart';
import 'package:flutter/material.dart';

class LoginDialog extends StatelessWidget {
  const LoginDialog({super.key});

  static Future<void> show(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Login',
      barrierColor: colorScheme.scrim.withValues(alpha: 0.5),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) {
        return const Center(child: LoginDialog());
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: LoginPanel(
        onClose: () => Navigator.of(context).pop(),
      ),
    );
  }
}
