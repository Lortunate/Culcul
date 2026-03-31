import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Auth/Video presentation does not import data layer directly', () async {
    final forbiddenImport = RegExp(
      r'''import\s+['"]package:culcul/features/(auth|video)/data/''',
    );
    final violations = <String>[];

    for (final feature in ['auth', 'video']) {
      final presentationDir = Directory('lib/features/$feature/presentation');
      if (!presentationDir.existsSync()) {
        continue;
      }

      for (final file in presentationDir.listSync(recursive: true)) {
        if (file is! File || !file.path.endsWith('.dart')) {
          continue;
        }
        final content = await file.readAsString();
        if (forbiddenImport.hasMatch(content)) {
          violations.add(file.path);
        }
      }
    }

    expect(
      violations,
      isEmpty,
      reason: 'Found forbidden presentation -> data imports: ${violations.join(', ')}',
    );
  });

  test('Auth DTO layer does not export domain entities', () async {
    final dtoDir = Directory('lib/features/auth/data/dtos');
    final forbiddenExport = RegExp(
      r'''export\s+['"]package:culcul/features/auth/domain/''',
    );
    final violations = <String>[];

    if (dtoDir.existsSync()) {
      for (final file in dtoDir.listSync(recursive: true)) {
        if (file is! File || !file.path.endsWith('.dart')) {
          continue;
        }
        final content = await file.readAsString();
        if (forbiddenExport.hasMatch(content)) {
          violations.add(file.path);
        }
      }
    }

    expect(
      violations,
      isEmpty,
      reason: 'Found forbidden auth DTO exports: ${violations.join(', ')}',
    );
  });
}
