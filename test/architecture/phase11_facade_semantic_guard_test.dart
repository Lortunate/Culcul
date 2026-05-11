import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('facades do not expose repositories as public contract', () async {
    final violations = await findPublicRepositoryFieldsInFacades();
    expect(
      violations,
      isEmpty,
      reason: 'Facade files should expose capabilities, not public repository fields.\n'
          'Found facade leaks:\n${violations.join('\n')}',
    );
  });
}

Future<List<String>> findPublicRepositoryFieldsInFacades() async {
  final violations = <String>[];
  final fieldPattern = RegExp(r'^\s*final\s+\w*Repository\s+([A-Za-z]\w*)\s*;', multiLine: true);

  await for (final file in _listFacadeFiles()) {
    final content = await file.readAsString();
    final lines = content.split('\n');
    for (var index = 0; index < lines.length; index++) {
      final match = fieldPattern.firstMatch(lines[index]);
      if (match == null) {
        continue;
      }

      final fieldName = match.group(1)!;
      if (fieldName.startsWith('_')) {
        continue;
      }

      violations.add('${file.path}:${index + 1} -> ${lines[index].trim()}');
    }
  }

  return violations;
}

Stream<File> _listFacadeFiles() async* {
  final featuresDir = Directory('lib/features');
  if (!featuresDir.existsSync()) {
    return;
  }

  await for (final entity in featuresDir.list(recursive: true)) {
    if (entity is! File || !entity.path.endsWith('.dart')) {
      continue;
    }

    final normalizedPath = entity.path.replaceAll('\\', '/');
    final fileName = normalizedPath.split('/').last;
    if (!normalizedPath.contains('/application/')) {
      continue;
    }
    if (!fileName.contains('facade')) {
      continue;
    }

    yield entity;
  }
}
