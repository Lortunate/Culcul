part of 'favorite_detail_page.dart';

class _FavoriteFolderHeader extends StatelessWidget {
  final FavoriteFolderInfo info;

  const _FavoriteFolderHeader({required this.info});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          AppNetworkImage(
            url: info.cover,
            width: 100,
            height: 100,
            borderRadius: BorderRadius.circular(8),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  info.title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ClipOval(
                      child: AppNetworkImage(url: info.upper.face, width: 20, height: 20),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      info.upper.name,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  t.favorites.folder_item_count(count: info.mediaCount),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FavoriteResourceRow extends StatelessWidget {
  final FavoriteResource item;
  final bool isSelectionMode;
  final bool isSelected;
  final ValueChanged<bool> onSelectionChanged;
  final VoidCallback onTap;

  const _FavoriteResourceRow({
    required this.item,
    required this.isSelectionMode,
    required this.isSelected,
    required this.onSelectionChanged,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            if (isSelectionMode)
              Checkbox(
                value: isSelected,
                onChanged: (value) => onSelectionChanged(value ?? false),
              ),
            Expanded(
              child: FavResourceItem(item: item, onTap: onTap),
            ),
          ],
        ),
        const Divider(height: 1, indent: 16, endIndent: 16),
      ],
    );
  }
}
