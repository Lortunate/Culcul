import 'package:culcul/features/profile/controllers/user_space_controller.dart';
import 'package:culcul/ui/pages/profile/tabs/user_dynamic_tab.dart';
import 'package:culcul/ui/pages/profile/tabs/user_home_tab.dart';
import 'package:culcul/ui/pages/profile/tabs/user_video_tab.dart';
import 'package:culcul/ui/pages/profile/widgets/user_profile_app_bar.dart';
import 'package:culcul/ui/pages/profile/widgets/user_profile_info.dart';
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
    final profileAsync = ref.watch(userSpaceProvider(mid.toString()));
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    final tabController = useTabController(initialLength: 3);
    final scrollOffsetNotifier = useValueNotifier(0.0);
    final topPadding = MediaQuery.paddingOf(context).top + kToolbarHeight;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          profileAsync.when(
            data: (profile) => NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollUpdateNotification &&
                    notification.metrics.axis == Axis.vertical &&
                    notification.depth == 0) {
                  scrollOffsetNotifier.value = notification.metrics.pixels;
                }
                return false;
              },
              child: RefreshIndicator(
                edgeOffset: topPadding,
                onRefresh: () => ref.refresh(
                  userSpaceProvider(mid.toString()).future,
                ),
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverToBoxAdapter(
                        child: UserProfileInfo(profile: profile),
                      ),
                      // Add a spacer/divider to separate the profile info from the tabs
                      SliverToBoxAdapter(
                        child: Container(
                          height: 8,
                          color: theme.colorScheme.surfaceContainerHighest
                              .withValues(alpha: 0.3),
                        ),
                      ),
                      SliverOverlapAbsorber(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context,
                        ),
                        sliver: SliverPersistentHeader(
                          delegate: SliverTabBarDelegate(
                            TabBar(
                              controller: tabController,
                              tabs: const [
                                Tab(text: '主页'),
                                Tab(text: '动态'),
                                Tab(text: '投稿'),
                              ],
                              labelColor: colorScheme.primary,
                              labelStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                letterSpacing: 0.5,
                              ),
                              unselectedLabelColor:
                                  colorScheme.onSurfaceVariant,
                              unselectedLabelStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              indicator: UnderlineTabIndicator(
                                borderSide: BorderSide(
                                  width: 3,
                                  color: colorScheme.primary,
                                ),
                                borderRadius: BorderRadius.circular(2),
                                insets: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                              ),
                              indicatorSize: TabBarIndicatorSize.label,
                              dividerColor: Colors.transparent,
                              splashFactory: NoSplash.splashFactory,
                              overlayColor: WidgetStateProperty.all(
                                Colors.transparent,
                              ),
                            ),
                            topPadding: topPadding,
                          ),
                          pinned: true,
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(
                    controller: tabController,
                    children: [
                      UserHomeTab(
                        mid: mid,
                        onSwitchToTab: (index) =>
                            tabController.animateTo(index),
                      ),
                      UserDynamicTab(mid: mid),
                      UserVideoTab(mid: mid),
                    ],
                  ),
                ),
              ),
            ),
            error: (err, stack) => Center(
              child: AppErrorWidget(
                error: err,
                onRetry: () =>
                    ref.refresh(userSpaceProvider(mid.toString())),
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
