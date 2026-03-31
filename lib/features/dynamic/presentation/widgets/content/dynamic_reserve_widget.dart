import 'package:culcul/features/dynamic/models/dynamic_models.dart';
import 'package:culcul/features/dynamic/presentation/utils/dynamic_navigation.dart';
import 'package:culcul/features/dynamic/presentation/widgets/content/dynamic_content_surface.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class DynamicReserveWidget extends StatelessWidget {
  final DynamicAdditional additional;

  const DynamicReserveWidget({super.key, required this.additional});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);
    final jumpUrl = additional.jumpUrl;
    final canOpen = jumpUrl != null && jumpUrl.isNotEmpty;

    return DynamicContentSurface(
      padding: const EdgeInsets.all(12),
      borderRadius: BorderRadius.circular(8),
      onTap: canOpen ? () => DynamicNavigation.open(context, url: jumpUrl) : null,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  additional.title ?? t.moments.reserve,
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
            onPressed: canOpen
                ? () => DynamicNavigation.open(context, url: jumpUrl)
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            child: Text(additional.state == 1 ? t.moments.reserved : t.moments.reserve),
          ),
        ],
      ),
    );
  }
}
