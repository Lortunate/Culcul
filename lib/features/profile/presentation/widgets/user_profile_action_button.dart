import 'package:flutter/material.dart';

class UserProfileActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final double size;

  const UserProfileActionButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.size = 44,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size(size, size),
        fixedSize: Size(size, size),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: BorderSide(color: colorScheme.outline.withValues(alpha: 0.2)),
        backgroundColor: colorScheme.surface,
      ),
      child: Icon(icon, size: size * 0.45, color: colorScheme.onSurfaceVariant),
    );
  }
}

