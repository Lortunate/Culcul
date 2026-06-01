import 'package:culcul/features/auth/application/auth_session_providers.dart';
import 'package:culcul/features/profile/domain/entities/profile_user.dart';
import 'package:culcul/features/profile/state/user_space_view_model.dart';
import 'package:culcul/features/profile/presentation/widgets/profile_navigation_scope.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/buttons/follow_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserProfileButtons extends ConsumerWidget {
  final ProfileUser profile;
  final bool isSelf;
  final double height;
  final double borderRadius;

  const UserProfileButtons({
    super.key,
    required this.profile,
    required this.isSelf,
    this.height = 36,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final navigation = ProfileNavigationScope.of(context);

    if (isSelf) {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: navigation.onOpenSettings,
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size(double.infinity, height),
                fixedSize: Size.fromHeight(height),
                side: BorderSide(color: colorScheme.outline.withValues(alpha: 0.3)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                backgroundColor: colorScheme.surface,
                foregroundColor: colorScheme.onSurface,
                elevation: 0,
              ),
              child: Text(
                t.profile.actions.edit_profile,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),
            ),
          ),
        ],
      );
    }

    return Row(
      children: [
        Expanded(
          child: FollowButton(
            isFollowed: profile.isFollowing,
            onTap: () {
              final session = ref.read(currentUserProvider);
              if (!(session?.isLoggedIn ?? false)) {
                navigation.onLogin();
                return;
              }
              ref.read(userSpaceProvider(profile.id).notifier).toggleFollow();
            },
            height: height,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        ),
        OutlinedButton(
          onPressed: () {
            navigation.onOpenChat(
              talkerId: int.parse(profile.id),
              name: profile.username,
              avatarUrl: profile.avatarUrl,
            );
          },
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size(height, height),
            fixedSize: Size(height, height),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            side: BorderSide(color: colorScheme.outline.withValues(alpha: 0.2)),
            backgroundColor: colorScheme.surface,
          ),
          child: Icon(
            Icons.mail_outline_rounded,
            size: height * 0.45,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
