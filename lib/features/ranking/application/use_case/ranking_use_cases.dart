import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/ranking/domain/repositories/ranking_repository.dart';
import 'package:culcul/features/ranking/domain/entities/ranking_video.dart';
import 'package:culcul/features/ranking/ranking_providers.dart';
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
      return Success(await _repository.getRanking(rid: rid));
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }
}
