import 'package:culcul/core/errors/error_handler.dart';
import 'package:culcul/shared/widgets/app_error_widget.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class _LongError {
  @override
  String toString() {
    return 'LongError: ${'a' * 200}\nsecond line';
  }
}

Widget _wrap(Widget child) {
  return TranslationProvider(
    child: MaterialApp(home: Scaffold(body: child)),
  );
}

void main() {
  testWidgets('shows short error message and action buttons', (tester) async {
    var retried = false;
    await tester.pumpWidget(
      _wrap(
        AppErrorWidget(
          error: _LongError(),
          onRetry: () {
            retried = true;
          },
        ),
      ),
    );

    final labels = _labelsFromWidget(tester);
    final textWidget = tester.widget<Text>(
      find.byWidgetPredicate(
        (widget) => widget is Text && (widget.data?.startsWith('LongError: ') ?? false),
      ),
    );

    expect(textWidget.data, isNotNull);
    expect(textWidget.data!.contains('\n'), isFalse);
    expect(textWidget.data!.length, lessThanOrEqualTo(120));
    expect(textWidget.data!.endsWith('...'), isTrue);
    expect(find.text(labels.viewDetails), findsOneWidget);
    expect(find.text(labels.retry), findsOneWidget);
    expect(find.byIcon(Icons.info_outline_rounded), findsOneWidget);
    expect(find.byIcon(Icons.refresh_rounded), findsOneWidget);

    await tester.tap(find.byIcon(Icons.refresh_rounded));
    await tester.pump();
    expect(retried, isTrue);
  });

  testWidgets('opens details dialog with full error details', (tester) async {
    final stack = StackTrace.fromString('stack-line-1\nstack-line-2');
    await tester.pumpWidget(
      _wrap(
        AppErrorWidget(
          error: Exception('dialog failure'),
          stackTrace: stack,
          onRetry: () {},
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.info_outline_rounded));
    await tester.pumpAndSettle();

    expect(find.textContaining('Raw: Exception: dialog failure'), findsOneWidget);
    expect(find.textContaining('stack-line-1'), findsOneWidget);
  });

  testWidgets('compact layout still shows details and retry buttons', (tester) async {
    await tester.pumpWidget(
      _wrap(AppErrorWidget(error: Exception('compact'), onRetry: () {}, compact: true)),
    );

    final labels = _labelsFromWidget(tester);
    expect(find.text(labels.viewDetails), findsOneWidget);
    expect(find.text(labels.retry), findsOneWidget);
    expect(find.byIcon(Icons.info_outline_rounded), findsOneWidget);
    expect(find.byIcon(Icons.refresh_rounded), findsOneWidget);
  });

  testWidgets('logs same error only once across rebuilds', (tester) async {
    ErrorHandler.resetLoggedErrorsForTest();

    const message = 'dedup-check-error';

    await tester.pumpWidget(
      _wrap(AppErrorWidget(error: Exception(message), onRetry: () {})),
    );

    await tester.pumpWidget(
      _wrap(AppErrorWidget(error: Exception(message), onRetry: () {})),
    );

    expect(ErrorHandler.loggedErrorCountForTest, 1);
  });
}

({String viewDetails, String retry}) _labelsFromWidget(WidgetTester tester) {
  final context = tester.element(find.byType(AppErrorWidget));
  final t = Translations.of(context);
  return (viewDetails: t.error.view_details, retry: t.common.retry);
}
