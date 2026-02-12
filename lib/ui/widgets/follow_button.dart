import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/providers/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FollowButton extends ConsumerWidget {
  final bool isFollowed;
  final VoidCallback onTap;
  final double? width;
  final double? height;
  final String? text;

  const FollowButton({
    super.key,
    required this.isFollowed,
    required this.onTap,
    this.width,
    this.height,
    this.text,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final authState = ref.watch(authProvider);

    return FilledButton(
      onPressed: () {
        if (!authState.isLoggedIn) {
          context.push('/login');
          return;
        }
        onTap();
      },
      style: FilledButton.styleFrom(
        backgroundColor: isFollowed
            ? colorScheme.surfaceContainerHighest
            : colorScheme.primary,
        foregroundColor: isFollowed
            ? colorScheme.onSurfaceVariant
            : colorScheme.onPrimary,
        elevation: 0,
        minimumSize: Size(width ?? 56, height ?? 32),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        visualDensity: VisualDensity.compact,
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(scale: animation, child: child),
          );
        },
        child: Text(
          text ??
              (isFollowed
                  ? t.video.actions.followed
                  : '+ ${t.video.actions.follow}'),
          key: ValueKey<bool>(isFollowed),
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
