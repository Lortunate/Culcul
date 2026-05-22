import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/core/data/network/dio_client.dart';
import 'package:culcul/core/data/network/request_executor.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/ranking/data/dtos/ranking_response_dto.dart';
import 'package:culcul/features/ranking/data/ranking_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ranking_repository_impl.g.dart';

@riverpod
RankingRepositoryImpl rankingRepository(Ref ref) {
  return RankingRepositoryImpl(RankingApi(ref.watch(dioClientProvider)));
}

class RankingRepositoryImpl {
  final RankingApi _api;
  final RequestExecutor _requestExecutor;

  RankingRepositoryImpl(this._api, {RequestExecutor? requestExecutor})
    : _requestExecutor = requestExecutor ?? const RequestExecutor();

  Future<Result<RankingResponseDto, AppError>> _getRankingResponseDto({int? rid}) {
    return _requestExecutor.runApiDirect(() => _api.fetchRanking(rid: rid));
  }

  Future<Result<List<VideoModel>, AppError>> getRanking({int? rid}) async {
    final result = await _getRankingResponseDto(rid: rid);
    return result.map((data) => data.list);
  }
}
