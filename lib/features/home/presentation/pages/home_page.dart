import 'dart:async';

import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/shared/perf/startup_perf_logger.dart';
import 'package:culcul/features/home/presentation/widgets/home_app_bar.dart';
import 'package:culcul/features/home/presentation/widgets/live_view.dart';
import 'package:culcul/features/home/presentation/widgets/popular_view.dart';
import 'package:culcul/features/home/presentation/widgets/recommend_view.dart';
import 'package:culcul/features/home/presentation/view_models/home_page_view_model.dart';
import 'package:culcul/features/search/presentation/view_models/search_view_model.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef _HomeTabItem = ({String title, Widget Function() buildView});

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  static const int _recommendTabIndex = 1;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final hintText = useState<String?>(null);
    final visitedTabs = useState<Set<int>>(<int>{_recommendTabIndex});
    final tabs = useMemoized(() => _buildTabs(t), [t]);
    final tabController = useTabController(initialLength: tabs.length, initialIndex: 1);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        StartupPerfLogger.log(StartupPerfEvent.homeReady);
        unawaited(_loadHintText(context: context, ref: ref, hintText: hintText));
      });
      return null;
    }, const []);

    useEffect(() {
      void listener() {
        final index = tabController.index;
        if (visitedTabs.value.contains(index)) {
          return;
        }
        visitedTabs.value = <int>{...visitedTabs.value, index};
      }

      tabController.addListener(listener);
      return () => tabController.removeListener(listener);
    }, [tabController]);

    return Scaffold(
      appBar: HomeAppBar(
        tabController: tabController,
        tabs: tabs.map((e) => e.title).toList(),
        onTabTap: (index) {
          if (!visitedTabs.value.contains(index)) {
            visitedTabs.value = <int>{...visitedTabs.value, index};
          }
          ref
              .read(homePageViewModelProvider.notifier)
              .onTabTapped(index, isChanging: tabController.indexIsChanging);
        },
        onSearchTap: () => const SearchRoute().push(context),
        hintText: hintText.value,
        onAvatarTap: () => const ProfileRoute().go(context),
        onMessageTap: () => const NotificationRoute().push(context),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          for (final (index, tab) in tabs.indexed)
            visitedTabs.value.contains(index) ? tab.buildView() : const SizedBox.shrink(),
        ],
      ),
    );
  }

  static Future<void> _loadHintText({
    required BuildContext context,
    required WidgetRef ref,
    required ValueNotifier<String?> hintText,
  }) async {
    try {
      final hint = await ref.read(defaultSearchProvider.future);
      if (!context.mounted) {
        return;
      }
      hintText.value = hint?.text;
    } catch (_) {
      // Keep default fallback hint when preload fails.
    }
  }

  List<_HomeTabItem> _buildTabs(Translations t) => [
    (title: t.home.tabs.live, buildView: () => const LiveView()),
    (title: t.home.tabs.recommend, buildView: () => const RecommendView()),
    (title: t.home.tabs.hot, buildView: () => const PopularView()),
  ];
}
