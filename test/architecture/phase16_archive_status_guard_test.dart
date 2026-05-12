import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('archived specs and plans never declare active status', () async {
    final violations = <String>[];
    final archiveDirs = [
      Directory('docs/superpowers/specs/archive'),
      Directory('docs/superpowers/plans/archive'),
    ];

    for (final dir in archiveDirs) {
      if (!dir.existsSync()) {
        continue;
      }

      await for (final entity in dir.list(recursive: true)) {
        if (entity is! File || !entity.path.endsWith('.md')) {
          continue;
        }
        final content = await entity.readAsString();
        if (content.contains('**Status:** Active')) {
          violations.add(entity.path.replaceAll('\\', '/'));
        }
      }
    }

    expect(
      violations,
      isEmpty,
      reason:
          'Archived docs must not declare active status. Found: ${violations.join(', ')}',
    );
  });
}
