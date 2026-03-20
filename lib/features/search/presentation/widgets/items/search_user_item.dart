import 'package:culcul/core/router/router.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/data/models/search/search_result.dart';
import 'package:culcul/ui/widgets/index.dart';
import 'package:flutter/material.dart';

class SearchUserItem extends StatelessWidget {
  final SearchUserModel item;

  const SearchUserItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return UserListTile(
      onTap: () {
        if (item.mid != null) {
          UserProfileRoute(mid: item.mid!).push(context);
        }
      },
      avatarUrl: item.upic ?? item.upicUrl ?? '',
      avatarSize: 60,
      name: FormatUtils.stripHtmlTags(item.uname ?? ''),
      subtitle: item.usign != null
          ? FormatUtils.stripHtmlTags(item.usign!)
          : null,
      stats: [
        _UserMetaItem(
          label: '粉丝',
          value: FormatUtils.formatAnyNumber(item.fans),
        ),
        _UserMetaItem(
          label: '视频',
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Text(
            '关注',
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
