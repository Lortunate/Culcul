import 'package:culcul/features/profile/presentation/view_models/user_space_view_model.dart';
import 'package:culcul/features/profile/presentation/widgets/user_dynamic_tab.dart';
import 'package:culcul/features/profile/presentation/widgets/user_home_tab.dart';
import 'package:culcul/features/profile/presentation/widgets/user_video_tab.dart';
import 'package:culcul/features/profile/presentation/widgets/user_profile_app_bar.dart';
import 'package:culcul/features/profile/presentation/widgets/user_profile_info.dart';
import 'package:culcul/features/profile/domain/entities/profile_user.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:culcul/ui/widgets/layout/sliver_tab_bar_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'user_profile_page.content.dart';

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
              child: AppErrorWidget(
                error: err,
                stackTrace: stack,
                onRetry: () => ref.refresh(provider),
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
