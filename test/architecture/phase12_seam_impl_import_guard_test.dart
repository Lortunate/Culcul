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

  // Phase 19: these impls no longer have interfaces — direct import is expected
  const allowedImplImports = {
    'home_repository_impl.dart',
    'settings_repository_impl.dart',
    'to_view_repository_impl.dart',
    'danmaku_repository_impl.dart',
    'relation_repository_impl.dart',
  };

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
      final importedFile = match.group(0)!.split('/').last.replaceAll("'", '');
      if (allowedImplImports.contains(importedFile)) continue;
      violations.add('$normalizedPath -> ${match.group(0)}');
    }
  }

  return violations;
}
