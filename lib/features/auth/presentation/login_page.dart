import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:culcul/features/auth/presentation/widgets/auth_background.dart';
import 'package:culcul/features/auth/presentation/widgets/password_login_view.dart';
import 'package:culcul/features/auth/presentation/widgets/qr_login_view.dart';
import 'package:culcul/features/auth/presentation/widgets/sms_login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    final selectedTab = useListenableSelector(tabController, () => tabController.index);

    ref.listen(authProvider, (previous, next) {
      if (next.isLoggedIn && !next.isLoading) {
        if (context.canPop()) {
          context.pop();
        }
      }
      if (next.error != null) {
        _showLoginErrorSnackBar(context, theme, next.error!);
      }
    });

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: theme.colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 12, top: 8),
            child: IconButton(
              icon: const Icon(Icons.close_rounded, size: 24),
              onPressed: () => context.pop(),
              style: IconButton.styleFrom(
                backgroundColor: theme.colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.5,
                ),
                foregroundColor: theme.colorScheme.onSurface,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(8),
              ),
            ),
          ),
        ),
        body: AuthBackground(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  _AuthHeader(title: t.auth.login),
                  const SizedBox(height: 32),
                  _LoginMethodTabs(
                    labels: [
                      t.auth.methods.sms,
                      t.auth.methods.account,
                      t.auth.methods.qr,
                    ],
                    controller: tabController,
                  ),
                  const SizedBox(height: 24),
                  Expanded(child: _LoginContentSwitcher(selectedTab: selectedTab)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void _showLoginErrorSnackBar(BuildContext context, ThemeData theme, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      backgroundColor: theme.colorScheme.error,
      showCloseIcon: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(16),
    ),
  );
}

class _AuthHeader extends StatelessWidget {
  const _AuthHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w900,
            color: theme.colorScheme.onSurface,
            letterSpacing: -1.5,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          Translations.of(context).auth.welcome_back,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
            fontSize: 16,
            letterSpacing: 0.1,
          ),
        ),
      ],
    );
  }
}

class _LoginMethodTabs extends StatelessWidget {
  const _LoginMethodTabs({required this.labels, required this.controller});

  final List<String> labels;
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: TabBar(
        controller: controller,
        tabs: labels.map((label) => Tab(text: label)).toList(),
        onTap: (index) => HapticFeedback.lightImpact(),
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: theme.colorScheme.primary,
        unselectedLabelColor: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
        labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.2,
        ),
        indicator: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginContentSwitcher extends StatelessWidget {
  const _LoginContentSwitcher({required this.selectedTab});

  final int selectedTab;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: KeyedSubtree(
        key: ValueKey<int>(selectedTab),
        child: switch (selectedTab) {
          0 => const SmsLoginView(),
          1 => const PasswordLoginView(),
          2 => const QrLoginView(),
          _ => const SizedBox(),
        },
      ),
    );
  }
}
