import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class LiveGuardBadge extends StatelessWidget {
  final int level;

  const LiveGuardBadge({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    final color =
        level == 1
            ? const Color(0xFFD32F2F) // Material Red 700
            : level == 2
            ? const Color(0xFF7B1FA2) // Material Purple 700
            : const Color(0xFF1976D2); // Material Blue 700

    final icon =
        level == 1
            ? Icons.local_police
            : level == 2
            ? Icons.star
            : Icons.shield;

    return Container(
      margin: const EdgeInsets.only(right: 4),
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        border: Border.all(color: color, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Icon(icon, size: 10, color: color),
    );
  }
}

class LiveMedalBadge extends StatelessWidget {
  final List<dynamic> medal;

  const LiveMedalBadge({super.key, required this.medal});

  @override
  Widget build(BuildContext context) {
    if (medal.length < 2) return const SizedBox.shrink();

    final name = medal[1].toString();
    final level = medal[0].toString();
    int colorInt = 0;
    if (medal.length > 4 && medal[4] is int) {
      colorInt = medal[4] as int;
    }

    final color =
        colorInt != 0
            ? Color(0xFF000000 + colorInt)
            : Theme.of(context).colorScheme.primary;

    return Container(
      margin: const EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 0.8),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            child: Text(
              name,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.horizontal(
                right: Radius.circular(2),
              ),
            ),
            child: Text(
              level,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 0.5),
      decoration: BoxDecoration(
        color: const Color(0xFFFF5252),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        t.live.danmaku.admin,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          height: 1.1,
        ),
      ),
    );
  }
}
