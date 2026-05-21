import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/theme/culcul_theme.dart';
import 'package:culcul/ui/widgets/feedback/app_empty_state_widget.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:culcul/ui/widgets/smart_paging_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  testWidgets('SmartPagingContent renders default empty fallback with refresh', (
    tester,
  ) async {
    var refreshes = 0;

    await tester.pumpWidget(
      _TestApp(
        child: SmartPagingContent<int>(
          asyncValue: const AsyncValue.data(<int>[]),
          items: const <int>[],
          builder: (context, items) => Text('items-${items.length}'),
          onRefresh: () async {
            refreshes += 1;
          },
          errorBuilder: null,
          emptyBuilder: null,
          emptyText: 'No rows',
        ),
      ),
    );

    expect(find.byType(AppEmptyStateWidget), findsOneWidget);
    expect(find.text('No rows'), findsOneWidget);
    expect(find.text('items-0'), findsNothing);

    await tester.tap(find.byType(OutlinedButton));
    await tester.pump();

    expect(refreshes, 1);
  });

  testWidgets('SmartPagingContent renders default error fallback with retry', (
    tester,
  ) async {
    var refreshes = 0;
    final error = Exception('network failed');
    final stackTrace = StackTrace.current;

    await tester.pumpWidget(
      _TestApp(
        child: SmartPagingContent<int>(
          asyncValue: AsyncError<List<int>>(error, stackTrace),
          items: const <int>[],
          builder: (context, items) => Text('items-${items.length}'),
          onRefresh: () async {
            refreshes += 1;
          },
          errorBuilder: null,
          emptyBuilder: null,
          emptyText: null,
        ),
      ),
    );

    expect(find.byType(AppErrorWidget), findsOneWidget);
    expect(find.byType(AppEmptyStateWidget), findsNothing);
    expect(find.text('items-0'), findsNothing);

    await tester.tap(find.byIcon(Icons.refresh_rounded));
    await tester.pump();

    expect(refreshes, 1);
  });
}

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
