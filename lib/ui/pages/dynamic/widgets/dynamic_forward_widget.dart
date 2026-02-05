import 'package:culcul/domain/entities/dynamic_post.dart';
import 'package:culcul/ui/pages/dynamic/widgets/dynamic_content_widget.dart';
import 'package:flutter/material.dart';

class DynamicForwardWidget extends StatelessWidget {
  final DynamicPost post;

  const DynamicForwardWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '@${post.authorName}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
                if (post.description == null || post.description!.isEmpty) ...[
                  const TextSpan(text: ' : '),
                  const TextSpan(
                    text: '转发动态',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 4),
          DynamicContentWidget(post: post),
        ],
      ),
    );
  }
}
