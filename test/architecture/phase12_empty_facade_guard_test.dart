import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('facades must expose at least one real capability', () async {
    final violations = await findEmptyFacadeCandidates();
    expect(
      violations,
      isEmpty,
      reason: 'Facade files should carry capability behavior, not only wrapper state.\n'
          'Found empty facade candidates:\n${violations.join('\n')}',
    );
  });
}

Future<List<String>> findEmptyFacadeCandidates() async {
  final violations = <String>[];

  await for (final file in _listFacadeFiles()) {
    final content = await file.readAsString();
    final classBody = _extractFacadeClassBody(content);
    if (classBody == null) {
      continue;
    }

    final hasPrivateState = RegExp(
      r'^\s*final\s+[A-Za-z0-9_<>, ?]+\s+_[A-Za-z0-9_]+\s*;',
      multiLine: true,
    ).hasMatch(classBody);
    if (!hasPrivateState) {
      continue;
    }

    final capabilityMethodCount = RegExp(
      r'^\s*(?:Future<[^;{]+>|Stream<[^;{]+>|void|bool|int|double|String|Map<[^;{]+>|List<[^;{]+>|Set<[^;{]+>|[A-Z][A-Za-z0-9_<>, ?]+)\s+[a-z][A-Za-z0-9_]*\s*\(',
      multiLine: true,
    ).allMatches(classBody).length;

    if (capabilityMethodCount == 0) {
      violations.add(file.path.replaceAll('\\', '/'));
    }
  }

  return violations;
}

String? _extractFacadeClassBody(String content) {
  final classMatch = RegExp(
    r'class\s+[A-Za-z0-9_]*Facade\s*\{([\s\S]*)\}\s*$',
    multiLine: true,
  ).firstMatch(content);
  return classMatch?.group(1);
}

Stream<File> _listFacadeFiles() async* {
  final featuresDir = Directory('lib/features');
  if (!featuresDir.existsSync()) {
    return;
  }

  await for (final entity in featuresDir.list(recursive: true)) {
    if (entity is! File || !entity.path.endsWith('.dart')) {
      continue;
    }

    final normalizedPath = entity.path.replaceAll('\\', '/');
    final fileName = normalizedPath.split('/').last;
    if (fileName.endsWith('.g.dart')) {
      continue;
    }
    if (!normalizedPath.contains('/application/')) {
      continue;
    }
    if (!fileName.contains('facade')) {
      continue;
    }

    yield entity;
  }
}
