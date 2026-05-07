import 'package:culcul/core/data/network/dtos/video_model_contract_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('video model dto maps to pure contract', () {
    final model = VideoModelDto.fromJson({
      'bvid': 'BV1xx',
      'title': 'Video',
      'pic': 'cover',
      'owner': {'mid': 1, 'name': 'author', 'face': 'face'},
      'stat': {'view': 10, 'danmaku': 2},
      'duration': 120,
      'pubdate': 123456,
      'rcmd_reason': {'content': 'hot'},
    });

    expect(model.bvid, 'BV1xx');
    expect(model.owner.name, 'author');
    expect(model.stat.view, 10);
    expect(model.rcmdReason, 'hot');
  });
}
