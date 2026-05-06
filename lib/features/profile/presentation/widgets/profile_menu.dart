import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:culcul/ui/widgets/app_clickable.dart';
import 'package:flutter/material.dart';
import 'package:culcul/ui/responsive/app_breakpoints.dart';
import 'package:culcul/ui/responsive/app_responsive.dart';
import 'package:culcul/ui/responsive/responsive_container.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileMenu extends ConsumerWidget {
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: context.pageHorizontalPadding),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          ResponsiveContentContainer(
            maxWidth: AppBreakpoints.pageMaxWidth,
            horizontalPadding: 0,
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              clipBehavior: Clip.antiAlias,
              child: _MenuItem(
                icon: Icons.logout_rounded,
                label: t.auth.logout,
                textColor: colorScheme.error,
                iconColor: colorScheme.error,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(t.auth.logout),
                      content: Text(t.profile.logout_confirm),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(t.common.cancel),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            ref.read(authProvider.notifier).logout();
                          },
                          child: Text(
                            t.auth.logout,
                            style: TextStyle(color: colorScheme.error),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: context.isDesktopLayout ? 40 : 32),
        ]),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? textColor;
  final Color? iconColor;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.textColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AppClickable(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: iconColor ?? colorScheme.onSurfaceVariant, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: textColor ?? colorScheme.onSurface,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
