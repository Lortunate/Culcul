import 'package:culcul/core/constants/app_dimens.dart';
import 'package:culcul/ui/widgets/app_avatar.dart';
import 'package:culcul/ui/widgets/app_clickable.dart';
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
    this.avatarSize = AppDimens.iconXLarge, // 48
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppDimens.p16,
      vertical: AppDimens.p12,
    ),
    this.titleBadge,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AppClickable(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Row(
          children: [
            AppAvatar(url: avatarUrl, size: avatarSize),
            const SizedBox(width: AppDimens.p12),
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
                            fontSize: 15, // TODO: Use text theme properly
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (titleBadge != null) ...[
                        const SizedBox(width: AppDimens.p4),
                        titleBadge!,
                      ],
                    ],
                  ),
                  if (stats != null && stats!.isNotEmpty) ...[
                    const SizedBox(height: AppDimens.p4),
                    Row(
                      children: [
                        for (int i = 0; i < stats!.length; i++) ...[
                          if (i > 0) const SizedBox(width: AppDimens.p12),
                          stats![i],
                        ],
                      ],
                    ),
                  ],
                  if (subtitle != null && subtitle!.isNotEmpty) ...[
                    const SizedBox(height: AppDimens.p4),
                    Text(
                      subtitle!,
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
            if (trailing != null) ...[const SizedBox(width: AppDimens.p12), trailing!],
          ],
        ),
      ),
    );
  }
}
