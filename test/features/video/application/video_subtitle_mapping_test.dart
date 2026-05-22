import 'package:flutter_test/flutter_test.dart';

import 'package:culcul/features/video/application/video_detail_models.dart';
import 'package:culcul/features/video/data/dtos/video_detail_dto.dart';

void main() {
  test('video detail maps subtitle DTOs to JSON-free application subtitles', () {
    final detail = VideoDetail.fromJson({
      'bvid': 'BV1',
      'aid': 1,
      'videos': 1,
      'tid': 1,
      'tname': 'animation',
      'copyright': 1,
      'pic': 'cover',
      'title': 'title',
      'pubdate': 123,
      'ctime': 123,
      'desc': 'desc',
      'owner': {'mid': 42, 'name': 'owner'},
      'stat': {'view': 10},
      'pages': <Map<String, Object?>>[],
      'subtitle': {
        'list': [
          {
            'id': 7,
            'lan': 'zh-CN',
            'lan_doc': 'Chinese',
            'subtitle_url': '//example.test/subtitle.json',
            'is_lock': true,
            'id_str': '7',
            'type': 1,
          },
        ],
      },
    });

    final viewData = detail.toVideoDetailViewData();
    final subtitle = viewData.subtitle;

    expect(subtitle, isNotNull);
    expect(subtitle!.list, hasLength(1));
    expect(subtitle.list.single.lanDoc, 'Chinese');
    expect(subtitle.list.single.subtitleUrl, '//example.test/subtitle.json');
    expect(subtitle.list.single.isLock, isTrue);
    expect(subtitle.list.single.idStr, '7');
  });
}
