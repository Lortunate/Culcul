import 'package:cilixili/core/theme/app_colors.dart';
import 'package:cilixili/i18n/strings.g.dart';
import 'package:cilixili/shared/widgets/app_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DynamicPage extends HookConsumerWidget {
  const DynamicPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final tabs = [
      t.moments.tabs.all,
      t.moments.tabs.video,
      t.moments.tabs.comprehensive,
    ];
    final tabController = useTabController(initialLength: tabs.length);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 16,
        backgroundColor: isDark
            ? AppColors.darkScaffoldBackground
            : Colors.white,
        title: Text(
          t.moments.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_note_rounded, size: 24),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search_rounded, size: 22),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
        bottom: AppTabBar(
          controller: tabController,
          tabs: tabs,
          isScrollable: false,
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: tabs.map((tab) => _DynamicEmptyState(tab: tab)).toList(),
      ),
    );
  }
}

class _DynamicEmptyState extends StatelessWidget {
  final String tab;

  const _DynamicEmptyState({required this.tab});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.auto_awesome_motion_outlined,
            size: 48,
            color: isDark ? Colors.grey[800] : Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            t.moments.empty(tab: tab),
            style: TextStyle(
              color: isDark ? Colors.grey[600] : Colors.grey[400],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
