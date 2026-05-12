import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/features/to_view/data/dtos/to_view_model_dto.dart';
import 'package:culcul/features/to_view/data/to_view_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ToViewModelMapper.toDomain', () {
    test('maps all fields from dto to entry', () {
      const dto = ToViewModelDto(
        aid: 12345,
        bvid: 'BV1xx411c7mD',
        title: 'Test Video',
        pic: 'https://example.com/cover.jpg',
        duration: 300,
        progress: 150,
        owner: VideoOwner(mid: 1, name: 'Uploader', face: ''),
        stat: VideoStat(view: 1000, danmaku: 50),
      );

      final entry = dto.toDomain();

      expect(entry.aid, 12345);
      expect(entry.bvid, 'BV1xx411c7mD');
      expect(entry.title, 'Test Video');
      expect(entry.coverUrl, 'https://example.com/cover.jpg');
      expect(entry.duration, 300);
      expect(entry.progress, 150);
      expect(entry.ownerName, 'Uploader');
      expect(entry.viewCount, 1000);
      expect(entry.danmakuCount, 50);
    });

    test('defaults null owner name to empty string', () {
      const dto = ToViewModelDto(
        aid: 1,
        bvid: 'BV1',
        title: 'Video',
        pic: '',
        duration: 100,
        progress: 0,
        owner: null,
        stat: null,
      );

      final entry = dto.toDomain();

      expect(entry.ownerName, '');
      expect(entry.viewCount, 0);
      expect(entry.danmakuCount, 0);
    });

    test('defaults null title to empty string', () {
      const dto = ToViewModelDto(
        aid: 2,
        bvid: 'BV2',
        pic: '',
        duration: 0,
        progress: 0,
        owner: VideoOwner(mid: 0, name: ''),
        stat: VideoStat(),
      );

      final entry = dto.toDomain();

      expect(entry.title, '');
    });

    test('defaults null aid to 0 and null bvid to empty string', () {
      const dto = ToViewModelDto(
        duration: 60,
        progress: 30,
        owner: VideoOwner(mid: 0, name: 'User'),
        stat: VideoStat(view: 5, danmaku: 1),
      );

      final entry = dto.toDomain();

      expect(entry.aid, 0);
      expect(entry.bvid, '');
      expect(entry.duration, 60);
      expect(entry.progress, 30);
    });
  });
}
