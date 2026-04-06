import 'package:culcul/features/live/presentation/view_models/live_danmaku_event_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const parser = LiveDanmakuEventParser();

  test('parses DANMU_MSG into strongly typed item', () {
    final item = parser.parse({
      'cmd': 'DANMU_MSG',
      'info': [
        [],
        'hello',
        [123, 'alice', 1, 1, 0],
        [3, 'fan-medal', '', 10086, 16711680],
        [42, 7],
        ['title-name', 'title-skin'],
      ],
    });

    expect(item, isNotNull);
    expect(item!.text, 'hello');
    expect(item.nickname, 'alice');
    expect(item.uid, 123);
    expect(item.medal?.level, 3);
    expect(item.medal?.name, 'fan-medal');
    expect(item.userLevel?.level, 42);
    expect(item.userLevel?.rank, 7);
    expect(item.title?.title, 'title-name');
    expect(item.title?.skin, 'title-skin');
  });

  test('parses INTERACT_WORD, NOTICE_MSG and SEND_GIFT', () {
    final interact = parser.parse({
      'cmd': 'INTERACT_WORD',
      'data': {
        'uname': 'bob',
        'uid': 222,
        'msg_type': 2,
        'fans_medal': {
          'medal_level': 4,
          'medal_name': 'badge',
          'anchor_roomid': 12345,
          'medal_color': 0x00AABBCC,
        },
      },
    });
    expect(interact, isNotNull);
    expect(interact!.dmType, 1);
    expect(interact.medal?.level, 4);

    final notice = parser.parse({'cmd': 'NOTICE_MSG', 'msg_common': 'system message'});
    expect(notice, isNotNull);
    expect(notice!.dmType, 3);
    expect(notice.text, 'system message');

    final gift = parser.parse({
      'cmd': 'SEND_GIFT',
      'data': {
        'uname': 'carol',
        'uid': 333,
        'giftName': 'flower',
        'num': 2,
        'medal_info': {
          'medal_level': 5,
          'medal_name': 'gift-badge',
          'anchor_roomid': 555,
          'medal_color': 123,
        },
      },
    });
    expect(gift, isNotNull);
    expect(gift!.dmType, 2);
    expect(gift.nickname, 'carol');
    expect(gift.medal?.name, 'gift-badge');
  });

  test('drops malformed payload without throwing', () {
    expect(parser.parse({'cmd': 'DANMU_MSG', 'info': 'oops'}), isNull);
    expect(parser.parse({'cmd': 'UNKNOWN'}), isNull);
    expect(parser.parse({'cmd': null}), isNull);
  });
}
