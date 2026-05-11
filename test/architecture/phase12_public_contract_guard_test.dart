import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('public contract files do not export presentation or data internals', () async {
    final violations = await findPublicContractInternalExports();
    expect(
      violations,
      isEmpty,
      reason: 'Feature public contracts should expose deliberate capability seams only.\n'
          'Found internal exports:\n${violations.join('\n')}',
    );
  });
}

Future<List<String>> findPublicContractInternalExports() async {
  final violations = <String>[];
  final exportPattern = RegExp(
    r'''^export\s+['"][^'"]*(presentation|data)/[^'"]+['"][^;]*;''',
    multiLine: true,
  );

  await for (final file in _listPublicContractFiles()) {
    final content = await file.readAsString();
    for (final match in exportPattern.allMatches(content)) {
      violations.add('${file.path.replaceAll('\\', '/')} -> ${match.group(0)}');
    }
  }

  return violations;
}

Stream<File> _listPublicContractFiles() async* {
  final featuresDir = Directory('lib/features');
  if (!featuresDir.existsSync()) {
    return;
  }

  await for (final entity in featuresDir.list()) {
    if (entity is! Directory) {
      continue;
    }

    final featureName = entity.path.split(Platform.pathSeparator).last;
    final barrelFile = File('${entity.path}/$featureName.dart');
    if (barrelFile.existsSync()) {
      yield barrelFile;
    }

    await for (final child in entity.list()) {
      if (child is! File || !child.path.endsWith('.dart')) {
        continue;
      }
      final normalizedPath = child.path.replaceAll('\\', '/');
      if (!normalizedPath.endsWith('_public_contracts.dart')) {
        continue;
      }
      yield child;
    }
  }
}
