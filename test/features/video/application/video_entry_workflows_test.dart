import 'package:culcul/features/video/application/video_entry_layout.dart';
import 'package:culcul/features/video/application/video_entry_workflows.dart';
import 'package:culcul/features/video/domain/entities/video_entities.dart';
import 'package:culcul/features/video/domain/repositories/video_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ResolveVideoEntryLayoutWorkflow', () {
    test('returns vertical when repository provides vertical dimension', () async {
      final workflow = ResolveVideoEntryLayoutWorkflow(
        _FakeVideoRepository(
          dimension: const VideoDimension(width: 1080, height: 1920, rotate: 0),
        ),
      );

      final layout = await workflow.call('BV1');

      expect(layout, VideoEntryLayout.vertical);
    });

    test('returns normal when repository returns null dimension', () async {
      final workflow = ResolveVideoEntryLayoutWorkflow(
        _FakeVideoRepository(dimension: null),
      );

      final layout = await workflow.call('BV1');

      expect(layout, VideoEntryLayout.normal);
    });

    test('returns normal when repository throws', () async {
      final workflow = ResolveVideoEntryLayoutWorkflow(
        _FakeVideoRepository(shouldThrow: true),
      );

      final layout = await workflow.call('BV1');

      expect(layout, VideoEntryLayout.normal);
    });
  });
}

class _FakeVideoRepository extends Fake implements VideoRepository {
  final VideoDimension? dimension;
  final bool shouldThrow;

  _FakeVideoRepository({this.dimension, this.shouldThrow = false});

  @override
  Future<VideoDimension?> fetchVideoEntryDimension(String bvid) async {
    if (shouldThrow) {
      throw Exception('fetch failed');
    }
    return dimension;
  }
}
