import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'architecture_guard_utils.dart';

void main() {
  test('dynamic detail and publish routes live in the dynamic route part', () {
    final dynamicRoutes = File('lib/app/router/routes/app_dynamic_routes.dart');
    final notificationRoutes = File('lib/app/router/routes/app_notification_routes.dart');

    expect(dynamicRoutes.existsSync(), isTrue);

    final dynamicRouteSource = dynamicRoutes.readAsStringSync();
    expect(dynamicRouteSource, contains('class DynamicDetailRoute'));
    expect(dynamicRouteSource, contains('class PublishDynamicRoute'));

    final notificationRouteSource = notificationRoutes.readAsStringSync();
    expect(notificationRouteSource, isNot(contains('class DynamicDetailRoute')));
    expect(notificationRouteSource, isNot(contains('class PublishDynamicRoute')));
  });

  test('feature presentation must not import app route definitions', () {
    final offenders = <String>[];

    for (final file in sourceDartFiles('lib')) {
      final importerPath = normalizePath(file.path);
      final importerFeature = featureNameFromPath(importerPath);
      if (importerFeature == null ||
          !importerPath.startsWith('lib/features/$importerFeature/presentation/')) {
        continue;
      }

      for (final import in dartImports(file)) {
        if (import.resolvedPath != 'lib/app/router/app_routes.dart') {
          continue;
        }

        offenders.add(
          '${formatLocation(import.importerPath, import.lineNumber)} '
          'imports ${import.uri}',
        );
      }
    }

    expect(
      offenders,
      isEmpty,
      reason:
          'Feature presentation must receive route callbacks from app/router '
          'instead of importing typed app routes:\n'
          '${offenders.join('\n')}',
    );
  });

  test('app router must only import feature route entries', () {
    final offenders = <String>[];

    for (final file in dartFiles('lib/app/router')) {
      for (final import in dartImports(file)) {
        final targetPath = import.resolvedPath;
        if (targetPath == null || !targetPath.startsWith('lib/features/')) {
          continue;
        }
        if (targetPath.endsWith('/route_entry.dart')) {
          continue;
        }

        offenders.add(
          '${formatLocation(import.importerPath, import.lineNumber)} '
          'imports ${import.uri} -> $targetPath',
        );
      }
    }

    expect(
      offenders,
      isEmpty,
      reason:
          'App router must depend on feature route_entry.dart public APIs, not '
          'feature internals:\n${offenders.join('\n')}',
    );
  });

  test('dynamic and search presentation must not construct local routes', () {
    final offenders = <String>[];
    const guardedPrefixes = <String>[
      'lib/features/dynamic/presentation/',
      'lib/features/search/presentation/',
    ];

    for (final file in sourceDartFiles('lib')) {
      final path = normalizePath(file.path);
      if (!guardedPrefixes.any(path.startsWith)) {
        continue;
      }

      for (final line in authoredDartCodeLines(file)) {
        if (line.text.contains('MaterialPageRoute(')) {
          offenders.add('${formatLocation(path, line.lineNumber)} MaterialPageRoute');
        }
      }
    }

    expect(
      offenders,
      isEmpty,
      reason:
          'Dynamic/search presentation must use app-owned route callbacks '
          'instead of constructing MaterialPageRoute locally:\n'
          '${offenders.join('\n')}',
    );
  });
}
