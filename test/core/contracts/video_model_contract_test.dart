import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('VideoModel.fromJson', () {
    test('deserializes all fields correctly', () {
      final json = <String, dynamic>{
        'bvid': 'BV1xx411c7mD',
        'title': 'Test Video',
        'pic': 'https://example.com/cover.jpg',
        'owner': <String, dynamic>{
          'mid': 12345,
          'name': 'uploader',
          'face': 'https://example.com/avatar.jpg',
        },
        'stat': <String, dynamic>{
          'view': 1000,
          'danmaku': 50,
          'reply': 30,
          'like': 200,
          'coin': 15,
          'favorite': 80,
          'share': 10,
        },
        'duration': 300,
        'pubdate': 1700000000,
        'desc': 'A test video description',
        'rcmd_reason': <String, dynamic>{'content': 'Popular'},
      };

      final model = VideoModel.fromJson(json);

      expect(model.bvid, 'BV1xx411c7mD');
      expect(model.title, 'Test Video');
      expect(model.pic, 'https://example.com/cover.jpg');
      expect(model.owner.mid, 12345);
      expect(model.owner.name, 'uploader');
      expect(model.owner.face, 'https://example.com/avatar.jpg');
      expect(model.stat.view, 1000);
      expect(model.stat.danmaku, 50);
      expect(model.stat.reply, 30);
      expect(model.stat.like, 200);
      expect(model.stat.coin, 15);
      expect(model.stat.favorite, 80);
      expect(model.stat.share, 10);
      expect(model.duration, 300);
      expect(model.pubDate, 1700000000);
      expect(model.desc, 'A test video description');
      expect(model.rcmdReason, 'Popular');
    });

    test('uses defaults for optional fields when missing', () {
      final json = <String, dynamic>{
        'bvid': 'BV1yy',
        'title': 'Minimal',
        'pic': 'pic.jpg',
        'owner': <String, dynamic>{'mid': 1, 'name': 'author'},
        'stat': <String, dynamic>{},
        'duration': 60,
        'pubdate': 1700000000,
      };

      final model = VideoModel.fromJson(json);

      expect(model.desc, '');
      expect(model.rcmdReason, '');
      expect(model.owner.face, '');
      expect(model.stat.view, 0);
      expect(model.stat.danmaku, 0);
      expect(model.stat.reply, 0);
      expect(model.stat.like, 0);
      expect(model.stat.coin, 0);
      expect(model.stat.favorite, 0);
      expect(model.stat.share, 0);
    });

    test('uses defaults for optional fields when null', () {
      final json = <String, dynamic>{
        'bvid': 'BV1zz',
        'title': 'Nulls',
        'pic': 'pic.jpg',
        'owner': <String, dynamic>{'mid': 2, 'name': 'a'},
        'stat': <String, dynamic>{'view': 5},
        'duration': 10,
        'pubdate': 1700000001,
        'desc': null,
        'rcmd_reason': null,
      };

      final model = VideoModel.fromJson(json);

      expect(model.desc, '');
      expect(model.rcmdReason, '');
    });
  });

  group('VideoOwner.fromJson', () {
    test('deserializes all fields', () {
      final json = <String, dynamic>{
        'mid': 42,
        'name': 'creator',
        'face': 'https://face.url',
      };

      final owner = VideoOwner.fromJson(json);

      expect(owner.mid, 42);
      expect(owner.name, 'creator');
      expect(owner.face, 'https://face.url');
    });

    test('defaults face to empty string when missing', () {
      final json = <String, dynamic>{'mid': 1, 'name': 'a'};

      final owner = VideoOwner.fromJson(json);

      expect(owner.face, '');
    });
  });

  group('VideoStat.fromJson', () {
    test('deserializes all fields', () {
      final json = <String, dynamic>{
        'view': 5000,
        'danmaku': 100,
        'reply': 50,
        'like': 300,
        'coin': 25,
        'favorite': 120,
        'share': 15,
      };

      final stat = VideoStat.fromJson(json);

      expect(stat.view, 5000);
      expect(stat.danmaku, 100);
      expect(stat.reply, 50);
      expect(stat.like, 300);
      expect(stat.coin, 25);
      expect(stat.favorite, 120);
      expect(stat.share, 15);
    });

    test('defaults all fields to 0 when empty', () {
      final stat = VideoStat.fromJson(<String, dynamic>{});

      expect(stat.view, 0);
      expect(stat.danmaku, 0);
      expect(stat.reply, 0);
      expect(stat.like, 0);
      expect(stat.coin, 0);
      expect(stat.favorite, 0);
      expect(stat.share, 0);
    });
  });

  group('RcmdReasonConverter', () {
    const converter = RcmdReasonConverter();

    test('extracts content from map', () {
      final result = converter.fromJson({'content': 'Recommended for you'});

      expect(result, 'Recommended for you');
    });

    test('returns empty string for map without content key', () {
      final result = converter.fromJson({'other': 'value'});

      expect(result, '');
    });

    test('returns empty string for string input', () {
      final result = converter.fromJson('some string');

      expect(result, '');
    });

    test('returns empty string for null input', () {
      final result = converter.fromJson(null);

      expect(result, '');
    });

    test('returns empty string for numeric input', () {
      final result = converter.fromJson(42);

      expect(result, '');
    });

    test('toJson returns the string unchanged', () {
      final result = converter.toJson('hello');

      expect(result, 'hello');
    });

    test('toJson returns empty string for empty input', () {
      final result = converter.toJson('');

      expect(result, '');
    });
  });
}
