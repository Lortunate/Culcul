import 'package:culcul/features/video/domain/entities/video_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('VideoModel from domain path supports API json keys and converter', () {
    final model = VideoModel.fromJson(<String, dynamic>{
      'bvid': 'BV1xx411c7mD',
      'title': 'test title',
      'pic': 'https://i0.hdslb.com/test.jpg',
      'owner': <String, dynamic>{'mid': 1001, 'name': 'up', 'face': ''},
      'stat': <String, dynamic>{'view': 100, 'danmaku': 10, 'reply': 1},
      'duration': 120,
      'pubdate': 1700000000,
      'desc': 'desc',
      'rcmd_reason': <String, dynamic>{'content': 'recommended'},
    });

    expect(model.bvid, 'BV1xx411c7mD');
    expect(model.pubDate, 1700000000);
    expect(model.rcmdReason, 'recommended');
  });
}
