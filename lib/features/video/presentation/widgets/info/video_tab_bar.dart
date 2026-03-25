import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class VideoTabBar extends StatelessWidget {
  final TabController controller;

  const VideoTabBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
            width: 0.5,
          ),
        ),
      ),
      child: TabBar(
        controller: controller,
        indicatorColor: colorScheme.primary,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorWeight: 2,
        labelColor: colorScheme.primary,
        unselectedLabelColor: colorScheme.onSurfaceVariant,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        dividerColor: Colors.transparent,
        tabs: [
          Tab(text: t.video.tabs.info),
          Tab(text: t.video.tabs.comment),
        ],
      ),
    );
  }
}

