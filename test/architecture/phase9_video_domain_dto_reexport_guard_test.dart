import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('video domain entities do not re-export data dto files', () async {
    final dir = Directory('lib/features/video/domain/entities');
    final violations = <String>[];

    const allowedAggregateBarrels = {
      'lib/features/video/domain/entities/video_entities.dart',
    };

    if (dir.existsSync()) {
      for (final entity in dir.listSync(recursive: true)) {
        if (entity is! File || !entity.path.endsWith('.dart')) {
          continue;
        }
        final normalizedPath = entity.path.replaceAll('\\', '/');
        if (allowedAggregateBarrels.contains(normalizedPath)) continue;
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
          'video domain entities must not depend on data/dtos. Found: '
          '${violations.join(', ')}',
    );
  });
}
