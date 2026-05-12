import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Phase 18 update: Cross-feature presentation imports are allowed for
/// widgets and view models that are designed to be shared (previously
/// hidden behind barrel files). The rule now only forbids importing
/// another feature's _pages_ (top-level screens), which are never shared.
void main() {
  test('features only depend on other features through public seams, not presentation internals', () async {
    final violations = <String>[];
    final importPattern = RegExp(
      "^\\s*import\\s+['\"]package:culcul/features/([^/]+)/presentation/pages/[^'\"]+['\"]",
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
          'Cross-feature page imports are forbidden — use route_entry.dart for navigation. '
          'Found: ${violations.join(', ')}',
    );
  });
}
