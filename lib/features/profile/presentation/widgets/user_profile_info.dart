import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:culcul/features/profile/domain/entities/profile_user.dart';
import 'package:culcul/features/profile/presentation/widgets/user_profile_banner.dart';
import 'package:culcul/features/profile/presentation/widgets/user_profile_buttons.dart';
import 'package:culcul/features/profile/presentation/widgets/user_profile_stat_item.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/app_avatar.dart';
import 'package:culcul/ui/widgets/app_image_preview.dart';
import 'package:culcul/ui/widgets/user_tags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'user_profile_info.sections.dart';

class UserProfileInfo extends HookConsumerWidget {
  final ProfileUser? profile;

  static const double _bannerHeight = 160.0;
  static const double _avatarSize = 88.0;
  static const double _borderRadius = 20.0;

  const UserProfileInfo({super.key, required this.profile});

  void _showImagePreview(BuildContext context, String? url) {
    if (url == null || url.isEmpty) return;
    AppImagePreview.open(context, imageUrls: [url], initialIndex: 0);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = profile;
    if (user == null) {
      return const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final theme = Theme.of(context);
    final isExpanded = useState(false);
    final authState = ref.watch(authProvider);
    final isSelf =
        authState.isLoggedIn && authState.user?.id.toString() == user.id.toString();

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              height: _bannerHeight + 20,
              width: double.infinity,
              child: UserProfileBanner(
                bannerUrl: user.bannerUrl,
                onTap: () => _showImagePreview(context, user.bannerUrl),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: _bannerHeight),
              child: Container(
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(_borderRadius),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _StatsRow(user: user, isSelf: isSelf, avatarSize: _avatarSize),
                    _UserIdentity(user: user),
                    if (user.isVerified) const _VerifiedBadge(),
                    const SizedBox(height: 12),
                    _UidTag(uid: user.id),
                    if (user.bio != null && user.bio!.isNotEmpty)
                      _BioSection(
                        bio: user.bio!,
                        isExpanded: isExpanded.value,
                        onToggle: () => isExpanded.value = !isExpanded.value,
                      ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
            Positioned(
              top: _bannerHeight - (_avatarSize * 0.4),
              left: 20,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  shape: BoxShape.circle,
                ),
                child: AppAvatar(
                  url: user.avatarUrl,
                  size: _avatarSize,
                  onTap: () => _showImagePreview(context, user.avatarUrl),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
