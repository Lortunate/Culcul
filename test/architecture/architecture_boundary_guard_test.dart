import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'architecture_guard_utils.dart';

const _phase30InventoryPath =
    'docs/architecture/archive/2026-05-21-phase30-application-seam-inventory.superseded.md';
const _activeArchitectureGuidePath = 'docs/architecture/architecture-guide.md';
const _activeArchitectureSpecPath =
    'docs/specs/2026-05-22-phase40-architecture-ssot-modernization.md';
const _activeArchitecturePlanPath =
    'docs/plans/2026-05-22-phase40-architecture-ssot-modernization.md';

const _phase30AllowedInventoryCategories = {
  'approved-session-seam',
  'approved-search-seam',
  'approved-profile-seam',
  'move-to-core-contract',
  'move-to-ui',
  'new-feature-public-api',
  'remove-accidental-coupling',
};

void main() {
  test('active architecture guide points at the current phase documents', () {
    final guide = File(_activeArchitectureGuidePath).readAsStringSync();

    expect(guide, contains('Active phase: Phase 40 Architecture SSOT Modernization.'));

    final activeLinks = RegExp(
      r'- Active (?:spec|plan): `([^`]+)`',
    ).allMatches(guide).map((match) => match.group(1)).toList();

    expect(
      activeLinks,
      unorderedEquals([_activeArchitectureSpecPath, _activeArchitecturePlanPath]),
      reason:
          'The architecture guide must expose exactly one active spec and one '
          'active plan for the current phase.',
    );

    for (final path in activeLinks) {
      expect(
        File(path!).existsSync(),
        isTrue,
        reason: 'Active architecture document does not exist: $path',
      );
      expect(
        path.contains('/archive/'),
        isFalse,
        reason: 'Archived documents cannot be linked as active work: $path',
      );
    }
  });

  test('active architecture docs do not present archived or older phases as current', () {
    final offenders = <String>[];

    for (final path in [
      _activeArchitectureGuidePath,
      _activeArchitectureSpecPath,
      _activeArchitecturePlanPath,
    ]) {
      final markdown = File(path).readAsStringSync();
      for (final block in _markdownBlocks(markdown)) {
        if (_presentsArchivedOrOlderPhaseAsCurrent(block.text)) {
          offenders.add('$path:${block.startLine}: ${block.text}');
        }
      }
    }

    expect(
      offenders,
      isEmpty,
      reason:
          'Active architecture docs must clearly mark archived and older phase '
          'references as superseded, archived, completed, or historical:\n'
          '${offenders.join('\n\n')}',
    );
  });

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

  test('phase 36 presentation contract shims stay deleted', () {
    final offenders = <String>[];

    for (final file in sourceDartFiles('lib')) {
      for (final import in dartImports(file)) {
        final targetPath = import.resolvedPath;
        if (targetPath == null) {
          continue;
        }

        if (targetPath.contains('/application/presentation_contracts/')) {
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
          'Phase 36 removed presentation_contracts compatibility shims. '
          'Import the owning feature source-of-truth directly instead:\n'
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

  test(
    'cross-feature application and domain imports must be classified',
    () {
      final inventory = _readPhase30ApplicationSeamInventory();
      final offenders = <String>[...inventory.invalidRows];

      for (final file in sourceDartFiles('lib')) {
        final importerPath = normalizePath(file.path);
        final importerFeature = featureNameFromPath(importerPath);
        if (importerFeature == null) {
          continue;
        }

        for (final import in dartImports(file)) {
          final targetPath = import.resolvedPath;
          final targetFeature = targetPath == null
              ? null
              : featureNameFromPath(targetPath);
          if (targetPath == null ||
              targetFeature == null ||
              targetFeature == importerFeature) {
            continue;
          }

          final isApplicationOrDomain =
              targetPath.startsWith('lib/features/$targetFeature/application/') ||
              targetPath.startsWith('lib/features/$targetFeature/domain/');
          if (!isApplicationOrDomain) {
            continue;
          }

          final key = _phase30InventoryKey(importerPath, targetPath);
          final category = inventory.classifiedImports[key];
          if (category == null) {
            offenders.add(
              '${formatLocation(import.importerPath, import.lineNumber)} '
              'imports ${import.uri} -> $targetPath but is not classified in '
              '$_phase30InventoryPath',
            );
          }
        }
      }

      expect(
        offenders,
        isEmpty,
        reason:
            'Cross-feature application/domain imports must be listed in '
            '$_phase30InventoryPath with an approved category and decision:\n'
            '${offenders.join('\n')}',
      );
    },
    skip: !File(_phase30InventoryPath).existsSync()
        ? 'Phase 30 inventory is retired in the Phase 31 baseline.'
        : false,
  );

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

  test('lib/shared must stay retired', () {
    final sharedDirectory = Directory('lib/shared');

    expect(
      sharedDirectory.existsSync(),
      isFalse,
      reason: 'lib/shared is retired. Use app/core/features/ui ownership instead.',
    );
  });

  test('runtime code must not contain placeholder implementations', () {
    final offenders = <String>[];
    const forbiddenMarkers = {'TODO(', 'UnimplementedError', 'throw Exception('};

    for (final file in sourceDartFiles('lib')) {
      final path = normalizePath(file.path);
      for (final line in authoredDartCodeLines(file)) {
        for (final marker in forbiddenMarkers) {
          if (line.text.contains(marker)) {
            offenders.add('${formatLocation(path, line.lineNumber)} $marker');
          }
        }
      }
    }

    expect(
      offenders,
      isEmpty,
      reason:
          'Runtime placeholder implementations are not allowed:\n'
          '${offenders.join('\n')}',
    );
  });

  test('retired architecture symbols must stay deleted', () {
    final offenders = <String>[];
    const retiredSymbols = {'PageQuery', 'rankingCategoriesV2'};

    for (final file in sourceDartFiles('lib')) {
      final path = normalizePath(file.path);
      for (final line in authoredDartCodeLines(file)) {
        for (final symbol in retiredSymbols) {
          if (line.text.contains(symbol)) {
            offenders.add('${formatLocation(path, line.lineNumber)} $symbol');
          }
        }
      }
    }

    expect(
      offenders,
      isEmpty,
      reason:
          'Retired architecture symbols must not be reintroduced:\n'
          '${offenders.join('\n')}',
    );
  });

  test('ResourceApi construction stays centralized', () {
    final offenders = <String>[];
    const approvedConstructors = {
      'lib/core/data/network/resource_api.dart',
      'lib/core/data/network/resource_api_provider.dart',
    };

    for (final file in sourceDartFiles('lib')) {
      final path = normalizePath(file.path);
      if (approvedConstructors.contains(path)) {
        continue;
      }

      for (final line in authoredDartCodeLines(file)) {
        if (line.text.contains('ResourceApi(')) {
          offenders.add('${formatLocation(path, line.lineNumber)} ResourceApi(');
        }
      }
    }

    expect(
      offenders,
      isEmpty,
      reason:
          'ResourceApi must be constructed only by the central network provider:\n'
          '${offenders.join('\n')}',
    );
  });

  test('shared comment reply endpoints stay in CommentService', () {
    final offenders = <String>[];
    const approvedFiles = {
      'lib/core/constants/api_constants.dart',
      'lib/core/services/comment_service.dart',
    };
    const forbiddenMarkers = {
      'ApiConstants.reply',
      'ApiConstants.replyReply',
      'ApiConstants.replyAction',
      'ApiConstants.replyHate',
      'ApiConstants.replyAdd',
      "'/x/v2/reply'",
      "'/x/v2/reply/reply'",
      "'/x/v2/reply/action'",
      "'/x/v2/reply/hate'",
      "'/x/v2/reply/add'",
    };

    for (final file in sourceDartFiles('lib')) {
      final path = normalizePath(file.path);
      if (approvedFiles.contains(path)) {
        continue;
      }

      final lines = file.readAsLinesSync();
      for (var lineIndex = 0; lineIndex < lines.length; lineIndex++) {
        final trimmed = lines[lineIndex].trim();
        if (trimmed.startsWith('//') ||
            trimmed.startsWith('/*') ||
            trimmed.startsWith('*')) {
          continue;
        }
        for (final marker in forbiddenMarkers) {
          if (trimmed.contains(marker)) {
            offenders.add('${formatLocation(path, lineIndex + 1)} $marker');
          }
        }
      }
    }

    expect(
      offenders,
      isEmpty,
      reason:
          'Shared comment reply endpoints must be routed through CommentService:\n'
          '${offenders.join('\n')}',
    );
  });

  test('re-export-only barrels are not allowed', () {
    final offenders = <String>[];

    for (final file in sourceDartFiles('lib')) {
      final normalizedPath = normalizePath(file.path);

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
      reason: 'Re-export-only barrels:\n${offenders.join('\n')}',
    );
  });

  test('feature_scope.dart files must stay retired', () {
    final offenders = sourceDartFiles('lib')
        .map((file) => normalizePath(file.path))
        .where(
          (path) => RegExp(r'^lib/features/[^/]+/feature_scope\.dart$').hasMatch(path),
        )
        .toList();

    expect(
      offenders,
      isEmpty,
      reason:
          'feature_scope.dart is retired in the Phase 30 baseline. Reintroduce it '
          'only with a concrete approved runtime seam:\n'
          '${offenders.join('\n')}',
    );
  });
}

_Phase30ApplicationSeamInventory _readPhase30ApplicationSeamInventory() {
  final file = File(_phase30InventoryPath);
  if (!file.existsSync()) {
    return const _Phase30ApplicationSeamInventory(
      classifiedImports: {},
      invalidRows: ['Missing $_phase30InventoryPath'],
    );
  }

  final classifiedImports = <String, String>{};
  final invalidRows = <String>[];

  for (final entry in file.readAsLinesSync().indexed) {
    final lineNumber = entry.$1 + 1;
    final line = entry.$2.trim();
    if (!line.startsWith('|') ||
        line.startsWith('|---') ||
        line.startsWith('| Importer |')) {
      continue;
    }

    final columns = line
        .split('|')
        .skip(1)
        .take(4)
        .map((column) => column.trim())
        .toList();
    if (columns.length < 4) {
      invalidRows.add('$_phase30InventoryPath:$lineNumber malformed inventory row');
      continue;
    }

    final importer = _stripBackticks(columns[0]);
    final target = _stripBackticks(columns[1]);
    final category = _stripBackticks(columns[2]);
    final decision = columns[3].trim();
    final importerPath = RegExp(
      r'^(lib/[^:]+\.dart)(?::\d+)?$',
    ).firstMatch(importer)?.group(1);

    if (importerPath == null || !target.startsWith('lib/features/')) {
      invalidRows.add('$_phase30InventoryPath:$lineNumber invalid importer/target');
      continue;
    }
    if (!_phase30AllowedInventoryCategories.contains(category)) {
      invalidRows.add('$_phase30InventoryPath:$lineNumber invalid category $category');
      continue;
    }
    if (decision.isEmpty || decision == '`TBD`' || decision == 'TBD') {
      invalidRows.add('$_phase30InventoryPath:$lineNumber missing decision');
      continue;
    }

    classifiedImports[_phase30InventoryKey(importerPath, target)] = category;
  }

  return _Phase30ApplicationSeamInventory(
    classifiedImports: classifiedImports,
    invalidRows: invalidRows,
  );
}

String _phase30InventoryKey(String importerPath, String targetPath) {
  return '${normalizePath(importerPath)} -> ${normalizePath(targetPath)}';
}

String _stripBackticks(String value) {
  return value.trim().replaceAll('`', '');
}

class _MarkdownBlock {
  const _MarkdownBlock({required this.startLine, required this.text});

  final int startLine;
  final String text;
}

List<_MarkdownBlock> _markdownBlocks(String markdown) {
  final blocks = <_MarkdownBlock>[];
  final current = <String>[];
  var startLine = 1;

  final lines = markdown.split(RegExp(r'\r?\n'));
  for (var index = 0; index < lines.length; index += 1) {
    final line = lines[index];
    if (line.trim().isEmpty) {
      if (current.isNotEmpty) {
        blocks.add(_MarkdownBlock(startLine: startLine, text: current.join(' ').trim()));
        current.clear();
      }
      startLine = index + 2;
      continue;
    }

    if (current.isEmpty) {
      startLine = index + 1;
    }
    current.add(line.trim());
  }

  if (current.isNotEmpty) {
    blocks.add(_MarkdownBlock(startLine: startLine, text: current.join(' ').trim()));
  }

  return blocks;
}

bool _presentsArchivedOrOlderPhaseAsCurrent(String block) {
  final currentLanguage = RegExp(
    r'\b(active|current|latest|authoritative)\b|source[- ]of[- ]truth',
    caseSensitive: false,
  );
  final staleTarget = RegExp(
    r'docs/(specs|plans|architecture)/archive/|'
    r'Phase\s*(38|39)\b|'
    r'phase(38|39)\b|'
    r'2026-05-21-phase(38|39)',
    caseSensitive: false,
  );
  final archivalStatus = RegExp(
    r'\b(supersedes|superseded|archive|archived|completed|previous|earlier|'
    r'historical|history|baseline|retired)\b',
    caseSensitive: false,
  );

  return currentLanguage.hasMatch(block) &&
      staleTarget.hasMatch(block) &&
      !archivalStatus.hasMatch(block);
}

class _Phase30ApplicationSeamInventory {
  const _Phase30ApplicationSeamInventory({
    required this.classifiedImports,
    required this.invalidRows,
  });

  final Map<String, String> classifiedImports;
  final List<String> invalidRows;
}
