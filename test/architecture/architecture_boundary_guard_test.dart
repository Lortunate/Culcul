import 'package:flutter_test/flutter_test.dart';

import 'architecture_guard_utils.dart';

void main() {
  test('feature presentation code must not import other presentation features', () {
    final offenders = <String>[];

    for (final file in sourceDartFiles('lib')) {
      final importerPath = normalizePath(file.path);
      final importerFeature = featureNameFromPath(importerPath);
      if (importerFeature == null ||
          !importerPath.startsWith('lib/features/$importerFeature/presentation/')) {
        continue;
      }

      for (final import in dartImports(file)) {
        final targetPath = import.resolvedPath;
        final targetFeature = targetPath == null ? null : featureNameFromPath(targetPath);
        if (targetPath == null ||
            targetFeature == null ||
            targetFeature == importerFeature) {
          continue;
        }

        if (targetPath.startsWith('lib/features/$targetFeature/presentation/')) {
          offenders.add(
            '${formatLocation(import.importerPath, import.lineNumber)} '
            'imports ${import.uri} -> $targetPath',
          );
        }
      }
    }

    expect(
      offenders,
      isEmpty,
      reason:
          'Cross-feature presentation imports are not allowed:\n'
          '${offenders.join('\n')}',
    );
  });

  test('features must not import other feature data implementations', () {
    final offenders = <String>[];

    for (final file in sourceDartFiles('lib')) {
      final importerPath = normalizePath(file.path);
      final importerFeature = featureNameFromPath(importerPath);
      if (importerFeature == null) {
        continue;
      }

      for (final import in dartImports(file)) {
        final targetPath = import.resolvedPath;
        final targetFeature = targetPath == null ? null : featureNameFromPath(targetPath);
        if (targetPath == null ||
            targetFeature == null ||
            targetFeature == importerFeature) {
          continue;
        }

        if (targetPath.startsWith('lib/features/$targetFeature/data/')) {
          offenders.add(
            '${formatLocation(import.importerPath, import.lineNumber)} '
            'imports ${import.uri} -> $targetPath',
          );
        }
      }
    }

    expect(
      offenders,
      isEmpty,
      reason:
          'Cross-feature data imports are not allowed:\n'
          '${offenders.join('\n')}',
    );
  });

  test('core and ui must not import feature internals', () {
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

  test('AppException must not appear in lib', () {
    final offenders = <String>[];

    for (final file in sourceDartFiles('lib')) {
      final path = normalizePath(file.path);
      for (final line in authoredDartCodeLines(file)) {
        if (line.text.contains('AppException')) {
          offenders.add('${formatLocation(path, line.lineNumber)} AppException');
        }
      }
    }

    expect(
      offenders,
      isEmpty,
      reason:
          'AppException references are not allowed in lib/:\n'
          '${offenders.join('\n')}',
    );
  });

  test('only approved contract files may be re-export-only barrels', () {
    final offenders = <String>[];

    for (final file in sourceDartFiles('lib')) {
      final normalizedPath = normalizePath(file.path);
      if (const {
        'lib/core/contracts/core_contracts.dart',
        'lib/ui/ui.dart',
      }.contains(normalizedPath)) {
        continue;
      }

      final lines = meaningfulLines(file);

      if (lines.isNotEmpty &&
          lines.every(
            (line) =>
                line.startsWith('export ') ||
                line.startsWith('library ') ||
                line.startsWith('@'),
          )) {
        offenders.add(normalizedPath);
      }
    }

    expect(
      offenders,
      isEmpty,
      reason: 'Unauthorized re-export-only files:\n${offenders.join('\n')}',
    );
  });

  test('feature scopes must stay export-only composition seams', () {
    final offenders = <String>[];
    final declarationPattern = RegExp(
      r'^(?:@\\w+\\s*)?(?:class|enum|typedef|final|const|var|Future<|void|[A-Z][A-Za-z0-9_<>?]*\\s+[a-zA-Z_])\\b',
    );

    for (final file in sourceDartFiles('lib')) {
      final normalizedPath = normalizePath(file.path);
      if (!RegExp(
        r'^lib/features/[^/]+/feature_scope\\.dart$',
      ).hasMatch(normalizedPath)) {
        continue;
      }

      for (final line in commentStrippedDartCodeLines(file)) {
        final text = line.text.trim();
        if (text.isEmpty ||
            text.startsWith('import ') ||
            text.startsWith('export ') ||
            text.startsWith('show ') ||
            text == ';') {
          continue;
        }

        if (declarationPattern.hasMatch(text) ||
            !text.startsWith('//') && !text.startsWith('hide ')) {
          offenders.add('${formatLocation(normalizedPath, line.lineNumber)} $text');
        }
      }

      for (final import in dartImports(file)) {
        final targetPath = import.resolvedPath;
        if (targetPath != null &&
            targetPath.startsWith('lib/features/') &&
            targetPath.contains('/data/')) {
          offenders.add(
            '${formatLocation(import.importerPath, import.lineNumber)} '
            'exports data seam ${import.uri} -> $targetPath',
          );
        }
      }
    }

    expect(
      offenders,
      isEmpty,
      reason:
          'feature_scope.dart files must only import/export source-owned seams:\\n'
          '${offenders.join('\\n')}',
    );
  });
}
