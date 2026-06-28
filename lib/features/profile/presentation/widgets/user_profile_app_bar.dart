import 'package:culcul/core/feedback/app_feedback.dart';
import 'package:culcul/core/theme/culcul_tokens.dart';
import 'package:culcul/features/profile/models/profile_user.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class UserProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ProfileUser? profile;
  final ValueListenable<double> scrollOffset;

  const UserProfileAppBar({super.key, this.profile, required this.scrollOffset});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return ValueListenableBuilder<double>(
      valueListenable: scrollOffset,
      builder: (context, offset, child) {
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;
        final topPadding = MediaQuery.paddingOf(context).top;

        const double fadeStart = 0;
        const double fadeEnd = 120;
        final double opacity = ((offset - fadeStart) / (fadeEnd - fadeStart)).clamp(
          0.0,
          1.0,
        );
        final bool isScrolled = opacity > 0.8;

        final Color backgroundColor = theme.scaffoldBackgroundColor.withValues(
          alpha: opacity,
        );
        final Color contentColor = isScrolled
            ? colorScheme.onSurface
            : colorScheme.onPrimary;
        final Color iconBackgroundColor = isScrolled
            ? Colors.transparent
            : colorScheme.scrim.withValues(alpha: 0.3);
        final iconButtonStyle = IconButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        );

        final SystemUiOverlayStyle overlayStyle = isScrolled
            ? (theme.brightness == Brightness.dark
                  ? SystemUiOverlayStyle.light
                  : SystemUiOverlayStyle.dark)
            : SystemUiOverlayStyle.light;

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: overlayStyle,
          child: Container(
            padding: EdgeInsets.only(top: topPadding),
            height: kToolbarHeight + topPadding,
            decoration: BoxDecoration(
              color: backgroundColor,
              border: isScrolled
                  ? Border(
                      bottom: BorderSide(
                        color: theme.dividerColor.withValues(alpha: 0.1),
                        width: 0.5,
                      ),
                    )
                  : null,
            ),
            child: Row(
              children: [
                const SizedBox(width: 4),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: iconBackgroundColor,
                  ),
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.arrow_back, color: contentColor, size: 22),
                    constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                    style: iconButtonStyle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    profile?.username ?? '',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: contentColor.withValues(alpha: opacity),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: iconBackgroundColor,
                  ),
                  child: IconButton(
                    onPressed: () {
                      context.showAppFeedback(t.profile.space_search_coming_soon);
                    },
                    icon: Icon(Icons.search, color: contentColor, size: 22),
                    constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                    style: iconButtonStyle,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: iconBackgroundColor,
                  ),
                  child: IconButton(
                    onPressed: () {
                      showModalBottomSheet<void>(
                        context: context,
                        backgroundColor: colorScheme.surface,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: CulculRadius.radiusLg),
                        ),
                        clipBehavior: Clip.antiAlias,
                        builder: (context) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: const Icon(Icons.share_outlined),
                              title: Text(t.actions.share),
                              onTap: () {
                                Navigator.pop(context);
                                if (profile != null) {
                                  final url = 'https://space.bilibili.com/${profile!.id}';
                                  SharePlus.instance.share(
                                    ShareParams(
                                      text:
                                          'Check out ${profile!.username} on Bilibili!\n$url',
                                      subject: profile!.username,
                                    ),
                                  );
                                }
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.block_outlined),
                              title: Text(t.profile.menu.blacklist),
                              onTap: () {
                                Navigator.pop(context);
                                context.showAppFeedback(
                                  t.common.coming_soon(tab: t.profile.menu.blacklist),
                                );
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.report_gmailerrorred_outlined),
                              title: Text(t.profile.menu.report),
                              onTap: () {
                                Navigator.pop(context);
                                context.showAppFeedback(
                                  t.common.coming_soon(tab: t.profile.menu.report),
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      );
                    },
                    icon: Icon(Icons.more_vert, color: contentColor, size: 22),
                    constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                    style: iconButtonStyle,
                  ),
                ),
                const SizedBox(width: 4),
              ],
            ),
          ),
        );
      },
    );
  }
}
