import 'package:culcul/features/dynamic/application/dynamic_post_card_view_data.dart';
import 'package:culcul/features/dynamic/presentation/widgets/detail/dynamic_post_header.dart';
import 'package:flutter/material.dart';

class DynamicDetailHeader extends StatelessWidget {
  final DynamicPostCardViewData post;

  const DynamicDetailHeader({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
      child: DynamicPostHeader(
        post: post,
        avatarSize: 42,
        moreIcon: Icons.more_vert_rounded,
      ),
    );
  }
}
