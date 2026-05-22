part of 'live_header.dart';

extension _LiveHeaderAnchorParts on LiveHeader {
  Widget _buildAnchorRow(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
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
          _buildAvatar(context),
          const SizedBox(width: 8),
          _buildNameAndOnline(context),
          _buildFollowButton(context, ref),
          _buildViewerStack(context),
          const SizedBox(width: 8),
          _buildMoreButton(context),
        ],
      ],
    );
  }

  Widget _buildAvatar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: colorScheme.primary, width: 1.5),
      ),
      padding: const EdgeInsets.all(1.5),
      child: AppAvatar(url: anchorInfo?.face ?? roomInfo!.userCover, size: 38),
    );
  }

  Widget _buildNameAndOnline(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Expanded(
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
              if (liveAnchorInfo != null) ...[
                const SizedBox(width: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Text(
                    '${t.common.up} ${liveAnchorInfo!.exp.masterLevel.level}',
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
                t.live.header.online(count: _liveHeaderFormatNumber(roomInfo!.online)),
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
    );
  }

  Widget _buildFollowButton(BuildContext context, WidgetRef ref) {
    if (anchorInfo == null || anchorInfo!.isFollowed) {
      return const SizedBox.shrink();
    }
    final session = ref.watch(currentUserProvider);
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FollowButton(
        isFollowed: false,
        onTap: (session?.isLoggedIn ?? false) ? (onFollow ?? () {}) : onLogin,
        height: 32,
        text: '+ ${t.actions.follow}',
      ),
    );
  }

  Widget _buildViewerStack(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    if (goldRank == null || goldRank!.list.isEmpty) {
      return const SizedBox.shrink();
    }

    final top3 = goldRank!.list.take(3).toList();

    return SizedBox(
      height: 32,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 20.0 + (top3.length - 1) * 14.0,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                for (int i = 0; i < top3.length; i++)
                  Positioned(left: i * 14.0, child: _buildViewerAvatar(top3[i].face)),
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
              _liveHeaderFormatNumber(goldRank!.onlineNum),
              style: TextStyle(
                color: colorScheme.onPrimary.withValues(alpha: 0.9),
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoreButton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return IconButton(
      icon: Icon(Icons.more_vert_rounded, color: colorScheme.onPrimary),
      onPressed: () {},
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
    );
  }

  Widget _buildViewerAvatar(String url) {
    return Container(
      width: 20,
      height: 20,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: AppAvatar(url: url, size: 20),
    );
  }
}
