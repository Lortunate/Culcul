import 'package:culcul/core/feedback/app_feedback.dart';
import 'package:culcul/features/profile/relation_api.dart';
import 'package:culcul/features/auth/application/auth_session_providers.dart';
import 'package:culcul/core/models/relation_user_contract.dart';
import 'package:culcul/features/profile/presentation/widgets/profile_navigation_scope.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/buttons/follow_button.dart';
import 'package:culcul/ui/widgets/users/user_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RelationUserItem extends ConsumerStatefulWidget {
  final ProfileRelationUser user;

  const RelationUserItem({super.key, required this.user});

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
    final t = Translations.of(context);
    // 0: not following, 2: following, 6: mutual, 128: blocked
    String followText = t.actions.follow;
    bool isFollowed = false;

    if (_attribute == 2) {
      followText = t.actions.followed;
      isFollowed = true;
    } else if (_attribute == 6) {
      followText = t.profile.relation.mutual;
      isFollowed = true;
    } else if (_attribute == 128) {
      followText = t.profile.relation.blacklisted;
      isFollowed = true;
    }

    return UserListTile(
      onTap: () {
        ProfileNavigationScope.of(context).onOpenUser(widget.user.mid);
      },
      avatarUrl: widget.user.face,
      name: widget.user.uname,
      subtitle: widget.user.sign,
      trailing: FollowButton(
        isFollowed: isFollowed,
        text: followText,
        onTap: () {
          final session = ref.read(currentUserProvider);
          if (!(session?.isLoggedIn ?? false)) {
            ProfileNavigationScope.of(context).onLogin();
            return;
          }
          _handleFollow();
        },
        height: 32,
      ),
    );
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

    final result = await ref
        .read(relationServiceProvider)
        .modifyRelation(mid: widget.user.mid, isFollow: newStatus);
    final error = result.errorOrNull;
    if (error != null) {
      // Revert on error
      if (mounted) {
        setState(() {
          _attribute = widget.user.attribute;
        });
        context.showAppFeedback(
          Translations.of(context).profile.relation.failed(error: error.message),
          level: AppFeedbackLevel.error,
        );
      }
    }
  }
}
