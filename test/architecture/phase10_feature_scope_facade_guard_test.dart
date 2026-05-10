import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('feature_scope exposes facades instead of raw data providers', () async {
    final violations = await findFeatureScopeDataProviderLeaks();
    expect(
      violations,
      isEmpty,
      reason: 'feature_scope.dart should act as a facade seam, not a repository-provider dump.\n'
          'Found violations:\n${violations.join('\n')}',
    );
  });
}

Future<List<String>> findFeatureScopeDataProviderLeaks() async {
  final violations = <String>[];
  final leakPattern = RegExp(r"RepositoryProvider|ApiProvider");

  final featuresDir = Directory('lib/features');
  if (!featuresDir.existsSync()) return violations;

  await for (final entity in featuresDir.list()) {
    if (entity is Directory) {
      final featureScopeFile = File('${entity.path}/feature_scope.dart');
      
      if (featureScopeFile.existsSync()) {
        final content = await featureScopeFile.readAsString();
        final lines = content.split('\n');
        for (var i = 0; i < lines.length; i++) {
          if (leakPattern.hasMatch(lines[i])) {
            violations.add('${featureScopeFile.path}:${i + 1} -> ${lines[i].trim()}');
          }
        }
      }
    }
  }

  return violations;
}
