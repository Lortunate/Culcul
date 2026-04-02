import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/core/network/dio_client.dart';
import 'package:culcul/core/network/dtos/video_model_contract_dto.dart';
import 'package:culcul/core/network/request_executor.dart';
import 'package:culcul/core/network/request_executor_binding.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/ranking/data/dtos/ranking_response_dto.dart';
import 'package:culcul/features/ranking/data/ranking_video_mapper.dart';
import 'package:culcul/features/ranking/data/ranking_api.dart';
import 'package:culcul/features/ranking/domain/entities/ranking_video.dart';
import 'package:culcul/features/ranking/domain/repositories/ranking_repository.dart'
    as domain;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ranking_repository_impl.g.dart';

@riverpod
domain.RankingRepository rankingRepository(Ref ref) {
  return RankingRepositoryImpl(RankingApi(ref.watch(dioClientProvider)));
}

class RankingRepositoryImpl with RequestExecutorBinding implements domain.RankingRepository {
  final RankingApi _api;
  final RequestExecutor _requestExecutor;

  RankingRepositoryImpl(this._api, {RequestExecutor? requestExecutor})
    : _requestExecutor = requestExecutor ?? const RequestExecutor();

  @override
  RequestExecutor get requestExecutor => _requestExecutor;

  Future<RankingResponseDto> getRankingResponseDto({int? rid}) {
    return requestApi(() => _api.fetchRanking(rid: rid));
  }

  Future<List<VideoModel>> getRankingModels({int? rid}) async {
    final data = await getRankingResponseDto(rid: rid);
    return data.list.map((item) => item.toContract()).toList();
  }

  @override
  Future<Result<List<RankingVideo>, AppError>> getRanking({int? rid}) async {
    return requestResult(() async {
      final videos = await getRankingModels(rid: rid);
      return videos.map((video) => video.toDomain()).toList();
    });
  }
}
