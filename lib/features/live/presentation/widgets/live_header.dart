import 'package:culcul/features/auth/application/auth_session_providers.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/features/live/application/models/live_anchor_info_model.dart';
import 'package:culcul/features/live/application/models/live_gold_rank_model.dart';
import 'package:culcul/features/live/application/models/live_guard_list_model.dart';
import 'package:culcul/features/live/application/models/live_room_detail_model.dart';
import 'package:culcul/core/contracts/user_card_contract.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/users/app_avatar.dart';
import 'package:culcul/ui/widgets/buttons/follow_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'live_header.anchor.dart';
part 'live_header.tags.dart';

class LiveHeader extends ConsumerWidget {
  final LiveRoomDetailModel? roomInfo;
  final UserCardModel? anchorInfo;
  final LiveAnchorInfoModel? liveAnchorInfo;
  final LiveGuardListModel? guardList;
  final LiveGoldRankModel? goldRank;
  final VoidCallback onLogin;
  final VoidCallback? onFollow;
  final VoidCallback? onBack;

  const LiveHeader({
    super.key,
    this.roomInfo,
    this.anchorInfo,
    this.liveAnchorInfo,
    this.guardList,
    this.goldRank,
    required this.onLogin,
    this.onFollow,
    this.onBack,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.fromLTRB(4, 4, 12, 4),
      decoration: BoxDecoration(color: colorScheme.scrim),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Anchor Info & Tools
          _buildAnchorRow(context, ref),

          // Row 2: Tags & "More"
          if (roomInfo != null) _buildTagsRow(context),
        ],
      ),
    );
  }
}
