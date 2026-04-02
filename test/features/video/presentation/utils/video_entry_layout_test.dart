import 'package:culcul/features/video/application/video_entry_layout.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('inferVideoEntryLayoutFromDimension', () {
    test('returns vertical when rotate is 0 and height is greater than width', () {
      final layout = inferVideoEntryLayoutFromDimension(
        width: 1080,
        height: 1920,
        rotate: 0,
      );

      expect(layout, VideoEntryLayout.vertical);
    });

    test(
      'returns normal when rotate is 0 and width is greater than or equal to height',
      () {
        final landscape = inferVideoEntryLayoutFromDimension(
          width: 1920,
          height: 1080,
          rotate: 0,
        );
        final square = inferVideoEntryLayoutFromDimension(
          width: 1080,
          height: 1080,
          rotate: 0,
        );

        expect(landscape, VideoEntryLayout.normal);
        expect(square, VideoEntryLayout.normal);
      },
    );

    test('returns vertical when rotate is 1 and swapped size is vertical', () {
      final layout = inferVideoEntryLayoutFromDimension(
        width: 1920,
        height: 1080,
        rotate: 1,
      );

      expect(layout, VideoEntryLayout.vertical);
    });

    test('treats rotate 90 and 270 the same as rotate 1', () {
      final rotate90 = inferVideoEntryLayoutFromDimension(
        width: 1920,
        height: 1080,
        rotate: 90,
      );
      final rotate270 = inferVideoEntryLayoutFromDimension(
        width: 1920,
        height: 1080,
        rotate: 270,
      );

      expect(rotate90, VideoEntryLayout.vertical);
      expect(rotate270, VideoEntryLayout.vertical);
    });

    test('returns normal when width or height is invalid', () {
      final noWidth = inferVideoEntryLayoutFromDimension(
        width: 0,
        height: 1080,
        rotate: 0,
      );
      final noHeight = inferVideoEntryLayoutFromDimension(
        width: 1080,
        height: 0,
        rotate: 0,
      );

      expect(noWidth, VideoEntryLayout.normal);
      expect(noHeight, VideoEntryLayout.normal);
    });
  });
}
