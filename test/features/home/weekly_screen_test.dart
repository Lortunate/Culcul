import 'package:culcul/features/home/home.dart';
import 'package:culcul/ui/widgets/app_error_widget.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  testWidgets('WeeklyScreen renders AppErrorWidget on provider error', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          weeklyListProvider.overrideWith((ref) async {
            throw Exception('weekly error');
          }),
        ],
        child: TranslationProvider(child: const MaterialApp(home: WeeklyScreen())),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(AppErrorWidget), findsOneWidget);
  });
}

