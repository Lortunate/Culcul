import 'dart:io';

final _projectRoot = _resolveProjectRoot();
const _applicationAllowedFeatures = {'dynamic', 'video'};
const _presentationAllowedSubdirs = {'pages', 'widgets', 'view_models', 'hooks'};
const _allowedCrossFeatureDomainExportFiles = <String>{};
const _allowedDomainDtoForwardFiles = <String>{
  'lib/features/dynamic/domain/entities/dynamic_response.dart',
};
const _allowedNonResultRepositoryMethods = <String>{
  'writeProfile',
  'saveThemePreference',
  'clearCache',
  'getCacheSizeInBytes',
  'readProfile',
  'getUnreadCountFromLocal',
  'listSystemNoticesFromLocal',
  'pageSessionsFromLocal',
  'pageMessagesFromLocal',
  'getMessageEmojiMapFromLocal',
  'pageFeedFromLocal',
};
const _longFileWarnLineThreshold = 200;
const _longFileWarnCountThreshold = 30;

void main() {
  final issues = <String>[];
  final warnings = <String>[];
  final longFileLines = <String, int>{};
  final parameterTypeLocations = <String, Set<String>>{};
  final mapperTypeLocations = <String, Set<String>>{};
  final exportOnlySignatureLocations = <String, ({String feature, Set<String> paths})>{};
  final libRootPrefix = '${_projectRoot.path.replaceAll('\\', '/')}/lib/';
  final dartFiles = _projectRoot
      .listSync(recursive: true, followLinks: false)
      .whereType<File>()
      .where((file) {
        final path = file.path.replaceAll('\\', '/');
        if (!path.startsWith(libRootPrefix)) return false;
        if (path.contains('/.dart_tool/')) return false;
        if (path.contains('/build/')) return false;
        if (!path.endsWith('.dart')) return false;
        return !path.endsWith('.g.dart') &&
            !path.endsWith('.freezed.dart') &&
            !path.endsWith('.pb.dart') &&
            !path.endsWith('.pbenum.dart') &&
            !path.endsWith('.pbjson.dart') &&
            !path.endsWith('.pbserver.dart');
      })
      .toList();

  final useCaseDirs = _projectRoot.listSync(recursive: true).whereType<Directory>().where(
    (dir) {
      final path = dir.path.replaceAll('\\', '/');
      if (path.contains('/.dart_tool/')) return false;
      return path.contains('/application/use_case');
    },
  ).toList();
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
    issues.add(
      'Forbidden application directory outside complex features: ${_rel(dir.path)}',
    );
  }

  final emptyApplicationDirs = _projectRoot
      .listSync(recursive: true)
      .whereType<Directory>()
      .where((dir) {
        final path = dir.path.replaceAll('\\', '/');
        if (path.contains('/.dart_tool/')) return false;
        if (!RegExp(r'/lib/features/[^/]+/application$').hasMatch(path)) {
          return false;
        }
        return !dir
            .listSync(recursive: true)
            .whereType<File>()
            .any(
              (file) =>
                  file.path.endsWith('.dart') &&
                  !file.path.endsWith('.g.dart') &&
                  !file.path.endsWith('.freezed.dart'),
            );
      })
      .toList();
  for (final dir in emptyApplicationDirs) {
    issues.add('Forbidden empty application directory: ${_rel(dir.path)}');
  }

  final legacyProviderFiles = _projectRoot
      .listSync(recursive: true)
      .whereType<File>()
      .where((file) {
        final path = file.path.replaceAll('\\', '/');
        if (path.contains('/.dart_tool/')) return false;
        return RegExp(r'/lib/features/[^/]+/[^/]+_providers\.dart$').hasMatch(path);
      })
      .toList();
  for (final file in legacyProviderFiles) {
    issues.add('Forbidden legacy provider entrypoint: ${_rel(file.path)}');
  }

  final modelsDirs = _projectRoot.listSync(recursive: true).whereType<Directory>().where((
    dir,
  ) {
    final path = dir.path.replaceAll('\\', '/');
    if (path.contains('/.dart_tool/')) return false;
    return RegExp(r'/lib/features/[^/]+/models$').hasMatch(path);
  }).toList();
  for (final dir in modelsDirs) {
    issues.add('Forbidden directory: ${_rel(dir.path)}');
  }

  final legacyPresentationDirs = _projectRoot
      .listSync(recursive: true)
      .whereType<Directory>()
      .where((dir) {
        final path = dir.path.replaceAll('\\', '/');
        if (path.contains('/.dart_tool/')) return false;
        return RegExp(
          r'/lib/features/[^/]+/presentation/(live|weekly|relation|tabs|utils)$',
        ).hasMatch(path);
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
        final match = RegExp(
          r'/lib/features/[^/]+/presentation/([^/]+)$',
        ).firstMatch(path);
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
    final lineCount = file.readAsLinesSync().length;
    final importLines = lines
        .where((line) => line.trimLeft().startsWith("import 'package:"))
        .toList();
    final packageExports = lines
        .where((line) => line.trimLeft().startsWith("export 'package:"))
        .toList();
    longFileLines[path] = lineCount;

    if (normalized.contains('/features/')) {
      final parameterTypeMatches = RegExp(
        r'\b(?:class|sealed class|final class|base class|abstract class)\s+(\w*(?:Query|Params|Param|Request))\b',
      ).allMatches(content);
      for (final match in parameterTypeMatches) {
        final typeName = match.group(1);
        if (typeName == null) continue;
        parameterTypeLocations.putIfAbsent(typeName, () => <String>{}).add(path);
      }

      final mapperTypeMatches = RegExp(
        r'\b(?:class|extension)\s+(\w*Mapper)\b',
      ).allMatches(content);
      for (final match in mapperTypeMatches) {
        final typeName = match.group(1);
        if (typeName == null) continue;
        mapperTypeLocations.putIfAbsent(typeName, () => <String>{}).add(path);
      }
    }

    final nonCommentLines = lines
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty && !line.startsWith('//'))
        .toList();
    final isExportOnlyFile =
        nonCommentLines.isNotEmpty &&
        nonCommentLines.every((line) => line.startsWith('export '));
    if (isExportOnlyFile) {
      final feature = RegExp(r'^lib/features/([^/]+)/').firstMatch(normalized)?.group(1);
      if (feature != null) {
        final exports = nonCommentLines.toList()..sort();
        final signature = exports.join('\n');
        final key = '$feature::$signature';
        final entry = exportOnlySignatureLocations.putIfAbsent(
          key,
          () => (feature: feature, paths: <String>{}),
        );
        entry.paths.add(path);
      }
    }

    if (RegExp(
      r'/lib/features/[^/]+/presentation/[^/]+_route_entry\.dart$',
    ).hasMatch(normalized)) {
      issues.add('$path must be renamed to route_entry.dart at feature root');
    }

    if (RegExp(
      r'/lib/features/[^/]+/presentation/[^/]+_page\.dart$',
    ).hasMatch(normalized)) {
      issues.add('$path must be moved under presentation/pages/');
    }

    if (RegExp(r'/lib/features/[^/]+/presentation/[^/]+\.dart$').hasMatch(normalized)) {
      issues.add(
        '$path must be moved under presentation/pages, presentation/widgets, or presentation/hooks',
      );
    }

    if (RegExp(r'/lib/features/[^/]+/application/.+\.dart$').hasMatch(normalized) &&
        !normalized.endsWith('_workflows.dart')) {
      issues.add('$path must use *_workflows.dart naming in application layer');
    }

    if (normalized.contains('/features/') &&
        importLines.any((line) => line.contains('core/providers/api_provider.dart'))) {
      issues.add('$path must not import core/providers/api_provider.dart');
    }

    if (normalized.contains('/core/contracts/')) {
      if (content.contains('FormatUtils')) {
        issues.add('$path must keep shared contracts free of presentation details');
      }
    }

    if (content.contains('core/base_repository.dart')) {
      issues.add('$path must not import BaseRepository');
    }

    if (content.contains('core/result/run_result.dart') ||
        RegExp(r'\brun(Result|VoidResult)\s*\(').hasMatch(content)) {
      issues.add('$path must not depend on run_result helpers');
    }

    if (RegExp(
      r'/lib/features/[^/]+/(data/dtos|domain/entities)/[^/]*models[^/]*\.dart$',
    ).hasMatch(normalized)) {
      issues.add('$path must not use *models*.dart naming in dto/domain entities');
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
        normalized.contains('/data/dtos/') &&
        packageExports.any((line) => line.contains('/domain/'))) {
      issues.add('$path must not export feature domain symbols from data/dtos');
    }

    if (normalized.contains('/features/') &&
        normalized.contains('/domain/') &&
        packageExports.any((line) => line.contains('/data/dtos/')) &&
        !_allowedDomainDtoForwardFiles.contains(path)) {
      issues.add('$path must not export data/dtos from domain layer');
    }

    if (normalized.contains('/features/') && normalized.contains('/domain/entities/')) {
      final hasDomainJsonDetails =
          RegExp(r'\bJsonKey\b').hasMatch(content) ||
          RegExp(r'\bfromJson\s*\(').hasMatch(content) ||
          RegExp(r'\btoJson\s*\(').hasMatch(content) ||
          RegExp("part\\s+['\\\"].*\\.g\\.dart['\\\"]").hasMatch(content);
      if (hasDomainJsonDetails) {
        issues.add('$path must keep domain entities free of JSON serialization details');
      }
    }

    if (normalized.contains('/features/') && normalized.contains('/domain/entities/')) {
      final sourceFeatureMatch = RegExp(r'/lib/features/([^/]+)/').firstMatch(normalized);
      final sourceFeature = sourceFeatureMatch?.group(1);
      for (final line in packageExports) {
        final match = RegExp(
          r"export 'package:culcul/features/([^/]+)/domain/entities/",
        ).firstMatch(line);
        if (match == null || sourceFeature == null) continue;
        final targetFeature = match.group(1)!;
        if (targetFeature != sourceFeature &&
            !_allowedCrossFeatureDomainExportFiles.contains(path)) {
          issues.add(
            '$path must not export other feature domain entities directly (use core/contracts)',
          );
          break;
        }
      }
    }

    final domainImportMatches = RegExp(
      r"import 'package:culcul/features/([^/]+)/domain/",
    ).allMatches(content);
    final featureImportMatches = RegExp(
      r"import 'package:culcul/features/([^/]+)/([^']+)'",
    ).allMatches(content);
    if (normalized.contains('/features/') && normalized.contains('/domain/')) {
      final sourceFeatureMatch = RegExp(r'/lib/features/([^/]+)/').firstMatch(normalized);
      final sourceFeature = sourceFeatureMatch?.group(1);
      for (final match in domainImportMatches) {
        final targetFeature = match.group(1);
        if (sourceFeature != null &&
            targetFeature != null &&
            sourceFeature != targetFeature) {
          issues.add(
            '$path must not import other feature domain symbols directly (use core/contracts)',
          );
          break;
        }
      }
    }

    if (normalized.startsWith('lib/app/')) {
      for (final match in featureImportMatches) {
        final feature = match.group(1);
        final suffix = match.group(2);
        if (feature == null || suffix == null) continue;
        if (suffix != '$feature.dart') {
          issues.add(
            '$path must import feature public entrypoints only (use package:culcul/features/$feature/$feature.dart)',
          );
          break;
        }
      }
    }

    if (normalized.contains('/features/')) {
      final sourceFeatureMatch = RegExp(r'/lib/features/([^/]+)/').firstMatch(normalized);
      final sourceFeature = sourceFeatureMatch?.group(1);
      for (final match in featureImportMatches) {
        final targetFeature = match.group(1);
        final suffix = match.group(2);
        if (sourceFeature == null || targetFeature == null || suffix == null) continue;
        final allowedCrossFeatureEntrypoints = <String>{'$targetFeature.dart'};
        if (sourceFeature != targetFeature &&
            !allowedCrossFeatureEntrypoints.contains(suffix)) {
          issues.add(
            '$path must import other features through their public entrypoint only',
          );
          break;
        }
      }
    }

    if (normalized.contains('/features/') && normalized.contains('/presentation/')) {
      final sourceFeatureMatch = RegExp(r'/lib/features/([^/]+)/').firstMatch(normalized);
      final sourceFeature = sourceFeatureMatch?.group(1);
      for (final match in domainImportMatches) {
        final targetFeature = match.group(1);
        if (sourceFeature != null &&
            targetFeature != null &&
            sourceFeature != targetFeature &&
            !content.contains("import 'package:culcul/core/contracts/")) {
          issues.add(
            '$path must not import other feature domain symbols directly from presentation (use core/contracts)',
          );
          break;
        }
      }
    }

    if (normalized.contains('/features/') &&
        (RegExp(r'\bclass\s+\w*UseCase\b').hasMatch(content) ||
            RegExp(r'\bUseCaseProvider\b').hasMatch(content) ||
            RegExp(r'\buseCaseProvider\b').hasMatch(content))) {
      issues.add('$path must use Workflow naming instead of UseCase');
    }

    if (normalized.contains('/features/') &&
        normalized.contains('/presentation/') &&
        importLines.any((line) => line.contains('core/errors/exceptions.dart'))) {
      issues.add('$path must not import AppException definitions in presentation layer');
    }

    if (RegExp(r'^lib/features/[^/]+/(domain|presentation)\.dart$').hasMatch(normalized)) {
      issues.add(
        '$path is a removed legacy feature entrypoint; use <feature>.dart as the only public entrypoint',
      );
    }

    if (normalized.contains('/features/') &&
        normalized.contains('/presentation/') &&
        RegExp(r'\bAppException\b').hasMatch(content)) {
      issues.add('$path must not use AppException in presentation layer (use AppError)');
    }

    if (normalized.contains('/features/') &&
        normalized.contains('/presentation/') &&
        RegExp(r'throw\s+.+toException\s*\(').hasMatch(content)) {
      issues.add('$path must not throw toException() in presentation layer');
    }

    if (normalized.contains('/features/') &&
        normalized.contains('/presentation/') &&
        RegExp(r'throw\s+Exception\s*\(').hasMatch(content)) {
      issues.add('$path must not throw Exception(...) in presentation layer');
    }

    final isStateLayer =
        normalized.contains('/state/') || normalized.endsWith('_state.dart');
    if (normalized.contains('/features/') &&
        isStateLayer &&
        importLines.any((line) => line.contains('core/errors/exceptions.dart'))) {
      issues.add('$path must not import AppException definitions in state layer');
    }

    if (normalized.contains('/features/') &&
        isStateLayer &&
        RegExp(r'\bAppException\b').hasMatch(content)) {
      issues.add('$path must not use AppException in state layer (use AppError)');
    }

    if (normalized.contains('/features/') &&
        RegExp(
          r'\b(?:class|sealed class|final class|base class|abstract class)\s+\w*(?:Exception|Failure)\b',
        ).hasMatch(content)) {
      issues.add(
        '$path must not define feature-private exception/failure types (use AppError)',
      );
    }

    if (normalized.contains('/features/') &&
        (RegExp(r'\bimplements\s+Exception\b').hasMatch(content) ||
            RegExp(r'\bextends\s+Exception\b').hasMatch(content))) {
      issues.add('$path must not implement/extend Exception inside features');
    }

    if (normalized.contains('/features/') &&
        normalized.contains('/application/') &&
        RegExp(r'\bclass\s+\w*(Command|Query)\b').hasMatch(content)) {
      issues.add(
        '$path must use named parameters instead of one-off Command/Query wrappers',
      );
    }

    if (normalized.contains('/features/') &&
        normalized.contains('/application/') &&
        RegExp(r'runResult\s*\(\s*\(\)\s*=>\s*\w+Repository\.').hasMatch(content) &&
        !RegExp(r'fetchPlayerInfo|fetchMaskData|compute\s*\(').hasMatch(content)) {
      issues.add('$path must not keep pure pass-through workflows');
    }

    if (normalized.contains('/features/') &&
        normalized.contains('/domain/repositories/')) {
      final nonResultMethodMatches = RegExp(
        r'Future<(?!Result<)(.+?)>\s+(\w+)\s*\(',
      ).allMatches(content);
      for (final match in nonResultMethodMatches) {
        final method = match.group(2);
        if (method != null && !_allowedNonResultRepositoryMethods.contains(method)) {
          issues.add(
            '$path must use Result return type for remote repository methods ($method)',
          );
        }
      }

      if (RegExp(r'\bint\s+(pageSize|ps)\s*=').hasMatch(content)) {
        issues.add(
          '$path must not expose paging size technical parameters in domain repositories',
        );
      }

      if (RegExp(r'\breferer\b|\bmode\s*=').hasMatch(content)) {
        issues.add(
          '$path must not expose transport-level parameters in domain repositories',
        );
      }
    }

    if (normalized == 'lib/core/network/request_executor_binding.dart' &&
        RegExp(r'Future<[^>]+>\s+request(Api|Void)?\s*\(').hasMatch(content)) {
      issues.add('$path must not expose throw-based request/requestApi/requestVoid APIs');
    }

    if (normalized == 'lib/core/network/request_executor.dart' &&
        RegExp(r'runOrThrow|runApiOrThrow|runUnitOrThrow').hasMatch(content)) {
      issues.add('$path must not expose throw-based run*OrThrow APIs');
    }
  }

  final longFiles =
      longFileLines.entries
          .where((entry) => entry.value >= _longFileWarnLineThreshold)
          .toList()
        ..sort((a, b) => b.value.compareTo(a.value));
  if (longFiles.length > _longFileWarnCountThreshold) {
    warnings.add(
      'Long-file threshold warning: ${longFiles.length} files >= $_longFileWarnLineThreshold lines '
      '(target <= $_longFileWarnCountThreshold)',
    );
  }
  if (longFiles.isNotEmpty) {
    final samples = longFiles
        .take(10)
        .map((entry) => '${entry.key} (${entry.value})')
        .join(', ');
    warnings.add(
      'Long-file sample (top ${longFiles.length >= 10 ? 10 : longFiles.length}): $samples',
    );
  }

  void collectDuplicateTypeWarnings(Map<String, Set<String>> locations, String label) {
    final duplicates = locations.entries.where((entry) => entry.value.length > 1).toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    for (final duplicate in duplicates) {
      final locationsText = duplicate.value.toList()..sort();
      warnings.add(
        'Duplicate $label candidate `${duplicate.key}` in: ${locationsText.join(', ')}',
      );
    }
  }

  collectDuplicateTypeWarnings(parameterTypeLocations, 'parameter object');
  collectDuplicateTypeWarnings(mapperTypeLocations, 'mapper');

  final duplicateExportBarrels = exportOnlySignatureLocations.entries
      .where((entry) => entry.value.paths.length > 1)
      .toList();
  for (final duplicate in duplicateExportBarrels) {
    final files = duplicate.value.paths.toList()..sort();
    warnings.add(
      'Duplicate export-only barrel candidate in feature `${duplicate.value.feature}`: '
      '${files.join(', ')}',
    );
  }

  if (issues.isEmpty) {
    stdout.writeln('Architecture guard passed.');
    if (warnings.isNotEmpty) {
      stdout.writeln('Architecture redundancy scan warnings (${warnings.length}):');
      for (final warning in warnings) {
        stdout.writeln('- $warning');
      }
    }
    exit(0);
  }

  stderr.writeln('Architecture guard failed with ${issues.length} issue(s):');
  for (final issue in issues) {
    stderr.writeln('- $issue');
  }
  if (warnings.isNotEmpty) {
    stderr.writeln('Architecture redundancy scan warnings (${warnings.length}):');
    for (final warning in warnings) {
      stderr.writeln('- $warning');
    }
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

Directory _resolveProjectRoot() {
  var dir = Directory.current.absolute;
  while (true) {
    final marker = File('${dir.path}${Platform.pathSeparator}pubspec.yaml');
    if (marker.existsSync()) {
      return dir;
    }
    final parent = dir.parent;
    if (parent.path == dir.path) {
      return Directory.current.absolute;
    }
    dir = parent;
  }
}
