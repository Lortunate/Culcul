import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/data/models/index.dart';
import 'package:culcul/ui/widgets/index.dart';
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
      subtitle: '12.5万粉丝 · 168视频', // TODO: Fetch real stats if available
      avatarSize: 34,
      padding: EdgeInsets.zero,
      onTap: () => UserProfileRoute(mid: owner.mid).push(context),
      trailing: FollowButton(isFollowed: isFollowed, onTap: onToggleFollow),
    );
  }
}
