import 'package:culcul/ui/theme/culcul_tokens.dart';
import 'package:culcul/ui/widgets/feedback/app_shimmer.dart';
import 'package:culcul/ui/widgets/layout/refresh_header_footer.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

class PrivateSessionSkeletonList extends StatelessWidget {
  const PrivateSessionSkeletonList({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      onRefresh: () async {}, // No-op for skeleton
      header: const AppRefreshHeader(),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: CulculSpacing.md,
          vertical: CulculSpacing.sm,
        ),
        itemCount: 15,
        separatorBuilder: (context, index) => const SizedBox(height: CulculSpacing.md),
        itemBuilder: (context, index) => const _PrivateSessionSkeletonItem(),
      ),
    );
  }
}

class _PrivateSessionSkeletonItem extends StatelessWidget {
  const _PrivateSessionSkeletonItem();

  @override
  Widget build(BuildContext context) {
    return const AppShimmer(
      child: Row(
        children: [
          AppShimmerBox(width: 48, height: 48, borderRadius: CulculRadius.xl),
          SizedBox(width: CulculSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppShimmerBox(width: 120, height: 16),
                SizedBox(height: CulculSpacing.xs),
                AppShimmerBox(width: double.infinity, height: 14),
              ],
            ),
          ),
          SizedBox(width: CulculSpacing.md),
          AppShimmerBox(width: 40, height: 12),
        ],
      ),
    );
  }
}

class ChatMessageSkeletonList extends StatelessWidget {
  const ChatMessageSkeletonList({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      // Note: ChatPage usually has reverse: true.
      // If we want to simulate that, we should use reverse: true here too,
      // or just list items from bottom up visually.
      // Since it's a skeleton, order matters less, but let's match the visual density.
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: CulculSpacing.sm,
          vertical: CulculSpacing.md,
        ),
        itemCount: 10,
        separatorBuilder: (context, index) => const SizedBox(height: CulculSpacing.lg),
        itemBuilder: (context, index) {
          final isSelf = index % 2 == 0;
          return _ChatMessageSkeletonItem(isSelf: isSelf);
        },
      ),
    );
  }
}

class _ChatMessageSkeletonItem extends StatelessWidget {
  final bool isSelf;

  const _ChatMessageSkeletonItem({required this.isSelf});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: Row(
        mainAxisAlignment: isSelf ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isSelf) ...[
            const AppShimmerBox(width: 40, height: 40, borderRadius: 20),
            const SizedBox(width: CulculSpacing.xs),
          ],
          Container(
            width: 150 + (isSelf ? 30.0 : 0.0), // Randomize slightly
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.only(
                topLeft: CulculRadius.radiusMd,
                topRight: CulculRadius.radiusMd,
                bottomLeft: isSelf ? CulculRadius.radiusMd : CulculRadius.radiusXs,
                bottomRight: isSelf ? CulculRadius.radiusXs : CulculRadius.radiusMd,
              ),
            ),
          ),
          if (isSelf) ...[
            const SizedBox(width: CulculSpacing.xs),
            const AppShimmerBox(width: 40, height: 40, borderRadius: 20),
          ],
        ],
      ),
    );
  }
}
