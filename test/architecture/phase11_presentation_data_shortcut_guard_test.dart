import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('presentation does not import feature-local data when a facade seam exists', () async {
    final violations = await findPresentationDataShortcuts();
    expect(
      violations,
      isEmpty,
      reason: 'Presentation should go through feature capabilities instead of importing its own data layer directly.\n'
          'Found shortcuts:\n${violations.join('\n')}',
    );
  });
}

Future<List<String>> findPresentationDataShortcuts() async {
  final violations = <String>[];
  final importPattern = RegExp(
    r'''^\s*import\s+['"]package:culcul/features/([^/]+)/data/[^'"]+['"]''',
    multiLine: true,
  );

  await for (final entity in Directory('lib/features').list(recursive: true)) {
    if (entity is! File || !entity.path.endsWith('.dart')) {
      continue;
    }

    final normalizedPath = entity.path.replaceAll('\\', '/');
    if (!normalizedPath.contains('/presentation/')) {
      continue;
    }
    if (normalizedPath.endsWith('.g.dart') || normalizedPath.endsWith('.freezed.dart')) {
      continue;
    }

    final ownerMatch = RegExp(r'/features/([^/]+)/presentation/').firstMatch(normalizedPath);
    if (ownerMatch == null) {
      continue;
    }
    final ownerFeature = ownerMatch.group(1)!;

    final content = await entity.readAsString();
    for (final match in importPattern.allMatches(content)) {
      final targetFeature = match.group(1)!;
      if (targetFeature == ownerFeature) {
        violations.add('$normalizedPath -> ${match.group(0)}');
      }
    }
  }

  return violations;
}
