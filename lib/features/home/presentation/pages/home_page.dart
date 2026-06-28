import 'dart:async';

import 'package:culcul/core/perf/dev_logger.dart';
import 'package:culcul/features/auth/application/auth_session_providers.dart';
import 'package:culcul/features/auth/presentation/widgets/login_panel.dart';
import 'package:culcul/features/home/presentation/hooks/use_home_scroll_sync.dart';
import 'package:culcul/features/home/presentation/widgets/live_view.dart';
import 'package:culcul/features/home/presentation/widgets/popular_view.dart';
import 'package:culcul/features/home/presentation/widgets/recommend_view.dart';
import 'package:culcul/features/search/application/search_application_providers.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/responsive/app_responsive.dart';
import 'package:culcul/ui/widgets/inputs/app_search_bar.dart';
import 'package:culcul/ui/widgets/users/app_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
    final tabs = useMemoized(
      () => [
        (title: t.home.tabs.live, buildView: () => LiveView(onOpenRoom: onOpenLiveRoom)),
        (
          title: t.home.tabs.recommend,
          buildView: () => RecommendView(onOpenVideo: onOpenVideo),
        ),
        (title: t.home.tabs.hot, buildView: () => PopularView(onOpenVideo: onOpenVideo)),
      ],
      [t, onOpenLiveRoom, onOpenVideo],
    );
    final tabController = useTabController(initialLength: tabs.length, initialIndex: 1);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        DevLogger.log('startup', 'home_ready');
        unawaited(() async {
          try {
            final hint = await ref.read(defaultSearchProvider.future);
            if (!context.mounted) {
              return;
            }
            hintText.value = hint;
          } catch (_) {
            // Keep default fallback hint when preload fails.
          }
        }());
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
      appBar: _HomeAppBar(
        tabController: tabController,
        tabs: tabs.map((e) => e.title).toList(),
        onTabTap: (index) {
          if (!visitedTabs.value.contains(index)) {
            visitedTabs.value = <int>{...visitedTabs.value, index};
          }
          notifyHomeTabTapped(ref, index, isChanging: tabController.indexIsChanging);
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
}

class _HomeAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final TabController tabController;
  final List<String> tabs;
  final VoidCallback? onSearchTap;
  final String? hintText;
  final VoidCallback onAvatarTap;
  final VoidCallback onMessageTap;
  final ValueChanged<int>? onTabTap;

  const _HomeAppBar({
    required this.tabController,
    required this.tabs,
    required this.onAvatarTap,
    required this.onMessageTap,
    this.onSearchTap,
    this.hintText,
    this.onTabTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);
    final isDesktop = context.isDesktopLayout;
    final authState = ref.watch(
      currentUserProvider.select(
        (session) =>
            (isLoggedIn: session?.isLoggedIn ?? false, avatarUrl: session?.avatarUrl),
      ),
    );

    return AppBar(
      backgroundColor: colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      titleSpacing: isDesktop ? 16 : 12,
      centerTitle: false,
      leadingWidth: isDesktop ? 52 : 44,
      leading: Padding(
        padding: EdgeInsets.only(left: isDesktop ? 16 : 12),
        child: Center(
          child: AppAvatar(
            url: authState.avatarUrl,
            onTap: () {
              if (authState.isLoggedIn) {
                onAvatarTap();
                return;
              }
              showLoginDialog(context);
            },
          ),
        ),
      ),
      title: Align(
        alignment: Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: isDesktop ? 560 : double.infinity),
          child: AppSearchBar(
            onTap: onSearchTap,
            hintText: hintText ?? t.home.search_hint,
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.mail_outline_rounded,
            size: 24,
            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.9),
          ),
          onPressed: () {
            if (authState.isLoggedIn) {
              onMessageTap();
              return;
            }
            showLoginDialog(context);
          },
          visualDensity: VisualDensity.compact,
          style: IconButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(40, 40),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        SizedBox(width: isDesktop ? 12 : 8),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(44),
        child: Container(
          height: 44,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            border: Border(
              bottom: BorderSide(
                color: colorScheme.outlineVariant.withValues(alpha: 0.1),
                width: 0.5,
              ),
            ),
          ),
          child: TabBar(
            controller: tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.center,
            onTap: onTabTap,
            tabs: tabs.map((tab) => Tab(text: tab)).toList(growable: false),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 44);
}
