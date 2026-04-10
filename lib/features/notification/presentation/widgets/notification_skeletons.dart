import 'package:culcul/shared/widgets/app_shimmer.dart';
import 'package:culcul/shared/widgets/refresh_header_footer.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: 15,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) => const _PrivateSessionSkeletonItem(),
      ),
    );
  }
}

class _PrivateSessionSkeletonItem extends StatelessWidget {
  const _PrivateSessionSkeletonItem();

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: Row(
        children: [
          const AppShimmerBox(width: 48, height: 48, borderRadius: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                AppShimmerBox(width: 120, height: 16, borderRadius: 4),
                SizedBox(height: 8),
                AppShimmerBox(width: double.infinity, height: 14, borderRadius: 4),
              ],
            ),
          ),
          const SizedBox(width: 16),
          const AppShimmerBox(width: 40, height: 12, borderRadius: 4),
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
      header:
          null, // Chat usually doesn't refresh from top in this context (history is top)
      footer: null, // Skeleton doesn't need footer
      // Note: ChatPage usually has reverse: true.
      // If we want to simulate that, we should use reverse: true here too,
      // or just list items from bottom up visually.
      // Since it's a skeleton, order matters less, but let's match the visual density.
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        itemCount: 10,
        separatorBuilder: (context, index) => const SizedBox(height: 24),
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
            const SizedBox(width: 8),
          ],
          Container(
            width: 150 + (isSelf ? 30.0 : 0.0), // Randomize slightly
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12),
                topRight: const Radius.circular(12),
                bottomLeft: Radius.circular(isSelf ? 12 : 4),
                bottomRight: Radius.circular(isSelf ? 4 : 12),
              ),
            ),
          ),
          if (isSelf) ...[
            const SizedBox(width: 8),
            const AppShimmerBox(width: 40, height: 40, borderRadius: 20),
          ],
        ],
      ),
    );
  }
}
