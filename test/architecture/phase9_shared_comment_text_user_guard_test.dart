import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'features do not import shared comment, text, or user widgets from feature internals',
    () async {
      const blockedImports = [
        'package:culcul/features/video/presentation/comments/comments/comment_item.dart',
        'package:culcul/features/video/presentation/comments/comments/comment_reply_sheet.dart',
        'package:culcul/features/dynamic/presentation/widgets/bilibili_emoji_text.dart',
        'package:culcul/features/profile/presentation/widgets/user_tags.dart',
      ];

      final violations = <String>[];

      await for (final entity in Directory('lib/features').list(recursive: true)) {
        if (entity is! File || !entity.path.endsWith('.dart')) {
          continue;
        }

        final normalizedPath = entity.path.replaceAll('\\', '/');
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
            'Shared comment/text/user widgets must live under ui/compositions. '
            'Found feature-internal imports: ${violations.join(', ')}',
      );
    },
  );
}
