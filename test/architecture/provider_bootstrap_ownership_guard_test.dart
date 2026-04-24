import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

const _retiredBootstrapImportPaths = [
  'package:culcul/shared/providers/cache_store_provider.dart',
  'package:culcul/shared/providers/cookie_jar_provider.dart',
  'package:culcul/shared/providers/storage_provider.dart',
  'package:culcul/shared/providers/session_refresh_provider.dart',
  'package:culcul/shared/session/session_cookie_refresher.dart',
];

void main() {
  test('Production code does not import retired bootstrap-owned shared paths', () async {
    final libDir = Directory('lib');
    final violations = <String>[];

    if (libDir.existsSync()) {
      for (final file in libDir.listSync(recursive: true)) {
        if (file is! File || !file.path.endsWith('.dart')) {
          continue;
        }

        final normalizedPath = file.path.replaceAll('\\', '/');
        final content = _stripComments(await file.readAsString());

        for (final retiredImportPath in _retiredBootstrapImportPaths) {
          if (_referencesRetiredPath(content, retiredImportPath)) {
            violations.add('$normalizedPath -> $retiredImportPath');
          }
        }
      }
    }

    expect(
      violations,
      isEmpty,
      reason:
          'Found production imports that still point at retired bootstrap-owned shared paths: '
          '${violations.join(', ')}',
    );
  });
}

String _stripComments(String content) {
  final withoutBlockComments = content.replaceAll(RegExp(r'/\*[\s\S]*?\*/'), '');
  return withoutBlockComments.replaceAll(RegExp(r'//.*$', multiLine: true), '');
}

bool _referencesRetiredPath(String content, String retiredImportPath) {
  final directivePattern = RegExp(
    "^\\s*(?:import|export)\\s+['\"]${RegExp.escape(retiredImportPath)}['\"](?:\\s+as\\s+\\w+)?(?:\\s+(?:show|hide)\\s+[^;]+)?\\s*;",
    multiLine: true,
  );
  return directivePattern.hasMatch(content);
}
