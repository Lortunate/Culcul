import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/history/data/mappers/history_mapper.dart';
import 'package:culcul/features/history/data/history_repository.dart';
import 'package:culcul/features/history/domain/entities/history_entry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history_use_cases.g.dart';

@riverpod
HistoryUseCases historyUseCases(Ref ref) {
  return HistoryUseCases(ref.read(historyRepositoryProvider));
}

class HistoryUseCases {
  final HistoryRepository _repository;

  const HistoryUseCases(this._repository);

  Future<Result<List<HistoryEntry>, AppError>> getHistory() async {
    try {
      final data = await _repository.getHistoryCursor();
      return Success(data.list.map((item) => item.toDomain()).toList());
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }
}
