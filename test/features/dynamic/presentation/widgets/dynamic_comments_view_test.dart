import 'package:culcul/features/dynamic/presentation/widgets/dynamic_comments_view.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DynamicCommentsEmptyState calls refresh when tapped', (tester) async {
    var refreshCount = 0;

    await tester.pumpWidget(
      _TestApp(child: DynamicCommentsEmptyState(onRefresh: () => refreshCount++)),
    );

    await tester.tap(find.text(t.moments.no_comments));

    expect(refreshCount, 1);
  });
}

class _TestApp extends StatelessWidget {
  final Widget child;

  const _TestApp({required this.child});

  @override
  Widget build(BuildContext context) {
    return TranslationProvider(
      child: MaterialApp(
        home: Scaffold(body: CustomScrollView(slivers: [child])),
        locale: AppLocale.zh.flutterLocale,
        supportedLocales: AppLocaleUtils.supportedLocales,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
      ),
    );
  }
}
