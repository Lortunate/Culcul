import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/auth/controllers/auth_controller.dart';
import 'package:culcul/features/auth/presentation/widgets/password_login_view.dart';
import 'package:culcul/features/auth/presentation/widgets/qr_login_view.dart';
import 'package:culcul/features/auth/presentation/widgets/sms_login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginDialog extends HookConsumerWidget {
  const LoginDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Login',
      barrierColor: Colors.black.withValues(alpha: 0.5),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) {
        return const Center(
          child: LoginDialog(),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curve = CurvedAnimation(parent: animation, curve: Curves.easeOutBack);
        return ScaleTransition(
          scale: curve,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final theme = Theme.of(context);
    final selectedTab = useState(0);

    ref.listen(authProvider, (previous, next) {
      if (next.isLoggedIn && !next.isLoading) {
        Navigator.of(context).pop();
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

    final tabs = ["SMS", "Account", "QR"];

    return Material(
      color: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 600),
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 12, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.auth.login,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Welcome back",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded),
                    style: IconButton.styleFrom(
                      backgroundColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                    ),
                  ),
                ],
              ),
            ),

            // Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? theme.colorScheme.primary
                              : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          tabs[index],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? theme.colorScheme.onPrimary
                                : theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),

            // Content
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: KeyedSubtree(
                    key: ValueKey<int>(selectedTab.value),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: 300),
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
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
