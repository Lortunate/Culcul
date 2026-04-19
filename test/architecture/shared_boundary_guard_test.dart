import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

// Phase 1 guardrails: shared stays feature-agnostic while boundary cleanup is in progress.
void main() {
  test('Shared layer does not import feature packages', () async {
    final sharedDir = Directory('lib/shared');
    final featureImport = RegExp(r'''import\s+['"]package:culcul/features/''');
    final violations = <String>[];

    if (sharedDir.existsSync()) {
      for (final file in sharedDir.listSync(recursive: true)) {
        if (file is! File || !file.path.endsWith('.dart')) {
          continue;
        }
        final content = await file.readAsString();
        if (featureImport.hasMatch(content)) {
          violations.add(file.path.replaceAll('\\', '/'));
        }
      }
    }

    expect(
      violations,
      isEmpty,
      reason: 'Found forbidden shared -> features imports: ${violations.join(', ')}',
    );
  });
}
