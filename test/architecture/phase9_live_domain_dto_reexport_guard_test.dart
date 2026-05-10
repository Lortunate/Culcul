import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('live domain entities do not re-export data dto files', () async {
    final dir = Directory('lib/features/live/domain/entities');
    final violations = <String>[];

    if (dir.existsSync()) {
      for (final entity in dir.listSync(recursive: true)) {
        if (entity is! File || !entity.path.endsWith('.dart')) {
          continue;
        }
        final normalizedPath = entity.path.replaceAll('\\', '/');
        final content = await entity.readAsString();
        if (content.contains('data/dtos/')) {
          violations.add(normalizedPath);
        }
      }
    }

    expect(
      violations,
      isEmpty,
      reason:
          'live domain entities must not depend on data/dtos. Found: '
          '${violations.join(', ')}',
    );
  });
}
