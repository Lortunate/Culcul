import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/auth/controllers/auth_controller.dart';
import 'package:culcul/ui/pages/auth/widgets/auth_background.dart';
import 'package:culcul/ui/pages/auth/widgets/password_login_view.dart';
import 'package:culcul/ui/pages/auth/widgets/qr_login_view.dart';
import 'package:culcul/ui/pages/auth/widgets/sms_login_view.dart';
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!),
            behavior: SnackBarBehavior.floating,
            backgroundColor: theme.colorScheme.error,
            showCloseIcon: true,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.all(16),
          ),
        );
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

    final tabs = ["SMS", "Account", "QR"];

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
                  // Welcome Header with Animation
                  FadeTransition(
                    opacity: headerAnimation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.2),
                        end: Offset.zero,
                      ).animate(headerAnimation),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Brand Logo
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
                            t.auth.login,
                            style: theme.textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: theme.colorScheme.onSurface,
                              letterSpacing: -1,
                              height: 1.1,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Welcome back to Cilixili",
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                              fontSize: 16,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // Custom Tab Selector
                  FadeTransition(
                    opacity: tabsAnimation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.2),
                        end: Offset.zero,
                      ).animate(tabsAnimation),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        clipBehavior: Clip.none,
                        child: Row(
                          children: List.generate(tabs.length, (index) {
                            final isSelected = selectedTab.value == index;
                            return GestureDetector(
                              onTap: () {
                                selectedTab.value = index;
                                HapticFeedback.lightImpact();
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeOut,
                                margin: const EdgeInsets.only(right: 16),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                  color: isSelected 
                                      ? theme.colorScheme.primary
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                    color: isSelected 
                                        ? Colors.transparent 
                                        : theme.colorScheme.outline.withValues(alpha: 0.1),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  tabs[index],
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
                  ),
                  
                  const SizedBox(height: 32),
                  // Content
                  Expanded(
                    child: FadeTransition(
                      opacity: contentAnimation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.1),
                          end: Offset.zero,
                        ).animate(contentAnimation),
                        child: AnimatedSwitcher(
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
                              scale: Tween<double>(begin: 0.95, end: 1.0)
                                  .animate(animation),
                              child: child,
                            ),
                          ),
                        );
                      },
                      child: KeyedSubtree(
                        key: ValueKey<int>(selectedTab.value),
                        child: switch (selectedTab.value) {
                          0 => const SmsLoginView(),
                          1 => const PasswordLoginView(),
                          2 => const QrLoginView(),
                          _ => const SizedBox(),
                        },
                      ),
                    ),
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
