import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:culcul/features/auth/presentation/widgets/password_login_view.dart';
import 'package:culcul/features/auth/presentation/widgets/qr_login_view.dart';
import 'package:culcul/features/auth/presentation/widgets/sms_login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
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
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 12, 8),
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

          // Content
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 180),
                    switchInCurve: Curves.easeOutCubic,
                    switchOutCurve: Curves.easeInCubic,
                    child: feedback.value == null
                        ? const SizedBox.shrink()
                        : Padding(
                            key: ValueKey(
                              '${feedback.value!.message}-${feedback.value!.isSuccess}',
                            ),
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _AuthInlineFeedback(
                              message: feedback.value!.message,
                              isSuccess: feedback.value!.isSuccess,
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
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _AuthInlineFeedback extends StatelessWidget {
  const _AuthInlineFeedback({required this.message, required this.isSuccess});

  final String message;
  final bool isSuccess;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final backgroundColor = isSuccess
        ? colorScheme.primaryContainer.withValues(alpha: 0.9)
        : colorScheme.errorContainer.withValues(alpha: 0.9);
    final foregroundColor = isSuccess
        ? colorScheme.onPrimaryContainer
        : colorScheme.onErrorContainer;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isSuccess
              ? colorScheme.primary.withValues(alpha: 0.2)
              : colorScheme.error.withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        children: [
          Icon(
            isSuccess ? Icons.check_circle_rounded : Icons.error_outline_rounded,
            size: 18,
            color: foregroundColor,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: foregroundColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
