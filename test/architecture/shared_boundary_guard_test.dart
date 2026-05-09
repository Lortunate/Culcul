import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'guard_test_utils.dart';

// Boundary guardrails: retired shared stays feature-agnostic while cleanup
// proceeds, and the core barrel keeps exposing the canonical entry points used
// across the repo.
void main() {
  test('Shared layer does not import feature packages', () async {
    final violations = <String>[
      for (final directive in await collectImportDirectives('lib/shared'))
        if (_isSharedToFeatureDependency(directive))
          '${directive.sourcePath} -> ${directive.importPath}',
    ]
      ..sort();

    expect(
      violations,
      isEmpty,
      reason: 'Found forbidden shared -> features imports: ${violations.join(', ')}',
    );
  });

  test('Core barrel exports canonical modules', () async {
    final coreEntry = File('lib/core/core.dart');
    final coreAppError = File('lib/core/errors/app_error.dart');
    final coreResult = File('lib/core/result/result.dart');

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

    final exports = {
      for (final directive in await collectImportDirectivesFromFile(coreEntry))
        if (directive.importPath.endsWith('.dart')) directive.importPath,
    };
    expect(exports, contains('errors/app_error.dart'));
    expect(exports, contains('result/result.dart'));
  });
}

bool _isSharedToFeatureDependency(ImportDirective directive) {
  if (directive.importPath.startsWith('package:culcul/features/')) {
    return true;
  }

  final resolvedPath = directive.resolvedProjectPath;
  return resolvedPath != null && resolvedPath.startsWith('lib/features/');
}
