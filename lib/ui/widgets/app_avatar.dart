import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/app_clickable.dart';
import 'package:culcul/ui/widgets/app_network_image.dart';
import 'package:flutter/material.dart';

class AppAvatar extends StatelessWidget {
  final String? url;
  final double size;
  final VoidCallback? onTap;
  final BoxBorder? border;

  const AppAvatar({
    super.key,
    this.url,
    this.size = 32,
    this.onTap,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);
    final hasUrl = url?.isNotEmpty == true;

    return AppClickable(
      onTap: onTap,
      borderRadius: BorderRadius.circular(size / 2),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: hasUrl
              ? colorScheme.surfaceContainerHighest
              : colorScheme.primaryContainer,
          border:
              border ??
              (hasUrl
                  ? Border.all(
                      color: colorScheme.outlineVariant.withValues(alpha: 0.2),
                      width: 0.5,
                    )
                  : null),
        ),
        clipBehavior: Clip.antiAlias,
        child: hasUrl
            ? AppNetworkImage(
                url: url!,
                width: size,
                height: size,
                borderRadius: size / 2,
                placeholder: Icon(
                  Icons.person_rounded,
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                  size: size * 0.6,
                ),
                errorWidget: Icon(
                  Icons.person_rounded,
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                  size: size * 0.6,
                ),
              )
            : Center(
                child: Text(
                  t.auth.login,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: size * 0.35,
                  ),
                ),
              ),
      ),
    );
  }
}
