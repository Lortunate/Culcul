import 'package:culcul/features/profile/state/user_space_view_model.dart';
import 'package:culcul/features/dynamic/presentation/widgets/user_dynamic_feed.dart';
import 'package:culcul/features/profile/presentation/widgets/home_tab/masterpiece_section.dart';
import 'package:culcul/features/profile/presentation/widgets/home_tab/recent_video_section.dart';
import 'package:culcul/features/profile/presentation/widgets/home_tab/sticky_video_section.dart';
import 'package:culcul/features/profile/presentation/widgets/user_video_tab.dart';
import 'package:culcul/features/profile/presentation/widgets/user_profile_app_bar.dart';
import 'package:culcul/features/profile/presentation/widgets/user_profile_info.dart';
import 'package:culcul/features/profile/domain/entities/profile_user.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserProfilePage extends HookConsumerWidget {
  final int mid;
  const UserProfilePage({super.key, required this.mid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final provider = userSpaceProvider('$mid');
    final profileAsync = ref.watch(provider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final tabController = useTabController(initialLength: 3);
    final scrollOffsetNotifier = useValueNotifier(0.0);
    final topPadding = MediaQuery.paddingOf(context).top + kToolbarHeight;

    final userProfileTabs = [
      Tab(text: t.profile.tabs.home),
      Tab(text: t.profile.tabs.moments),
      Tab(text: t.profile.tabs.contribution),
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          profileAsync.when(
            data: (profile) => _UserProfileContent(
              profile: profile,
              mid: mid,
              theme: theme,
              colorScheme: colorScheme,
              tabController: tabController,
              tabs: userProfileTabs,
              topPadding: topPadding,
              scrollOffsetNotifier: scrollOffsetNotifier,
              onRefresh: () => ref.refresh(provider.future),
            ),
            error: (err, stack) => Center(
              child: AppErrorWidget(
                error: err,
                stackTrace: stack,
                onRetry: () => ref.refresh(provider),
              ),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: UserProfileAppBar(
              profile: profileAsync.value,
              scrollOffset: scrollOffsetNotifier,
            ),
          ),
        ],
      ),
    );
  }
}

class _UserProfileContent extends StatelessWidget {
  const _UserProfileContent({
    required this.profile,
    required this.mid,
    required this.theme,
    required this.colorScheme,
    required this.tabController,
    required this.tabs,
    required this.topPadding,
    required this.scrollOffsetNotifier,
    required this.onRefresh,
  });

  final ProfileUser profile;
  final int mid;
  final ThemeData theme;
  final ColorScheme colorScheme;
  final TabController tabController;
  final List<Tab> tabs;
  final double topPadding;
  final ValueNotifier<double> scrollOffsetNotifier;
  final RefreshCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification case ScrollUpdateNotification(
          metrics: final metrics,
          depth: 0,
        ) when metrics.axis == Axis.vertical) {
          scrollOffsetNotifier.value = metrics.pixels;
        }
        return false;
      },
      child: RefreshIndicator(
        edgeOffset: topPadding,
        onRefresh: onRefresh,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(child: UserProfileHeader(profile: profile)),
            SliverToBoxAdapter(
              child: Container(
                height: 8,
                color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
              ),
            ),
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverPersistentHeader(
                delegate: _UserProfileTabBarDelegate(
                  TabBar(
                    controller: tabController,
                    tabs: tabs,
                    labelColor: colorScheme.primary,
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      letterSpacing: 0.5,
                    ),
                    unselectedLabelColor: colorScheme.onSurfaceVariant,
                    unselectedLabelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(width: 3, color: colorScheme.primary),
                      borderRadius: BorderRadius.circular(2),
                      insets: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                    indicatorSize: TabBarIndicatorSize.label,
                    dividerColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                  ),
                  topPadding: topPadding,
                ),
                pinned: true,
              ),
            ),
          ],
          body: TabBarView(
            controller: tabController,
            children: [
              _UserHomeTab(mid: mid, onSwitchToTab: tabController.animateTo),
              UserDynamicFeed(mid: mid),
              UserVideoTab(mid: mid),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserHomeTab extends ConsumerStatefulWidget {
  final int mid;
  final ValueChanged<int>? onSwitchToTab;

  const _UserHomeTab({required this.mid, this.onSwitchToTab});

  @override
  ConsumerState<_UserHomeTab> createState() => _UserHomeTabState();
}

class _UserHomeTabState extends ConsumerState<_UserHomeTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomScrollView(
      key: PageStorageKey<String>('user_home_tab_${widget.mid}'),
      slivers: [
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(top: 12),
          sliver: StickyVideoSection(mid: widget.mid),
        ),
        MasterpieceSection(mid: widget.mid),
        RecentVideoSection(mid: widget.mid, onSwitchToTab: widget.onSwitchToTab),
        SliverToBoxAdapter(
          child: SizedBox(height: MediaQuery.paddingOf(context).bottom + 24),
        ),
      ],
    );
  }
}

class _UserProfileTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  final double topPadding;

  _UserProfileTabBarDelegate(this.tabBar, {this.topPadding = 0});

  double get _extent => tabBar.preferredSize.height + topPadding;

  @override
  double get minExtent => _extent;

  @override
  double get maxExtent => _extent;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.only(top: topPadding),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        border: Border(
          bottom: BorderSide(color: theme.dividerColor.withValues(alpha: 0.05)),
        ),
      ),
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_UserProfileTabBarDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar || topPadding != oldDelegate.topPadding;
  }
}
