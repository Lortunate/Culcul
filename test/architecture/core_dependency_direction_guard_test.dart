import 'package:flutter_test/flutter_test.dart';

import 'guard_test_utils.dart';

void main() {
  test('Core layer does not import feature-owned code', () async {
    final violations = <String>[
      for (final directive in await collectImportDirectives('lib/core'))
        if (_isCoreToFeatureDependency(directive))
          '${directive.sourcePath} -> ${directive.importPath}',
    ]..sort();

    expect(
      violations,
      isEmpty,
      reason:
          'Found forbidden core -> features imports/exports: ${violations.join(', ')}',
    );
  });
}

bool _isCoreToFeatureDependency(ImportDirective directive) {
  final targetPath = directive.resolvedProjectPath;
  return targetPath != null && targetPath.startsWith('lib/features/');
}
