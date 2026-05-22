import 'package:culcul/core/contracts/bilibili_link_contract.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BilibiliLinkParser', () {
    const parser = BilibiliLinkParser();

    test('extracts BV and av video identifiers', () {
      final bvTarget = parser.parse('https://www.bilibili.com/video/BV1xx411c7mD');
      final avTarget = parser.parse('/video/av123456');

      expect(bvTarget.kind, BilibiliLinkKind.video);
      expect(bvTarget.videoId, 'BV1xx411c7mD');
      expect(avTarget.kind, BilibiliLinkKind.video);
      expect(avTarget.videoId, 'av123456');
    });

    test('extracts dynamic and opus identifiers from web and native links', () {
      final dynamicTarget = parser.parse('https://t.bilibili.com/987654321');
      final opusTarget = parser.parse('bilibili://opus/detail/123456789');

      expect(dynamicTarget.kind, BilibiliLinkKind.dynamicDetail);
      expect(dynamicTarget.dynamicId, '987654321');
      expect(opusTarget.kind, BilibiliLinkKind.dynamicDetail);
      expect(opusTarget.dynamicId, '123456789');
    });

    test('classifies article and live room links', () {
      final articleTarget = parser.parse('/read/cv12345');
      final liveTarget = parser.parse('live.bilibili.com/55');

      expect(articleTarget.kind, BilibiliLinkKind.article);
      expect(articleTarget.uri.toString(), 'https://www.bilibili.com/read/cv12345');
      expect(liveTarget.kind, BilibiliLinkKind.liveRoom);
      expect(liveTarget.liveRoomId, 55);
    });

    test('uses explicit video fallbacks before external launch fallback', () {
      final target = parser.parse(
        'https://example.com/not-bilibili',
        fallbackBvid: 'BV1ab411c7mD',
      );

      expect(target.kind, BilibiliLinkKind.video);
      expect(target.videoId, 'BV1ab411c7mD');
    });
  });
}
