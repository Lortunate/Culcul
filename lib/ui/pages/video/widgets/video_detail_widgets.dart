import 'package:culcul/core/router/router.dart';
import 'package:culcul/providers/auth/auth_provider.dart';
import 'package:culcul/shared/extensions/format_extensions.dart';
import 'package:culcul/data/models/video_model.dart';
import 'package:culcul/data/models/index.dart';
import 'package:culcul/data/models/extensions/video_mapping.dart';
import 'package:culcul/providers/video/video_detail_controller.dart';
import 'package:culcul/providers/video/video_detail_state.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/follow_button.dart';
import 'package:culcul/ui/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

class VideoTabBar extends StatelessWidget {
  final TabController controller;

  const VideoTabBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
            width: 0.5,
          ),
        ),
      ),
      child: TabBar(
        controller: controller,
        indicatorColor: colorScheme.primary,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorWeight: 2,
        labelColor: colorScheme.primary,
        unselectedLabelColor: colorScheme.onSurfaceVariant,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        dividerColor: Colors.transparent,
        tabs: [
          Tab(text: t.video.tabs.info),
          Tab(text: t.video.tabs.comment),
        ],
      ),
    );
  }
}

class UploaderSection extends StatelessWidget {
  final Owner owner;
  final bool isFollowed;
  final VoidCallback onToggleFollow;

  const UploaderSection({
    super.key,
    required this.owner,
    required this.isFollowed,
    required this.onToggleFollow,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        AppAvatar(
          url: owner.face,
          size: 34,
          onTap: () => UserProfileRoute(mid: owner.mid).push(context),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: GestureDetector(
            onTap: () => UserProfileRoute(mid: owner.mid).push(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  owner.name,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '12.5万粉丝 · 168视频',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
        FollowButton(isFollowed: isFollowed, onTap: onToggleFollow),
      ],
    );
  }
}

class FollowButton extends ConsumerWidget {
  final bool isFollowed;
  final VoidCallback onTap;

  const FollowButton({super.key, required this.isFollowed, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final authState = ref.watch(authProvider);

    return FilledButton(
      onPressed: () {
        if (!authState.isLoggedIn) {
          context.push('/login');
          return;
        }
        onTap();
      },
      style: FilledButton.styleFrom(
        backgroundColor: isFollowed
            ? colorScheme.surfaceContainerHighest
            : colorScheme.primary,
        foregroundColor:
            isFollowed ? colorScheme.onSurfaceVariant : colorScheme.onPrimary,
        elevation: 0,
        minimumSize: const Size(56, 28),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        visualDensity: VisualDensity.compact,
      ),
      child: Text(
        isFollowed ? '已关注' : '+ 关注',
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class VideoStatsRow extends StatelessWidget {
  final VideoDetail detail;

  const VideoStatsRow({super.key, required this.detail});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final style = theme.textTheme.labelSmall?.copyWith(
      color: colorScheme.onSurfaceVariant,
    );
    final d = DateTime.fromMillisecondsSinceEpoch(detail.pubDate * 1000);
    final date =
        '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

    return Wrap(
      spacing: 10,
      runSpacing: 4,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        IconText(
          icon: Icons.play_circle_outline_rounded,
          text: detail.stat.view.formatNumber,
        ),
        IconText(
          icon: Icons.list_alt_outlined,
          text: detail.stat.danmaku.formatNumber,
        ),
        Text(date, style: style),
        Text('BV${detail.bvid}', style: style),
      ],
    );
  }
}

class ExpandableDescriptionAndTags extends HookWidget {
  final String description;
  final List<VideoTag> tags;

  const ExpandableDescriptionAndTags({
    super.key,
    required this.description,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AppClickable(
      onTap: () => isExpanded.value = !isExpanded.value,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    description.isEmpty ? '暂无简介' : description,
                    maxLines: isExpanded.value ? null : 1,
                    overflow: isExpanded.value ? null : TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      height: 1.6,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  isExpanded.value
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  size: 20,
                  color: colorScheme.onSurfaceVariant,
                ),
              ],
            ),
            if (isExpanded.value && tags.isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: tags
                    .take(12)
                    .map((tag) => CompactTag(tag: tag))
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class CompactTag extends StatelessWidget {
  final VideoTag tag;

  const CompactTag({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        tag.tagName,
        style: theme.textTheme.labelSmall?.copyWith(
          color: colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class VideoActionsRow extends ConsumerWidget {
  final VideoDetailState state;
  final VideoDetailController notifier;

  const VideoActionsRow({
    super.key,
    required this.state,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = state.videoDetail!;
    final t = Translations.of(context);
    final authState = ref.watch(authProvider);

    void checkLoginAndAction(VoidCallback action) {
      if (!authState.isLoggedIn) {
        context.push('/login');
        return;
      }
      action();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ActionButton(
            icon: Icons.thumb_up_outlined,
            label: d.stat.like.formatNumber,
            onTap: () => checkLoginAndAction(() => notifier.toggleLike()),
          ),
          ActionButton(
            icon: Icons.thumb_down_outlined,
            label: t.video.actions.unlike,
            onTap: () => checkLoginAndAction(() => notifier.toggleDislike()),
          ),
          ActionButton(
            icon: Icons.monetization_on_outlined,
            label: d.stat.coin.formatNumber,
            onTap: () => checkLoginAndAction(() => notifier.sendCoin()),
          ),
          ActionButton(
            icon: Icons.star_outline_rounded,
            label: d.stat.favorite.formatNumber,
            onTap: () => checkLoginAndAction(() => notifier.toggleFavorite()),
          ),
          ActionButton(
            icon: Icons.share_outlined,
            label: d.stat.share.formatNumber,
            onTap: () => notifier.share(), // Share usually doesn't require login
          ),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AppClickable(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 22, color: colorScheme.onSurfaceVariant),
            const SizedBox(height: 4),
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                fontSize: 10,
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoPartsSection extends StatelessWidget {
  final List<VideoPage> pages;
  final int currentCid;
  final ValueChanged<int> onPartChanged;

  const VideoPartsSection({
    super.key,
    required this.pages,
    required this.currentCid,
    required this.onPartChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text(
                '${t.video.parts} (${pages.length})',
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.chevron_right_rounded,
                size: 20,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 32,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: pages.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final page = pages[index];
              final isSelected = page.cid == currentCid;
              return AppClickable(
                onTap: () => onPartChanged(page.cid),
                borderRadius: BorderRadius.circular(6),
                backgroundColor: isSelected
                    ? colorScheme.primaryContainer.withValues(alpha: 0.5)
                    : colorScheme.surfaceContainerHighest.withValues(
                        alpha: 0.4,
                      ),
                child: Container(
                  constraints: const BoxConstraints(minWidth: 80),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: isSelected
                          ? colorScheme.primary
                          : Colors.transparent,
                      width: 1,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'P${page.page} ${page.part}',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: isSelected
                          ? colorScheme.primary
                          : colorScheme.onSurface,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class RecommendationsSection extends StatelessWidget {
  final List<RelatedVideo> videos;

  const RecommendationsSection({super.key, required this.videos});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = Translations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Text(
            t.video.recommend,
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.95,
          ),
          itemCount: videos.length,
          itemBuilder: (context, index) =>
              RecommendationItem(video: videos[index]),
        ),
      ],
    );
  }
}

class RecommendationItem extends StatelessWidget {
  final RelatedVideo video;

  const RecommendationItem({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return VideoCard(
      video: video.toVideoModel(),
      onTap: () => VideoDetailRoute(bvid: video.bvid).push(context),
    );
  }
}
