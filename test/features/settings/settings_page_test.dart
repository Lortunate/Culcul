import 'package:culcul/shared/providers/storage_provider.dart';
import 'package:culcul/features/settings/presentation/pages/about_page.dart';
import 'package:culcul/features/settings/presentation/pages/settings_page.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

class _FakeSettingsBox extends Fake implements Box<dynamic> {
  final Map<dynamic, dynamic> _store = <dynamic, dynamic>{};

  @override
  dynamic get(dynamic key, {dynamic defaultValue}) {
    return _store.containsKey(key) ? _store[key] : defaultValue;
  }

  @override
  Future<void> put(dynamic key, dynamic value) async {
    _store[key] = value;
  }
}

ProviderContainer _buildContainer(_FakeSettingsBox box) {
  return ProviderContainer(
    overrides: [settingsStorageBoxProvider.overrideWith((ref) => box)],
  );
}

void main() {
  testWidgets('settings page renders continuous list rows', (tester) async {
    final box = _FakeSettingsBox();
    final container = _buildContainer(box);
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: TranslationProvider(child: const MaterialApp(home: SettingsPage())),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(SettingsPage), findsOneWidget);
    expect(find.byKey(const ValueKey<String>('language')), findsOneWidget);
    expect(find.byKey(const ValueKey<String>('appearance')), findsOneWidget);
    expect(find.byKey(const ValueKey<String>('clear_cache')), findsOneWidget);
    expect(find.byKey(const ValueKey<String>('about')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('tapping version row navigates to about page', (tester) async {
    final box = _FakeSettingsBox();
    final container = _buildContainer(box);
    addTearDown(container.dispose);

    final router = GoRouter(
      initialLocation: '/settings',
      routes: [
        GoRoute(
          path: '/settings',
          builder: (_, _) => const SettingsPage(),
          routes: [GoRoute(path: 'about', builder: (_, _) => const AboutPage())],
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: TranslationProvider(child: MaterialApp.router(routerConfig: router)),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey<String>('about')));
    await tester.pumpAndSettle();

    expect(find.byType(AboutPage), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
