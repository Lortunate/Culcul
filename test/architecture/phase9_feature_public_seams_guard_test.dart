import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('features only depend on other features through public seams, not presentation internals', () async {
    final violations = <String>[];
    final importPattern = RegExp(
      "^\\s*import\\s+['\"]package:culcul/features/([^/]+)/presentation/[^'\"]+['\"]",
      multiLine: true,
    );

    await for (final entity in Directory('lib/features').list(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) {
        continue;
      }

      final normalizedPath = entity.path.replaceAll('\\', '/');
      if (normalizedPath.endsWith('.g.dart') || normalizedPath.endsWith('.freezed.dart')) {
        continue;
      }

      final parts = normalizedPath.split('/');
      if (parts.length < 3) {
        continue;
      }
      final feature = parts[2];
      final content = await entity.readAsString();

      for (final match in importPattern.allMatches(content)) {
        final targetFeature = match.group(1)!;
        if (targetFeature != feature) {
          violations.add('$normalizedPath -> ${match.group(0)}');
        }
      }
    }

    expect(
      violations,
      isEmpty,
      reason:
          'Cross-feature presentation imports must be replaced by route_entry, feature_scope, or <feature>.dart seams. '
          'Found: ${violations.join(', ')}',
    );
  });
}
