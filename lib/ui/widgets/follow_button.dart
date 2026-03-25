import 'package:culcul/features/auth/controllers/auth_controller.dart';
import 'package:culcul/i18n/strings.g.dart';
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

  void _handlePressed(BuildContext context, WidgetRef ref) {
    final authState = ref.read(authProvider);
    if (!authState.isLoggedIn) {
      context.push('/login');
      return;
    }
    onTap();
  }

  String _resolveLabel(Translations t) {
    return text ?? (isFollowed ? t.actions.followed : '+ ${t.actions.follow}');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    ref.watch(authProvider);

    return FilledButton(
      onPressed: () => _handlePressed(context, ref),
      style: FilledButton.styleFrom(
        backgroundColor: isFollowed ? colorScheme.primaryContainer : colorScheme.primary,
        foregroundColor: isFollowed
            ? colorScheme.onPrimaryContainer
            : colorScheme.onPrimary,
        elevation: 0,
        minimumSize: Size(width ?? 56, height ?? 32),
        fixedSize: height != null ? Size.fromHeight(height!) : null,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        shape: shape ?? const StadiumBorder(),
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
            Text(
              _resolveLabel(t),
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

