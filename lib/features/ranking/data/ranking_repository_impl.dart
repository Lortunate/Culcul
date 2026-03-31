import 'package:culcul/core/base_repository.dart';
import 'package:culcul/core/network/dio_client.dart';
import 'package:culcul/features/ranking/data/ranking_video_mapper.dart';
import 'package:culcul/features/ranking/data/ranking_api.dart';
import 'package:culcul/features/ranking/domain/entities/ranking_video.dart';
import 'package:culcul/features/ranking/domain/repositories/ranking_repository.dart'
    as domain;
import 'package:culcul/features/ranking/data/dtos/ranking_dtos.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ranking_repository_impl.g.dart';

@riverpod
domain.RankingRepository rankingRepository(Ref ref) {
  return RankingRepositoryImpl(RankingApi(ref.watch(dioClientProvider)));
}

class RankingRepositoryImpl extends BaseRepository implements domain.RankingRepository {
  final RankingApi _api;

  RankingRepositoryImpl(this._api);

  Future<List<VideoModel>> getRankingModels({int? rid}) async {
    final data = await requestApi(() => _api.fetchRanking(rid: rid));
    return data.list;
  }

  @override
  Future<List<RankingVideo>> getRanking({int? rid}) async {
    final videos = await getRankingModels(rid: rid);
    return videos.map((video) => video.toDomain()).toList();
  }
}
