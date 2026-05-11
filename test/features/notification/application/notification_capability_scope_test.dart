import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('notification exposes inbox/chat capabilities instead of one entry facade', () async {
    final featureScope = await File(
      'lib/features/notification/feature_scope.dart',
    ).readAsString();
    final capabilitySource = await File(
      'lib/features/notification/application/notification_facade.dart',
    ).readAsString();

    expect(featureScope, isNot(contains('notificationFacadeEntryProvider')));
    expect(featureScope, contains('notificationInboxFacadeProvider'));
    expect(featureScope, contains('notificationChatFacadeProvider'));
    expect(capabilitySource, isNot(contains('class NotificationFacade')));
    expect(capabilitySource, contains('class NotificationInboxFacade'));
    expect(capabilitySource, contains('class NotificationChatFacade'));
  });
}
