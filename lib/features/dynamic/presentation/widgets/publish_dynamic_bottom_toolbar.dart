import 'package:flutter/material.dart';

class PublishDynamicBottomToolbar extends StatelessWidget {
  const PublishDynamicBottomToolbar({
    required this.charCount,
    required this.onPickImage,
    required this.onInsertMention,
    required this.onPickTopic,
    required this.onPickEmoji,
    super.key,
  });

  final int charCount;
  final VoidCallback onPickImage;
  final VoidCallback onInsertMention;
  final VoidCallback onPickTopic;
  final VoidCallback onPickEmoji;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 12,
        bottom: MediaQuery.paddingOf(context).bottom + 12,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(color: colorScheme.outlineVariant.withValues(alpha: 0.2)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _ToolbarAction(icon: Icons.image_outlined, onTap: onPickImage),
              const SizedBox(width: 24),
              _ToolbarAction(icon: Icons.alternate_email, onTap: onInsertMention),
              const SizedBox(width: 24),
              _ToolbarAction(icon: Icons.tag, onTap: onPickTopic),
              const SizedBox(width: 24),
              _ToolbarAction(icon: Icons.sentiment_satisfied_alt, onTap: onPickEmoji),
            ],
          ),
          Text('$charCount', style: TextStyle(color: colorScheme.outline, fontSize: 12)),
        ],
      ),
    );
  }
}

class _ToolbarAction extends StatelessWidget {
  const _ToolbarAction({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Icon(icon, size: 26, color: Theme.of(context).colorScheme.onSurface),
      ),
    );
  }
}
