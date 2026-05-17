import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'architecture_guard_utils.dart';

const _phase32AllowedPresentationDataFiles = <String>{
  'lib/features/dynamic/presentation/pages/topic_detail_page.dart', // Phase 32 Task 7
  'lib/features/dynamic/presentation/view_models/article_detail_view_model.dart', // Phase 32 Task 7
  'lib/features/dynamic/presentation/view_models/dynamic_comment_view_model.dart', // Phase 32 Task 7
  'lib/features/dynamic/presentation/view_models/dynamic_detail_view_model.dart', // Phase 32 Task 7
  'lib/features/dynamic/presentation/view_models/dynamic_view_model.dart', // Phase 32 Task 7
  'lib/features/dynamic/presentation/view_models/emote_view_model.dart', // Phase 32 Task 7
  'lib/features/dynamic/presentation/view_models/topic_dynamic_view_model.dart', // Phase 32 Task 7
  'lib/features/dynamic/presentation/widgets/detail/dynamic_detail_bottom_bar.dart', // Phase 32 Task 7
  'lib/features/dynamic/presentation/widgets/detail/dynamic_detail_header.dart', // Phase 32 Task 7
  'lib/features/dynamic/presentation/widgets/detail/dynamic_post_header.dart', // Phase 32 Task 7
  'lib/features/dynamic/presentation/widgets/dynamic_comments_view.dart', // Phase 32 Task 7
  'lib/features/dynamic/presentation/widgets/dynamic_content_widget.dart', // Phase 32 Task 7
  'lib/features/dynamic/presentation/widgets/dynamic_forward_widget.dart', // Phase 32 Task 7
  'lib/features/dynamic/presentation/widgets/dynamic_list_view.dart', // Phase 32 Task 7
  'lib/features/dynamic/presentation/widgets/dynamic_post_actions.dart', // Phase 32 Task 7
  'lib/features/dynamic/presentation/widgets/emoji_picker.dart', // Phase 32 Task 7
  'lib/features/home/presentation/view_models/home_popular_view_model.dart', // Phase 32 Task 4
  'lib/features/home/presentation/view_models/home_recommend_view_model.dart', // Phase 32 Task 4
  'lib/features/home/presentation/view_models/weekly_view_model.dart', // Phase 32 Task 4
  'lib/features/live/presentation/view_models/live_room_state.dart', // Phase 32 Task 4
  'lib/features/live/presentation/view_models/live_room_view_model.dart', // Phase 32 Task 4
  'lib/features/live/presentation/view_models/live_socket_service.dart', // Phase 32 Task 4
  'lib/features/live/presentation/widgets/live_header.dart', // Phase 32 Task 4
  'lib/features/notification/presentation/pages/system_notification_page.dart', // Phase 32 Task 4
  'lib/features/notification/presentation/view_models/chat_view_model.dart', // Phase 32 Task 4
  'lib/features/notification/presentation/view_models/notification_feed_view_model.dart', // Phase 32 Task 4
  'lib/features/notification/presentation/view_models/notification_lifecycle_sync_view_model.dart', // Phase 32 Task 4
  'lib/features/notification/presentation/view_models/private_session_view_model.dart', // Phase 32 Task 4
  'lib/features/notification/presentation/view_models/system_notification_view_model.dart', // Phase 32 Task 4
  'lib/features/notification/presentation/view_models/unread_count_view_model.dart', // Phase 32 Task 4
  'lib/features/notification/presentation/widgets/notification_navigation.dart', // Phase 32 Task 4
  'lib/features/profile/presentation/pages/user_profile_page.dart', // Phase 32 Task 4
  'lib/features/profile/presentation/view_models/profile_view_model.dart', // Phase 32 Task 4
  'lib/features/profile/presentation/view_models/user_space_extras_view_model.dart', // Phase 32 Task 4
  'lib/features/profile/presentation/view_models/user_space_videos_view_model.dart', // Phase 32 Task 4
  'lib/features/profile/presentation/view_models/user_space_view_model.dart', // Phase 32 Task 4
  'lib/features/profile/presentation/widgets/home_tab/recent_video_section.dart', // Phase 32 Task 4
  'lib/features/profile/presentation/widgets/profile_app_bar.dart', // Phase 32 Task 4
  'lib/features/profile/presentation/widgets/user_profile_app_bar.dart', // Phase 32 Task 4
  'lib/features/profile/presentation/widgets/user_profile_buttons.dart', // Phase 32 Task 4
  'lib/features/profile/presentation/widgets/user_profile_info.dart', // Phase 32 Task 4
  'lib/features/ranking/presentation/view_models/category_ranking_view_model.dart', // Phase 32 Task 4
  'lib/features/search/presentation/view_models/search_view_model.dart', // Phase 32 Task 7
  'lib/features/video/presentation/comments/comment_reply_view_model.dart', // Phase 32 Task 4
  'lib/features/video/presentation/comments/video_comments_view_model.dart', // Phase 32 Task 4
  'lib/features/video/presentation/detail/info/video_actions.dart', // Phase 32 Task 4
  'lib/features/video/presentation/detail/info/video_description.dart', // Phase 32 Task 4
  'lib/features/video/presentation/detail/info/video_parts.dart', // Phase 32 Task 4
  'lib/features/video/presentation/detail/info/video_recommendation.dart', // Phase 32 Task 4
  'lib/features/video/presentation/detail/info/video_stats.dart', // Phase 32 Task 4
  'lib/features/video/presentation/detail/video_detail_state.dart', // Phase 32 Task 4
  'lib/features/video/presentation/detail/video_detail_view_model.dart', // Phase 32 Task 4
  'lib/features/video/presentation/overlays/danmaku_view_model.dart', // Phase 32 Task 4
  'lib/features/video/presentation/overlays/layers/subtitle_layer.dart', // Phase 32 Task 4
  'lib/features/video/presentation/overlays/subtitle_view_model.dart', // Phase 32 Task 4
  'lib/features/video/presentation/player/controls/player_constants.dart', // Phase 32 Task 4
  'lib/features/video/presentation/player/hooks/use_listen_audio_mode.dart', // Phase 32 Task 4
  'lib/features/video/presentation/player/hooks/use_video_loader.dart', // Phase 32 Task 4
  'lib/features/video/presentation/player/hooks/use_video_orientation.dart', // Phase 32 Task 4
  'lib/features/video/presentation/player/playable_urls.dart', // Phase 32 Task 4
  'lib/features/video/presentation/player/vertical_video_page.dart', // Phase 32 Task 4
};

void main() {
  test('lib/shared must stay retired', () {
    final sharedDirectory = Directory('lib/shared');
    final files = sharedDirectory.existsSync()
        ? authoredDartFiles(
            sharedDirectory,
          ).map((file) => normalizePath(file.path)).toList()
        : <String>[];

    files.sort();

    expect(
      files,
      isEmpty,
      reason:
          'lib/shared is retired; move shared code to core/ or ui/:\n'
          '${files.join('\n')}',
    );
  });

  test('authored source has no old-style hand-written providers', () {
    final offenders = <String>[];
    final providerDeclarationPattern = RegExp(
      r'\bfinal\s+[A-Za-z0-9_]*Provider\s*=\s*'
      r'(?:Provider|FutureProvider|StreamProvider|StateProvider|'
      r'StateNotifierProvider|NotifierProvider|AsyncNotifierProvider)\b',
    );

    for (final file in authoredDartFiles(Directory('lib'))) {
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
          '@riverpod generated providers:\n${offenders.join('\n')}',
    );
  });

  test('app must not import feature presentation or data internals', () {
    final offenders = <String>[];

    for (final file in authoredDartFiles(Directory('lib/app'))) {
      for (final import in dartImports(file)) {
        final targetPath = import.resolvedPath;
        if (targetPath == null ||
            !RegExp(r'^lib/features/[^/]+/(presentation|data)/').hasMatch(targetPath)) {
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
          'App layer must use app/core contracts or feature application seams, '
          'not feature presentation/data internals:\n${offenders.join('\n')}',
    );
  });

  test('auth application must not import auth presentation internals', () {
    final offenders = <String>[];

    for (final file in authoredDartFiles(Directory('lib/features/auth/application'))) {
      for (final import in dartImports(file)) {
        final targetPath = import.resolvedPath;
        if (targetPath == null ||
            !targetPath.startsWith('lib/features/auth/presentation/')) {
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
          'Auth application owns session state and must not import presentation '
          'view models:\n${offenders.join('\n')}',
    );
  });

  test('feature presentation to data files match the Phase 32 snapshot', () {
    final illegal =
        authoredDartFiles(Directory('lib/features'))
            .where((file) => normalizePath(file.path).contains('/presentation/'))
            .where(_importsFeatureData)
            .map((file) => normalizePath(file.path))
            .toList()
          ..sort();

    final newDebt = illegal
        .where((path) => !_phase32AllowedPresentationDataFiles.contains(path))
        .toList();
    final staleAllowlistEntries = _phase32AllowedPresentationDataFiles
        .where((path) => !illegal.contains(path))
        .toList();

    expect(
      newDebt,
      isEmpty,
      reason:
          'Presentation -> data imports must be migrated or added to the '
          'Phase 32 temporary allowlist with a planned task comment:\n'
          '${newDebt.join('\n')}',
    );
    expect(
      staleAllowlistEntries,
      isEmpty,
      reason:
          'Remove migrated files from the Phase 32 presentation/data allowlist:\n'
          '${staleAllowlistEntries.join('\n')}',
    );
  });

  test('feature presentation data DTO imports are snapshot allowlisted', () {
    final offenders = <String>[];

    for (final file in authoredDartFiles(Directory('lib/features'))) {
      final importerPath = normalizePath(file.path);
      if (!importerPath.contains('/presentation/')) {
        continue;
      }

      for (final import in dartImports(file)) {
        final targetPath = import.resolvedPath;
        if (targetPath == null ||
            !RegExp(r'^lib/features/[^/]+/data/dtos/').hasMatch(targetPath) ||
            _phase32AllowedPresentationDataFiles.contains(importerPath)) {
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
          'Presentation files must not import feature data DTOs unless the file '
          'is in the Phase 32 allowlist:\n${offenders.join('\n')}',
    );
  });

  test('feature presentation must not import other feature internals', () {
    final offenders = <String>[];

    for (final file in authoredDartFiles(Directory('lib/features'))) {
      final importerPath = normalizePath(file.path);
      final importerFeature = featureNameFromPath(importerPath);
      if (importerFeature == null ||
          !importerPath.startsWith('lib/features/$importerFeature/presentation/')) {
        continue;
      }

      for (final import in dartImports(file)) {
        final targetPath = import.resolvedPath;
        final targetFeature = targetPath == null ? null : featureNameFromPath(targetPath);
        if (targetPath == null ||
            targetFeature == null ||
            targetFeature == importerFeature) {
          continue;
        }

        if (RegExp(
          '^lib/features/$targetFeature/(presentation|data)/',
        ).hasMatch(targetPath)) {
          offenders.add(
            '${formatLocation(import.importerPath, import.lineNumber)} '
            'imports ${import.uri} -> $targetPath',
          );
        }
      }
    }

    expect(
      offenders,
      isEmpty,
      reason:
          'Feature presentation must use public seams instead of other feature '
          'presentation/data internals:\n${offenders.join('\n')}',
    );
  });
}

bool _importsFeatureData(File file) {
  return dartImports(file).any((import) {
    final resolvedPath = import.resolvedPath;
    return resolvedPath != null &&
        resolvedPath.startsWith('lib/features/') &&
        resolvedPath.contains('/data/');
  });
}
