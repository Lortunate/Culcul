import 'package:culcul/features/notification/application/notification_navigation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NotificationNavigationParser', () {
    const parser = NotificationNavigationParser();

    test('keeps opus notification links routed to dynamic detail', () {
      final target = parser.parse(uri: '/opus/123456');

      expect(target.kind, NotificationNavigationKind.dynamicDetail);
      expect(target.dynamicId, '123456');
    });

    test('keeps archive subject fallback as av video navigation', () {
      final target = parser.parse(business: 'archive', subjectId: 42);

      expect(target.kind, NotificationNavigationKind.video);
      expect(target.videoId, 'av42');
    });
  });
}
