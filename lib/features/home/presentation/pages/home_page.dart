import 'dart:async';

import 'package:culcul/features/home/presentation/view_models/home_tab_sync_controller.dart';
import 'package:culcul/features/home/presentation/widgets/home_app_bar.dart';
import 'package:culcul/features/home/presentation/widgets/live_view.dart';
import 'package:culcul/features/home/presentation/widgets/popular_view.dart';
import 'package:culcul/features/home/presentation/widgets/recommend_view.dart';
import 'package:culcul/features/search/application/search_application_providers.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/core/perf/dev_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef _HomeTabItem = ({String title, Widget Function() buildView});

class HomePage extends HookConsumerWidget {
  final VoidCallback onOpenSearch;
  final VoidCallback onOpenProfile;
  final VoidCallback onOpenNotification;
  final ValueChanged<int> onOpenLiveRoom;
  final ValueChanged<String> onOpenVideo;

  const HomePage({
    super.key,
    required this.onOpenSearch,
    required this.onOpenProfile,
    required this.onOpenNotification,
    required this.onOpenLiveRoom,
    required this.onOpenVideo,
  });

  static const int _recommendTabIndex = 1;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final hintText = useState<String?>(null);
    final visitedTabs = useState<Set<int>>(<int>{_recommendTabIndex});
    final tabs = useMemoized(() => _buildTabs(t), [t, onOpenLiveRoom, onOpenVideo]);
    final tabController = useTabController(initialLength: tabs.length, initialIndex: 1);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        DevLogger.log('startup', 'home_ready');
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
              .read(homeTabSyncControllerProvider.notifier)
              .onTabTapped(index, isChanging: tabController.indexIsChanging);
        },
        onSearchTap: onOpenSearch,
        hintText: hintText.value,
        onAvatarTap: onOpenProfile,
        onMessageTap: onOpenNotification,
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
      hintText.value = hint;
    } catch (_) {
      // Keep default fallback hint when preload fails.
    }
  }

  List<_HomeTabItem> _buildTabs(Translations t) => [
    (title: t.home.tabs.live, buildView: () => LiveView(onOpenRoom: onOpenLiveRoom)),
    (
      title: t.home.tabs.recommend,
      buildView: () => RecommendView(onOpenVideo: onOpenVideo),
    ),
    (title: t.home.tabs.hot, buildView: () => PopularView(onOpenVideo: onOpenVideo)),
  ];
}
