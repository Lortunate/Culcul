import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

// Phase 1 guardrails: preserve package boundaries while feature cleanup proceeds.
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

  test('Feature modules do not import removed domain/presentation facades', () async {
    final forbiddenImport = RegExp(
      r'''import\s+['"]package:culcul/features/[^'"]+/(domain|presentation)\.dart['"]''',
    );
    final violations = <String>[];
    final libDir = Directory('lib');

    if (libDir.existsSync()) {
      for (final file in libDir.listSync(recursive: true)) {
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
      reason: 'Found forbidden facade imports: ${violations.join(', ')}',
    );
  });

  test('App routes does not import Phase 2A broad feature barrels', () async {
    final appRoutesFile = File('lib/app/router/app_routes.dart');
    final broadFeatureBarrelImport = RegExp(
      r'''import\s+['"]package:culcul/features/(auth|dynamic|home|live|notification|profile|search|settings|to_view|video)/\1\.dart['"]''',
    );
    final violations = <String>[];

    if (appRoutesFile.existsSync()) {
      final content = await appRoutesFile.readAsString();
      for (final match in broadFeatureBarrelImport.allMatches(content)) {
        violations.add(match.group(0)!);
      }
    }

    expect(
      violations,
      isEmpty,
      reason:
          'Found broad feature barrel imports in app_routes.dart: ${violations.join(', ')}',
    );
  });

  test(
    'App routes uses the home route entry instead of concrete home page imports',
    () async {
      final appRoutesFile = File('lib/app/router/app_routes.dart');
      const homeRouteEntryImport =
          "import 'package:culcul/features/home/route_entry.dart';";
      final forbiddenImports = [
        "import 'package:culcul/features/home/presentation/pages/home_page.dart';",
        "import 'package:culcul/features/home/presentation/pages/weekly_screen.dart';",
      ];

      expect(appRoutesFile.existsSync(), isTrue, reason: 'app_routes.dart must exist');

      final content = await appRoutesFile.readAsString();
      final violations = [
        for (final forbiddenImport in forbiddenImports)
          if (content.contains(forbiddenImport)) forbiddenImport,
      ];

      expect(
        content.contains(homeRouteEntryImport),
        isTrue,
        reason: 'Expected app_routes.dart to import the home route entry.',
      );
      expect(
        violations,
        isEmpty,
        reason:
            'Found concrete home page imports in app_routes.dart: ${violations.join(', ')}',
      );
    },
  );
}
