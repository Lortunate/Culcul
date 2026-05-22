import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/features/auth/application/auth_session_providers.dart';
import 'package:culcul/ui/widgets/buttons/follow_button.dart';
import 'package:culcul/ui/widgets/users/user_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UploaderSection extends ConsumerWidget {
  final VideoOwner owner;
  final bool isFollowed;
  final VoidCallback onToggleFollow;
  final VoidCallback onLogin;
  final ValueChanged<int> onOpenUser;

  const UploaderSection({
    super.key,
    required this.owner,
    required this.isFollowed,
    required this.onToggleFollow,
    required this.onLogin,
    required this.onOpenUser,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return UserListTile(
      avatarUrl: owner.face,
      name: owner.name,
      avatarSize: 30,
      padding: EdgeInsets.zero,
      onTap: () => onOpenUser(owner.mid),
      trailing: FollowButton(
        isFollowed: isFollowed,
        width: 72,
        height: 28,
        onTap: () {
          final session = ref.read(currentUserProvider);
          if (!(session?.isLoggedIn ?? false)) {
            onLogin();
            return;
          }
          onToggleFollow();
        },
      ),
    );
  }
}
