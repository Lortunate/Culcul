import 'package:culcul/core/base_repository.dart';
import 'package:culcul/core/network/dio_client.dart';
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

class WeeklyRepositoryImpl extends BaseRepository implements domain.WeeklyRepository {
  final WeeklyApi _api;

  WeeklyRepositoryImpl(this._api);

  Future<WeeklyModelDto> getWeeklyListModel() {
    return requestApi(() => _api.getWeeklyList());
  }

  @override
  Future<HomeWeeklyFeed> getWeeklyList() async {
    return (await getWeeklyListModel()).toDomain();
  }
}


