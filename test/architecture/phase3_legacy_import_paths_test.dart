import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

const _legacyImportPaths = [
  'package:culcul/shared/responsive/responsive.dart',
  'package:culcul/shared/responsive/app_breakpoints.dart',
  'package:culcul/shared/responsive/app_responsive.dart',
  'package:culcul/shared/responsive/responsive_container.dart',
  'package:culcul/shared/errors/app_error.dart',
  'package:culcul/shared/errors/error_handler.dart',
  'package:culcul/shared/errors/exceptions.dart',
  'package:culcul/shared/result/result.dart',
  'package:culcul/shared/perf/feature_flow_perf_logger.dart',
  'package:culcul/shared/perf/frame_timing_sampler.dart',
  'package:culcul/shared/perf/list_perf_logger.dart',
  'package:culcul/shared/perf/network_perf_logger.dart',
  'package:culcul/shared/perf/performance_policy.dart',
  'package:culcul/shared/perf/startup_perf_logger.dart',
  'package:culcul/shared/perf/video_perf_logger.dart',
  'package:culcul/shared/contracts/comment_contract.dart',
  'package:culcul/shared/contracts/live_room_summary_contract.dart',
  'package:culcul/shared/contracts/relation_user_contract.dart',
  'package:culcul/shared/contracts/search_result_contract.dart',
  'package:culcul/shared/contracts/user_card_contract.dart',
  'package:culcul/shared/contracts/video_model_contract.dart',
];

void main() {
  test('Production code does not import retired shared paths', () async {
    final libDir = Directory('lib');
    final violations = <String>[];

    if (libDir.existsSync()) {
      for (final file in libDir.listSync(recursive: true)) {
        if (file is! File || !file.path.endsWith('.dart')) {
          continue;
        }

        final normalizedPath = file.path.replaceAll('\\', '/');
        final content = _stripComments(await file.readAsString());
        for (final legacyImport in _legacyImportPaths) {
          if (_referencesRetiredPath(content, legacyImport)) {
            violations.add('$normalizedPath -> $legacyImport');
          }
        }
      }
    }

    expect(
      violations,
      isEmpty,
      reason:
          'Found production imports that still point at retired shared paths: '
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
