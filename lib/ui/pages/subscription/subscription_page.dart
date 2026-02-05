import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/app_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SubscriptionPage extends HookConsumerWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final tabs = [
      t.subscription.tabs.video,
      t.subscription.tabs.anime,
      t.subscription.tabs.series,
    ];
    final tabController = useTabController(initialLength: tabs.length);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 16,
        backgroundColor: colorScheme.surface,
        scrolledUnderElevation: 0,
        title: Text(
          t.subscription.title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.subscriptions_outlined,
            size: 64,
            color: colorScheme.outlineVariant,
          ),
          const SizedBox(height: 16),
          Text(
            t.subscription.empty(tab: tab),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}
