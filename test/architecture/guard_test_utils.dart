import 'dart:io';

final _directivePattern = RegExp(r'''^\s*(?:import|export)\s+[^;]+;''', multiLine: true);
final _quotedPathPattern = RegExp(r'''['"]([^'"]+)['"]''');

class ImportDirective {
  const ImportDirective({
    required this.sourcePath,
    required this.importPath,
    required this.resolvedProjectPath,
  });

  final String sourcePath;
  final String importPath;
  final String? resolvedProjectPath;
}

Future<List<ImportDirective>> collectImportDirectives(String directoryPath) async {
  final directives = <ImportDirective>[];

  for (final file in dartFilesIn(directoryPath)) {
    directives.addAll(await collectImportDirectivesFromFile(file));
  }

  return directives;
}

Future<List<ImportDirective>> collectImportDirectivesFromFile(File file) async {
  final directives = <ImportDirective>[];
  final sourcePath = normalizePath(file.path);
  final content = stripComments(await file.readAsString());

  for (final directiveMatch in _directivePattern.allMatches(content)) {
    final directiveSource = directiveMatch.group(0)!;
    for (final quotedPathMatch in _quotedPathPattern.allMatches(directiveSource)) {
      final importPath = quotedPathMatch.group(1)!;
      directives.add(
        ImportDirective(
          sourcePath: sourcePath,
          importPath: importPath,
          resolvedProjectPath: resolveProjectPath(sourcePath, importPath),
        ),
      );
    }
  }

  return directives;
}

Iterable<File> dartFilesIn(String directoryPath) sync* {
  final directory = Directory(directoryPath);
  if (!directory.existsSync()) {
    return;
  }

  for (final entity in directory.listSync(recursive: true)) {
    if (entity is File && entity.path.endsWith('.dart')) {
      yield entity;
    }
  }
}

String normalizePath(String path) => path.replaceAll('\\', '/');

String stripComments(String content) {
  final withoutBlockComments = content.replaceAll(RegExp(r'/\*[\s\S]*?\*/'), '');
  return withoutBlockComments.replaceAll(RegExp(r'//.*$', multiLine: true), '');
}

String? resolveProjectPath(String sourcePath, String importPath) {
  if (importPath.startsWith('package:culcul/')) {
    return 'lib/${importPath.substring('package:culcul/'.length)}';
  }
  if (importPath.startsWith('package:') || importPath.startsWith('dart:')) {
    return null;
  }

  final resolvedPath = normalizePath(
    File(sourcePath).absolute.uri.resolve(importPath).toFilePath(
      windows: Platform.isWindows,
    ),
  );
  final repoRoot = normalizePath(Directory.current.absolute.path);
  final repoRootPrefix = repoRoot.endsWith('/') ? repoRoot : '$repoRoot/';
  if (!resolvedPath.startsWith(repoRootPrefix)) {
    return null;
  }

  return resolvedPath.substring(repoRootPrefix.length);
}

String? featureNameForProjectPath(String? projectPath) {
  final match = RegExp(r'^lib/features/([^/]+)/').firstMatch(projectPath ?? '');
  return match?.group(1);
}

bool isFeaturePresentationInternal(String? projectPath) {
  if (projectPath == null) {
    return false;
  }

  return RegExp(
    r'^lib/features/[^/]+/presentation/(widgets|pages|view_models)/',
  ).hasMatch(projectPath);
}

class AllowlistCheckResult {
  const AllowlistCheckResult({
    required this.unexpectedViolations,
    required this.staleAllowlistEntries,
  });

  final List<String> unexpectedViolations;
  final List<String> staleAllowlistEntries;
}

AllowlistCheckResult evaluateExactAllowlist({
  required Iterable<String> observedViolations,
  required Set<String> allowedViolations,
}) {
  final observedSet = {...observedViolations};
  final unexpectedViolations = <String>[
    for (final violation in observedSet)
      if (!allowedViolations.contains(violation)) violation,
  ]..sort();
  final staleAllowlistEntries = <String>[
    for (final violation in allowedViolations)
      if (!observedSet.contains(violation)) violation,
  ]..sort();

  return AllowlistCheckResult(
    unexpectedViolations: unexpectedViolations,
    staleAllowlistEntries: staleAllowlistEntries,
  );
}
