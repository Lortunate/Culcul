import 'package:culcul/features/history/data/dtos/history_model_dto.dart';
import 'package:culcul/features/history/data/history_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

HistoryDetailDto _makeDetail({
  int oid = 1001,
  int epid = 2002,
  String bvid = 'BV1abc123',
  int page = 1,
  int cid = 3003,
  String part = 'P1',
  String business = 'archive',
  int dt = 1700000000,
}) {
  return HistoryDetailDto(
    oid: oid,
    epid: epid,
    bvid: bvid,
    page: page,
    cid: cid,
    part: part,
    business: business,
    dt: dt,
  );
}

HistoryItemDto _makeItem({
  String title = 'Test Video',
  String longTitle = 'Test Video Long Title',
  String cover = 'https://img.example.com/cover.jpg',
  List<String>? covers,
  String uri = 'https://www.bilibili.com/video/BV1abc123',
  HistoryDetailDto? history,
  int videos = 1,
  String authorName = 'TestAuthor',
  String authorFace = 'https://img.example.com/face.jpg',
  int authorMid = 12345,
  int viewAt = 1700001000,
  int progress = 300,
  String badge = '',
  String showTitle = 'Test Video',
  int duration = 600,
  String current = '1',
  int total = 1,
  String newDesc = '',
  int isFinish = 0,
  int isFav = 0,
  int kid = 0,
  String tagName = 'anime',
  int liveStatus = 0,
}) {
  return HistoryItemDto(
    title: title,
    longTitle: longTitle,
    cover: cover,
    covers: covers,
    uri: uri,
    history: history ?? _makeDetail(),
    videos: videos,
    authorName: authorName,
    authorFace: authorFace,
    authorMid: authorMid,
    viewAt: viewAt,
    progress: progress,
    badge: badge,
    showTitle: showTitle,
    duration: duration,
    current: current,
    total: total,
    newDesc: newDesc,
    isFinish: isFinish,
    isFav: isFav,
    kid: kid,
    tagName: tagName,
    liveStatus: liveStatus,
  );
}

void main() {
  group('HistoryItemMapper.toDomain', () {
    test('maps all fields correctly with known values', () {
      final detail = _makeDetail(bvid: 'BV1xyz999', business: 'pgc');
      final dto = _makeItem(
        title: 'My Video',
        cover: 'https://img.example.com/my-cover.jpg',
        authorName: 'SomeAuthor',
        viewAt: 1700005000,
        progress: 120,
        badge: 'new',
        duration: 900,
        history: detail,
      );

      final entry = dto.toDomain();

      expect(entry.title, 'My Video');
      expect(entry.coverUrl, 'https://img.example.com/my-cover.jpg');
      expect(entry.bvid, 'BV1xyz999');
      expect(entry.business, 'pgc');
      expect(entry.authorName, 'SomeAuthor');
      expect(entry.viewedAt, 1700005000);
      expect(entry.progress, 120);
      expect(entry.duration, 900);
      expect(entry.badge, 'new');
    });

    test('maps empty string values correctly', () {
      final dto = _makeItem(title: '', cover: '', authorName: '', badge: '');

      final entry = dto.toDomain();

      expect(entry.title, isEmpty);
      expect(entry.coverUrl, isEmpty);
      expect(entry.authorName, isEmpty);
      expect(entry.badge, isEmpty);
    });

    test('maps zero numeric values correctly', () {
      final dto = _makeItem(viewAt: 0, progress: 0, duration: 0);

      final entry = dto.toDomain();

      expect(entry.viewedAt, 0);
      expect(entry.progress, 0);
      expect(entry.duration, 0);
    });

    test('maps large numeric values correctly', () {
      final dto = _makeItem(viewAt: 9999999999, progress: 86400, duration: 86400);

      final entry = dto.toDomain();

      expect(entry.viewedAt, 9999999999);
      expect(entry.progress, 86400);
      expect(entry.duration, 86400);
    });

    test('maps bvid and business from nested history detail', () {
      final detail = _makeDetail(bvid: 'BV999special', business: 'live');
      final dto = _makeItem(history: detail);

      final entry = dto.toDomain();

      expect(entry.bvid, 'BV999special');
      expect(entry.business, 'live');
    });

    test('preserves all field values from dto without transformation', () {
      final dto = _makeItem(
        title: 'Title A',
        cover: 'https://cover-a.jpg',
        authorName: 'Author A',
        viewAt: 111,
        progress: 222,
        badge: 'vip',
        duration: 333,
      );

      final entry = dto.toDomain();

      // Verify no field gets swapped or lost
      expect(entry.title, dto.title);
      expect(entry.coverUrl, dto.cover);
      expect(entry.bvid, dto.history.bvid);
      expect(entry.business, dto.history.business);
      expect(entry.authorName, dto.authorName);
      expect(entry.viewedAt, dto.viewAt);
      expect(entry.progress, dto.progress);
      expect(entry.duration, dto.duration);
      expect(entry.badge, dto.badge);
    });
  });
}
