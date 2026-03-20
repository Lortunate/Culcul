import 'package:culcul/ui/widgets/app_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:culcul/features/ranking/data/models/ranking_category.dart';
import 'package:culcul/features/ranking/presentation/widgets/ranking_list_view.dart';

class RankingPage extends StatelessWidget {
  const RankingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTabController(
      length: rankingCategoriesV2.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: Text(
                  '排行榜',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
                pinned: true,
                floating: true,
                forceElevated: innerBoxIsScrolled,
                bottom: AppTabBar(
                  tabs:
                      rankingCategoriesV2
                          .map((category) => category.name)
                          .toList(),
                ),
              ),
            ];
          },
          body: TabBarView(
            children:
                rankingCategoriesV2
                    .map((category) => RankingListView(category: category))
                    .toList(),
          ),
        ),
      ),
    );
  }
}
