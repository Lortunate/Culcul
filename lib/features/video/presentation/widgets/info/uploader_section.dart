import 'package:culcul/core/session/current_user_provider.dart';
import 'package:culcul/features/video/domain/entities/video_entities.dart';
import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/ui/widgets/follow_button.dart';
import 'package:culcul/ui/widgets/user_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UploaderSection extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    return UserListTile(
      avatarUrl: owner.face,
      name: owner.name,
      subtitle: '12.5W followers · 168 videos', // TODO: Fetch real stats if available
      avatarSize: 34,
      padding: EdgeInsets.zero,
      onTap: () => UserProfileRoute(mid: owner.mid).push(context),
      trailing: FollowButton(
        isFollowed: isFollowed,
        onTap: () {
          final session = ref.read(currentUserProvider);
          if (!(session?.isLoggedIn ?? false)) {
            const LoginRoute().push(context);
            return;
          }
          onToggleFollow();
        },
      ),
    );
  }
}
