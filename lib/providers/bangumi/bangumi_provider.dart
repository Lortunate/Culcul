import 'package:culcul/core/types/result.dart';
import 'package:culcul/data/api/bangumi_api.dart';
import 'package:culcul/data/network/dio_client.dart';
import 'package:culcul/repositories/bangumi_repository.dart';
import 'package:culcul/data/models/bangumi/timeline_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bangumi_provider.g.dart';

@riverpod
BangumiApi bangumiApi(Ref ref) {
  final dio = ref.watch(dioClientProvider);
  return BangumiApi(dio);
}

@riverpod
BangumiRepository bangumiRepository(Ref ref) {
  final api = ref.watch(bangumiApiProvider);
  return BangumiRepository(api);
}

@riverpod
Future<List<TimelineResponse>> bangumiTimeline(
  Ref ref, {
  int types = 1,
  int before = 0,
  int after = 6,
}) async {
  final repository = ref.watch(bangumiRepositoryProvider);
  final result = await repository.fetchTimeline(
    types: types,
    before: before,
    after: after,
  );

  return switch (result) {
    Success(value: final data) => data,
    Failure(exception: final error) => throw error,
  };
}
