import 'package:culcul/core/network/dtos/video_model_contract_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('video model dto maps to pure contract', () {
    final dto = VideoModelDto.fromJson({
      'bvid': 'BV1xx',
      'title': 'Video',
      'pic': 'cover',
      'owner': {'mid': 1, 'name': 'author', 'face': 'face'},
      'stat': {'view': 10, 'danmaku': 2},
      'duration': 120,
      'pubdate': 123456,
      'rcmd_reason': {'content': 'hot'},
    });

    final contract = dto.toContract();

    expect(contract.bvid, 'BV1xx');
    expect(contract.owner.name, 'author');
    expect(contract.stat.view, 10);
    expect(contract.rcmdReason, 'hot');
  });
}
