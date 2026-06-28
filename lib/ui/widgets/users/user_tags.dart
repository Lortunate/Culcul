import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class VipTag extends StatelessWidget {
  final int type;
  final bool showShadow;

  const VipTag({super.key, required this.type, this.showShadow = false});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final isYear = type == 2;
    final colorScheme = Theme.of(context).colorScheme;
    final color = colorScheme.primary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: color.withValues(alpha: 0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Text(
        isYear ? t.profile.vip.annual_premium : t.profile.vip.premium,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: colorScheme.onPrimary,
          height: 1.1,
        ),
      ),
    );
  }
}

class LevelTag extends StatelessWidget {
  final int level;

  const LevelTag({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final levelColor = switch (level) {
      0 || 1 => colorScheme.outline,
      2 => colorScheme.tertiary,
      3 => colorScheme.secondary,
      4 => colorScheme.primaryContainer,
      5 => colorScheme.primary,
      6 => colorScheme.error,
      _ => colorScheme.outline,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(
        border: Border.all(color: levelColor, width: 1.5),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        'LV$level',
        style: TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.w900,
          color: levelColor,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
