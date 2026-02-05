import 'package:culcul/data/models/live/index.dart';
import 'package:culcul/data/models/user/user_card_model.dart';
import 'package:culcul/ui/widgets/app_avatar.dart';
import 'package:culcul/ui/widgets/follow_button.dart';
import 'package:flutter/material.dart';

class LiveInfoView extends StatelessWidget {
  final LiveRoomDetailModel info;
  final UserCardModel? anchor;
  final VoidCallback? onFollow;

  const LiveInfoView({
    super.key,
    required this.info,
    this.anchor,
    this.onFollow,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppAvatar(
                url: anchor?.face ?? info.userCover,
                size: 36,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      info.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'UP: ${anchor?.name ?? info.uid}',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              if (anchor != null)
                FollowButton(
                  isFollowed: anchor!.isFollowed,
                  onTap: onFollow ?? () {},
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Online: ${info.online} | Area: ${info.parentAreaName} > ${info.areaName}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          if (info.description.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              info.description,
              style: theme.textTheme.bodyMedium,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }
}
