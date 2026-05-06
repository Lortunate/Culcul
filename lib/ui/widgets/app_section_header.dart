import 'package:culcul/ui/widgets/app_clickable.dart';
import 'package:flutter/material.dart';

class AppSectionHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTrailingTap;

  const AppSectionHeader({
    super.key,
    required this.title,
    this.trailing,
    this.padding,
    this.onTrailingTap,
  });

  List<Widget> _buildTrailing() {
    if (trailing == null) {
      return const [];
    }

    return [
      AppClickable(
        onTap: onTrailingTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(padding: const EdgeInsets.all(4), child: trailing!),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final trailingView = _buildTrailing();

    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          ...trailingView,
        ],
      ),
    );
  }
}
