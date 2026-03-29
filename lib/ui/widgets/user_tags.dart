import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class VipTag extends StatelessWidget {
  final int type;
  final bool showShadow;

  const VipTag({super.key, required this.type, this.showShadow = false});

  List<BoxShadow>? _buildShadow(Color color) {
    if (!showShadow) {
      return null;
    }

    return [
      BoxShadow(
        color: color.withValues(alpha: 0.3),
        blurRadius: 4,
        offset: const Offset(0, 2),
      ),
    ];
  }

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
        boxShadow: _buildShadow(color),
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

  Color _resolveLevelColor(ColorScheme colorScheme) {
    switch (level) {
      case 0:
      case 1:
        return colorScheme.outline;
      case 2:
        return colorScheme.tertiary;
      case 3:
        return colorScheme.secondary;
      case 4:
        return colorScheme.primaryContainer;
      case 5:
        return colorScheme.primary;
      case 6:
        return colorScheme.error;
      default:
        return colorScheme.outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final levelColor = _resolveLevelColor(Theme.of(context).colorScheme);

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
