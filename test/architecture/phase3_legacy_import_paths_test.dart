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
  'package:culcul/shared/constants/api_constants.dart',
  'package:culcul/shared/constants/app_dimens.dart',
  'package:culcul/shared/utils/crypto_utils.dart',
  'package:culcul/shared/utils/danmaku_mask_parser.dart',
  'package:culcul/shared/utils/format_extensions.dart',
  'package:culcul/shared/utils/format_utils.dart',
  'package:culcul/shared/utils/id_utils.dart',
  'package:culcul/shared/utils/json_compute.dart',
  'package:culcul/shared/utils/json_utils.dart',
  'package:culcul/shared/utils/list_utils.dart',
  'package:culcul/shared/utils/share_utils.dart',
  'package:culcul/shared/utils/toast_utils.dart',
  'package:culcul/shared/utils/validation_utils.dart',
  'package:culcul/shared/hooks/use_managed_easy_refresh_controller.dart',
  'package:culcul/shared/pagination/page_query.dart',
  'package:culcul/shared/pagination/paged_async_notifier.dart',
  'package:culcul/shared/pagination/paged_list_state.dart',
  'package:culcul/shared/pagination/paged_list_state_transitions.dart',
  'package:culcul/shared/pagination/pagination_load_gate.dart',
  'package:culcul/shared/pagination/scroll_load_trigger.dart',
  'package:culcul/shared/network/dio_client.dart',
  'package:culcul/shared/network/dtos/comment_contract_dto.dart',
  'package:culcul/shared/network/dtos/video_model_contract_dto.dart',
  'package:culcul/shared/network/interceptors/cache_interceptor.dart',
  'package:culcul/shared/network/interceptors/csrf_interceptor.dart',
  'package:culcul/shared/network/interceptors/in_flight_dedup_interceptor.dart',
  'package:culcul/shared/network/interceptors/network_quality_interceptor.dart',
  'package:culcul/shared/network/interceptors/retry_interceptor.dart',
  'package:culcul/shared/network/interceptors/token_interceptor.dart',
  'package:culcul/shared/network/interceptors/wbi_interceptor.dart',
  'package:culcul/shared/network/models/api_response.dart',
  'package:culcul/shared/network/network_concurrency_executor.dart',
  'package:culcul/shared/network/network_concurrency_profiles.dart',
  'package:culcul/shared/network/network_quality_policy.dart',
  'package:culcul/shared/network/providers/wbi_helper_provider.dart',
  'package:culcul/shared/network/request_cancel_token.dart',
  'package:culcul/shared/network/request_executor.dart',
  'package:culcul/shared/network/request_executor_binding.dart',
  'package:culcul/shared/network/resource_api.dart',
  'package:culcul/shared/network/resource_api_provider.dart',
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
