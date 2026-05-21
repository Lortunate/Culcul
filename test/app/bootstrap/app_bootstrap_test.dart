import 'package:culcul/app/bootstrap/app_bootstrap.dart';
import 'package:culcul/core/bootstrap/providers/cache_store_provider.dart';
import 'package:culcul/core/bootstrap/providers/cookie_jar_provider.dart';
import 'package:culcul/core/bootstrap/providers/storage_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late PathProviderPlatform previousPathProvider;
  late _CountingPathProviderPlatform pathProvider;

  setUp(() {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    previousPathProvider = PathProviderPlatform.instance;
    pathProvider = _CountingPathProviderPlatform();
    PathProviderPlatform.instance = pathProvider;
  });

  tearDown(() {
    PathProviderPlatform.instance = previousPathProvider;
  });

  test(
    'initialize returns the shared preferences override without creating network resources',
    () async {
      final overrides = await AppBootstrap.initialize();

      expect(overrides, hasLength(1));
      expect(pathProvider.temporaryPathCalls, 0);
      expect(pathProvider.applicationDocumentsPathCalls, 0);

      final container = ProviderContainer(overrides: overrides);
      addTearDown(container.dispose);

      expect(container.read(sharedPreferencesProvider), isA<SharedPreferences>());
      expect(container.read(cacheStoreProvider), isNotNull);
      expect(container.read(cookieJarProvider), isNotNull);
      expect(pathProvider.temporaryPathCalls, 0);
      expect(pathProvider.applicationDocumentsPathCalls, 0);
    },
  );
}

final class _CountingPathProviderPlatform extends PathProviderPlatform {
  int temporaryPathCalls = 0;
  int applicationDocumentsPathCalls = 0;

  @override
  Future<String?> getTemporaryPath() async {
    temporaryPathCalls += 1;
    return null;
  }

  @override
  Future<String?> getApplicationDocumentsPath() async {
    applicationDocumentsPathCalls += 1;
    return null;
  }
}
