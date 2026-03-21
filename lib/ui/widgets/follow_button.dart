import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FollowButton extends ConsumerWidget {
  final bool isFollowed;
  final VoidCallback onTap;
  final double? width;
  final double? height;
  final String? text;
  final OutlinedBorder? shape;

  const FollowButton({
    super.key,
    required this.isFollowed,
    required this.onTap,
    this.width,
    this.height,
    this.text,
    this.shape,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
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
            ? colorScheme.surfaceContainerHighest.withValues(
                alpha: 0.5,
              ) // Lighter grey for followed
            : colorScheme.primary, // Theme primary color for follow
        foregroundColor: isFollowed
            ? colorScheme.onSurfaceVariant
            : colorScheme.onPrimary,
        elevation: 0,
        minimumSize: Size(width ?? 56, height ?? 32),
        fixedSize: height != null ? Size.fromHeight(height!) : null,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape:
            shape ??
            (isFollowed
                ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))
                : const StadiumBorder()),
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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          key: ValueKey<bool>(isFollowed),
          children: [
            if (isFollowed) ...[
              const Icon(Icons.menu, size: 16),
              const SizedBox(width: 4),
            ],
            Text(
              text ??
                  (isFollowed
                      ? '已关注' // Use explicit text for now or verify translation
                      : '+ ${t.video.actions.follow}'),
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
