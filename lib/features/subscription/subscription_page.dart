import 'package:cilixili/core/theme/app_colors.dart';
import 'package:cilixili/i18n/strings.g.dart';
import 'package:cilixili/shared/widgets/app_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SubscriptionPage extends HookConsumerWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final tabs = [
      t.subscription.tabs.video,
      t.subscription.tabs.anime,
      t.subscription.tabs.series,
    ];
    final tabController = useTabController(initialLength: tabs.length);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 16,
        backgroundColor: isDark
            ? AppColors.darkScaffoldBackground
            : Colors.white,
        title: Text(
          t.subscription.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
          ),
        ),
        actions: [
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
        children: tabs.map((tab) => _SubscriptionEmptyState(tab: tab)).toList(),
      ),
    );
  }
}

class _SubscriptionEmptyState extends StatelessWidget {
  final String tab;

  const _SubscriptionEmptyState({required this.tab});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.subscriptions_outlined,
            size: 48,
            color: isDark ? Colors.grey[800] : Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            t.subscription.empty(tab: tab),
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
