import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/core/utils/format_extensions.dart';
import 'package:flutter/material.dart';

class VideoTabBar extends StatelessWidget {
  final TabController controller;
  final int? commentCount;

  const VideoTabBar({super.key, required this.controller, this.commentCount});

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
      child: SizedBox(
        height: 38,
        child: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  controller: controller,
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  indicatorColor: colorScheme.primary,
                  indicatorWeight: 2.5,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: colorScheme.primary,
                  unselectedLabelColor: colorScheme.onSurfaceVariant,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 16),
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12.5,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.5,
                  ),
                  dividerColor: Colors.transparent,
                  tabs: [
                    Tab(text: t.video.tabs.info),
                    Tab(
                      text: commentCount == null
                          ? t.video.tabs.comment
                          : '${t.video.tabs.comment} ${commentCount!.formatNumber}',
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: colorScheme.outlineVariant.withValues(alpha: 0.7),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                  child: Icon(Icons.subtitles_outlined, size: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
