import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:culcul/core/contracts/relation_user_contract.dart';
import 'package:culcul/features/profile/presentation/view_models/relation_user_action_view_model.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/follow_button.dart';
import 'package:culcul/ui/widgets/user_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RelationUserItem extends ConsumerStatefulWidget {
  final ProfileRelationUser user;
  final VoidCallback? onTap;

  const RelationUserItem({super.key, required this.user, this.onTap});

  @override
  ConsumerState<RelationUserItem> createState() => _RelationUserItemState();
}

class _RelationUserItemState extends ConsumerState<RelationUserItem> {
  late int _attribute;

  @override
  void initState() {
    super.initState();
    _attribute = widget.user.attribute;
  }

  @override
  void didUpdateWidget(covariant RelationUserItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.user.attribute != oldWidget.user.attribute) {
      _attribute = widget.user.attribute;
    }
  }

  @override
  Widget build(BuildContext context) {
    return UserListTile(
      onTap:
          widget.onTap ??
          () {
            UserProfileRoute(mid: widget.user.mid).push(context);
          },
      avatarUrl: widget.user.face,
      name: widget.user.uname,
      subtitle: widget.user.sign,
      trailing: _buildFollowButton(context),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }

  Widget _buildFollowButton(BuildContext context) {
    final t = Translations.of(context);
    // 0: not following, 2: following, 6: mutual, 128: blocked
    String text = t.actions.follow;
    bool isFollowed = false;

    if (_attribute == 2) {
      text = t.actions.followed;
      isFollowed = true;
    } else if (_attribute == 6) {
      text = t.profile.relation.mutual;
      isFollowed = true;
    } else if (_attribute == 128) {
      text = t.profile.relation.blacklisted;
      isFollowed = true;
    }

    return FollowButton(
      isFollowed: isFollowed,
      text: text,
      onTap: _handleFollowPressed,
      height: 32,
    );
  }

  void _handleFollowPressed() {
    final authState = ref.read(authProvider);
    if (!authState.isLoggedIn) {
      const LoginRoute().push(context);
      return;
    }
    _handleFollow();
  }

  Future<void> _handleFollow() async {
    final isFollowing = _attribute != 0;
    final newStatus = !isFollowing;

    // Optimistic update
    setState(() {
      if (newStatus) {
        _attribute = 2; // Default to "Following"
      } else {
        _attribute = 0;
      }
    });

    final error = await ref
        .read(relationUserActionViewModelProvider.notifier)
        .toggleFollow(mid: widget.user.mid, isFollow: newStatus);
    if (error != null) {
      // Revert on error
      if (mounted) {
        setState(() {
          _attribute = widget.user.attribute;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              Translations.of(context).profile.relation.failed(error: error.message),
            ),
          ),
        );
      }
    }
  }
}
