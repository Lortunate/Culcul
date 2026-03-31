import 'dart:io';

final _projectRoot = Directory.current;
const _applicationAllowedFeatures = {
  'video',
  'dynamic',
  'live',
  'notification',
  'profile',
};
const _presentationAllowedSubdirs = {
  'pages',
  'widgets',
  'view_models',
};

void main() {
  final issues = <String>[];
  final dartFiles = _projectRoot
      .listSync(recursive: true)
      .whereType<File>()
      .where((file) {
        final path = file.path.replaceAll('\\', '/');
        if (!path.contains('/lib/')) return false;
        if (path.contains('/.dart_tool/')) return false;
        if (!path.endsWith('.dart')) return false;
        return !path.endsWith('.g.dart') && !path.endsWith('.freezed.dart');
      })
      .toList();

  final useCaseDirs = _projectRoot
      .listSync(recursive: true)
      .whereType<Directory>()
      .where((dir) {
        final path = dir.path.replaceAll('\\', '/');
        if (path.contains('/.dart_tool/')) return false;
        return path.contains('/application/use_case');
      })
      .toList();
  for (final dir in useCaseDirs) {
    issues.add('Forbidden directory: ${_rel(dir.path)}');
  }

  final disallowedApplicationDirs = _projectRoot
      .listSync(recursive: true)
      .whereType<Directory>()
      .where((dir) {
        final path = dir.path.replaceAll('\\', '/');
        if (path.contains('/.dart_tool/')) return false;
        final match = RegExp(r'/lib/features/([^/]+)/application$').firstMatch(path);
        if (match == null) return false;
        final feature = match.group(1)!;
        return !_applicationAllowedFeatures.contains(feature);
      })
      .toList();
  for (final dir in disallowedApplicationDirs) {
    issues.add('Forbidden application directory outside complex features: ${_rel(dir.path)}');
  }

  final modelsDirs = _projectRoot
      .listSync(recursive: true)
      .whereType<Directory>()
      .where((dir) {
        final path = dir.path.replaceAll('\\', '/');
        if (path.contains('/.dart_tool/')) return false;
        return RegExp(r'/lib/features/[^/]+/models$').hasMatch(path);
      })
      .toList();
  for (final dir in modelsDirs) {
    issues.add('Forbidden directory: ${_rel(dir.path)}');
  }

  final legacyPresentationDirs = _projectRoot
      .listSync(recursive: true)
      .whereType<Directory>()
      .where((dir) {
        final path = dir.path.replaceAll('\\', '/');
        if (path.contains('/.dart_tool/')) return false;
        return RegExp(r'/lib/features/[^/]+/presentation/(live|weekly|relation|tabs|utils)$')
            .hasMatch(path);
      })
      .toList();
  for (final dir in legacyPresentationDirs) {
    issues.add('Forbidden legacy presentation directory: ${_rel(dir.path)}');
  }

  final disallowedPresentationSubdirs = _projectRoot
      .listSync(recursive: true)
      .whereType<Directory>()
      .where((dir) {
        final path = dir.path.replaceAll('\\', '/');
        if (path.contains('/.dart_tool/')) return false;
        final match = RegExp(r'/lib/features/[^/]+/presentation/([^/]+)$').firstMatch(path);
        if (match == null) return false;
        return !_presentationAllowedSubdirs.contains(match.group(1));
      })
      .toList();
  for (final dir in disallowedPresentationSubdirs) {
    issues.add('Forbidden presentation subdirectory: ${_rel(dir.path)}');
  }

  for (final file in dartFiles) {
    final path = _rel(file.path);
    final normalized = path.replaceAll('\\', '/');
    final content = file.readAsStringSync();
    final lines = content.split('\n');
    final importLines = lines
        .where((line) => line.trimLeft().startsWith("import 'package:"))
        .toList();
    final packageExports = lines
        .where((line) => line.trimLeft().startsWith("export 'package:"))
        .toList();

    if (RegExp(r'/lib/features/[^/]+/presentation/[^/]+_route_entry\.dart$')
        .hasMatch(normalized)) {
      issues.add('$path must be renamed to presentation/route_entry.dart');
    }

    if (RegExp(r'/lib/features/[^/]+/presentation/[^/]+_page\.dart$')
        .hasMatch(normalized)) {
      issues.add('$path must be moved under presentation/pages/');
    }

    if (RegExp(r'/lib/features/[^/]+/presentation/[^/]+\.dart$').hasMatch(normalized) &&
        !normalized.endsWith('/presentation/route_entry.dart')) {
      issues.add('$path must be moved under presentation/pages or presentation/widgets');
    }

    if (RegExp(r'/lib/features/[^/]+/application/.+\.dart$').hasMatch(normalized) &&
        !normalized.endsWith('_workflows.dart')) {
      issues.add('$path must use *_workflows.dart naming in application layer');
    }

    if (normalized.contains('/features/') &&
        importLines.any((line) => line.contains('core/providers/api_provider.dart'))) {
      issues.add('$path must not import core/providers/api_provider.dart');
    }

    if (normalized.contains('/features/') &&
        normalized.contains('/presentation/') &&
        importLines.any((line) => line.contains('/data/'))) {
      issues.add('$path must not import feature data layer directly');
    }

    if (normalized.contains('/features/') &&
        importLines.any(
          (line) => line.contains('/features/') && line.contains('/models/'),
        )) {
      issues.add('$path must not import feature models directly');
    }

    if (normalized.contains('/features/') &&
        packageExports.any(
          (line) => line.contains('/features/') && line.contains('/models/'),
        )) {
      issues.add('$path must not export feature models directly');
    }

    if (normalized.contains('/features/') &&
        (RegExp(r'\bclass\s+\w*UseCase\b').hasMatch(content) ||
            RegExp(r'\bUseCaseProvider\b').hasMatch(content) ||
            RegExp(r'\buseCaseProvider\b').hasMatch(content))) {
      issues.add('$path must use Workflow naming instead of UseCase');
    }
  }

  if (issues.isEmpty) {
    stdout.writeln('Architecture guard passed.');
    exit(0);
  }

  stderr.writeln('Architecture guard failed with ${issues.length} issue(s):');
  for (final issue in issues) {
    stderr.writeln('- $issue');
  }
  exit(1);
}

String _rel(String absolutePath) {
  final root = _projectRoot.path.replaceAll('\\', '/');
  final normalized = absolutePath.replaceAll('\\', '/');
  if (normalized.startsWith(root)) {
    return normalized.substring(root.length + 1);
  }
  return normalized;
}
