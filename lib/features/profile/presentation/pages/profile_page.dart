import 'package:culcul/features/auth/application/auth_session_providers.dart';
import 'package:culcul/features/profile/presentation/widgets/profile_action_grid.dart';
import 'package:culcul/features/profile/presentation/widgets/profile_app_bar.dart';
import 'package:culcul/features/profile/presentation/widgets/guest_profile_view.dart';
import 'package:culcul/features/profile/presentation/widgets/profile_menu.dart';
import 'package:culcul/features/profile/presentation/widgets/profile_stats.dart';
import 'package:culcul/ui/responsive/responsive_container.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfilePage extends HookConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(currentUserProvider);

    if (!(session?.isLoggedIn ?? false)) {
      return const Scaffold(
        body: ResponsiveContentContainer(maxWidth: 760, child: GuestProfileView()),
      );
    }

    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLow,
      body: const CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          ProfileAppBar(),
          ProfileStats(),
          SliverToBoxAdapter(child: SizedBox(height: 12)),
          ProfileActionGrid(),
          SliverToBoxAdapter(child: SizedBox(height: 12)),
          ProfileMenu(),
          SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}
