import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/features/auth/controllers/auth_controller.dart';
import 'package:culcul/features/auth/presentation/widgets/login_dialog.dart';
import 'package:culcul/features/home/presentation/widgets/home_app_bar.dart';
import 'package:culcul/features/home/presentation/widgets/popular_view.dart';
import 'package:culcul/features/home/presentation/widgets/recommend_view.dart';
import 'package:culcul/features/home/presentation/live/live_view.dart';
import 'package:culcul/features/home/presentation/home_events.dart';
import 'package:culcul/features/search/controllers/search_controller.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef _HomeTabItem = ({String title, Widget view});

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final defaultSearchAsync = ref.watch(defaultSearchProvider);
    final authState = ref.watch(authProvider);

    final tabs = useMemoized(() => _buildTabs(t), [t]);

    final tabController = useTabController(initialLength: tabs.length, initialIndex: 1);

    return Scaffold(
      appBar: HomeAppBar(
        tabController: tabController,
        tabs: tabs.map((e) => e.title).toList(),
        onTabTap: (index) =>
            _handleTabTap(index: index, controller: tabController, ref: ref),
        onSearchTap: () => const SearchRoute().push(context),
        hintText: defaultSearchAsync.asData?.value?.showName,
        onAvatarTap: () => _handleAvatarTap(context, authState.isLoggedIn),
        onMessageTap: () => const NotificationRoute().push(context),
        onGameTap: () {},
      ),
      body: TabBarView(
        controller: tabController,
        children: tabs.map((e) => e.view).toList(),
      ),
    );
  }

  List<_HomeTabItem> _buildTabs(Translations t) => [
    (title: t.home.tabs.live, view: const LiveView()),
    (title: t.home.tabs.recommend, view: const RecommendView()),
    (title: t.home.tabs.hot, view: const PopularView()),
  ];

  void _handleTabTap({
    required int index,
    required TabController controller,
    required WidgetRef ref,
  }) {
    if (controller.indexIsChanging) return;
    ref.read(homeTabTapProvider.notifier).update(HomeTabTapEvent(index));
  }

  void _handleAvatarTap(BuildContext context, bool isLoggedIn) {
    if (isLoggedIn) {
      const ProfileRoute().go(context);
      return;
    }
    LoginDialog.show(context);
  }
}

