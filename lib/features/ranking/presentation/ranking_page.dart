import 'package:culcul/ui/widgets/app_tab_bar.dart';
import 'package:culcul/features/ranking/data/models/ranking_category.dart';
import 'package:culcul/features/ranking/presentation/widgets/ranking_list_view.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class RankingPage extends StatelessWidget {
  const RankingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final tabs = rankingCategoriesV2.map((category) => category.label(t)).toList();

    return DefaultTabController(
      length: rankingCategoriesV2.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) => [
            _RankingAppBar(
              title: t.ranking.title,
              tabs: tabs,
              forceElevated: innerBoxIsScrolled,
            ),
          ],
          body: TabBarView(
            children: rankingCategoriesV2
                .map((category) => RankingListView(category: category))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class _RankingAppBar extends StatelessWidget {
  final String title;
  final List<String> tabs;
  final bool forceElevated;

  const _RankingAppBar({
    required this.title,
    required this.tabs,
    required this.forceElevated,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverAppBar(
      title: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      pinned: true,
      floating: true,
      forceElevated: forceElevated,
      bottom: AppTabBar(tabs: tabs),
    );
  }
}
