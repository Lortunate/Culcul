import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('public seam files do not import concrete repository implementations', () async {
    final violations = await findPublicSeamImplementationImports();
    expect(
      violations,
      isEmpty,
      reason: 'Application/public seam files should depend on ports or feature-owned providers, not *_repository_impl.dart.\n'
          'Found implementation imports:\n${violations.join('\n')}',
    );
  });
}

Future<List<String>> findPublicSeamImplementationImports() async {
  final violations = <String>[];
  final importPattern = RegExp(
    r'''^\s*import\s+['"][^'"]*_repository_impl\.dart['"]''',
    multiLine: true,
  );

  await for (final entity in Directory('lib/features').list(recursive: true)) {
    if (entity is! File || !entity.path.endsWith('.dart')) {
      continue;
    }

    final normalizedPath = entity.path.replaceAll('\\', '/');
    final fileName = normalizedPath.split('/').last;
    final isFeatureScope = fileName == 'feature_scope.dart';
    final isApplicationFile = normalizedPath.contains('/application/');
    final isFacadeLike = fileName.contains('facade');

    if (!isFeatureScope && !(isApplicationFile && isFacadeLike) && !normalizedPath.contains('/application/use_cases/')) {
      continue;
    }

    final content = await entity.readAsString();
    for (final match in importPattern.allMatches(content)) {
      violations.add('$normalizedPath -> ${match.group(0)}');
    }
  }

  return violations;
}
