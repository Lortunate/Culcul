import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

const _providerFiles = [
  'lib/core/bootstrap/providers/cache_store_provider.dart',
  'lib/core/bootstrap/providers/cookie_jar_provider.dart',
  'lib/core/bootstrap/providers/storage_provider.dart',
];

final _riverpodKeepAlivePattern = RegExp(r'@Riverpod\(keepAlive:\s*true\)');

final _providerFunctionPattern = RegExp(
  r'@Riverpod\(keepAlive:\s*true\)\s*\n\S+\s+\w+\(Ref\s+\w+\)\s*\{[^}]*throw\s+UnimplementedError',
  dotAll: true,
);

final _concreteClassPattern = RegExp(r'^class\s+\w+', multiLine: true);

void main() {
  group('Bootstrap provider files', () {
    for (final path in _providerFiles) {
      group(path, () {
        late String source;

        setUpAll(() async {
          source = await File(path).readAsString();
        });

        test('contains only @Riverpod(keepAlive: true) annotated functions', () {
          final riverpodCount = _riverpodKeepAlivePattern.allMatches(source).length;
          expect(
            riverpodCount,
            greaterThanOrEqualTo(1),
            reason: 'Expected at least one @Riverpod(keepAlive: true) annotation',
          );
        });

        test('all provider functions throw UnimplementedError', () {
          final providerFunctionCount = _providerFunctionPattern
              .allMatches(source)
              .length;
          final riverpodCount = _riverpodKeepAlivePattern.allMatches(source).length;

          expect(
            providerFunctionCount,
            equals(riverpodCount),
            reason:
                'Expected every @Riverpod(keepAlive: true) function to throw '
                'UnimplementedError. Found $riverpodCount annotations but only '
                '$providerFunctionCount matching throws.',
          );
        });

        test('does not contain concrete class implementations', () {
          final classMatches = _concreteClassPattern.allMatches(source);

          for (final match in classMatches) {
            final className = match.group(0)!.replaceFirst('class ', '').trim();

            // StorageKeys is a constants container -- not a provider impl.
            if (className == 'StorageKeys') continue;

            fail(
              'Bootstrap provider file contains a concrete class: $className. '
              'Provider files should only contain @Riverpod annotated functions '
              'that throw UnimplementedError.',
            );
          }
        });
      });
    }
  });
}
