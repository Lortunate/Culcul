import 'package:culcul/features/search/presentation.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/app_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  testWidgets('HotSearchSection uses compact AppErrorWidget on error', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          trendingRankingProvider.overrideWith((ref) async {
            throw Exception('hot search error');
          }),
        ],
        child: TranslationProvider(
          child: MaterialApp(
            home: Scaffold(body: HotSearchSection(onTap: (_) {})),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final errorWidget = tester.widget<AppErrorWidget>(find.byType(AppErrorWidget));
    expect(errorWidget.variant, AppErrorWidgetVariant.compact);
  });
}
