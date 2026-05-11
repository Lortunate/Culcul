import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('feature barrels do not export presentation or data internals', () async {
    final violations = await findFeatureBarrelInternalExports();
    expect(
      violations,
      isEmpty,
      reason: 'Feature barrels must only expose deliberate public seams.\n'
          'Found internal exports:\n${violations.join('\n')}',
    );
  });
}

Future<List<String>> findFeatureBarrelInternalExports() async {
  final violations = <String>[];
  final exportPattern = RegExp(
    r'''^export\s+['"][^'"]*(presentation|data)/[^'"]+['"][^;]*;''',
    multiLine: true,
  );

  final featuresDir = Directory('lib/features');
  if (!featuresDir.existsSync()) {
    return violations;
  }

  await for (final entity in featuresDir.list()) {
    if (entity is! Directory) {
      continue;
    }

    final featureName = entity.path.split(Platform.pathSeparator).last;
    final barrelFile = File('${entity.path}/$featureName.dart');
    if (!barrelFile.existsSync()) {
      continue;
    }

    final content = await barrelFile.readAsString();
    for (final match in exportPattern.allMatches(content)) {
      violations.add('${barrelFile.path} -> ${match.group(0)}');
    }
  }

  return violations;
}
