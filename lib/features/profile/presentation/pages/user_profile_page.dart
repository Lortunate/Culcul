import 'package:culcul/features/profile/presentation/view_models/user_space_view_model.dart';
import 'package:culcul/features/profile/presentation/widgets/tabs/user_dynamic_tab.dart';
import 'package:culcul/features/profile/presentation/widgets/tabs/user_home_tab.dart';
import 'package:culcul/features/profile/presentation/widgets/tabs/user_video_tab.dart';
import 'package:culcul/features/profile/presentation/widgets/user_profile_app_bar.dart';
import 'package:culcul/features/profile/presentation/widgets/user_profile_info.dart';
import 'package:culcul/features/profile/domain/entities/profile_user.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/app_error_widget.dart';
import 'package:culcul/ui/widgets/sliver_tab_bar_delegate.dart';
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
              child: AppErrorWidget(error: err, onRetry: () => ref.refresh(provider)),
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
            SliverToBoxAdapter(child: UserProfileInfo(profile: profile)),
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

