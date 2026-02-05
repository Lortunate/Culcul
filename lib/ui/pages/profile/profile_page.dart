import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/providers/auth/auth_provider.dart';
import 'package:culcul/ui/pages/profile/widgets/profile_action_grid.dart';
import 'package:culcul/ui/pages/profile/widgets/profile_app_bar.dart';
import 'package:culcul/ui/pages/profile/widgets/profile_menu.dart';
import 'package:culcul/ui/pages/profile/widgets/profile_stats.dart';
import 'package:culcul/ui/widgets/guest_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfilePage extends HookConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    if (!authState.isLoggedIn) {
      return GuestView(
        title: t.profile.not_logged_in,
        message: t.profile.login_hint,
      );
    }

    return const Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          ProfileAppBar(),
          SliverToBoxAdapter(child: SizedBox(height: 16)),
          ProfileStats(),
          SliverToBoxAdapter(child: SizedBox(height: 16)),
          ProfileActionGrid(),
          SliverToBoxAdapter(child: SizedBox(height: 16)),
          ProfileMenu(),
        ],
      ),
    );
  }
}
