import 'package:culcul/data/models/dynamic/dynamic_view_models.dart';
import 'package:flutter/material.dart';

class DynamicReserveWidget extends StatelessWidget {
  final DynamicAdditional additional;

  const DynamicReserveWidget({super.key, required this.additional});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  additional.title ?? '预约',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${additional.desc1 ?? ''}  ${additional.desc2 ?? ''}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 12,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            child: Text(additional.state == 1 ? '已预约' : '预约'),
          ),
        ],
      ),
    );
  }
}
