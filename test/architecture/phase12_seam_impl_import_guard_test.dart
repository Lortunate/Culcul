import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('active seam files do not import concrete repository implementations', () async {
    final violations = await findActiveSeamImplementationImports();
    expect(
      violations,
      isEmpty,
      reason: 'Feature seam files should depend on capabilities, ports, or owned providers.\n'
          'Found implementation imports:\n${violations.join('\n')}',
    );
  });
}

Future<List<String>> findActiveSeamImplementationImports() async {
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
    if (fileName.endsWith('.g.dart')) {
      continue;
    }

    final isFeatureScope = fileName == 'feature_scope.dart';
    final isApplicationFile = normalizedPath.contains('/application/');
    if (!isFeatureScope && !isApplicationFile) {
      continue;
    }

    final content = await entity.readAsString();
    for (final match in importPattern.allMatches(content)) {
      violations.add('$normalizedPath -> ${match.group(0)}');
    }
  }

  return violations;
}
