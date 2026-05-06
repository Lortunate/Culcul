import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

const _legacyImportPaths = [
  'package:culcul/shared/responsive/responsive.dart',
  'package:culcul/shared/responsive/app_breakpoints.dart',
  'package:culcul/shared/responsive/app_responsive.dart',
  'package:culcul/shared/responsive/responsive_container.dart',
  'package:culcul/shared/errors/app_error.dart',
  'package:culcul/shared/errors/exceptions.dart',
  'package:culcul/shared/result/result.dart',
  'package:culcul/shared/perf/feature_flow_perf_logger.dart',
  'package:culcul/shared/perf/frame_timing_sampler.dart',
  'package:culcul/shared/perf/list_perf_logger.dart',
  'package:culcul/shared/perf/network_perf_logger.dart',
  'package:culcul/shared/perf/performance_policy.dart',
  'package:culcul/shared/perf/startup_perf_logger.dart',
  'package:culcul/shared/perf/video_perf_logger.dart',
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

        final content = await file.readAsString();
        for (final legacyImport in _legacyImportPaths) {
          if (content.contains(legacyImport)) {
            violations.add('${file.path} -> $legacyImport');
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
