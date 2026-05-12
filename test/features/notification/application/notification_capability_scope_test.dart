import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'notification uses feature scope and targeted use cases instead of a facade entry',
    () async {
      final featureScope = await File(
        'lib/features/notification/feature_scope.dart',
      ).readAsString();
      final featureRoot = await File(
        'lib/features/notification/notification.dart',
      ).readAsString();
      final refreshUseCase = await File(
        'lib/features/notification/application/use_cases/refresh_unread_and_feed_use_case.dart',
      ).readAsString();
      final removedFacadeFile = File(
        'lib/features/notification/application/notification_facade.dart',
      );

      expect(featureScope, isNot(contains('notificationFacadeEntryProvider')));
      expect(featureScope, contains('notificationRepositoryProvider'));
      expect(featureRoot, contains("export 'feature_scope.dart';"));
      expect(
        refreshUseCase,
        contains("import 'package:culcul/features/notification/feature_scope.dart';"),
      );
      expect(refreshUseCase, contains('ref.watch(notificationRepositoryProvider)'));
      expect(removedFacadeFile.existsSync(), isFalse);
    },
  );
}
