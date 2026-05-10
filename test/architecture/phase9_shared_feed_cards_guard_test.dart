import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'non-video features do not import shared feed cards from video presentation',
    () async {
      const blockedImports = [
        'package:culcul/features/video/presentation/widgets/video_card.dart',
        'package:culcul/features/video/presentation/widgets/video_list_card.dart',
        'package:culcul/features/video/presentation/widgets/video_thumbnail.dart',
        'package:culcul/features/video/presentation/widgets/video_card_skeleton.dart',
        'package:culcul/features/video/presentation/widgets/video_list_skeleton.dart',
      ];

      final violations = <String>[];

      await for (final entity in Directory('lib/features').list(recursive: true)) {
        if (entity is! File || !entity.path.endsWith('.dart')) {
          continue;
        }

        final normalizedPath = entity.path.replaceAll('\\', '/');
        if (normalizedPath.startsWith('lib/features/video/')) {
          continue;
        }

        final content = await entity.readAsString();
        for (final blockedImport in blockedImports) {
          if (content.contains(blockedImport)) {
            violations.add('$normalizedPath -> $blockedImport');
          }
        }
      }

      expect(
        violations,
        isEmpty,
        reason:
            'Shared feed cards must move to ui/compositions/feed_cards. '
            'Found cross-feature imports: ${violations.join(', ')}',
      );
    },
  );
}
