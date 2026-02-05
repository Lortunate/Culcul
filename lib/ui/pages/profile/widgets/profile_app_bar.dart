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
      expandedHeight: 200,
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
        background: Stack(
          children: [
            // Background Gradient
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      colorScheme.primaryContainer.withValues(alpha: 0.2),
                      colorScheme.surface,
                    ],
                  ),
                ),
              ),
            ),
            // Decorative Element (Optional - subtle circle in background)
            Positioned(
              right: -50,
              top: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.primary.withValues(alpha: 0.05),
                ),
              ),
            ),
            
            // Content
            Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              alignment: Alignment.bottomLeft,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start, // Align to top of avatar
                mainAxisAlignment: MainAxisAlignment.end, // Align bottom
                children: [
                  // Avatar Section
                  Padding(
                    padding: const EdgeInsets.only(top: 4), // Slight visual alignment
                    child: Hero(
                      tag: 'profile_avatar',
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: profile?.vipStatus == 1
                                ? const Color(0xFFFB7299)
                                : colorScheme.surface,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: colorScheme.shadow.withValues(alpha: 0.1),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: AppAvatar(
                          url: profile?.avatarUrl ?? user?.avatarUrl,
                          size: 76,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  
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
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20,
                                  color: (profile?.vipStatus == 1)
                                      ? const Color(0xFFFB7299)
                                      : colorScheme.onSurface,
                                  letterSpacing: -0.5,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (profile?.vipStatus == 1) ...[
                              const SizedBox(width: 6),
                              _VipTag(type: profile!.vipType),
                            ],
                          ],
                        ),
                        
                        // Row 2: Bio (Sign)
                        if (profile?.bio != null && profile!.bio!.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          Text(
                            profile.bio!,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                              fontSize: 12,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],

                        if (profile != null) ...[
                          const SizedBox(height: 10),
                          
                          // Row 3: Level & Exp
                          Row(
                            children: [
                              _LevelTag(level: profile.level),
                              if (profile.currentExp != null &&
                                  profile.currentMinExp != null) ...[
                                const SizedBox(width: 8),
                                Expanded(
                                  child: _ExpBar(
                                    current: profile.currentExp!,
                                    next: profile.nextExp,
                                    min: profile.currentMinExp!,
                                  ),
                                ),
                              ] else 
                                const Spacer(),
                            ],
                          ),

                          const SizedBox(height: 12),

                          // Row 4: Assets (Coins & BCoins)
                          Row(
                            children: [
                              if (profile.coins != null) ...[
                                _AssetItem(
                                  icon: Icons.monetization_on_rounded,
                                  value: profile.coins!.toStringAsFixed(1),
                                  color: const Color(0xFF23ADE5),
                                  label: '硬币',
                                ),
                              ],
                              if (profile.coins != null && profile.bCoins != null)
                                Container(
                                  height: 10,
                                  width: 1,
                                  margin: const EdgeInsets.symmetric(horizontal: 12),
                                  color: colorScheme.outlineVariant,
                                ),
                              if (profile.bCoins != null)
                                _AssetItem(
                                  icon: Icons.copyright_rounded,
                                  value: profile.bCoins!.toStringAsFixed(0),
                                  color: const Color(0xFFF3CB2D),
                                  label: 'B币',
                                ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
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
