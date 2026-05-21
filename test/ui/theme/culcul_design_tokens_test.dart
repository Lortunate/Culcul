import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/theme/culcul_theme.dart';
import 'package:culcul/ui/theme/culcul_tokens.dart';
import 'package:culcul/ui/widgets/buttons/follow_button.dart';
import 'package:culcul/ui/widgets/cards/app_card_container.dart';
import 'package:culcul/ui/widgets/inputs/app_search_bar.dart';
import 'package:culcul/ui/widgets/layout/app_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shared UI primitives use Culcul design token defaults', (tester) async {
    await tester.pumpWidget(
      const _TestApp(
        child: Column(
          children: [
            AppCardContainer(child: SizedBox(width: 8, height: 8)),
            AppSearchBar(hintText: 'Search'),
            DefaultTabController(length: 2, child: AppTabBar(tabs: ['A', 'B'])),
            FollowButton(isFollowed: false, onTap: _noop),
          ],
        ),
      ),
    );

    final cardDecoration =
        tester
                .widget<DecoratedBox>(
                  find.descendant(
                    of: find.byType(AppCardContainer),
                    matching: find.byType(DecoratedBox),
                  ),
                )
                .decoration
            as BoxDecoration;
    final cardRadius = cardDecoration.borderRadius! as BorderRadius;
    expect(cardRadius.topLeft.x, CulculRadius.lg);

    final searchClip = tester.widget<ClipRRect>(
      find.descendant(of: find.byType(AppSearchBar), matching: find.byType(ClipRRect)),
    );
    final searchRadius = searchClip.borderRadius as BorderRadius;
    expect(searchRadius.topLeft.x, CulculRadius.lg);

    final tabBar = tester.widget<TabBar>(find.byType(TabBar));
    final indicator = tabBar.indicator! as UnderlineTabIndicator;
    final indicatorRadius = indicator.borderRadius!;
    expect(indicatorRadius.topLeft.x, CulculRadius.xs);

    final switcher = tester.widget<AnimatedSwitcher>(
      find.descendant(
        of: find.byType(FollowButton),
        matching: find.byType(AnimatedSwitcher),
      ),
    );
    expect(switcher.duration, CulculMotion.standard);
  });
}

void _noop() {}

class _TestApp extends StatelessWidget {
  final Widget child;

  const _TestApp({required this.child});

  @override
  Widget build(BuildContext context) {
    return TranslationProvider(
      child: MaterialApp(
        theme: CulculTheme.light,
        home: Scaffold(body: child),
        locale: AppLocale.zh.flutterLocale,
        supportedLocales: AppLocaleUtils.supportedLocales,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
      ),
    );
  }
}
