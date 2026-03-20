
import 'package:culcul/core/constants/app_dimens.dart';
import 'package:flutter/material.dart';

class PrivacyErrorWidget extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;

  const PrivacyErrorWidget({
    super.key,
    this.title = '该用户设置了隐私',
    this.message = '无法查看关注/粉丝列表',
    this.icon = Icons.lock_outline_rounded,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: AppDimens.iconHuge,
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: AppDimens.p16),
          Text(
            title,
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppDimens.p8),
          Text(
            message,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
