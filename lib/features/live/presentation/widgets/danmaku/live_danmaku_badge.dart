import 'package:culcul/features/live/data/dtos/live_history_danmaku_model.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/theme/culcul_colors.dart';
import 'package:flutter/material.dart';

class LiveGuardBadge extends StatelessWidget {
  final int level;

  const LiveGuardBadge({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final semanticColors = context.semanticColors;
    final color = level == 1
        ? semanticColors.warning
        : level == 2
        ? colorScheme.secondary
        : semanticColors.info;

    final icon = level == 1
        ? Icons.local_police
        : level == 2
        ? Icons.star
        : Icons.shield;

    return Container(
      padding: const EdgeInsets.all(1.5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        border: Border.all(color: color.withValues(alpha: 0.8), width: 0.8),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Icon(icon, size: 9, color: color.withValues(alpha: 0.92)),
    );
  }
}

class LiveMedalBadge extends StatelessWidget {
  final LiveDanmakuMedal medal;

  const LiveMedalBadge({super.key, required this.medal});

  @override
  Widget build(BuildContext context) {
    final name = medal.name;
    final level = medal.level.toString();
    final colorInt = medal.color;

    final color = colorInt != 0
        ? Color.fromARGB(
            255,
            (colorInt >> 16) & 0xFF,
            (colorInt >> 8) & 0xFF,
            colorInt & 0xFF,
          )
        : Theme.of(context).colorScheme.primary;

    return Container(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        border: Border.all(color: color.withValues(alpha: 0.75), width: 0.7),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1.5),
            child: Text(
              name,
              style: TextStyle(
                color: color.withValues(alpha: 0.92),
                fontSize: 9.5,
                fontWeight: FontWeight.w600,
                height: 1.1,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1.5),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.78),
              borderRadius: const BorderRadius.horizontal(right: Radius.circular(2)),
            ),
            child: Text(
              level,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 9.5,
                fontWeight: FontWeight.bold,
                height: 1.1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LiveAdminBadge extends StatelessWidget {
  const LiveAdminBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3.5, vertical: 1.2),
      decoration: BoxDecoration(
        color: colorScheme.error.withValues(alpha: 0.82),
        border: Border.all(color: colorScheme.error.withValues(alpha: 0.9), width: 0.7),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        t.live.danmaku.admin,
        style: TextStyle(
          color: colorScheme.onError,
          fontSize: 9.5,
          fontWeight: FontWeight.bold,
          height: 1.1,
        ),
      ),
    );
  }
}
