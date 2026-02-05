import 'package:culcul/core/router/router.dart';
import 'package:culcul/ui/pages/home/widgets/home_app_bar.dart';
import 'package:culcul/ui/pages/home/widgets/home_empty_tab.dart';
import 'package:culcul/ui/pages/home/widgets/popular_view.dart';
import 'package:culcul/ui/pages/home/widgets/recommend_view.dart';
import 'package:culcul/ui/pages/home/widgets/bangumi_view.dart';
import 'package:culcul/ui/pages/home/live/live_view.dart';
import 'package:culcul/ui/pages/home/home_events.dart';
import 'package:culcul/providers/search/search_provider.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final defaultSearchAsync = ref.watch(defaultSearchProvider);
    final tabs = [
      t.home.tabs.live,
      t.home.tabs.recommend,
      t.home.tabs.hot,
      t.home.tabs.anime,
      t.home.tabs.cinema,
    ];

    final tabController = useTabController(
      initialLength: tabs.length,
      initialIndex: 1,
    );

    return Scaffold(
      appBar: HomeAppBar(
        tabController: tabController,
        tabs: tabs,
        onTabTap: (index) {
          if (!tabController.indexIsChanging) {
            ref
                .read(homeTabTapProvider.notifier)
                .update(HomeTabTapEvent(index));
          }
        },
        onSearchTap: () => const SearchRoute().push(context),
        hintText: defaultSearchAsync.asData?.value?.showName,
        onAvatarTap: () => const ProfileRoute().go(context),
        onMessageTap: () => const NotificationRoute().push(context),
        onGameTap: () {},
      ),
      body: TabBarView(
        controller: tabController,
        children: tabs.map((tab) {
          if (tab == t.home.tabs.live) {
            return const LiveView();
          }
          if (tab == t.home.tabs.recommend) {
            return const RecommendView();
          }
          if (tab == t.home.tabs.hot) {
            return const PopularView();
          }
          if (tab == t.home.tabs.anime) {
            return const BangumiView();
          }
          return HomeEmptyTab(tab: tab);
        }).toList(),
      ),
    );
  }
}
