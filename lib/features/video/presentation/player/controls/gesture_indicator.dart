import 'dart:ui';

import 'package:culcul/core/perf/performance_policy.dart';
import 'package:flutter/material.dart';

class GestureIndicator extends StatelessWidget {
  static const _borderRadius = BorderRadius.all(Radius.circular(20));
  static final _blurFilter = ImageFilter.blur(sigmaX: 32, sigmaY: 32);

  final IconData icon;
  final String label;
  final double? value;
  final String? textValue;

  const GestureIndicator({
    super.key,
    required this.icon,
    required this.label,
    this.value,
    this.textValue,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final blurEnabled = PerformancePolicyController.notifier.value.blurEnabled;

    final content = Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
      decoration: BoxDecoration(
        color: colorScheme.scrim.withValues(alpha: blurEnabled ? 0.5 : 0.7),
        borderRadius: _borderRadius,
        border: Border.all(
          color: colorScheme.onPrimary.withValues(alpha: 0.1),
          width: 0.5,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: colorScheme.onPrimary,
            size: 36,
            shadows: [
              Shadow(
                blurRadius: 8,
                color: colorScheme.shadow.withValues(alpha: 0.26),
                offset: const Offset(0, 2),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: TextStyle(
              color: colorScheme.onPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              decoration: TextDecoration.none,
              shadows: [
                Shadow(
                  blurRadius: 4,
                  color: colorScheme.shadow.withValues(alpha: 0.45),
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          ),
          if (textValue != null) ...[
            const SizedBox(height: 8),
            Text(
              textValue!,
              style: TextStyle(
                color: colorScheme.onPrimary.withValues(alpha: 0.7),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
          if (value != null) ...[
            const SizedBox(height: 16),
            SizedBox(
              width: 80,
              height: 6,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: LinearProgressIndicator(
                  value: value,
                  backgroundColor: colorScheme.onPrimary.withValues(alpha: 0.15),
                  valueColor: AlwaysStoppedAnimation<Color>(colorScheme.onPrimary),
                ),
              ),
            ),
          ],
        ],
      ),
    );

    if (!blurEnabled) return content;

    return Container(
      decoration: BoxDecoration(
        borderRadius: _borderRadius,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.3),
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: _borderRadius,
        child: BackdropFilter(filter: _blurFilter, child: content),
      ),
    );
  }
}
