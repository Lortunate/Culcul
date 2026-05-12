import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

const _activeSpec =
    'docs/superpowers/specs/2026-05-13-phase17-model-consolidation-and-code-modernization.md';
const _activePlan =
    'docs/superpowers/plans/2026-05-13-phase17-model-consolidation-and-code-modernization.md';

void main() {
  test('Active phase baseline pointers stay singular and truthful', () async {
    final claude = await File('CLAUDE.md').readAsString();
    final guide = await File('docs/architecture/architecture-guide.md').readAsString();

    expect(claude, contains('Active spec: `$_activeSpec`'));
    expect(claude, contains('Active plan: `$_activePlan`'));
    expect(guide, contains('## Phase 17 (Active): Model Consolidation & Code Modernization'));

    final specRoots = await _rootMarkdownFiles('docs/superpowers/specs');
    final planRoots = await _rootMarkdownFiles('docs/superpowers/plans');

    expect(specRoots, equals([_activeSpec.split('/').last]));
    expect(planRoots, equals([_activePlan.split('/').last]));
  });
}

Future<List<String>> _rootMarkdownFiles(String dirPath) async {
  final dir = Directory(dirPath);
  final names = <String>[];
  await for (final entity in dir.list(recursive: false)) {
    if (entity is File && entity.path.endsWith('.md')) {
      names.add(entity.uri.pathSegments.last);
    }
  }
  names.sort();
  return names;
}
