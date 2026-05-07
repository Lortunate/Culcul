import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
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

  String _resolveLabel(Translations t) {
    return text ?? (isFollowed ? t.actions.followed : '+ ${t.actions.follow}');
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Semantics(
      label: _resolveLabel(t),
      button: true,
      child: FilledButton(
      onPressed: onTap,
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
        child: Text(
          _resolveLabel(t),
          key: ValueKey<bool>(isFollowed),
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
      ),
    ),
    );
  }
}
