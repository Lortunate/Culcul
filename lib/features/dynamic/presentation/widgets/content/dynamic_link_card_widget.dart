import 'package:culcul/data/models/dynamic/dynamic_view_models.dart';
import 'package:culcul/features/dynamic/presentation/utils/dynamic_navigation.dart';
import 'package:culcul/features/dynamic/presentation/widgets/content/dynamic_content_surface.dart';
import 'package:culcul/ui/widgets/app_network_image.dart';
import 'package:flutter/material.dart';

class DynamicLinkCardWidget extends StatelessWidget {
  final DynamicLinkCard card;

  const DynamicLinkCardWidget({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return DynamicContentSurface(
      borderRadius: BorderRadius.circular(6),
      onTap: () => DynamicNavigation.open(context, url: card.url, title: card.title),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              bottomLeft: Radius.circular(6),
            ),
            child: AppNetworkImage(
              url: card.cover,
              width: 88,
              height: 88,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    card.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (card.desc != null && card.desc!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      card.desc!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
