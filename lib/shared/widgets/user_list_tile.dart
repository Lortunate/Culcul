import 'package:culcul/core/constants/app_dimens.dart';
import 'package:culcul/shared/widgets/app_avatar.dart';
import 'package:culcul/shared/widgets/app_clickable.dart';
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

  Widget _buildTitle(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      name,
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 15,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildTitleRow(BuildContext context) {
    return Row(
      children: [
        Flexible(child: _buildTitle(context)),
        if (titleBadge != null) ...[const SizedBox(width: AppDimens.p4), titleBadge!],
      ],
    );
  }

  Widget? _buildStatsRow() {
    if (stats == null || stats!.isEmpty) {
      return null;
    }

    return Row(
      children: [
        for (int index = 0; index < stats!.length; index++) ...[
          if (index > 0) const SizedBox(width: AppDimens.p12),
          stats![index],
        ],
      ],
    );
  }

  Widget? _buildSubtitle(BuildContext context) {
    if (subtitle == null || subtitle!.isEmpty) {
      return null;
    }

    return Text(
      subtitle!,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  @override
  Widget build(BuildContext context) {
    final statsRow = _buildStatsRow();
    final subtitleView = _buildSubtitle(context);

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
                  _buildTitleRow(context),
                  if (statsRow != null) ...[
                    const SizedBox(height: AppDimens.p4),
                    statsRow,
                  ],
                  if (subtitleView != null) ...[
                    const SizedBox(height: AppDimens.p4),
                    subtitleView,
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
