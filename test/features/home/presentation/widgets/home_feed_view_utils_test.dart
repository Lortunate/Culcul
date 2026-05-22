import 'package:culcul/features/home/presentation/widgets/home_feed_view_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('buildHomeFeedImagePrefetchSpecs', () {
    test('calculates cache size from logical width, pixel ratio, and aspect ratio', () {
      final specs = buildHomeFeedImagePrefetchSpecs(
        const ['cover-a'],
        startIndex: 0,
        count: 1,
        logicalWidth: 180,
        pixelRatio: 2.5,
        aspectRatio: 16 / 10,
        imageUrl: (url) => url,
      );

      expect(specs.single.url, 'cover-a');
      expect(specs.single.memCacheWidth, 450);
      expect(specs.single.memCacheHeight, 281);
    });

    test('slices upcoming items by start index and count', () {
      final specs = buildHomeFeedImagePrefetchSpecs(
        const ['a', 'b', 'c', 'd'],
        startIndex: 1,
        count: 2,
        logicalWidth: 100,
        pixelRatio: 2,
        aspectRatio: 2,
        imageUrl: (url) => 'https://img/$url',
      );

      expect(specs.map((spec) => spec.url), ['https://img/b', 'https://img/c']);
      expect(specs.map((spec) => spec.memCacheWidth), [200, 200]);
      expect(specs.map((spec) => spec.memCacheHeight), [100, 100]);
    });

    test('returns empty specs for empty or out-of-range windows', () {
      expect(
        buildHomeFeedImagePrefetchSpecs(
          const ['a'],
          startIndex: 2,
          count: 2,
          logicalWidth: 100,
          pixelRatio: 2,
          aspectRatio: 2,
          imageUrl: (url) => url,
        ),
        isEmpty,
      );

      expect(
        buildHomeFeedImagePrefetchSpecs(
          const ['a'],
          startIndex: 0,
          count: 0,
          logicalWidth: 100,
          pixelRatio: 2,
          aspectRatio: 2,
          imageUrl: (url) => url,
        ),
        isEmpty,
      );
    });
  });
}
