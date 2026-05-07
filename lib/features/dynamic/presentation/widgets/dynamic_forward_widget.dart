import 'package:culcul/features/dynamic/domain/entities/dynamic_entities.dart';
import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/features/dynamic/presentation/widgets/content/dynamic_content_surface.dart';
import 'package:culcul/features/dynamic/presentation/widgets/dynamic_content_widget.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/buttons/app_clickable.dart';
import 'package:flutter/material.dart';

class DynamicForwardWidget extends StatelessWidget {
  final DynamicItem post;

  const DynamicForwardWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    return DynamicContentSurface(
      padding: const EdgeInsets.all(12),
      borderRadius: BorderRadius.circular(6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppClickable(
                haptic: true,
                onTap: () => _openUserProfile(context),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    '@${post.authorName}',
                    style: TextStyle(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              if (post.description == null || post.description!.isEmpty) ...[
                const Text(' : '),
                Text(t.moments.forward_post, style: const TextStyle(fontSize: 15)),
              ],
            ],
          ),
          const SizedBox(height: 4),
          DynamicContentWidget(post: post),
        ],
      ),
    );
  }

  void _openUserProfile(BuildContext context) {
    UserProfileRoute(mid: post.authorMid).push(context);
  }
}
