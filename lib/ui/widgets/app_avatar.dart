import 'package:culcul/ui/widgets/app_clickable.dart';
import 'package:culcul/ui/widgets/app_network_image.dart';
import 'package:flutter/material.dart';

class AppAvatar extends StatelessWidget {
  final String? url;
  final double size;
  final VoidCallback? onTap;
  final BoxBorder? border;

  const AppAvatar({super.key, this.url, this.size = 32, this.onTap, this.border});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final hasUrl = url?.isNotEmpty == true;

    final fallbackIcon = Icon(
      Icons.account_circle,
      color: colorScheme.primary,
      size: size,
    );

    return AppClickable(
      onTap: onTap,
      borderRadius: BorderRadius.circular(size / 2),
      child: Container(
        width: size,
        height: size,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.08),
              blurRadius: size * 0.15,
              offset: Offset(0, size * 0.05),
            ),
          ],
          border:
              border ??
              Border.all(
                color: colorScheme.outlineVariant.withValues(alpha: 0.2),
                width: 0.5,
              ),
        ),
        child: hasUrl
            ? AppNetworkImage(
                url: url!,
                width: size,
                height: size,
                borderRadius: size / 2,
                placeholder: Center(child: fallbackIcon),
                errorWidget: Center(child: fallbackIcon),
              )
            : Center(child: fallbackIcon),
      ),
    );
  }
}
