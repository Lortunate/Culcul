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
            : const Color(0xFFFB7299), // Bilibili Pink for follow action
        foregroundColor:
            isFollowed ? colorScheme.onSurfaceVariant : Colors.white,
        elevation: 0,
        minimumSize: Size(width ?? 56, height ?? 28),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        visualDensity: VisualDensity.compact,
      ),
      child: Text(
        text ?? (isFollowed ? '已关注' : '+ 关注'),
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}
