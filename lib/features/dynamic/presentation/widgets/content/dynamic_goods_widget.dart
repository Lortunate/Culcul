import 'package:culcul/data/models/dynamic/dynamic_view_models.dart';
import 'package:culcul/ui/widgets/app_network_image.dart';
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

    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (additional.headText != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                additional.headText!,
                style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ...additional.goodsItems!.map(
            (item) => ListTile(
              leading: AppNetworkImage(
                url: item.cover,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
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
            ),
          ),
        ],
      ),
    );
  }
}
