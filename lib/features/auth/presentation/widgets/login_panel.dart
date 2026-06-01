import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/auth/application/auth_controller.dart';
import 'package:culcul/features/auth/presentation/widgets/password_login_view.dart';
import 'package:culcul/features/auth/presentation/widgets/qr_login_view.dart';
import 'package:culcul/features/auth/presentation/widgets/sms_login_view.dart';
import 'package:culcul/ui/theme/culcul_tokens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> showLoginDialog(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Login',
    barrierColor: colorScheme.scrim.withValues(alpha: 0.5),
    pageBuilder: (context, animation, secondaryAnimation) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: LoginPanel(onClose: () => Navigator.of(context).pop()),
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}

class LoginPanel extends HookConsumerWidget {
  const LoginPanel({super.key, this.onClose});

  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final theme = Theme.of(context);
    final selectedTab = useState(0);
    final feedback = useState<({String message, bool isSuccess})?>(null);
    final feedbackVersion = useState(0);
    final visibleFeedback = feedback.value;
    final feedbackBackgroundColor = visibleFeedback == null
        ? null
        : visibleFeedback.isSuccess
        ? theme.colorScheme.primaryContainer.withValues(alpha: 0.9)
        : theme.colorScheme.errorContainer.withValues(alpha: 0.9);
    final feedbackForegroundColor = visibleFeedback == null
        ? null
        : visibleFeedback.isSuccess
        ? theme.colorScheme.onPrimaryContainer
        : theme.colorScheme.onErrorContainer;

    void closePanel() {
      if (onClose != null) {
        onClose!();
      } else {
        Navigator.of(context).pop();
      }
    }

    void showFeedback(String message, {bool isSuccess = false}) {
      feedback.value = (message: message, isSuccess: isSuccess);
      feedbackVersion.value++;
      final currentVersion = feedbackVersion.value;
      Future<void>.delayed(const Duration(seconds: 2), () {
        if (!context.mounted || feedbackVersion.value != currentVersion) {
          return;
        }
        feedback.value = null;
      });
    }

    ref.listen(authProvider, (previous, next) {
      if (next.isLoggedIn && !next.isLoading) {
        closePanel();
      }
      if (next.error != null) {
        showFeedback(next.error!);
        ref.read(authProvider.notifier).clearError();
      }
    });

    final tabs = [t.auth.methods.sms, t.auth.methods.account, t.auth.methods.qr];

    return Container(
      constraints: const BoxConstraints(maxWidth: 400, maxHeight: 600),
      margin: const EdgeInsets.symmetric(
        horizontal: CulculSpacing.lg,
        vertical: CulculSpacing.xl + CulculSpacing.md,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.all(CulculRadius.radiusXl),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              CulculSpacing.lg,
              CulculSpacing.lg,
              CulculSpacing.sm,
              CulculSpacing.xs,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        t.auth.welcome_back,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: closePanel,
                  icon: const Icon(Icons.close_rounded),
                  style: IconButton.styleFrom(
                    backgroundColor: theme.colorScheme.surfaceContainerHighest.withValues(
                      alpha: 0.3,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: CulculSpacing.lg,
              vertical: CulculSpacing.md,
            ),
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
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? theme.colorScheme.primary
                            : theme.colorScheme.surfaceContainerHighest.withValues(
                                alpha: 0.3,
                              ),
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

          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: CulculSpacing.lg),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedSwitcher(
                    duration: CulculMotion.fast,
                    switchInCurve: Curves.easeOutCubic,
                    switchOutCurve: Curves.easeInCubic,
                    child: visibleFeedback == null
                        ? const SizedBox.shrink()
                        : Padding(
                            key: ValueKey(
                              '${visibleFeedback.message}-${visibleFeedback.isSuccess}',
                            ),
                            padding: const EdgeInsets.only(bottom: CulculSpacing.sm),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: feedbackBackgroundColor,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: visibleFeedback.isSuccess
                                      ? theme.colorScheme.primary.withValues(alpha: 0.2)
                                      : theme.colorScheme.error.withValues(alpha: 0.25),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    visibleFeedback.isSuccess
                                        ? Icons.check_circle_rounded
                                        : Icons.error_outline_rounded,
                                    size: 18,
                                    color: feedbackForegroundColor,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      visibleFeedback.message,
                                      style: theme.textTheme.bodyMedium?.copyWith(
                                        color: feedbackForegroundColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                  IndexedStack(
                    index: selectedTab.value,
                    children: [
                      SmsLoginView(onFeedback: showFeedback),
                      PasswordLoginView(onFeedback: showFeedback),
                      const QrLoginView(),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: CulculSpacing.lg),
        ],
      ),
    );
  }
}
