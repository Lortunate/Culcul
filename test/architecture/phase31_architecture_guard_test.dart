import 'package:flutter_test/flutter_test.dart';

import 'architecture_guard_utils.dart';

const _phase31AllowedPresentationDataImports = <String>{};

void main() {
  test('core and ui must not import features', () {
    final offenders = <String>[];

    for (final file in sourceDartFiles('lib')) {
      final importerPath = normalizePath(file.path);
      if (!importerPath.startsWith('lib/core/') && !importerPath.startsWith('lib/ui/')) {
        continue;
      }

      for (final import in dartImports(file)) {
        final targetPath = import.resolvedPath;
        if (targetPath == null || !targetPath.startsWith('lib/features/')) {
          continue;
        }

        offenders.add(
          '${formatLocation(import.importerPath, import.lineNumber)} '
          'imports ${import.uri} -> $targetPath',
        );
      }
    }

    expect(
      offenders,
      isEmpty,
      reason:
          'Core and UI layers must not import feature internals:\n'
          '${offenders.join('\n')}',
    );
  });

  test('hand-written Riverpod provider declarations must stay retired', () {
    final offenders = <String>[];
    final providerDeclarationPattern = RegExp(
      r'\bfinal\s+[A-Za-z0-9_]*Provider\s*=\s*'
      r'(?:Provider|FutureProvider|StreamProvider|StateProvider|'
      r'StateNotifierProvider|NotifierProvider|AsyncNotifierProvider)\b',
    );

    for (final file in sourceDartFiles('lib')) {
      final path = normalizePath(file.path);
      for (final line in authoredDartCodeLines(file)) {
        final match = providerDeclarationPattern.firstMatch(line.text);
        if (match == null) {
          continue;
        }

        offenders.add('${formatLocation(path, line.lineNumber)} ${match.group(0)}');
      }
    }

    expect(
      offenders,
      isEmpty,
      reason:
          'Hand-written Riverpod provider declarations are retired. Use '
          '@riverpod generated providers for new authored source:\n'
          '${offenders.join('\n')}',
    );
  });

  test('feature presentation to same-feature data imports are allowlisted', () {
    final observedDebt = <String>{};
    final newDebt = <String>[];

    for (final file in sourceDartFiles('lib')) {
      final importerPath = normalizePath(file.path);
      final importerFeature = featureNameFromPath(importerPath);
      if (importerFeature == null ||
          !importerPath.startsWith('lib/features/$importerFeature/presentation/')) {
        continue;
      }

      for (final import in dartImports(file)) {
        final targetPath = import.resolvedPath;
        if (targetPath == null ||
            !targetPath.startsWith('lib/features/$importerFeature/data/')) {
          continue;
        }

        final key = '$importerPath -> $targetPath';
        observedDebt.add(key);
        if (!_phase31AllowedPresentationDataImports.contains(key)) {
          newDebt.add(
            '${formatLocation(import.importerPath, import.lineNumber)} '
            'imports ${import.uri} -> $targetPath',
          );
        }
      }
    }

    final staleAllowlistEntries = _phase31AllowedPresentationDataImports.difference(
      observedDebt,
    );

    expect(
      newDebt,
      isEmpty,
      reason:
          'Same-feature presentation -> data imports must be migrated or '
          'explicitly added to the Phase 31 temporary allowlist:\n'
          '${newDebt.join('\n')}',
    );
    expect(
      staleAllowlistEntries,
      isEmpty,
      reason:
          'Remove migrated presentation -> data entries from the Phase 31 '
          'temporary allowlist:\n'
          '${staleAllowlistEntries.join('\n')}',
    );
  });
}
