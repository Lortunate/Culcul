import 'package:culcul/features/search/domain/entities/search_suggestion_entry.dart';
import 'package:culcul/features/search/presentation/view_models/search_view_model.dart';
import 'package:culcul/features/search/presentation/widgets/search_suggestion_view.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  testWidgets('uses list-level animation and keeps tap behavior', (tester) async {
    String? tappedValue;
    await tester.pumpWidget(
      TranslationProvider(
        child: ProviderScope(
          overrides: [
            searchSuggestionsProvider('flutter').overrideWith((ref) async {
              return const <SearchSuggestionEntry>[
                SearchSuggestionEntry(value: 'flutter riverpod'),
                SearchSuggestionEntry(value: 'flutter hooks'),
              ];
            }),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: SearchSuggestionView(
                term: 'flutter',
                onSuggestionTap: (value) => tappedValue = value,
              ),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(AnimatedSwitcher), findsOneWidget);
    expect(find.byType(TweenAnimationBuilder<double>), findsNothing);
    expect(find.byIcon(Icons.north_west_rounded), findsNWidgets(2));

    await tester.tap(find.byIcon(Icons.north_west_rounded).last);
    await tester.pump();
    expect(tappedValue, 'flutter hooks');
  });
}
