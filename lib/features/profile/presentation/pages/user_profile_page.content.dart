part of 'user_profile_page.dart';

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
                delegate: SliverTabBarDelegate(
                  _buildUserProfileTabBar(
                    tabController: tabController,
                    colorScheme: colorScheme,
                    tabs: tabs,
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
              UserHomeTab(mid: mid, onSwitchToTab: tabController.animateTo),
              UserDynamicTab(mid: mid),
              UserVideoTab(mid: mid),
            ],
          ),
        ),
      ),
    );
  }
}

TabBar _buildUserProfileTabBar({
  required TabController tabController,
  required ColorScheme colorScheme,
  required List<Tab> tabs,
}) => TabBar(
  controller: tabController,
  tabs: tabs,
  labelColor: colorScheme.primary,
  labelStyle: const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15,
    letterSpacing: 0.5,
  ),
  unselectedLabelColor: colorScheme.onSurfaceVariant,
  unselectedLabelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
  indicator: UnderlineTabIndicator(
    borderSide: BorderSide(width: 3, color: colorScheme.primary),
    borderRadius: BorderRadius.circular(2),
    insets: const EdgeInsets.symmetric(horizontal: 20),
  ),
  indicatorSize: TabBarIndicatorSize.label,
  dividerColor: Colors.transparent,
  splashFactory: NoSplash.splashFactory,
  overlayColor: WidgetStateProperty.all(Colors.transparent),
);
