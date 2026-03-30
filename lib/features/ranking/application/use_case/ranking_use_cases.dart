import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/ranking/data/mappers/ranking_video_mapper.dart';
import 'package:culcul/features/ranking/data/ranking_repository.dart';
import 'package:culcul/features/ranking/domain/entities/ranking_video.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ranking_use_cases.g.dart';

@riverpod
RankingUseCases rankingUseCases(Ref ref) {
  return RankingUseCases(ref.read(rankingRepositoryProvider));
}

class RankingUseCases {
  final RankingRepository _repository;

  const RankingUseCases(this._repository);

  Future<Result<List<RankingVideo>, AppError>> getRanking({int? rid}) async {
    try {
      final videos = await _repository.getRanking(rid: rid);
      return Success(videos.map((video) => video.toDomain()).toList());
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }
}
