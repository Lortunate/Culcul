import 'package:culcul/features/dynamic/domain/entities/dynamic_entities.dart';
import 'package:culcul/features/dynamic/presentation/widgets/dynamic_navigation.dart';
import 'package:culcul/features/dynamic/presentation/widgets/content/dynamic_content_surface.dart';
import 'package:culcul/shared/widgets/app_network_image.dart';
import 'package:flutter/material.dart';

class DynamicCommonWidget extends StatelessWidget {
  final DynamicAdditional additional;

  const DynamicCommonWidget({super.key, required this.additional});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DynamicContentSurface(
      borderRadius: BorderRadius.circular(6),
      onTap: () => DynamicNavigation.open(context, url: additional.jumpUrl),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              bottomLeft: Radius.circular(6),
            ),
            child: AppNetworkImage(
              url: additional.cover ?? '',
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
                    additional.title ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    additional.desc1 ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
