import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/theme/culcul_theme.dart';
import 'package:culcul/ui/theme/culcul_tokens.dart';
import 'package:culcul/ui/widgets/feedback/app_empty_state_widget.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:culcul/ui/widgets/inputs/app_selectable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AppEmptyStateWidget keeps default layout and optional action behavior', (
    tester,
  ) async {
    await tester.pumpWidget(
      const _TestApp(child: AppEmptyStateWidget(message: 'Nothing here')),
    );

    expect(find.byIcon(Icons.inbox_outlined), findsOneWidget);
    expect(_iconSize(Icons.inbox_outlined), 56);
    expect(
      _scrollPadding<AppEmptyStateWidget>(tester),
      const EdgeInsets.all(CulculSpacing.xl),
    );
    expect(_textWidget('Nothing here').maxLines, 3);
    expect(find.byType(OutlinedButton), findsNothing);

    await tester.pumpWidget(
      const _TestApp(
        child: AppEmptyStateWidget(message: 'Nothing here', actionLabel: 'Reload'),
      ),
    );
    expect(find.byType(OutlinedButton), findsNothing);

    await tester.pumpWidget(
      _TestApp(
        child: AppEmptyStateWidget(message: 'Nothing here', onAction: () {}),
      ),
    );
    expect(find.byType(OutlinedButton), findsNothing);
  });

  testWidgets('AppEmptyStateWidget keeps compact layout tokenized and actionable', (
    tester,
  ) async {
    var tapped = false;

    await tester.pumpWidget(
      _TestApp(
        child: AppEmptyStateWidget(
          message: 'Nothing here',
          compact: true,
          actionLabel: 'Reload',
          onAction: () => tapped = true,
        ),
      ),
    );

    expect(
      _scrollPadding<AppEmptyStateWidget>(tester),
      const EdgeInsets.all(CulculSpacing.md),
    );
    expect(_iconSize(Icons.inbox_outlined), 36);
    expect(_textWidget('Nothing here').maxLines, 2);

    final gaps = tester.widgetList<SizedBox>(
      find.descendant(
        of: find.byType(AppEmptyStateWidget),
        matching: find.byType(SizedBox),
      ),
    );
    expect(gaps.map((gap) => gap.height), contains(CulculSpacing.sm));

    final actionButton = tester.widget<OutlinedButton>(
      find.widgetWithText(OutlinedButton, 'Reload'),
    );
    expect(_buttonRadius(actionButton), CulculRadius.lg);

    await tester.tap(find.text('Reload'));
    expect(tapped, isTrue);
  });

  testWidgets('AppErrorWidget keeps regular layout, details, retry, and custom icon', (
    tester,
  ) async {
    var retries = 0;

    await tester.pumpWidget(
      _TestApp(
        child: AppErrorWidget(
          error: Exception('network failed'),
          stackTrace: StackTrace.current,
          icon: Icons.wifi_off_rounded,
          onRetry: () => retries += 1,
        ),
      ),
    );

    expect(find.byIcon(Icons.wifi_off_rounded), findsOneWidget);
    expect(find.byIcon(Icons.error_outline_rounded), findsNothing);
    expect(_iconSize(Icons.wifi_off_rounded), 56);
    expect(
      _scrollPadding<AppErrorWidget>(tester),
      const EdgeInsets.all(CulculSpacing.xl),
    );
    expect(_firstErrorMessage(tester).maxLines, 3);

    await tester.tap(find.byIcon(Icons.info_outline_rounded));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.byType(AppSelectableText), findsOneWidget);

    await tester.tap(
      find.text(tester.element(find.byType(AlertDialog)).t.common.confirm),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.refresh_rounded));
    expect(retries, 1);
  });

  testWidgets('AppErrorWidget keeps compact inputs equivalent and tokenized', (
    tester,
  ) async {
    await tester.pumpWidget(
      _TestApp(
        child: AppErrorWidget(
          error: Exception('network failed'),
          onRetry: () {},
          variant: AppErrorWidgetVariant.compact,
        ),
      ),
    );
    final variantPadding = _scrollPadding<AppErrorWidget>(tester);
    final variantButtonRadii = _errorButtonRadii(tester);
    final variantRetryPadding = _retryButtonPadding(tester);

    await tester.pumpWidget(
      _TestApp(
        child: AppErrorWidget(
          error: Exception('network failed'),
          onRetry: () {},
          compact: true,
        ),
      ),
    );

    expect(_scrollPadding<AppErrorWidget>(tester), variantPadding);
    expect(
      _scrollPadding<AppErrorWidget>(tester),
      const EdgeInsets.all(CulculSpacing.md),
    );
    expect(_iconSize(Icons.error_outline_rounded), 32);
    expect(_firstErrorMessage(tester).maxLines, 2);
    expect(_errorButtonRadii(tester), variantButtonRadii);
    expect(_errorButtonRadii(tester), everyElement(CulculRadius.lg));
    expect(_retryButtonPadding(tester), variantRetryPadding);
    expect(
      _retryButtonPadding(tester),
      const EdgeInsets.symmetric(
        horizontal: CulculSpacing.sm,
        vertical: CulculSpacing.xs,
      ),
    );
  });
}

EdgeInsetsGeometry? _scrollPadding<T extends Widget>(WidgetTester tester) {
  return tester
      .widget<SingleChildScrollView>(
        find.descendant(of: find.byType(T), matching: find.byType(SingleChildScrollView)),
      )
      .padding;
}

double? _iconSize(IconData icon) {
  final iconWidget = find.byIcon(icon).evaluate().single.widget as Icon;
  return iconWidget.size;
}

Text _textWidget(String text) {
  return find.text(text).evaluate().single.widget as Text;
}

Text _firstErrorMessage(WidgetTester tester) {
  return tester
      .widgetList<Text>(
        find.descendant(of: find.byType(AppErrorWidget), matching: find.byType(Text)),
      )
      .firstWhere((text) => text.maxLines != null);
}

List<double> _errorButtonRadii(WidgetTester tester) {
  return tester
      .widgetList<OutlinedButton>(
        find.descendant(
          of: find.byType(AppErrorWidget),
          matching: find.byType(OutlinedButton),
        ),
      )
      .map(_buttonRadius)
      .toList();
}

EdgeInsetsGeometry? _retryButtonPadding(WidgetTester tester) {
  final retryButton = tester.widget<OutlinedButton>(
    find.ancestor(
      of: find.byIcon(Icons.refresh_rounded),
      matching: find.byType(OutlinedButton),
    ),
  );
  return retryButton.style!.padding!.resolve(<WidgetState>{});
}

double _buttonRadius(OutlinedButton button) {
  final shape = button.style!.shape!.resolve(<WidgetState>{})! as RoundedRectangleBorder;
  final borderRadius = shape.borderRadius as BorderRadius;
  return borderRadius.topLeft.x;
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
