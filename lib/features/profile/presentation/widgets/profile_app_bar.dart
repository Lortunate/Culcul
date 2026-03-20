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
    final profileAsync = ref.watch(myProfileProvider);
    final profile = profileAsync.value;
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
      actions: [
        IconButton(
          icon: const Icon(Icons.qr_code_scanner_rounded, size: 22),
          onPressed: () => const ScannerRoute().push(context),
        ),
        IconButton(
          icon: const Icon(Icons.settings_outlined, size: 22),
          onPressed: () => const SettingsRoute().push(context),
        ),
        const SizedBox(width: 8),
      ],
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.zoomBackground],
        background: Container(
          color: colorScheme.surface,
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
          alignment: Alignment.bottomLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: 'profile_avatar',
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: profile?.vipStatus == 1
                          ? colorScheme.primary
                          : colorScheme.surfaceContainerHighest,
                      width: 2,
                    ),
                  ),
                  child: AppAvatar(
                    url: profile?.avatarUrl ?? user?.avatarUrl,
                    size: 80,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
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
                              color: (profile?.vipStatus == 1)
                                  ? colorScheme.primary
                                  : colorScheme.onSurface,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (profile?.vipStatus == 1) ...[
                          const SizedBox(width: 8),
                          VipTag(type: profile!.vipType, showShadow: true),
                        ],
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (profile != null)
                      Row(
                        children: [
                          LevelTag(level: profile.level),
                          if (profile.currentExp != null &&
                              profile.currentMinExp != null) ...[
                            const SizedBox(width: 12),
                            Expanded(
                              child: _ExpBar(
                                current: profile.currentExp!,
                                next: profile.nextExp,
                                min: profile.currentMinExp!,
                              ),
                            ),
                          ],
                        ],
                      ),
                    if (profile?.bio != null && profile!.bio!.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        profile.bio!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExpBar extends StatelessWidget {
  final int current;
  final int? next;
  final int min;

  const _ExpBar({required this.current, this.next, required this.min});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    double progress = 0.0;
    if (next != null && next! > min) {
      progress = (current - min) / (next! - min);
    } else if (next == null) {
      progress = 1.0;
    }
    progress = progress.clamp(0.0, 1.0);

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
                  gradient: const LinearGradient(
                    colors: [Color(0xFFF3CB2D), Color(0xFFFF9E00)],
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
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
