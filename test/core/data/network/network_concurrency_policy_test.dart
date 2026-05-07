import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

const _allowedFutureWaitPaths = <String>{
  'lib/core/data/network/network_concurrency_executor.dart',
  'lib/app/bootstrap/deferred_app_init.dart',
};

void main() {
  test('Future.wait is only used in explicitly allowed files', () {
    final root = Directory('lib');
    final violations = <String>[];

    for (final entity in root.listSync(recursive: true)) {
      if (entity is! File) {
        continue;
      }

      final path = entity.path.replaceAll('\\', '/');
      if (!path.endsWith('.dart') || path.endsWith('.g.dart')) {
        continue;
      }
      if (_allowedFutureWaitPaths.contains(path)) {
        continue;
      }

      final content = entity.readAsStringSync();
      if (content.contains('Future.wait(')) {
        violations.add(path);
      }
    }

    expect(
      violations,
      isEmpty,
      reason:
          'Use Future.wait only in $_allowedFutureWaitPaths. Violations: $violations',
    );
  });
}
