import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/features/auth/feature_scope.dart';
import 'package:culcul/features/profile/data/dtos/profile_user.dart';
import 'package:culcul/features/profile/presentation/view_models/user_space_view_model.dart';
import 'package:culcul/features/notification/route_entry.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/profile/presentation/widgets/user_profile_action_button.dart';
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

    if (isSelf) {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => const SettingsRoute().push(context),
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
                const LoginRoute().push(context);
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
        UserProfileActionButton(
          icon: Icons.mail_outline_rounded,
          onTap: () {
            ChatRoute(
              talkerId: int.parse(profile.id),
              $extra: ChatRouteInput(
                name: profile.username,
                avatarUrl: profile.avatarUrl,
              ),
            ).push(context);
          },
          size: height,
        ),
      ],
    );
  }
}
