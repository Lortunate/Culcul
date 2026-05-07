import 'package:culcul/core/constants/app_dimens.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class PrivacyErrorWidget extends StatelessWidget {
  final String? title;
  final String? message;
  final IconData icon;

  const PrivacyErrorWidget({
    super.key,
    this.title,
    this.message,
    this.icon = Icons.lock_outline_rounded,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final t = Translations.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: AppDimens.iconHuge, color: colorScheme.onSurfaceVariant),
          const SizedBox(height: AppDimens.p16),
          Text(
            title ?? t.profile.privacy_title,
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppDimens.p8),
          Text(
            message ?? t.profile.privacy_message,
            style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
