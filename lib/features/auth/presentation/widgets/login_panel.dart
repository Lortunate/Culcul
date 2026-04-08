import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:culcul/features/auth/presentation/widgets/password_login_view.dart';
import 'package:culcul/features/auth/presentation/widgets/qr_login_view.dart';
import 'package:culcul/features/auth/presentation/widgets/sms_login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'login_panel.components.dart';

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
            child: _LoginPanelHeader(
              title: t.auth.login,
              subtitle: t.auth.welcome_back,
              onClose: closePanel,
            ),
          ),

          // Tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: _LoginMethodTabs(
              tabs: tabs,
              selectedIndex: selectedTab.value,
              onSelected: (index) {
                selectedTab.value = index;
                HapticFeedback.lightImpact();
              },
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
