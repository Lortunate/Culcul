import 'package:culcul/features/live/domain/entities/live_room_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('LiveRoomModel from domain path supports API json keys', () {
    final model = LiveRoomModel.fromJson(<String, dynamic>{
      'roomid': 123,
      'uid': 456,
      'title': 'live',
      'uname': 'streamer',
      'cover': 'https://i0.hdslb.com/test.jpg',
      'face': 'https://i0.hdslb.com/avatar.jpg',
      'online': 999,
      'area_v2_name': 'art',
      'area_v2_parent_name': 'entertainment',
      'link': 'https://live.bilibili.com/123',
      'keyframe': null,
      'is_auto_play': 0,
      'watched_show': <String, dynamic>{
        'switch': true,
        'num': 1,
        'text_small': '1 watched',
        'text_large': '1 watched',
        'icon': '',
        'icon_web': '',
      },
    });

    expect(model.roomId, 123);
    expect(model.areaName, 'art');
    expect(model.parentAreaName, 'entertainment');
    expect(model.watchedShow?.switchStatus, isTrue);
  });
}
