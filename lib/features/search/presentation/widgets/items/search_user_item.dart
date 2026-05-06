import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/core/contracts/search_result_contract.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/shared/widgets/user_list_tile.dart';
import 'package:flutter/material.dart';

class SearchUserItem extends StatelessWidget {
  final SearchUserEntry item;

  const SearchUserItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    return UserListTile(
      onTap: () {
        if (item.mid != 0) {
          UserProfileRoute(mid: item.mid).push(context);
        }
      },
      avatarUrl: item.avatarUrl,
      avatarSize: 60,
      name: FormatUtils.stripHtmlTags(item.name),
      subtitle: item.sign != null ? FormatUtils.stripHtmlTags(item.sign!) : null,
      stats: [
        _UserMetaItem(
          label: t.profile.stats.followers,
          value: FormatUtils.formatAnyNumber(item.fans),
        ),
        _UserMetaItem(
          label: t.search.tabs.video,
          value: FormatUtils.formatAnyNumber(item.videos),
        ),
      ],
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      trailing: SizedBox(
        height: 30,
        child: OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: colorScheme.primary, width: 0.8),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          child: Text(
            t.actions.follow,
            style: TextStyle(
              color: colorScheme.primary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _UserMetaItem extends StatelessWidget {
  final String label;
  final String value;

  const _UserMetaItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            fontSize: 11,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: theme.textTheme.labelSmall?.copyWith(
            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
