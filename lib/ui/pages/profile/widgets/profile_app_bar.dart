import 'package:culcul/core/router/router.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/providers/auth/auth_provider.dart';
import 'package:culcul/providers/profile/profile_provider.dart';
import 'package:culcul/ui/widgets/app_avatar.dart';
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
              // Avatar Section
              Hero(
                tag: 'profile_avatar',
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: profile?.vipStatus == 1
                          ? const Color(0xFFFB7299)
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
              
              // Info Section
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row 1: Username & VIP
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            profile?.username ?? user?.username ?? '',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: (profile?.vipStatus == 1)
                                  ? const Color(0xFFFB7299)
                                  : colorScheme.onSurface,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (profile?.vipStatus == 1) ...[
                          const SizedBox(width: 8),
                          _VipTag(type: profile!.vipType),
                        ],
                      ],
                    ),
                    
                    const SizedBox(height: 8),

                    // Row 2: Level & Exp
                    if (profile != null)
                      Row(
                        children: [
                          _LevelTag(level: profile.level),
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
                    
                    // Row 3: Bio
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

class _AssetItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color color;
  final String label;

  const _AssetItem({
    required this.icon,
    required this.value,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          value,
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.onSurface,
            fontSize: 14,
            fontFamily: 'Roboto', 
          ),
        ),
        const SizedBox(width: 2),
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.outline,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _ExpBar extends StatelessWidget {
  final int current;
  final int? next;
  final int min;

  const _ExpBar({
    required this.current,
    this.next,
    required this.min,
  });

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

class _VipTag extends StatelessWidget {
  final int type;
  const _VipTag({required this.type});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final isYear = type == 2;
    final color = const Color(0xFFFB7299);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        isYear ? t.profile.vip.annual_premium : t.profile.vip.premium,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          height: 1.1,
        ),
      ),
    );
  }
}

class _LevelTag extends StatelessWidget {
  final int level;
  const _LevelTag({required this.level});

  @override
  Widget build(BuildContext context) {
    final Color levelColor;
    switch (level) {
      case 0:
      case 1:
        levelColor = const Color(0xFFBFBFBF);
        break;
      case 2:
        levelColor = const Color(0xFF95DDB2);
        break;
      case 3:
        levelColor = const Color(0xFF92D1E5);
        break;
      case 4:
        levelColor = const Color(0xFFFFB37C);
        break;
      case 5:
        levelColor = const Color(0xFFFF6C00);
        break;
      case 6:
        levelColor = const Color(0xFFFF0000);
        break;
      default:
        levelColor = const Color(0xFFBFBFBF);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      decoration: BoxDecoration(
        border: Border.all(color: levelColor, width: 1.5),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        'LV$level',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w900,
          color: levelColor,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
