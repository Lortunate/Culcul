import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/features/ranking/data/ranking_video_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RankingVideoMapper.toDomain', () {
    test('maps all fields from VideoModel to RankingVideo', () {
      const video = VideoModel(
        bvid: 'BV1xx411c7mD',
        title: 'Test Video Title',
        pic: 'https://i0.hdslb.com/bfs/archive/cover.jpg',
        owner: VideoOwner(mid: 12345, name: 'TestUploader', face: ''),
        stat: VideoStat(
          view: 98765,
          danmaku: 1234,
          reply: 567,
          like: 890,
          coin: 321,
          favorite: 654,
          share: 98,
        ),
        duration: 300,
        pubDate: 1700000000,
        desc: 'some description',
        rcmdReason: '',
      );

      final result = video.toDomain();

      expect(result.bvid, 'BV1xx411c7mD');
      expect(result.title, 'Test Video Title');
      expect(result.coverUrl, 'https://i0.hdslb.com/bfs/archive/cover.jpg');
      expect(result.duration, 300);
      expect(result.ownerName, 'TestUploader');
      expect(result.viewCount, 98765);
      expect(result.danmakuCount, 1234);
    });

    test('maps pic to coverUrl', () {
      final video = _makeVideo(pic: 'https://cdn.example.com/unique.png');
      final result = video.toDomain();
      expect(result.coverUrl, 'https://cdn.example.com/unique.png');
    });

    test('maps owner.name to ownerName', () {
      final video = _makeVideo(
        owner: const VideoOwner(mid: 99, name: 'CoolCreator', face: ''),
      );
      final result = video.toDomain();
      expect(result.ownerName, 'CoolCreator');
    });

    test('maps stat.view to viewCount', () {
      final video = _makeVideo(stat: const VideoStat(view: 42, danmaku: 0));
      final result = video.toDomain();
      expect(result.viewCount, 42);
    });

    test('maps stat.danmaku to danmakuCount', () {
      final video = _makeVideo(stat: const VideoStat(view: 0, danmaku: 777));
      final result = video.toDomain();
      expect(result.danmakuCount, 777);
    });

    test('preserves zero values', () {
      final video = _makeVideo(stat: const VideoStat(view: 0, danmaku: 0));
      final result = video.toDomain();
      expect(result.viewCount, 0);
      expect(result.danmakuCount, 0);
      expect(result.duration, 0);
    });
  });
}

VideoModel _makeVideo({
  String bvid = 'BV1test',
  String title = 'title',
  String pic = 'https://example.com/pic.jpg',
  VideoOwner owner = const VideoOwner(mid: 1, name: 'owner', face: ''),
  VideoStat stat = const VideoStat(view: 0, danmaku: 0),
  int duration = 0,
}) {
  return VideoModel(
    bvid: bvid,
    title: title,
    pic: pic,
    owner: owner,
    stat: stat,
    duration: duration,
    pubDate: 0,
  );
}
