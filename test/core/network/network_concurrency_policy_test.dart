import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Future.wait is only used inside network concurrency executor', () {
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
      if (path == 'lib/core/network/network_concurrency_executor.dart') {
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
      reason: 'Use NetworkConcurrencyExecutor instead of Future.wait: $violations',
    );
  });
}
