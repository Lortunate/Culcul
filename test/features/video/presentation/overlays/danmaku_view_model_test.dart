import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/video/application/danmaku_application_providers.dart';
import 'package:culcul/features/video/application/danmaku_port.dart';
import 'package:culcul/features/video/application/models/danmaku.dart';
import 'package:culcul/features/video/data/danmaku_repository_impl.dart';
import 'package:culcul/features/video/presentation/overlays/danmaku_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('danmaku segments read through the video danmaku application port', () async {
    const segment = DanmakuSegment(
      entries: [DanmakuEntry(content: 'hello', progress: 1000, color: 0xffffff, mode: 1)],
      state: 0,
    );
    final port = _FakeDanmakuPort(segment);
    final container = ProviderContainer(
      overrides: [
        danmakuPortProvider.overrideWithValue(port),
        danmakuRepositoryProvider.overrideWith(
          (ref) => throw StateError(
            'danmakuRepositoryProvider should not be read by UI state',
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    await container.read(danmakuProviderProvider.future);
    final result = await container
        .read(danmakuProviderProvider.notifier)
        .loadSegment(oid: 1, pid: 2, segmentIndex: 3);

    expect(result.dataOrNull, segment.entries);
    expect(port.requests, const [(oid: 1, pid: 2, segmentIndex: 3)]);
  });
}

final class _FakeDanmakuPort implements DanmakuPort {
  _FakeDanmakuPort(this.segment);

  final DanmakuSegment segment;
  final requests = <({int oid, int pid, int segmentIndex})>[];

  @override
  Future<Result<DanmakuSegment, AppError>> fetchDanmakuSegment({
    required int oid,
    required int pid,
    required int segmentIndex,
  }) async {
    requests.add((oid: oid, pid: pid, segmentIndex: segmentIndex));
    return Success(segment);
  }
}
