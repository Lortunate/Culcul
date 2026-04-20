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

  test('Task 8 core pilot keeps shared compatibility exports pointing at core', () async {
    final coreEntry = File('lib/core/core.dart');
    final coreAppError = File('lib/core/errors/app_error.dart');
    final coreResult = File('lib/core/result/result.dart');
    final sharedAppError = File('lib/shared/errors/app_error.dart');
    final sharedResult = File('lib/shared/result/result.dart');

    expect(coreEntry.existsSync(), isTrue, reason: 'Missing lib/core/core.dart');
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

    final coreEntryContent = await coreEntry.readAsString();
    expect(coreEntryContent, contains("export 'errors/app_error.dart';"));
    expect(coreEntryContent, contains("export 'result/result.dart';"));

    final sharedAppErrorContent = await sharedAppError.readAsString();
    final sharedResultContent = await sharedResult.readAsString();

    expect(
      sharedAppErrorContent.trim(),
      "export 'package:culcul/core/errors/app_error.dart';",
    );
    expect(
      sharedResultContent.trim(),
      "export 'package:culcul/core/result/result.dart';",
    );
  });
}
