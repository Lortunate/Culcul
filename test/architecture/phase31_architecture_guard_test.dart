import 'package:flutter_test/flutter_test.dart';

import 'architecture_guard_utils.dart';

const _phase31AllowedPresentationDataImports = <String>{
  'lib/features/dynamic/presentation/view_models/article_detail_view_model.dart -> lib/features/dynamic/data/dynamic_repository_impl.dart',
  'lib/features/dynamic/presentation/view_models/dynamic_comment_view_model.dart -> lib/features/dynamic/data/dynamic_repository_impl.dart',
  'lib/features/dynamic/presentation/view_models/dynamic_detail_view_model.dart -> lib/features/dynamic/data/dynamic_repository_impl.dart',
  'lib/features/favorites/presentation/pages/favorite_detail_page.dart -> lib/features/favorites/data/fav_repository_impl.dart',
  'lib/features/favorites/presentation/pages/favorites_page.dart -> lib/features/favorites/data/fav_repository_impl.dart',
  'lib/features/favorites/presentation/view_models/favorites_view_model.dart -> lib/features/favorites/data/fav_repository_impl.dart',
  'lib/features/live/presentation/view_models/live_room_view_model.dart -> lib/features/live/data/live_repository_impl.dart',
  'lib/features/notification/presentation/view_models/chat_view_model.dart -> lib/features/notification/data/notification_repository_impl.dart',
  'lib/features/notification/presentation/view_models/notification_feed_view_model.dart -> lib/features/notification/data/notification_repository_impl.dart',
  'lib/features/notification/presentation/view_models/notification_lifecycle_sync_view_model.dart -> lib/features/notification/data/notification_repository_impl.dart',
  'lib/features/notification/presentation/view_models/private_session_view_model.dart -> lib/features/notification/data/notification_repository_impl.dart',
  'lib/features/notification/presentation/view_models/system_notification_view_model.dart -> lib/features/notification/data/notification_repository_impl.dart',
  'lib/features/notification/presentation/view_models/unread_count_view_model.dart -> lib/features/notification/data/notification_repository_impl.dart',
  'lib/features/profile/presentation/view_models/profile_view_model.dart -> lib/features/profile/data/profile_cache_repository.dart',
  'lib/features/profile/presentation/view_models/profile_view_model.dart -> lib/features/profile/data/profile_repository_impl.dart',
  'lib/features/profile/presentation/view_models/user_space_extras_view_model.dart -> lib/features/profile/data/profile_repository_impl.dart',
  'lib/features/profile/presentation/view_models/user_space_videos_view_model.dart -> lib/features/profile/data/profile_repository_impl.dart',
  'lib/features/profile/presentation/view_models/user_space_view_model.dart -> lib/features/profile/data/profile_repository_impl.dart',
  'lib/features/video/presentation/comments/comment_reply_view_model.dart -> lib/features/video/data/video_repository_impl.dart',
  'lib/features/video/presentation/comments/video_comments_view_model.dart -> lib/features/video/data/video_repository_impl.dart',
  'lib/features/video/presentation/detail/video_detail_view_model.dart -> lib/features/video/data/video_repository_impl.dart',
  'lib/features/video/presentation/player/hooks/use_listen_audio_mode.dart -> lib/features/video/data/video_repository_impl.dart',
};

const _jsonFreeApplicationModelFiles = <String>{
  'lib/features/live/application/models/live_danmu_info_model.dart',
  'lib/features/live/application/models/live_gold_rank_model.dart',
  'lib/features/live/application/models/live_guard_list_model.dart',
  'lib/features/video/application/models/play_url.dart',
  'lib/features/video/application/models/subtitle.dart',
};

const _phase40AllowedDataApplicationImports = <String>{
  'lib/features/auth/data/auth_repository_impl.dart -> lib/features/auth/application/auth_qr_login_port.dart',
  'lib/features/dynamic/data/dynamic_api.dart -> lib/features/dynamic/application/models/dynamic_response.dart',
  'lib/features/dynamic/data/dynamic_repository_impl.dart -> lib/features/dynamic/application/dynamic_feed_port.dart',
  'lib/features/dynamic/data/dynamic_repository_impl.dart -> lib/features/dynamic/application/models/dynamic_item_extensions.dart',
  'lib/features/dynamic/data/dynamic_repository_impl.dart -> lib/features/dynamic/application/models/dynamic_response.dart',
  'lib/features/dynamic/data/emote_repository_impl.dart -> lib/features/dynamic/application/emote_port.dart',
  'lib/features/dynamic/data/emote_repository_impl.dart -> lib/features/dynamic/application/models/emote_catalog.dart',
  'lib/features/home/data/home_repository_impl.dart -> lib/features/home/application/home_port.dart',
  'lib/features/live/data/live_api.dart -> lib/features/live/application/models/live_anchor_info_model.dart',
  'lib/features/live/data/live_api.dart -> lib/features/live/application/models/live_danmaku_model.dart',
  'lib/features/live/data/live_api.dart -> lib/features/live/application/models/live_history_danmaku_model.dart',
  'lib/features/live/data/live_api.dart -> lib/features/live/application/models/live_play_url_model.dart',
  'lib/features/live/data/live_api.dart -> lib/features/live/application/models/live_room_detail_model.dart',
  'lib/features/live/data/live_repository_impl.dart -> lib/features/live/application/models/live_anchor_info_model.dart',
  'lib/features/live/data/live_repository_impl.dart -> lib/features/live/application/models/live_danmaku_model.dart',
  'lib/features/live/data/live_repository_impl.dart -> lib/features/live/application/models/live_danmu_info_model.dart',
  'lib/features/live/data/live_repository_impl.dart -> lib/features/live/application/models/live_gold_rank_model.dart',
  'lib/features/live/data/live_repository_impl.dart -> lib/features/live/application/models/live_guard_list_model.dart',
  'lib/features/live/data/live_repository_impl.dart -> lib/features/live/application/models/live_history_danmaku_model.dart',
  'lib/features/live/data/live_repository_impl.dart -> lib/features/live/application/models/live_play_url_model.dart',
  'lib/features/live/data/live_repository_impl.dart -> lib/features/live/application/models/live_room_detail_model.dart',
  'lib/features/ranking/data/ranking_repository_impl.dart -> lib/features/ranking/application/ranking_port.dart',
  'lib/features/search/data/search_mapper.dart -> lib/features/search/application/search_result.dart',
  'lib/features/search/data/search_mapper.dart -> lib/features/search/application/search_trending_item.dart',
  'lib/features/search/data/search_repository_impl.dart -> lib/features/search/application/search_port.dart',
  'lib/features/search/data/search_repository_impl.dart -> lib/features/search/application/search_query.dart',
  'lib/features/search/data/search_repository_impl.dart -> lib/features/search/application/search_result.dart',
  'lib/features/search/data/search_repository_impl.dart -> lib/features/search/application/search_trending_item.dart',
  'lib/features/video/data/danmaku_repository_impl.dart -> lib/features/video/application/danmaku_port.dart',
  'lib/features/video/data/danmaku_repository_impl.dart -> lib/features/video/application/models/danmaku.dart',
  'lib/features/video/data/video_repository_impl.dart -> lib/features/video/application/models/play_url.dart',
  'lib/features/video/data/video_repository_impl.dart -> lib/features/video/application/models/subtitle.dart',
  'lib/features/video/data/video_repository_impl.dart -> lib/features/video/application/subtitle_port.dart',
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

  test('application models must not expose DTO suffixes', () {
    final offenders = <String>[];
    final dtoClassPattern = RegExp(
      r'\b(?:class|sealed class|abstract class)\s+([A-Za-z0-9_]*Dto[A-Za-z0-9_]*)\b',
    );

    for (final file in sourceDartFiles('lib/features')) {
      final path = normalizePath(file.path);
      if (!path.contains('/application/models/') ||
          path.endsWith('.freezed.dart') ||
          path.endsWith('.g.dart')) {
        continue;
      }

      for (final line in authoredDartCodeLines(file)) {
        final match = dtoClassPattern.firstMatch(line.text);
        if (match == null) {
          continue;
        }

        offenders.add('${formatLocation(path, line.lineNumber)} ${match.group(1)}');
      }
    }

    expect(
      offenders,
      isEmpty,
      reason:
          'Transport DTO class names belong in data/dtos. Application models '
          'must use feature/runtime vocabulary instead:\n'
          '${offenders.join('\n')}',
    );
  });

  test('migrated application models must not own JSON transport serialization', () {
    final offenders = <String>[];
    final transportPattern = RegExp(r'\b(?:JsonKey|fromJson|toJson)\b');

    for (final file in sourceDartFiles('lib/features')) {
      final path = normalizePath(file.path);
      if (!_jsonFreeApplicationModelFiles.contains(path)) {
        continue;
      }

      for (final line in authoredDartCodeLines(file)) {
        final match = transportPattern.firstMatch(line.text);
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
          'Migrated application models must stay runtime/read models only. '
          'JSON transport serialization belongs in data/dtos:\n'
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

  test('feature data to same-feature application imports are allowlisted', () {
    final observedDebt = <String>{};
    final newDebt = <String>[];

    for (final file in sourceDartFiles('lib')) {
      final importerPath = normalizePath(file.path);
      final importerFeature = featureNameFromPath(importerPath);
      if (importerFeature == null ||
          !importerPath.startsWith('lib/features/$importerFeature/data/')) {
        continue;
      }

      for (final import in dartImports(file)) {
        final targetPath = import.resolvedPath;
        if (targetPath == null ||
            !targetPath.startsWith('lib/features/$importerFeature/application/')) {
          continue;
        }

        final key = '$importerPath -> $targetPath';
        observedDebt.add(key);
        if (!_phase40AllowedDataApplicationImports.contains(key)) {
          newDebt.add(
            '${formatLocation(import.importerPath, import.lineNumber)} '
            'imports ${import.uri} -> $targetPath',
          );
        }
      }
    }

    final staleAllowlistEntries = _phase40AllowedDataApplicationImports.difference(
      observedDebt,
    );

    expect(
      newDebt,
      isEmpty,
      reason:
          'Same-feature data -> application imports must be migrated or '
          'explicitly added to the Phase 40 temporary allowlist:\n'
          '${newDebt.join('\n')}',
    );
    expect(
      staleAllowlistEntries,
      isEmpty,
      reason:
          'Remove migrated data -> application entries from the Phase 40 '
          'temporary allowlist:\n'
          '${staleAllowlistEntries.join('\n')}',
    );
  });
}
