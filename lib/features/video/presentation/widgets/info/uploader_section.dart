import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/data/models/video/video_model.dart';
import 'package:culcul/ui/widgets/follow_button.dart';
import 'package:culcul/ui/widgets/user_list_tile.dart';
import 'package:flutter/material.dart';

class UploaderSection extends StatelessWidget {
  final Owner owner;
  final bool isFollowed;
  final VoidCallback onToggleFollow;

  const UploaderSection({
    super.key,
    required this.owner,
    required this.isFollowed,
    required this.onToggleFollow,
  });

  @override
  Widget build(BuildContext context) {
    return UserListTile(
      avatarUrl: owner.face,
      name: owner.name,
      subtitle: '12.5W followers · 168 videos', // TODO: Fetch real stats if available
      avatarSize: 34,
      padding: EdgeInsets.zero,
      onTap: () => UserProfileRoute(mid: owner.mid).push(context),
      trailing: FollowButton(isFollowed: isFollowed, onTap: onToggleFollow),
    );
  }
}

