import 'package:culcul/features/dynamic/data/dtos/dynamic_response.dart';
import 'package:culcul/features/dynamic/domain/entities/dynamic_extension.dart';
import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/features/dynamic/presentation/widgets/dynamic_post_actions.dart';
import 'package:culcul/ui/widgets/users/app_avatar.dart';
import 'package:culcul/ui/widgets/buttons/app_clickable.dart';
import 'package:flutter/material.dart';

class DynamicPostHeader extends StatelessWidget {
  final DynamicItem post;
  final double avatarSize;
  final IconData moreIcon;

  const DynamicPostHeader({
    super.key,
    required this.post,
    this.avatarSize = 40,
    this.moreIcon = Icons.more_horiz_rounded,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        AppAvatar(
          url: post.authorAvatar,
          size: avatarSize,
          onTap: () => _openUserProfile(context),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppClickable(
                haptic: true,
                onTap: () => _openUserProfile(context),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    post.authorName,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: _authorColor(colorScheme, post.authorName),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                post.timeText,
                style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 12),
              ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(moreIcon, size: 20, color: colorScheme.onSurfaceVariant),
          onPressed: () => showDynamicPostActions(context, post),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          style: const ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
        ),
      ],
    );
  }

  void _openUserProfile(BuildContext context) {
    UserProfileRoute(mid: post.authorMid).push(context);
  }
}

Color _authorColor(ColorScheme colorScheme, String authorName) {
  return switch (authorName) {
    '哔哩哔哩番剧' || '哔哩哔哩漫画' => colorScheme.primary,
    _ => colorScheme.onSurface,
  };
}
