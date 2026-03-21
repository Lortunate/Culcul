import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/data/models/relation/relation_model.dart';
import 'package:culcul/ui/widgets/follow_button.dart';
import 'package:culcul/ui/widgets/user_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RelationUserItem extends ConsumerStatefulWidget {
  final RelationUser user;
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
    // 0:未关注, 2:已关注, 6:已互粉, 128:已拉黑
    String text = '关注';
    bool isFollowed = false;

    if (_attribute == 2) {
      text = '已关注';
      isFollowed = true;
    } else if (_attribute == 6) {
      text = '互粉';
      isFollowed = true;
    } else if (_attribute == 128) {
      text = '已拉黑';
      isFollowed = true;
    }

    return FollowButton(
      isFollowed: isFollowed,
      text: text,
      onTap: _handleFollow,
      height: 32,
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

    try {
      await ref
          .read(profileRepositoryProvider)
          .modifyRelation(mid: widget.user.mid, isFollow: newStatus);
    } catch (e) {
      // Revert on error
      if (mounted) {
        setState(() {
          _attribute = widget.user.attribute;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('操作失败: $e')));
      }
    }
  }
}
