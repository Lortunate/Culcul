import 'package:culcul/features/dynamic/domain/entities/dynamic_content_entities.dart';
import 'package:culcul/features/dynamic/presentation/widgets/dynamic_navigation.dart';
import 'package:culcul/features/dynamic/presentation/widgets/content/dynamic_content_surface.dart';
import 'package:culcul/ui/widgets/media/app_network_image.dart';
import 'package:flutter/material.dart';

class DynamicGoodsWidget extends StatelessWidget {
  final DynamicAdditional additional;

  const DynamicGoodsWidget({super.key, required this.additional});

  @override
  Widget build(BuildContext context) {
    if (additional.goodsItems == null || additional.goodsItems!.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return DynamicContentSurface(
      padding: const EdgeInsets.only(top: 8),
      borderRadius: BorderRadius.circular(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (additional.headText != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
              child: Text(
                additional.headText!,
                style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ...List.generate(additional.goodsItems!.length, (i) {
            final item = additional.goodsItems![i];
            return RepaintBoundary(
              child: ListTile(
                onTap: () => DynamicNavigation.open(context, url: item.jumpUrl),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                leading: AppNetworkImage(
                  url: item.cover,
                  width: 50,
                  height: 50,
                  borderRadius: BorderRadius.circular(8),
                ),
                title: Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium,
                ),
                subtitle: Text(
                  item.price,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
