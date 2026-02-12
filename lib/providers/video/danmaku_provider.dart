import 'dart:async';
import 'package:culcul/core/types/result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/protos/dm.pb.dart';

part 'danmaku_provider.g.dart';

@riverpod
class DanmakuProvider extends _$DanmakuProvider {
  @override
  FutureOr<void> build() {}

  Future<List<DanmakuElem>> loadSegment({
    required int oid,
    required int pid,
    required int segmentIndex,
  }) async {
    final repo = ref.read(danmakuRepositoryProvider);
    final result = await repo.fetchDanmakuSegment(
      oid: oid,
      pid: pid,
      segmentIndex: segmentIndex,
    );

    return switch (result) {
      Success(value: final reply) => reply.elems,
      Failure(exception: final e) => throw e,
    };
  }
}
