import 'package:cilixili/features/home/widgets/home_app_bar.dart';
import 'package:cilixili/features/home/widgets/recommend_view.dart';
import 'package:cilixili/features/search/providers/search_provider.dart';
import 'package:cilixili/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
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
      t.home.tabs.new_journey,
    ];

    final tabController = useTabController(
      initialLength: tabs.length,
      initialIndex: 1,
    );

    return Scaffold(
      appBar: HomeAppBar(
        tabController: tabController,
        tabs: tabs,
        onSearchTap: () => context.push('/search'),
        hintText: defaultSearchAsync.asData?.value?.showName,
        onAvatarTap: () => StatefulNavigationShell.of(context).goBranch(3),
        onMessageTap: () {},
        onGameTap: () {},
      ),
      body: TabBarView(
        controller: tabController,
        children: tabs.map((tab) {
          if (tab == t.home.tabs.recommend) {
            return const RecommendView();
          }
          return _EmptyTab(tab: tab);
        }).toList(),
      ),
    );
  }
}

class _EmptyTab extends StatelessWidget {
  final String tab;
  const _EmptyTab({required this.tab});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.upcoming_outlined,
            size: 48,
            color: isDark ? Colors.grey[800] : Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            t.common.coming_soon(tab: tab),
            style: TextStyle(
              color: isDark ? Colors.grey[600] : Colors.grey[400],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
