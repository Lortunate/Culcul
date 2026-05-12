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

  test('Core canonical modules exist', () async {
    final coreAppError = File('lib/core/errors/app_error.dart');
    final coreResult = File('lib/core/result/result.dart');

    expect(
      coreAppError.existsSync(),
      isTrue,
      reason: 'Missing lib/core/errors/app_error.dart',
    );
    expect(
      coreResult.existsSync(),
      isTrue,
      reason: 'Missing lib/core/result/result.dart',
    );
  });
}
