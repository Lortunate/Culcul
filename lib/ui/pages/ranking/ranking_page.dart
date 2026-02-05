import 'package:culcul/ui/widgets/app_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:culcul/domain/entities/ranking_category.dart';
import 'package:culcul/ui/pages/ranking/widgets/ranking_list_view.dart';

class RankingPage extends StatelessWidget {
  const RankingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return DefaultTabController(
      length: rankingCategoriesV2.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '排行榜',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          titleSpacing: 16,
          centerTitle: false,
          backgroundColor: colorScheme.surface,
          scrolledUnderElevation: 0,
          bottom: AppTabBar(
            tabs: rankingCategoriesV2.map((category) => category.name).toList(),
          ),
        ),
        body: TabBarView(
          children:
              rankingCategoriesV2
                  .map((category) => RankingListView(category: category))
                  .toList(),
        ),
      ),
    );
  }
}
