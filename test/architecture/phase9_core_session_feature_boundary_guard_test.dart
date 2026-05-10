import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('core/session does not import feature-owned paths', () async {
    final sessionDir = Directory('lib/core/session');
    final violations = <String>[];

    if (sessionDir.existsSync()) {
      for (final file in sessionDir.listSync(recursive: true)) {
        if (file is! File || !file.path.endsWith('.dart')) {
          continue;
        }

        final normalizedPath = file.path.replaceAll('\\', '/');
        final content = _stripComments(await file.readAsString());
        final matches = _featureImportPattern.allMatches(content);

        for (final match in matches) {
          violations.add('$normalizedPath -> ${match.group(1)}');
        }
      }
    }

    expect(
      violations,
      isEmpty,
      reason:
          'core/session must stay feature-neutral. Found feature-owned imports: '
          '${violations.join(', ')}',
    );
  });
}

final _featureImportPattern = RegExp(
  "^\\s*(?:import|export)\\s+['\"](package:culcul/features/[^'\"]+)['\"](?:\\s+as\\s+\\w+)?(?:\\s+(?:show|hide)\\s+[^;]+)?\\s*;",
  multiLine: true,
);

String _stripComments(String content) {
  final withoutBlockComments = content.replaceAll(RegExp(r'/\*[\s\S]*?\*/'), '');
  return withoutBlockComments.replaceAll(RegExp(r'//.*$', multiLine: true), '');
}
