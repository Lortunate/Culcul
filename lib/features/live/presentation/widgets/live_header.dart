import 'package:culcul/features/auth/application/auth_session_providers.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/features/live/application/models/live_gold_rank_model.dart';
import 'package:culcul/features/live/application/models/live_guard_list_model.dart';
import 'package:culcul/features/live/application/models/live_room_detail_model.dart';
import 'package:culcul/core/models/user_card_contract.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/users/app_avatar.dart';
import 'package:culcul/ui/widgets/buttons/follow_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LiveHeader extends ConsumerWidget {
  final LiveRoomDetailModel? roomInfo;
  final UserCardModel? anchorInfo;
  final int? anchorLevel;
  final LiveGuardListModel? guardList;
  final LiveGoldRankModel? goldRank;
  final VoidCallback onLogin;
  final VoidCallback onFollow;
  final VoidCallback? onBack;

  const LiveHeader({
    super.key,
    this.roomInfo,
    this.anchorInfo,
    this.anchorLevel,
    this.guardList,
    this.goldRank,
    required this.onLogin,
    required this.onFollow,
    this.onBack,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final showFollowButton =
        roomInfo != null && anchorInfo != null && !anchorInfo!.isFollowed;
    final session = showFollowButton ? ref.watch(currentUserProvider) : null;
    final topGoldRankEntries = goldRank?.list.take(3).toList(growable: false);

    Widget tag(String text) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: colorScheme.onPrimary.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: colorScheme.onPrimary,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(4, 4, 12, 4),
      decoration: BoxDecoration(color: colorScheme.scrim),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Anchor Info & Tools
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 20,
                  color: colorScheme.onPrimary,
                ),
                onPressed: onBack ?? () => Navigator.of(context).maybePop(),
              ),
              if (roomInfo != null) ...[
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: colorScheme.primary, width: 1.5),
                  ),
                  padding: const EdgeInsets.all(1.5),
                  child: AppAvatar(
                    url: anchorInfo?.face ?? roomInfo!.userCover,
                    size: 38,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              anchorInfo?.name ?? '${roomInfo!.uid}',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: colorScheme.onPrimary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (anchorLevel != null) ...[
                            const SizedBox(width: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 1,
                              ),
                              decoration: BoxDecoration(
                                color: colorScheme.primary,
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Text(
                                '${t.common.up} $anchorLevel',
                                style: TextStyle(
                                  color: colorScheme.onPrimary,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Text(
                            t.live.header.online(
                              count: FormatUtils.formatNumber(roomInfo!.online),
                            ),
                            style: TextStyle(
                              color: colorScheme.onPrimary.withValues(alpha: 0.7),
                              fontSize: 10,
                            ),
                          ),
                          if (guardList != null) ...[
                            const SizedBox(width: 8),
                            Text(
                              t.live.header.guard(count: guardList!.info.num),
                              style: TextStyle(
                                color: colorScheme.onPrimary.withValues(alpha: 0.7),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                if (showFollowButton)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FollowButton(
                      isFollowed: false,
                      onTap: (session?.isLoggedIn ?? false) ? onFollow : onLogin,
                      height: 32,
                      text: '+ ${t.actions.follow}',
                    ),
                  ),
                if (topGoldRankEntries != null && topGoldRankEntries.isNotEmpty)
                  SizedBox(
                    height: 32,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 20.0 + (topGoldRankEntries.length - 1) * 14.0,
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              for (int i = 0; i < topGoldRankEntries.length; i++)
                                Positioned(
                                  left: i * 14.0,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: AppAvatar(
                                      url: topGoldRankEntries[i].face,
                                      size: 20,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: colorScheme.onPrimary.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            FormatUtils.formatNumber(goldRank!.onlineNum),
                            style: TextStyle(
                              color: colorScheme.onPrimary.withValues(alpha: 0.9),
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(width: 8),
              ],
            ],
          ),

          // Row 2: Tags & "More"
          if (roomInfo != null)
            Padding(
              padding: const EdgeInsets.only(left: 48, top: 8, bottom: 4),
              child: Row(
                children: [
                  tag(t.live.tags.hot),
                  const SizedBox(width: 6),
                  tag(t.live.tags.popularity),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
