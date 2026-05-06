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
  'package:culcul/shared/services/audio_handler.dart',
  'package:culcul/shared/services/audio_playback_state_gate.dart',
  'package:culcul/shared/services/media_service.dart',
  'package:culcul/shared/theme/app_theme.dart',
  'package:culcul/shared/widgets/adaptive_blur.dart',
  'package:culcul/shared/widgets/app_avatar.dart',
  'package:culcul/shared/widgets/app_bottom_sheet.dart',
  'package:culcul/shared/widgets/app_card_container.dart',
  'package:culcul/shared/widgets/app_clickable.dart',
  'package:culcul/shared/widgets/app_empty_state_widget.dart',
  'package:culcul/shared/widgets/app_error_widget.dart',
  'package:culcul/shared/widgets/app_image_preview.dart',
  'package:culcul/shared/widgets/app_image_preview.widgets.dart',
  'package:culcul/shared/widgets/app_min_lines_text.dart',
  'package:culcul/shared/widgets/app_network_image.dart',
  'package:culcul/shared/widgets/app_network_image_prefetcher.dart',
  'package:culcul/shared/widgets/app_overlay_tag.dart',
  'package:culcul/shared/widgets/app_search_bar.dart',
  'package:culcul/shared/widgets/app_section_header.dart',
  'package:culcul/shared/widgets/app_selectable_text.dart',
  'package:culcul/shared/widgets/app_shimmer.dart',
  'package:culcul/shared/widgets/app_tab_bar.dart',
  'package:culcul/shared/widgets/app_tag.dart',
  'package:culcul/shared/widgets/bilibili_emoji_text.dart',
  'package:culcul/shared/widgets/follow_button.dart',
  'package:culcul/shared/widgets/guest_view.dart',
  'package:culcul/shared/widgets/icon_text.dart',
  'package:culcul/shared/widgets/privacy_error_widget.dart',
  'package:culcul/shared/widgets/refresh_header_footer.dart',
  'package:culcul/shared/widgets/sliver_tab_bar_delegate.dart',
  'package:culcul/shared/widgets/smart_paging_view.dart',
  'package:culcul/shared/widgets/user_list_tile.dart',
  'package:culcul/shared/widgets/user_tags.dart',
  'package:culcul/shared/widgets/video_actions_bottom_sheet.dart',
  'package:culcul/shared/widgets/video_card.dart',
  'package:culcul/shared/widgets/video_list_card.dart',
  'package:culcul/shared/widgets/video_thumbnail.dart',
  'package:culcul/shared/widgets/guest_view/illustration.dart',
  'package:culcul/shared/widgets/guest_view/login_button.dart',
  'package:culcul/shared/widgets/guest_view/message.dart',
  'package:culcul/shared/widgets/skeletons/dynamic_skeleton.dart',
  'package:culcul/shared/widgets/skeletons/page_skeletons.dart',
  'package:culcul/shared/widgets/skeletons/video_card_skeleton.dart',
  'package:culcul/shared/widgets/skeletons/video_list_skeleton.dart',
  'package:culcul/shared/widgets/smart_paging_view/content.dart',
  'package:culcul/shared/widgets/smart_paging_view/load_more.dart',
  'package:culcul/shared/widgets/video_card/content.dart',
  'package:culcul/shared/widgets/video_card/footer.dart',
  'package:culcul/shared/widgets/video_card/thumbnail.dart',
  'package:culcul/shared/widgets/video_list_card/body.dart',
  'package:culcul/shared/widgets/video_list_card/content.dart',
  'package:culcul/shared/widgets/video_list_card/media.dart',
];

final _legacySet = _legacyImportPaths.toSet();
final _importPattern = RegExp(
  r"""^\s*(?:import|export)\s+['"]([^'"]+)['"]""",
  multiLine: true,
);

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
        final content = await file.readAsString();
        for (final match in _importPattern.allMatches(content)) {
          final importPath = match.group(1)!;
          if (_legacySet.contains(importPath)) {
            violations.add('$normalizedPath -> $importPath');
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
