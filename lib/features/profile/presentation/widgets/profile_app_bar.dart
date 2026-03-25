import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/features/auth/controllers/auth_controller.dart';
import 'package:culcul/features/profile/providers/profile_provider.dart';
import 'package:culcul/ui/widgets/app_avatar.dart';
import 'package:culcul/ui/widgets/user_tags.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileAppBar extends ConsumerWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final profile = ref.watch(myProfileProvider).value;
    final user = authState.user;

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
        background: _HeaderBackground(profile: profile, user: user),
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
  final dynamic profile;
  final dynamic user;

  const _HeaderBackground({required this.profile, required this.user});

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
          _ProfileAvatar(profile: profile, user: user),
          const SizedBox(width: 20),
          Expanded(
            child: _ProfileDetails(profile: profile, user: user),
          ),
        ],
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  final dynamic profile;
  final dynamic user;

  const _ProfileAvatar({required this.profile, required this.user});

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
        child: AppAvatar(url: profile?.avatarUrl ?? user?.avatarUrl, size: 80),
      ),
    );
  }
}

class _ProfileDetails extends StatelessWidget {
  final dynamic profile;
  final dynamic user;

  const _ProfileDetails({required this.profile, required this.user});

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
                profile?.username ?? user?.username ?? '',
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

class _ExpBar extends StatelessWidget {
  final int current;
  final int? next;
  final int min;

  const _ExpBar({required this.current, this.next, required this.min});

  double _calculateProgress() {
    if (next != null && next! > min) {
      return ((current - min) / (next! - min)).clamp(0.0, 1.0);
    }
    return 1.0;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final progress = _calculateProgress();

    return Row(
      children: [
        Expanded(
          child: Container(
            height: 6,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(3),
            ),
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [colorScheme.tertiary, colorScheme.primary],
                  ),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          next != null ? '$current/$next' : '$current',
          style: theme.textTheme.labelSmall?.copyWith(
            fontSize: 10,
            color: colorScheme.outline,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

