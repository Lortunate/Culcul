import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/core/session/user_providers.dart';
import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/ui/widgets/buttons/follow_button.dart';
import 'package:culcul/ui/widgets/users/user_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UploaderSection extends ConsumerWidget {
  final VideoOwner owner;
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
      subtitle: null,
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
