import 'package:culcul/shared/utils/share_utils.dart';
import 'package:culcul/features/profile/domain/entities/profile_user.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/shared/widgets/app_bottom_sheet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
                _buildIconButton(
                  context,
                  icon: Icons.arrow_back,
                  color: contentColor,
                  backgroundColor: iconBackgroundColor,
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Opacity(
                    opacity: opacity,
                    child: Text(
                      profile?.username ?? '',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: contentColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                _buildIconButton(
                  context,
                  icon: Icons.search,
                  color: contentColor,
                  backgroundColor: iconBackgroundColor,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(t.profile.space_search_coming_soon)),
                    );
                  },
                ),
                _buildIconButton(
                  context,
                  icon: Icons.more_vert,
                  color: contentColor,
                  backgroundColor: iconBackgroundColor,
                  onPressed: () => _showMoreMenu(context),
                ),
                const SizedBox(width: 4),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showMoreMenu(BuildContext context) {
    showAppModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.share_outlined),
            title: Text(t.actions.share),
            onTap: () {
              Navigator.pop(context);
              if (profile != null) {
                ShareUtils.shareUser(profile!.id, profile!.username);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.block_outlined),
            title: Text(t.profile.menu.blacklist),
            onTap: () {
              Navigator.pop(context);
              // TODO: Block
            },
          ),
          ListTile(
            leading: const Icon(Icons.report_gmailerrorred_outlined),
            title: Text(t.profile.menu.report),
            onTap: () {
              Navigator.pop(context);
              // TODO: Report
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildIconButton(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required Color backgroundColor,
    required VoidCallback onPressed,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(shape: BoxShape.circle, color: backgroundColor),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: color, size: 22),
        constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
        style: IconButton.styleFrom(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
      ),
    );
  }
}
