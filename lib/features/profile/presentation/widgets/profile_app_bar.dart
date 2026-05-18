import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/core/contracts/user_session_contract.dart';
import 'package:culcul/features/auth/application/auth_session_providers.dart';
import 'package:culcul/features/profile/data/dtos/profile_user.dart';
import 'package:culcul/features/profile/presentation/view_models/profile_view_model.dart';
import 'package:culcul/ui/widgets/users/app_avatar.dart';
import 'package:culcul/ui/assemblies/users/user_tags.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'profile_app_bar.exp_bar.dart';

class ProfileAppBar extends ConsumerWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(currentUserProvider);
    final profile = ref.watch(myProfileProvider).value;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SliverAppBar(
      expandedHeight: 140,
      pinned: true,
      stretch: true,
      backgroundColor: colorScheme.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      actions: _buildActions(context),
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.zoomBackground],
        background: _HeaderBackground(profile: profile, session: session),
      ),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.settings_outlined, size: 22),
        onPressed: () => const SettingsRoute().push(context),
      ),
      const SizedBox(width: 8),
    ];
  }
}

class _HeaderBackground extends StatelessWidget {
  final ProfileUser? profile;
  final UserSession? session;

  const _HeaderBackground({required this.profile, required this.session});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: colorScheme.surface,
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
      alignment: Alignment.bottomLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _ProfileAvatar(profile: profile, session: session),
          const SizedBox(width: 20),
          Expanded(
            child: _ProfileDetails(profile: profile, session: session),
          ),
        ],
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  final ProfileUser? profile;
  final UserSession? session;

  const _ProfileAvatar({required this.profile, required this.session});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isVip = profile?.vipStatus == 1;

    return Hero(
      tag: 'profile_avatar',
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isVip ? colorScheme.primary : colorScheme.surfaceContainerHighest,
            width: 2,
          ),
        ),
        child: AppAvatar(url: profile?.avatarUrl ?? session?.avatarUrl, size: 80),
      ),
    );
  }
}

class _ProfileDetails extends StatelessWidget {
  final ProfileUser? profile;
  final UserSession? session;

  const _ProfileDetails({required this.profile, required this.session});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isVip = profile?.vipStatus == 1;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                profile?.username ?? session?.nickname ?? '',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isVip ? colorScheme.primary : colorScheme.onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (isVip) ...[
              const SizedBox(width: 8),
              VipTag(type: profile!.vipType, showShadow: true),
            ],
          ],
        ),
        const SizedBox(height: 8),

        if (profile != null)
          Row(
            children: [
              LevelTag(level: profile!.level),
              if (profile!.currentExp != null && profile!.currentMinExp != null) ...[
                const SizedBox(width: 12),
                Expanded(
                  child: _ExpBar(
                    current: profile!.currentExp!,
                    next: profile!.nextExp,
                    min: profile!.currentMinExp!,
                  ),
                ),
              ],
            ],
          ),

        if (profile?.bio != null && profile!.bio!.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            profile!.bio!,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }
}
