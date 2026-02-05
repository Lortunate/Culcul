import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/providers/auth/auth_provider.dart';
import 'package:culcul/ui/pages/auth/widgets/auth_background.dart';
import 'package:culcul/ui/pages/auth/widgets/password_login_view.dart';
import 'package:culcul/ui/pages/auth/widgets/qr_login_view.dart';
import 'package:culcul/ui/pages/auth/widgets/sms_login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final theme = Theme.of(context);
    final tabController = useTabController(initialLength: 3);

    ref.listen(authProvider, (previous, next) {
      if (next.isLoggedIn && !next.isLoading) {
        if (context.canPop()) {
          context.pop();
        }
      }
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!),
            behavior: SnackBarBehavior.floating,
            backgroundColor: theme.colorScheme.error,
            showCloseIcon: true,
          ),
        );
      }
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close_rounded, color: theme.colorScheme.onSurface),
          onPressed: () => context.pop(),
        ),
      ),
      body: AuthBackground(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.primary.withValues(alpha: 0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.live_tv_rounded,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest.withValues(
                    alpha: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TabBar(
                  controller: tabController,
                  indicator: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  labelColor: theme.colorScheme.primary,
                  unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  tabs: [
                    Tab(text: t.auth.sms_login),
                    Tab(text: t.auth.account_login),
                    Tab(text: t.auth.qr_login),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: const [
                    SmsLoginView(),
                    PasswordLoginView(),
                    QrLoginView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
