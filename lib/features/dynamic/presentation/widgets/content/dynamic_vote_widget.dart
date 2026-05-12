import 'package:culcul/features/dynamic/domain/entities/dynamic_content_entities.dart';
import 'package:culcul/features/dynamic/presentation/widgets/content/dynamic_content_surface.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class DynamicVoteWidget extends StatelessWidget {
  final DynamicAdditional additional;

  const DynamicVoteWidget({super.key, required this.additional});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    return DynamicContentSurface(
      padding: const EdgeInsets.all(12),
      borderRadius: BorderRadius.circular(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            additional.title ?? t.moments.vote,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            t.moments.vote_stats(
              participants: additional.voteJoinNum.toString(),
              options: additional.voteChoiceCnt.toString(),
            ),
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
