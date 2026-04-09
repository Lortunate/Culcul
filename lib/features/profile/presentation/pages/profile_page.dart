import 'package:culcul/features/auth/auth.dart';
import 'package:culcul/core/responsive/responsive.dart';
import 'package:culcul/features/profile/presentation/widgets/profile_action_grid.dart';
import 'package:culcul/features/profile/presentation/widgets/profile_app_bar.dart';
import 'package:culcul/features/profile/presentation/widgets/guest_profile_view.dart';
import 'package:culcul/features/profile/presentation/widgets/profile_menu.dart';
import 'package:culcul/features/profile/presentation/widgets/profile_stats.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfilePage extends HookConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    if (!authState.isLoggedIn) {
      return const Scaffold(
        body: ResponsiveContentContainer(maxWidth: 760, child: GuestProfileView()),
      );
    }

    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLow,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const ProfileAppBar(),
          const ProfileStats(),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          const ProfileActionGrid(),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          const ProfileMenu(),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}
