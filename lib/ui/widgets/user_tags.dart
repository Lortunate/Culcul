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
    final color = Theme.of(context).colorScheme.primary;

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
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.white,
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
    final Color levelColor;
    switch (level) {
      case 0:
      case 1:
        levelColor = const Color(0xFFBFBFBF);
        break;
      case 2:
        levelColor = const Color(0xFF95DDB2);
        break;
      case 3:
        levelColor = const Color(0xFF92D1E5);
        break;
      case 4:
        levelColor = const Color(0xFFFFB37C);
        break;
      case 5:
        levelColor = const Color(0xFFFF6C00);
        break;
      case 6:
        levelColor = const Color(0xFFFF0000);
        break;
      default:
        levelColor = const Color(0xFFBFBFBF);
    }

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
