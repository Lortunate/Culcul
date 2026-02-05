import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/domain/entities/video_ranking.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_ranking_provider.g.dart';

@riverpod
Future<List<VideoItem>> categoryRankingList(Ref ref, {int? rid}) async {
  final repository = ref.watch(rankingRepositoryProvider);

  try {
    return await repository.getRanking(rid: rid);
  } catch (e) {
    throw Exception('Failed to load ranking: $e');
  }
}
