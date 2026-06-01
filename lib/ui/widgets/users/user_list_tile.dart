import 'package:culcul/ui/widgets/users/app_avatar.dart';
import 'package:culcul/ui/widgets/buttons/app_clickable.dart';
import 'package:flutter/material.dart';

class UserListTile extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final String? subtitle;
  final List<Widget>? stats;
  final Widget? trailing;
  final VoidCallback? onTap;
  final double avatarSize;
  final EdgeInsetsGeometry padding;
  final Widget? titleBadge;

  const UserListTile({
    super.key,
    required this.avatarUrl,
    required this.name,
    this.subtitle,
    this.stats,
    this.trailing,
    this.onTap,
    this.avatarSize = 48.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    this.titleBadge,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final stats = this.stats;

    return AppClickable(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Row(
          children: [
            AppAvatar(url: avatarUrl, size: avatarSize),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          name,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (titleBadge != null) ...[
                        const SizedBox(width: 4.0),
                        titleBadge!,
                      ],
                    ],
                  ),
                  if (stats != null && stats.isNotEmpty) ...[
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        for (int index = 0; index < stats.length; index++) ...[
                          if (index > 0) const SizedBox(width: 12.0),
                          stats[index],
                        ],
                      ],
                    ),
                  ],
                  if (subtitle case final subtitleText? when subtitleText.isNotEmpty) ...[
                    const SizedBox(height: 4.0),
                    Text(
                      subtitleText,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null) ...[const SizedBox(width: 12.0), trailing!],
          ],
        ),
      ),
    );
  }
}
