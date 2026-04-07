import 'package:culcul/features/search/data/dtos/search_result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('_SearchResultConverter', () {
    test('drops unknown result types and keeps supported types', () {
      final json = <String, dynamic>{
        'seid': 'test',
        'page': 1,
        'pagesize': 20,
        'numResults': 4,
        'numPages': 1,
        'result': <dynamic>[
          <String, dynamic>{
            'result_type': 'video',
            'data': <dynamic>[
              <String, dynamic>{'title': 'known video', 'bvid': 'BV1xx411c7mD'},
            ],
          },
          <String, dynamic>{
            'result_type': 'mystery_type',
            'data': <dynamic>[
              <String, dynamic>{'title': 'should drop 1'},
              <String, dynamic>{'title': 'should drop 2'},
            ],
          },
          <String, dynamic>{
            'type': 'article',
            'title': 'known article',
            'image_urls': <String>[],
          },
          <String, dynamic>{'type': 'unknown_direct', 'title': 'should drop direct'},
        ],
      };

      final data = SearchResultData.fromJson(json);

      expect(data.result.length, 2);
      expect(data.result.first, isA<SearchVideoModel>());
      expect(data.result.last, isA<SearchArticleModel>());
    });

    test('does not downgrade unknown direct type to video', () {
      final json = <String, dynamic>{
        'seid': 'test',
        'page': 1,
        'pagesize': 20,
        'numResults': 1,
        'numPages': 1,
        'result': <dynamic>[
          <String, dynamic>{
            'type': 'unknown_type',
            'title': 'unexpected',
            'bvid': 'BV1xx411c7mD',
          },
        ],
      };

      final data = SearchResultData.fromJson(json);

      expect(data.result, isEmpty);
    });
  });
}
