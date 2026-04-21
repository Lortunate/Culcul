import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

typedef ApprovedApplicationHomes = Map<String, String>;

const ApprovedApplicationHomes approvedApplicationHomes = {
  'lib/features/dynamic/application/dynamic_detail_actions.dart':
      'package:culcul/features/dynamic/presentation/pages/dynamic_detail_page_commands.dart',
  'lib/features/notification/application/chat_page_commands.dart':
      'package:culcul/features/notification/presentation/pages/chat_page_commands.dart',
};

// Phase 3 guardrails: once a workflow has an approved application home,
// production code must stop depending on presentation page-command locations.
void main() {
  test(
    'Phase 3 normalization rules doc exists and is linked from architecture notes',
    () async {
      final phase3Doc = File(
        'docs/architecture/phase3-structural-normalization-rules.md',
      );
      final sharedRulesDoc = File('docs/architecture/shared-boundary-rules.md');
      final phase2RulesDoc = File(
        'docs/architecture/phase2-route-and-orchestration-rules.md',
      );

      expect(
        phase3Doc.existsSync(),
        isTrue,
        reason: 'Missing docs/architecture/phase3-structural-normalization-rules.md',
      );

      final phase3Link = 'docs/architecture/phase3-structural-normalization-rules.md';
      final sharedRulesContent = await sharedRulesDoc.readAsString();
      final phase2RulesContent = await phase2RulesDoc.readAsString();

      expect(
        sharedRulesContent,
        contains(phase3Link),
        reason:
            'Expected shared boundary rules to link to the phase 3 normalization rules.',
      );
      expect(
        phase2RulesContent,
        contains(phase3Link),
        reason:
            'Expected phase 2 route/orchestration rules to link to the phase 3 normalization rules.',
      );

      final phase3RulesContent = await phase3Doc.readAsString();
      expect(
        phase3RulesContent,
        contains('presentation/pages/*_page_commands.dart'),
        reason:
            'Expected phase 3 rules to describe application ownership and transitional '
            'presentation page-command adapters.',
      );
      for (final applicationHome in approvedApplicationHomes.keys) {
        expect(
          phase3RulesContent,
          contains(applicationHome),
          reason:
              'Expected phase 3 rules to list approved application homes enforced by '
              'the guard: $applicationHome',
        );
      }
    },
  );

  test(
    'Approved application homes own production import and export directives',
    () async {
      final violations = <String>[];
      final libDir = Directory('lib');

      for (final applicationHome in approvedApplicationHomes.keys) {
        expect(
          File(applicationHome).existsSync(),
          isTrue,
          reason: 'Expected approved application home to exist: $applicationHome',
        );
      }

      if (libDir.existsSync()) {
        for (final file in libDir.listSync(recursive: true)) {
          if (file is! File || !file.path.endsWith('.dart')) {
            continue;
          }

          final normalizedPath = file.path.replaceAll('\\', '/');
          final content = _stripComments(await file.readAsString());

          for (final entry in approvedApplicationHomes.entries) {
            final forbiddenFilePath = entry.value
                .replaceFirst('package:culcul/', 'lib/')
                .replaceAll('\\', '/');

            if (normalizedPath == forbiddenFilePath || normalizedPath == entry.key) {
              continue;
            }

            if (_referencesLegacyPath(content, entry.value)) {
              violations.add('$normalizedPath -> ${entry.value}');
            }
          }
        }
      }

      expect(
        violations,
        isEmpty,
        reason:
            'Found production imports that still point at presentation page-command '
            'locations after an application home was approved: ${violations.join(', ')}',
      );
    },
  );
}

String _stripComments(String content) {
  final withoutBlockComments = content.replaceAll(RegExp(r'/\*[\s\S]*?\*/'), '');
  return withoutBlockComments.replaceAll(RegExp(r'//.*$', multiLine: true), '');
}

bool _referencesLegacyPath(String content, String legacyPackagePath) {
  final directivePattern = RegExp(
    r'''^\s*(?:import|export)\s+['"]([^'"]+)['"](?:\s+as\s+\w+)?(?:\s+(?:show|hide)\s+[^;]+)?\s*;''',
    multiLine: true,
  );
  final legacyFileName = legacyPackagePath.split('/').last;

  for (final match in directivePattern.allMatches(content)) {
    final directiveTarget = match.group(1);
    if (directiveTarget == null) {
      continue;
    }

    if (directiveTarget == legacyPackagePath) {
      return true;
    }

    if (!directiveTarget.startsWith('package:') &&
        (directiveTarget == legacyFileName ||
            directiveTarget.endsWith('/$legacyFileName'))) {
      return true;
    }
  }

  return false;
}
