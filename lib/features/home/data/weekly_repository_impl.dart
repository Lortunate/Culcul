import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/network/dio_client.dart';
import 'package:culcul/core/network/request_executor.dart';
import 'package:culcul/core/network/request_executor_binding.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/home/data/home_feed_mapper.dart';
import 'package:culcul/features/home/data/dtos/weekly_model_dto.dart';
import 'package:culcul/features/home/data/weekly_api.dart';
import 'package:culcul/features/home/domain/entities/home_video.dart';
import 'package:culcul/features/home/domain/repositories/weekly_repository.dart'
    as domain;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weekly_repository_impl.g.dart';

@riverpod
domain.WeeklyRepository weeklyRepository(Ref ref) {
  return WeeklyRepositoryImpl(WeeklyApi(ref.watch(dioClientProvider)));
}

class WeeklyRepositoryImpl with RequestExecutorBinding implements domain.WeeklyRepository {
  final WeeklyApi _api;
  final RequestExecutor _requestExecutor;

  WeeklyRepositoryImpl(this._api, {RequestExecutor? requestExecutor})
    : _requestExecutor = requestExecutor ?? const RequestExecutor();

  @override
  RequestExecutor get requestExecutor => _requestExecutor;

  Future<Result<WeeklyModelDto, AppError>> getWeeklyListModel() {
    return requestApiResult(() => _api.getWeeklyList());
  }

  @override
  Future<Result<HomeWeeklyFeed, AppError>> getWeeklyList() async {
    final result = await getWeeklyListModel();
    return result.map((data) => data.toDomain());
  }
}
