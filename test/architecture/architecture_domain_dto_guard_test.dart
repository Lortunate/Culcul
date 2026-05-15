import 'package:flutter_test/flutter_test.dart';

import 'architecture_guard_utils.dart';

void main() {
  test('domain entities must not contain DTO or response-shaped code', () {
    final offenders = <String>[];
    final dtoPattern = RegExp(r'\b(fromJson|toJson|JsonKey|Response|Request|Dto|DTO)\b');

    for (final file in sourceDartFiles('lib')) {
      final path = normalizePath(file.path);
      if (!RegExp(r'^lib/features/[^/]+/domain/entities/').hasMatch(path)) {
        continue;
      }

      final matches = <String>[];
      for (final line in authoredDartCodeLines(file)) {
        final match = dtoPattern.firstMatch(line.text);
        if (match != null) {
          matches.add('${match.group(1)}@${line.lineNumber}');
        }
      }

      if (matches.isNotEmpty) {
        offenders.add('$path contains ${matches.join(', ')}');
      }
    }

    expect(
      offenders,
      isEmpty,
      reason:
          'DTO/response-shaped code is not allowed in domain entities:\n'
          '${offenders.join('\n')}',
    );
  });

  test('domain entities must not import feature data DTOs', () {
    final offenders = <String>[];
    final domainEntityPattern = RegExp(r'^lib/features/[^/]+/domain/entities/');
    final featureDataDtoPattern = RegExp(r'^lib/features/[^/]+/data/dtos/');

    for (final file in sourceDartFiles('lib')) {
      final importerPath = normalizePath(file.path);
      if (!domainEntityPattern.hasMatch(importerPath)) {
        continue;
      }

      for (final import in dartImports(file)) {
        final targetPath = import.resolvedPath;
        if (targetPath == null || !featureDataDtoPattern.hasMatch(targetPath)) {
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
          'Domain entities must not import feature data DTOs. Move response-shape '
          'mapping to data/application instead:\n'
          '${offenders.join('\n')}',
    );
  });
}
