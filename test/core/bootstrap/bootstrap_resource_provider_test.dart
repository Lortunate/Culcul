import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:culcul/core/bootstrap/providers/cache_store_provider.dart';
import 'package:culcul/core/bootstrap/providers/cookie_jar_provider.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late PathProviderPlatform previousPathProvider;
  late Directory cacheDirectory;
  late Directory documentsDirectory;
  late _CountingPathProviderPlatform pathProvider;

  setUp(() async {
    previousPathProvider = PathProviderPlatform.instance;
    cacheDirectory = await Directory.systemTemp.createTemp();
    documentsDirectory = await Directory.systemTemp.createTemp();
    pathProvider = _CountingPathProviderPlatform(
      temporaryPath: cacheDirectory.path,
      applicationDocumentsPath: documentsDirectory.path,
    );
    PathProviderPlatform.instance = pathProvider;
  });

  tearDown(() async {
    PathProviderPlatform.instance = previousPathProvider;
    await cacheDirectory.delete(recursive: true);
    await documentsDirectory.delete(recursive: true);
  });

  test('network-backed bootstrap resources do not require startup overrides', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(cacheStoreProvider), isA<CacheStore>());
    expect(container.read(cookieJarProvider), isA<CookieJar>());
  });

  test('reading network-backed resources does not resolve filesystem paths', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(cacheStoreProvider), isA<CacheStore>());
    expect(container.read(cookieJarProvider), isA<CookieJar>());
    expect(pathProvider.temporaryPathCalls, 0);
    expect(pathProvider.applicationDocumentsPathCalls, 0);
  });

  test('network-backed resources resolve filesystem paths when first used', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final cacheStore = container.read(cacheStoreProvider);
    final cookieJar = container.read(cookieJarProvider);

    await cacheStore.exists('cache-key');
    await cookieJar.loadForRequest(Uri.https('example.com'));

    expect(pathProvider.temporaryPathCalls, 1);
    expect(pathProvider.applicationDocumentsPathCalls, 1);
  });
}

final class _CountingPathProviderPlatform extends PathProviderPlatform {
  _CountingPathProviderPlatform({
    required this.temporaryPath,
    required this.applicationDocumentsPath,
  });

  final String temporaryPath;
  final String applicationDocumentsPath;

  int temporaryPathCalls = 0;
  int applicationDocumentsPathCalls = 0;

  @override
  Future<String?> getTemporaryPath() async {
    temporaryPathCalls += 1;
    return temporaryPath;
  }

  @override
  Future<String?> getApplicationDocumentsPath() async {
    applicationDocumentsPathCalls += 1;
    return applicationDocumentsPath;
  }
}
