import 'package:culcul/providers/user_space/user_space_provider.dart';
import 'package:culcul/ui/pages/profile/tabs/user_dynamic_tab.dart';
import 'package:culcul/ui/pages/profile/tabs/user_home_tab.dart';
import 'package:culcul/ui/pages/profile/tabs/user_video_tab.dart';
import 'package:culcul/ui/pages/profile/widgets/user_profile_header.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserProfilePage extends ConsumerStatefulWidget {
  final int mid;
  const UserProfilePage({super.key, required this.mid});

  @override
  ConsumerState<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends ConsumerState<UserProfilePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(userSpaceProvider(widget.mid.toString()));

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            UserProfileHeader(profile: profileAsync.value),
            SliverPersistentHeader(
              delegate: _SliverTabBarDelegate(
                TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: '主页'),
                    Tab(text: '动态'),
                    Tab(text: '投稿'),
                  ],
                  labelColor: Theme.of(context).colorScheme.primary,
                  unselectedLabelColor: Theme.of(context).colorScheme.onSurfaceVariant,
                  indicatorColor: Theme.of(context).colorScheme.primary,
                ),
              ),
              pinned: true,
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            UserHomeTab(mid: widget.mid),
            UserDynamicTab(mid: widget.mid),
            UserVideoTab(mid: widget.mid),
          ],
        ),
      ),
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverTabBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return false;
  }
}
