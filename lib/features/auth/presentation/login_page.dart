import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/auth/controllers/auth_controller.dart';
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
    final selectedTab = useState(0);

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

    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 1200),
    );

    useEffect(() {
      animationController.forward();
      return null;
    }, []);

    final headerAnimation = CurvedAnimation(
      parent: animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOutQuart),
    );

    final tabsAnimation = CurvedAnimation(
      parent: animationController,
      curve: const Interval(0.2, 0.8, curve: Curves.easeOutQuart),
    );

    final contentAnimation = CurvedAnimation(
      parent: animationController,
      curve: const Interval(0.4, 1.0, curve: Curves.easeOutQuart),
    );

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
                backgroundColor: theme.colorScheme.surface.withValues(alpha: 0.3),
                foregroundColor: theme.colorScheme.onSurface,
                hoverColor: theme.colorScheme.surface.withValues(alpha: 0.5),
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
                  const SizedBox(height: 16),
                  _AuthHeader(animation: headerAnimation, title: t.auth.login),
                  const SizedBox(height: 40),

                  _LoginMethodTabs(
                    animation: tabsAnimation,
                    labels: [
                      t.auth.methods.sms,
                      t.auth.methods.account,
                      t.auth.methods.qr,
                    ],
                    selectedIndex: selectedTab.value,
                    onSelected: (index) {
                      selectedTab.value = index;
                      HapticFeedback.lightImpact();
                    },
                  ),

                  const SizedBox(height: 32),
                  Expanded(
                    child: FadeTransition(
                      opacity: contentAnimation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.1),
                          end: Offset.zero,
                        ).animate(contentAnimation),
                        child: _LoginContentSwitcher(selectedTab: selectedTab.value),
                      ),
                    ),
                  ),
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
  const _AuthHeader({required this.animation, required this.title});

  final Animation<double> animation;
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.2),
          end: Offset.zero,
        ).animate(animation),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 52,
              height: 52,
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.primary.withValues(alpha: 0.4),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Icon(
                Icons.play_arrow_rounded,
                size: 32,
                color: theme.colorScheme.onPrimary,
              ),
            ),
            Text(
              title,
              style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: theme.colorScheme.onSurface,
                letterSpacing: -1,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Welcome back to Cilixili',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontSize: 16,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginMethodTabs extends StatelessWidget {
  const _LoginMethodTabs({
    required this.animation,
    required this.labels,
    required this.selectedIndex,
    required this.onSelected,
  });

  final Animation<double> animation;
  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.2),
          end: Offset.zero,
        ).animate(animation),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          child: Row(
            children: List.generate(labels.length, (index) {
              final isSelected = selectedIndex == index;
              return GestureDetector(
                onTap: () => onSelected(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  margin: const EdgeInsets.only(right: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? theme.colorScheme.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: isSelected
                          ? Colors.transparent
                          : theme.colorScheme.outline.withValues(alpha: 0.1),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    labels[index],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? theme.colorScheme.onPrimary
                          : theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              );
            }),
          ),
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
      duration: const Duration(milliseconds: 500),
      switchInCurve: Curves.easeOutQuart,
      switchOutCurve: Curves.easeInQuart,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.05, 0),
              end: Offset.zero,
            ).animate(animation),
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.95, end: 1.0).animate(animation),
              child: child,
            ),
          ),
        );
      },
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
