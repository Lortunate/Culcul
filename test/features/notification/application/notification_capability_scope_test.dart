import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'notification uses feature scope without a facade entry',
    () async {
      final featureScope = await File(
        'lib/features/notification/feature_scope.dart',
      ).readAsString();
      final removedFacadeFile = File(
        'lib/features/notification/application/notification_facade.dart',
      );

      expect(featureScope, isNot(contains('notificationFacadeEntryProvider')));
      expect(featureScope, contains('notificationRepositoryProvider'));
      expect(removedFacadeFile.existsSync(), isFalse);
    },
  );
}
