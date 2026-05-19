import 'package:flutter_test/flutter_test.dart';

import 'architecture_guard_utils.dart';

const _phase31AllowedPresentationDataImports = <String>{
  'lib/features/auth/presentation/view_models/auth_qr_login_view_model.dart -> lib/features/auth/data/auth_repository_impl.dart',
  'lib/features/auth/presentation/view_models/auth_view_model.dart -> lib/features/auth/data/auth_repository_impl.dart',
  'lib/features/dynamic/presentation/pages/topic_detail_page.dart -> lib/features/dynamic/data/dtos/dynamic_item_extensions.dart',
  'lib/features/dynamic/presentation/view_models/article_detail_view_model.dart -> lib/features/dynamic/data/dynamic_repository_impl.dart',
  'lib/features/dynamic/presentation/view_models/dynamic_comment_view_model.dart -> lib/features/dynamic/data/dtos/dynamic_response.dart',
  'lib/features/dynamic/presentation/view_models/dynamic_comment_view_model.dart -> lib/features/dynamic/data/dynamic_repository_impl.dart',
  'lib/features/dynamic/presentation/view_models/dynamic_detail_view_model.dart -> lib/features/dynamic/data/dtos/dynamic_item_extensions.dart',
  'lib/features/dynamic/presentation/view_models/dynamic_detail_view_model.dart -> lib/features/dynamic/data/dtos/dynamic_response.dart',
  'lib/features/dynamic/presentation/view_models/dynamic_detail_view_model.dart -> lib/features/dynamic/data/dynamic_repository_impl.dart',
  'lib/features/dynamic/presentation/view_models/dynamic_view_model.dart -> lib/features/dynamic/data/dtos/dynamic_response.dart',
  'lib/features/dynamic/presentation/view_models/dynamic_view_model.dart -> lib/features/dynamic/data/dynamic_repository_impl.dart',
  'lib/features/dynamic/presentation/view_models/emote_view_model.dart -> lib/features/dynamic/data/dtos/emote_response.dart',
  'lib/features/dynamic/presentation/view_models/emote_view_model.dart -> lib/features/dynamic/data/emote_repository_impl.dart',
  'lib/features/dynamic/presentation/view_models/topic_dynamic_view_model.dart -> lib/features/dynamic/data/dtos/dynamic_response.dart',
  'lib/features/dynamic/presentation/view_models/topic_dynamic_view_model.dart -> lib/features/dynamic/data/dynamic_repository_impl.dart',
  'lib/features/dynamic/presentation/widgets/detail/dynamic_detail_bottom_bar.dart -> lib/features/dynamic/data/dtos/dynamic_item_extensions.dart',
  'lib/features/dynamic/presentation/widgets/detail/dynamic_detail_bottom_bar.dart -> lib/features/dynamic/data/dtos/dynamic_response.dart',
  'lib/features/dynamic/presentation/widgets/detail/dynamic_detail_header.dart -> lib/features/dynamic/data/dtos/dynamic_response.dart',
  'lib/features/dynamic/presentation/widgets/detail/dynamic_post_header.dart -> lib/features/dynamic/data/dtos/dynamic_item_extensions.dart',
  'lib/features/dynamic/presentation/widgets/detail/dynamic_post_header.dart -> lib/features/dynamic/data/dtos/dynamic_response.dart',
  'lib/features/dynamic/presentation/widgets/dynamic_comments_view.dart -> lib/features/dynamic/data/dtos/dynamic_response.dart',
  'lib/features/dynamic/presentation/widgets/dynamic_content_widget.dart -> lib/features/dynamic/data/dtos/dynamic_item_extensions.dart',
  'lib/features/dynamic/presentation/widgets/dynamic_content_widget.dart -> lib/features/dynamic/data/dtos/dynamic_response.dart',
  'lib/features/dynamic/presentation/widgets/dynamic_forward_widget.dart -> lib/features/dynamic/data/dtos/dynamic_item_extensions.dart',
  'lib/features/dynamic/presentation/widgets/dynamic_forward_widget.dart -> lib/features/dynamic/data/dtos/dynamic_response.dart',
  'lib/features/dynamic/presentation/widgets/dynamic_list_view.dart -> lib/features/dynamic/data/dtos/dynamic_item_extensions.dart',
  'lib/features/dynamic/presentation/widgets/dynamic_list_view.dart -> lib/features/dynamic/data/dtos/dynamic_response.dart',
  'lib/features/dynamic/presentation/widgets/dynamic_post_actions.dart -> lib/features/dynamic/data/dtos/dynamic_item_extensions.dart',
  'lib/features/dynamic/presentation/widgets/dynamic_post_actions.dart -> lib/features/dynamic/data/dtos/dynamic_response.dart',
  'lib/features/dynamic/presentation/widgets/emoji_picker.dart -> lib/features/dynamic/data/dtos/emote_response.dart',
  'lib/features/favorites/presentation/pages/favorite_detail_page.dart -> lib/features/favorites/data/fav_repository_impl.dart',
  'lib/features/favorites/presentation/pages/favorites_page.dart -> lib/features/favorites/data/fav_repository_impl.dart',
  'lib/features/favorites/presentation/view_models/favorites_view_model.dart -> lib/features/favorites/data/fav_repository_impl.dart',
  'lib/features/home/presentation/view_models/home_popular_view_model.dart -> lib/features/home/data/home_repository_impl.dart',
  'lib/features/home/presentation/view_models/home_recommend_view_model.dart -> lib/features/home/data/home_repository_impl.dart',
  'lib/features/home/presentation/view_models/weekly_view_model.dart -> lib/features/home/data/home_repository_impl.dart',
  'lib/features/live/presentation/view_models/live_danmaku_event_parser.dart -> lib/features/live/data/dtos/live_history_danmaku_model.dart',
  'lib/features/live/presentation/view_models/live_danmaku_feed_view_model.dart -> lib/features/live/data/dtos/live_history_danmaku_model.dart',
  'lib/features/live/presentation/view_models/live_room_state.dart -> lib/features/live/data/dtos/live_anchor_info_model.dart',
  'lib/features/live/presentation/view_models/live_room_state.dart -> lib/features/live/data/dtos/live_danmaku_model.dart',
  'lib/features/live/presentation/view_models/live_room_state.dart -> lib/features/live/data/dtos/live_gold_rank_model.dart',
  'lib/features/live/presentation/view_models/live_room_state.dart -> lib/features/live/data/dtos/live_guard_list_model.dart',
  'lib/features/live/presentation/view_models/live_room_state.dart -> lib/features/live/data/dtos/live_play_url_model.dart',
  'lib/features/live/presentation/view_models/live_room_state.dart -> lib/features/live/data/dtos/live_room_detail_model.dart',
  'lib/features/live/presentation/view_models/live_room_view_model.dart -> lib/features/live/data/dtos/live_history_danmaku_model.dart',
  'lib/features/live/presentation/view_models/live_room_view_model.dart -> lib/features/live/data/dtos/live_room_detail_model.dart',
  'lib/features/live/presentation/view_models/live_room_view_model.dart -> lib/features/live/data/live_repository_impl.dart',
  'lib/features/live/presentation/view_models/live_socket_service.dart -> lib/features/live/data/dtos/live_danmu_info_model.dart',
  'lib/features/live/presentation/view_models/live_socket_service.dart -> lib/features/live/data/dtos/live_history_danmaku_model.dart',
  'lib/features/live/presentation/widgets/danmaku/live_danmaku_badge.dart -> lib/features/live/data/dtos/live_history_danmaku_model.dart',
  'lib/features/live/presentation/widgets/danmaku/live_danmaku_message_factory.dart -> lib/features/live/data/dtos/live_history_danmaku_model.dart',
  'lib/features/live/presentation/widgets/danmaku/live_gift_message.dart -> lib/features/live/data/dtos/live_history_danmaku_model.dart',
  'lib/features/live/presentation/widgets/danmaku/live_interact_message.dart -> lib/features/live/data/dtos/live_history_danmaku_model.dart',
  'lib/features/live/presentation/widgets/danmaku/live_normal_message.dart -> lib/features/live/data/dtos/live_history_danmaku_model.dart',
  'lib/features/live/presentation/widgets/danmaku/live_system_message.dart -> lib/features/live/data/dtos/live_history_danmaku_model.dart',
  'lib/features/live/presentation/widgets/live_danmaku_view.dart -> lib/features/live/data/dtos/live_history_danmaku_model.dart',
  'lib/features/live/presentation/widgets/live_header.dart -> lib/features/live/data/dtos/live_anchor_info_model.dart',
  'lib/features/live/presentation/widgets/live_header.dart -> lib/features/live/data/dtos/live_gold_rank_model.dart',
  'lib/features/live/presentation/widgets/live_header.dart -> lib/features/live/data/dtos/live_guard_list_model.dart',
  'lib/features/live/presentation/widgets/live_header.dart -> lib/features/live/data/dtos/live_room_detail_model.dart',
  'lib/features/notification/presentation/pages/system_notification_page.dart -> lib/features/notification/data/dtos/system_notice.dart',
  'lib/features/notification/presentation/view_models/chat_view_model.dart -> lib/features/notification/data/notification_repository_impl.dart',
  'lib/features/notification/presentation/view_models/notification_feed_view_model.dart -> lib/features/notification/data/notification_repository_impl.dart',
  'lib/features/notification/presentation/view_models/notification_lifecycle_sync_view_model.dart -> lib/features/notification/data/notification_repository_impl.dart',
  'lib/features/notification/presentation/view_models/private_session_view_model.dart -> lib/features/notification/data/notification_repository_impl.dart',
  'lib/features/notification/presentation/view_models/system_notification_view_model.dart -> lib/features/notification/data/dtos/system_notice.dart',
  'lib/features/notification/presentation/view_models/system_notification_view_model.dart -> lib/features/notification/data/notification_repository_impl.dart',
  'lib/features/notification/presentation/view_models/unread_count_view_model.dart -> lib/features/notification/data/notification_repository_impl.dart',
  'lib/features/notification/presentation/widgets/notification_navigation.dart -> lib/features/notification/data/dtos/system_notice.dart',
  'lib/features/profile/presentation/pages/user_profile_page.dart -> lib/features/profile/data/dtos/profile_user.dart',
  'lib/features/profile/presentation/view_models/profile_view_model.dart -> lib/features/profile/data/dtos/profile_user.dart',
  'lib/features/profile/presentation/view_models/profile_view_model.dart -> lib/features/profile/data/profile_cache_repository.dart',
  'lib/features/profile/presentation/view_models/profile_view_model.dart -> lib/features/profile/data/profile_repository_impl.dart',
  'lib/features/profile/presentation/view_models/user_space_extras_view_model.dart -> lib/features/profile/data/dtos/profile_video.dart',
  'lib/features/profile/presentation/view_models/user_space_extras_view_model.dart -> lib/features/profile/data/profile_repository_impl.dart',
  'lib/features/profile/presentation/view_models/user_space_videos_view_model.dart -> lib/features/profile/data/dtos/profile_video.dart',
  'lib/features/profile/presentation/view_models/user_space_videos_view_model.dart -> lib/features/profile/data/profile_repository_impl.dart',
  'lib/features/profile/presentation/view_models/user_space_view_model.dart -> lib/features/profile/data/dtos/profile_user.dart',
  'lib/features/profile/presentation/view_models/user_space_view_model.dart -> lib/features/profile/data/profile_repository_impl.dart',
  'lib/features/profile/presentation/widgets/home_tab/recent_video_section.dart -> lib/features/profile/data/dtos/profile_video.dart',
  'lib/features/profile/presentation/widgets/profile_app_bar.dart -> lib/features/profile/data/dtos/profile_user.dart',
  'lib/features/profile/presentation/widgets/user_profile_app_bar.dart -> lib/features/profile/data/dtos/profile_user.dart',
  'lib/features/profile/presentation/widgets/user_profile_buttons.dart -> lib/features/profile/data/dtos/profile_user.dart',
  'lib/features/profile/presentation/widgets/user_profile_info.dart -> lib/features/profile/data/dtos/profile_user.dart',
  'lib/features/ranking/presentation/view_models/category_ranking_view_model.dart -> lib/features/ranking/data/ranking_repository_impl.dart',
  'lib/features/search/presentation/view_models/search_view_model.dart -> lib/features/search/data/dtos/trending_ranking.dart',
  'lib/features/search/presentation/view_models/search_view_model.dart -> lib/features/search/data/search_repository_impl.dart',
  'lib/features/video/presentation/comments/comment_reply_view_model.dart -> lib/features/video/data/video_repository_impl.dart',
  'lib/features/video/presentation/comments/video_comments_view_model.dart -> lib/features/video/data/video_repository_impl.dart',
  'lib/features/video/presentation/detail/info/video_actions.dart -> lib/features/video/data/dtos/video_detail_dto.dart',
  'lib/features/video/presentation/detail/info/video_description.dart -> lib/features/video/data/dtos/video_detail_dto.dart',
  'lib/features/video/presentation/detail/info/video_parts.dart -> lib/features/video/data/dtos/video_detail_dto.dart',
  'lib/features/video/presentation/detail/info/video_recommendation.dart -> lib/features/video/data/dtos/related_video_dto.dart',
  'lib/features/video/presentation/detail/info/video_stats.dart -> lib/features/video/data/dtos/video_detail_dto.dart',
  'lib/features/video/presentation/detail/video_detail_state.dart -> lib/features/video/data/dtos/play_url_dto.dart',
  'lib/features/video/presentation/detail/video_detail_state.dart -> lib/features/video/data/dtos/related_video_dto.dart',
  'lib/features/video/presentation/detail/video_detail_state.dart -> lib/features/video/data/dtos/video_detail_dto.dart',
  'lib/features/video/presentation/detail/video_detail_view_model.dart -> lib/features/video/data/dtos/play_url_dto.dart',
  'lib/features/video/presentation/detail/video_detail_view_model.dart -> lib/features/video/data/dtos/video_detail_dto.dart',
  'lib/features/video/presentation/detail/video_detail_view_model.dart -> lib/features/video/data/video_repository_impl.dart',
  'lib/features/video/presentation/overlays/danmaku_view_model.dart -> lib/features/video/data/danmaku_repository_impl.dart',
  'lib/features/video/presentation/overlays/danmaku_view_model.dart -> lib/features/video/data/dtos/danmaku_model.dart',
  'lib/features/video/presentation/overlays/layers/subtitle_layer.dart -> lib/features/video/data/dtos/subtitle_dto.dart',
  'lib/features/video/presentation/overlays/subtitle_view_model.dart -> lib/features/video/data/dtos/subtitle_dto.dart',
  'lib/features/video/presentation/overlays/subtitle_view_model.dart -> lib/features/video/data/video_repository_impl.dart',
  'lib/features/video/presentation/player/controls/player_constants.dart -> lib/features/video/data/dtos/play_url_dto.dart',
  'lib/features/video/presentation/player/hooks/use_listen_audio_mode.dart -> lib/features/video/data/dtos/play_url_dto.dart',
  'lib/features/video/presentation/player/hooks/use_listen_audio_mode.dart -> lib/features/video/data/video_repository_impl.dart',
  'lib/features/video/presentation/player/hooks/use_video_loader.dart -> lib/features/video/data/dtos/play_url_dto.dart',
  'lib/features/video/presentation/player/hooks/use_video_orientation.dart -> lib/features/video/data/dtos/video_detail_dto.dart',
  'lib/features/video/presentation/player/playable_urls.dart -> lib/features/video/data/dtos/play_url_dto.dart',
  'lib/features/video/presentation/player/vertical_video_page.dart -> lib/features/video/data/dtos/video_detail_dto.dart',
};

void main() {
  test('core and ui must not import features', () {
    final offenders = <String>[];

    for (final file in sourceDartFiles('lib')) {
      final importerPath = normalizePath(file.path);
      if (!importerPath.startsWith('lib/core/') && !importerPath.startsWith('lib/ui/')) {
        continue;
      }

      for (final import in dartImports(file)) {
        final targetPath = import.resolvedPath;
        if (targetPath == null || !targetPath.startsWith('lib/features/')) {
          continue;
        }

        offenders.add(
          '${formatLocation(import.importerPath, import.lineNumber)} '
          'imports ${import.uri} -> $targetPath',
        );
      }
    }

    expect(
      offenders,
      isEmpty,
      reason:
          'Core and UI layers must not import feature internals:\n'
          '${offenders.join('\n')}',
    );
  });

  test('hand-written Riverpod provider declarations must stay retired', () {
    final offenders = <String>[];
    final providerDeclarationPattern = RegExp(
      r'\bfinal\s+[A-Za-z0-9_]*Provider\s*=\s*'
      r'(?:Provider|FutureProvider|StreamProvider|StateProvider|'
      r'StateNotifierProvider|NotifierProvider|AsyncNotifierProvider)\b',
    );

    for (final file in sourceDartFiles('lib')) {
      final path = normalizePath(file.path);
      for (final line in authoredDartCodeLines(file)) {
        final match = providerDeclarationPattern.firstMatch(line.text);
        if (match == null) {
          continue;
        }

        offenders.add('${formatLocation(path, line.lineNumber)} ${match.group(0)}');
      }
    }

    expect(
      offenders,
      isEmpty,
      reason:
          'Hand-written Riverpod provider declarations are retired. Use '
          '@riverpod generated providers for new authored source:\n'
          '${offenders.join('\n')}',
    );
  });

  test('feature presentation to same-feature data imports are allowlisted', () {
    final observedDebt = <String>{};
    final newDebt = <String>[];

    for (final file in sourceDartFiles('lib')) {
      final importerPath = normalizePath(file.path);
      final importerFeature = featureNameFromPath(importerPath);
      if (importerFeature == null ||
          !importerPath.startsWith('lib/features/$importerFeature/presentation/')) {
        continue;
      }

      for (final import in dartImports(file)) {
        final targetPath = import.resolvedPath;
        if (targetPath == null ||
            !targetPath.startsWith('lib/features/$importerFeature/data/')) {
          continue;
        }

        final key = '$importerPath -> $targetPath';
        observedDebt.add(key);
        if (!_phase31AllowedPresentationDataImports.contains(key)) {
          newDebt.add(
            '${formatLocation(import.importerPath, import.lineNumber)} '
            'imports ${import.uri} -> $targetPath',
          );
        }
      }
    }

    final staleAllowlistEntries = _phase31AllowedPresentationDataImports.difference(
      observedDebt,
    );

    expect(
      newDebt,
      isEmpty,
      reason:
          'Same-feature presentation -> data imports must be migrated or '
          'explicitly added to the Phase 31 temporary allowlist:\n'
          '${newDebt.join('\n')}',
    );
    expect(
      staleAllowlistEntries,
      isEmpty,
      reason:
          'Remove migrated presentation -> data entries from the Phase 31 '
          'temporary allowlist:\n'
          '${staleAllowlistEntries.join('\n')}',
    );
  });
}
