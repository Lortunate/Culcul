import 'package:flutter_test/flutter_test.dart';

import 'guard_test_utils.dart';

// Transitional Phase 8 debt snapshot. These exact imports are allowed only
// until Tasks 6-8 move the shared primitives or replace them with explicit
// seams. New imports are forbidden immediately, and removed imports must also
// be deleted from this allowlist.
const _temporaryAllowlist = <String>{};

void main() {
  test(
    'Features do not import other features presentation internals without an explicit exception',
    () async {
      final observedViolations = <String>[
        for (final directive in await collectImportDirectives('lib/features'))
          if (_isCrossFeaturePresentationDependency(directive))
            '${directive.sourcePath} -> ${directive.importPath}',
      ];
      final allowlistResult = evaluateExactAllowlist(
        observedViolations: observedViolations,
        allowedViolations: _temporaryAllowlist,
      );

      expect(
        allowlistResult.unexpectedViolations,
        isEmpty,
        reason:
            'Found cross-feature presentation imports/exports outside the '
            'temporary Phase 8 allowlist: '
            '${allowlistResult.unexpectedViolations.join(', ')}',
      );

      expect(
        allowlistResult.staleAllowlistEntries,
        isEmpty,
        reason:
            'Temporary Phase 8 allowlist contains stale entries that should be '
            'removed: ${allowlistResult.staleAllowlistEntries.join(', ')}',
      );
    },
  );
}

bool _isCrossFeaturePresentationDependency(ImportDirective directive) {
  final sourceFeature = featureNameForProjectPath(directive.sourcePath);
  final targetFeature = featureNameForProjectPath(directive.resolvedProjectPath);
  if (sourceFeature == null ||
      targetFeature == null ||
      sourceFeature == targetFeature) {
    return false;
  }

  return isFeaturePresentationInternal(directive.resolvedProjectPath);
}
