import 'package:flutter_test/flutter_test.dart';

import 'architecture_guard_utils.dart';

const _phase31AllowedPresentationDataImports = <String>{
  'lib/features/auth/presentation/view_models/auth_qr_login_view_model.dart -> lib/features/auth/data/auth_repository_impl.dart',
  'lib/features/dynamic/presentation/view_models/article_detail_view_model.dart -> lib/features/dynamic/data/dynamic_repository_impl.dart',
  'lib/features/dynamic/presentation/view_models/dynamic_comment_view_model.dart -> lib/features/dynamic/data/dynamic_repository_impl.dart',
  'lib/features/dynamic/presentation/view_models/dynamic_detail_view_model.dart -> lib/features/dynamic/data/dynamic_repository_impl.dart',
  'lib/features/dynamic/presentation/view_models/dynamic_view_model.dart -> lib/features/dynamic/data/dynamic_repository_impl.dart',
  'lib/features/dynamic/presentation/view_models/emote_view_model.dart -> lib/features/dynamic/data/emote_repository_impl.dart',
  'lib/features/dynamic/presentation/view_models/topic_dynamic_view_model.dart -> lib/features/dynamic/data/dynamic_repository_impl.dart',
  'lib/features/favorites/presentation/pages/favorite_detail_page.dart -> lib/features/favorites/data/fav_repository_impl.dart',
  'lib/features/favorites/presentation/pages/favorites_page.dart -> lib/features/favorites/data/fav_repository_impl.dart',
  'lib/features/favorites/presentation/view_models/favorites_view_model.dart -> lib/features/favorites/data/fav_repository_impl.dart',
  'lib/features/home/presentation/view_models/home_popular_view_model.dart -> lib/features/home/data/home_repository_impl.dart',
  'lib/features/home/presentation/view_models/home_recommend_view_model.dart -> lib/features/home/data/home_repository_impl.dart',
  'lib/features/home/presentation/view_models/weekly_view_model.dart -> lib/features/home/data/home_repository_impl.dart',
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
  'lib/features/ranking/presentation/view_models/category_ranking_view_model.dart -> lib/features/ranking/data/ranking_repository_impl.dart',
  'lib/features/search/presentation/view_models/search_view_model.dart -> lib/features/search/data/search_repository_impl.dart',
  'lib/features/video/presentation/comments/comment_reply_view_model.dart -> lib/features/video/data/video_repository_impl.dart',
  'lib/features/video/presentation/comments/video_comments_view_model.dart -> lib/features/video/data/video_repository_impl.dart',
  'lib/features/video/presentation/detail/video_detail_view_model.dart -> lib/features/video/data/video_repository_impl.dart',
  'lib/features/video/presentation/overlays/danmaku_view_model.dart -> lib/features/video/data/danmaku_repository_impl.dart',
  'lib/features/video/presentation/overlays/subtitle_view_model.dart -> lib/features/video/data/video_repository_impl.dart',
  'lib/features/video/presentation/player/hooks/use_listen_audio_mode.dart -> lib/features/video/data/video_repository_impl.dart',
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
