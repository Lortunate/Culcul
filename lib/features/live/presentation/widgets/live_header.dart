import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/features/live/domain/entities/live_entities.dart';
import 'package:culcul/core/contracts/user_card_contract.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/app_avatar.dart';
import 'package:culcul/ui/widgets/follow_button.dart';
import 'package:flutter/material.dart';

part 'live_header.anchor.dart';
part 'live_header.tags.dart';

class LiveHeader extends StatelessWidget {
  final LiveRoomDetailModel? roomInfo;
  final UserCardModel? anchorInfo;
  final LiveAnchorInfoModel? liveAnchorInfo;
  final LiveGuardListModel? guardList;
  final LiveGoldRankModel? goldRank;
  final VoidCallback? onFollow;
  final VoidCallback? onBack;

  const LiveHeader({
    super.key,
    this.roomInfo,
    this.anchorInfo,
    this.liveAnchorInfo,
    this.guardList,
    this.goldRank,
    this.onFollow,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.fromLTRB(4, 4, 12, 4),
      decoration: BoxDecoration(color: colorScheme.scrim),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Anchor Info & Tools
          _buildAnchorRow(context),

          // Row 2: Tags & "More"
          if (roomInfo != null) _buildTagsRow(context),
        ],
      ),
    );
  }
}
