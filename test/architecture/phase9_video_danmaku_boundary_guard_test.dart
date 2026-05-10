import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('video danmaku protobuf stays out of domain and presentation layers', () async {
    final violations = <String>[];
    final targets = <String>[
      'lib/features/video/domain',
      'lib/features/video/presentation',
    ];

    for (final root in targets) {
      final dir = Directory(root);
      if (!dir.existsSync()) {
        continue;
      }

      for (final entity in dir.listSync(recursive: true)) {
        if (entity is! File || !entity.path.endsWith('.dart')) {
          continue;
        }
        final normalizedPath = entity.path.replaceAll('\\', '/');
        final content = await entity.readAsString();
        if (content.contains("package:culcul/protos/dm.pb.dart")) {
          violations.add(normalizedPath);
        }
      }
    }

    expect(
      violations,
      isEmpty,
      reason:
          'video protobuf contracts must stay in data/. Found dm.pb.dart imports in: '
          '${violations.join(', ')}',
    );
  });
}
