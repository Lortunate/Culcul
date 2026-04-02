import 'package:culcul/features/auth/presentation/widgets/auth_background.dart';
import 'package:culcul/features/auth/presentation/widgets/login_panel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: theme.colorScheme.surface,
        body: AuthBackground(
          child: SafeArea(
            child: Center(
              child: LoginPanel(
                onClose: () {
                  if (context.canPop()) {
                    context.pop();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
