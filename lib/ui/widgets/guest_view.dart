import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GuestView extends StatelessWidget {
  final String title;
  final String? message;
  final VoidCallback? onLogin;
  final bool showLoginButton;

  const GuestView({
    super.key,
    required this.title,
    this.message,
    this.onLogin,
    this.showLoginButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 180,
                height: 180,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            colorScheme.primary.withValues(alpha: 0.15),
                            colorScheme.primary.withValues(alpha: 0.0),
                          ],
                          stops: const [0.3, 1.0],
                        ),
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Icon(
                      Icons.lock_person_rounded,
                      size: 56,
                      color: colorScheme.primary,
                    ),
                    Positioned(
                      top: 40,
                      right: 40,
                      child: _DecorativeDot(
                        size: 8,
                        color: colorScheme.secondary.withValues(alpha: 0.8),
                      ),
                    ),
                    Positioned(
                      bottom: 45,
                      left: 45,
                      child: _DecorativeDot(
                        size: 6,
                        color: colorScheme.tertiary.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: colorScheme.onSurface,
                  letterSpacing: -0.5,
                ),
                textAlign: TextAlign.center,
              ),
              if (message != null) ...[
                const SizedBox(height: 12),
                Text(
                  message!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              if (showLoginButton) ...[
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: FilledButton(
                    onPressed: onLogin ?? () => context.push('/login'),
                    style: FilledButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: Text(
                      t.auth.login,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _DecorativeDot extends StatelessWidget {
  final double size;
  final Color color;

  const _DecorativeDot({
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

