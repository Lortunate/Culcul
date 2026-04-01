import 'package:culcul/core/network/bilibili_acceleration.dart';
import 'package:culcul/core/providers/storage_provider.dart';
import 'package:culcul/features/settings/presentation/pages/network_settings_page.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

class _FakeSettingsBox extends Fake implements Box<dynamic> {
  final Map<dynamic, dynamic> _store = <dynamic, dynamic>{};
  int putCount = 0;

  void seed(Map<dynamic, dynamic> initialValues) {
    _store.addAll(initialValues);
  }

  @override
  dynamic get(dynamic key, {dynamic defaultValue}) {
    return _store.containsKey(key) ? _store[key] : defaultValue;
  }

  @override
  Future<void> put(dynamic key, dynamic value) async {
    putCount += 1;
    _store[key] = value;
  }
}

ProviderContainer _buildContainer(_FakeSettingsBox box) {
  return ProviderContainer(
    overrides: [settingsStorageBoxProvider.overrideWith((ref) => box)],
  );
}

Widget _buildPage(ProviderContainer container) {
  return UncontrolledProviderScope(
    container: container,
    child: TranslationProvider(child: const MaterialApp(home: NetworkSettingsPage())),
  );
}

void main() {
  testWidgets(
    'network page renders core controls and does not overflow on narrow width',
    (tester) async {
      final view = tester.view;
      addTearDown(view.resetPhysicalSize);
      addTearDown(view.resetDevicePixelRatio);
      view.physicalSize = const Size(320, 640);
      view.devicePixelRatio = 1.0;

      final box = _FakeSettingsBox();
      box.seed({StorageKeys.biliAccelerationMode: 'manual'});
      final container = _buildContainer(box);
      addTearDown(container.dispose);

      await tester.pumpWidget(_buildPage(container));
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.byType(NetworkSettingsPage), findsOneWidget);
      expect(
        find.byWidgetPredicate(
          (widget) => widget is CupertinoSlidingSegmentedControl<BiliAccelerationMode>,
        ),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('preset_tile_official_direct')),
        findsOneWidget,
      );
      await tester.scrollUntilVisible(
        find.byKey(const ValueKey<String>('network_lock_switch')),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.byKey(const ValueKey<String>('network_lock_switch')), findsOneWidget);
      expect(find.byKey(const ValueKey<String>('network_test_button')), findsOneWidget);
      expect(find.byKey(const ValueKey<String>('network_test_row')), findsOneWidget);

      await tester.drag(find.byType(ListView).first, const Offset(0, -1200));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('tapping a preset switches to manual mode and sets active preset', (
    tester,
  ) async {
    final box = _FakeSettingsBox();
    box.seed({StorageKeys.biliAccelerationMode: 'manual'});
    final container = _buildContainer(box);
    addTearDown(container.dispose);
    final notifier = container.read(bilibiliAccelerationControllerProvider.notifier);

    final t0 = DateTime(2026, 1, 1, 10, 0, 0);
    await notifier.applyProbeResultForTesting(
      {
        'official_direct': const BiliLatencySnapshot(apiLatencyMs: 90, cdnLatencyMs: 90),
        'dns_backup': const BiliLatencySnapshot(apiLatencyMs: 100, cdnLatencyMs: 100),
        'cdn_cos': const BiliLatencySnapshot(apiLatencyMs: 120, cdnLatencyMs: 120),
        'cdn_ks3': const BiliLatencySnapshot(apiLatencyMs: 130, cdnLatencyMs: 130),
        'cdn_ali': const BiliLatencySnapshot(apiLatencyMs: 140, cdnLatencyMs: 140),
      },
      now: t0,
      applyAutoSwitch: false,
    );

    await tester.pumpWidget(_buildPage(container));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.byKey(const ValueKey<String>('preset_tile_cdn_ks3')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey<String>('preset_tile_cdn_ks3')));
    await tester.pumpAndSettle();

    final state = container.read(bilibiliAccelerationControllerProvider);
    expect(state.mode, BiliAccelerationMode.manual);
    expect(state.activePresetId, 'cdn_ks3');
  });

  testWidgets('changing lock switch updates locked state', (tester) async {
    final box = _FakeSettingsBox();
    final container = _buildContainer(box);
    addTearDown(container.dispose);

    await tester.pumpWidget(_buildPage(container));
    await tester.pumpAndSettle();

    expect(container.read(bilibiliAccelerationControllerProvider).locked, isFalse);
    await tester.scrollUntilVisible(
      find.byKey(const ValueKey<String>('network_lock_switch')),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    final lockTile = tester.widget<Switch>(
      find.byKey(const ValueKey<String>('network_lock_switch')),
    );
    lockTile.onChanged?.call(true);
    await tester.pumpAndSettle();
    expect(container.read(bilibiliAccelerationControllerProvider).locked, isTrue);
  });

  testWidgets('tapping current active preset is a no-op', (tester) async {
    final box = _FakeSettingsBox();
    box.seed({StorageKeys.biliAccelerationMode: 'manual'});
    final container = _buildContainer(box);
    addTearDown(container.dispose);

    await tester.pumpWidget(_buildPage(container));
    await tester.pumpAndSettle();

    final before = container.read(bilibiliAccelerationControllerProvider);
    expect(before.activePresetId, 'official_direct');
    final beforePutCount = box.putCount;

    await tester.tap(find.byKey(const ValueKey<String>('preset_tile_official_direct')));
    await tester.pumpAndSettle();

    final after = container.read(bilibiliAccelerationControllerProvider);
    expect(after.mode, BiliAccelerationMode.manual);
    expect(after.activePresetId, 'official_direct');
    expect(box.putCount, beforePutCount);
  });
}
