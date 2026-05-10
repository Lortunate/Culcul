import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('feature barrels do not broadly re-export presentation internals', () async {
    final violations = await findBarrelPresentationExports();
    expect(
      violations,
      isEmpty,
      reason: 'Feature barrels should expose deliberate public APIs, not whole presentation surfaces.\n'
          'Found violations:\n${violations.join('\n')}',
    );
  });
}

Future<List<String>> findBarrelPresentationExports() async {
  final violations = <String>[];
  final exportPattern = RegExp(r'''^export\s+['"]presentation/[^'"]+['"];''', multiLine: true);

  final featuresDir = Directory('lib/features');
  if (!featuresDir.existsSync()) return violations;

  await for (final entity in featuresDir.list()) {
    if (entity is Directory) {
      final featureName = entity.path.split(Platform.pathSeparator).last;
      final barrelFile = File('${entity.path}/$featureName.dart');
      
      if (barrelFile.existsSync()) {
        final content = await barrelFile.readAsString();
        for (final match in exportPattern.allMatches(content)) {
          violations.add('${barrelFile.path} -> ${match.group(0)}');
        }
      }
    }
  }

  return violations;
}
