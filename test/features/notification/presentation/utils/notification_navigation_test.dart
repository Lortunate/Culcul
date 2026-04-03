import 'package:culcul/features/notification/presentation/utils/notification_navigation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const parser = NotificationNavigationParser();

  test('parses video route from BV uri', () {
    final target = parser.parse(uri: 'https://www.bilibili.com/video/BV1xx411c7mD');

    expect(target.kind, NotificationNavigationKind.video);
    expect(target.videoId, 'BV1xx411c7mD');
  });

  test('parses video route from av uri', () {
    final target = parser.parse(uri: 'https://www.bilibili.com/video/av778899');

    expect(target.kind, NotificationNavigationKind.video);
    expect(target.videoId, 'av778899');
  });

  test('parses dynamic route from native opus uri', () {
    final target = parser.parse(
      nativeUri:
          'bilibili://opus/detail/1073543151725051921?comment_root_id=265141324256',
    );

    expect(target.kind, NotificationNavigationKind.dynamicDetail);
    expect(target.dynamicId, '1073543151725051921');
  });

  test('falls back to external url when no internal route matched', () {
    final target = parser.parse(uri: 'https://example.com/announcement');

    expect(target.kind, NotificationNavigationKind.external);
    expect(target.externalUri?.toString(), 'https://example.com/announcement');
  });

  test('returns none when uri is invalid and no fallback fields available', () {
    final target = parser.parse(uri: 'not-a-valid-uri');

    expect(target.kind, NotificationNavigationKind.none);
  });
}
