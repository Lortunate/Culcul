import 'package:flutter/material.dart';

class RankBadge extends StatelessWidget {
  final int rank;

  const RankBadge({super.key, required this.rank});

  static const _shadowOffset = Offset(0, 2);
  static const _borderRadius = BorderRadius.only(
    topLeft: Radius.circular(8),
    bottomRight: Radius.circular(8),
  );

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final style = _RankBadgeStyle.resolve(rank, colorScheme);

    return Container(
      width: style.size,
      height: style.size,
      alignment: Alignment.center,
      decoration: style.decoration,
      child: Text(
        '$rank',
        style: TextStyle(
          color: colorScheme.onPrimary,
          fontWeight: FontWeight.bold,
          fontSize: style.fontSize,
          fontStyle: FontStyle.italic,
          height: 1,
        ),
      ),
    );
  }
}

class _RankBadgeStyle {
  final double size;
  final double fontSize;
  final BoxDecoration decoration;

  const _RankBadgeStyle({
    required this.size,
    required this.fontSize,
    required this.decoration,
  });

  static _RankBadgeStyle resolve(int rank, ColorScheme colorScheme) {
    return switch (rank) {
      1 => _buildTopStyle(colorScheme.error),
      2 => _buildTopStyle(colorScheme.tertiary),
      3 => _buildTopStyle(colorScheme.primary),
      _ => _RankBadgeStyle(
        size: 20,
        fontSize: 12,
        decoration: BoxDecoration(
          color: colorScheme.scrim.withValues(alpha: 0.4),
          borderRadius: RankBadge._borderRadius,
        ),
      ),
    };
  }

  static _RankBadgeStyle _buildTopStyle(Color baseColor) {
    return _RankBadgeStyle(
      size: 24,
      fontSize: 14,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [baseColor, baseColor.withValues(alpha: 0.78)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: RankBadge._borderRadius,
        boxShadow: [
          BoxShadow(
            color: baseColor.withValues(alpha: 0.3),
            blurRadius: 4,
            offset: RankBadge._shadowOffset,
          ),
        ],
      ),
    );
  }
}

