import 'package:culcul/core/base_repository.dart';
import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/features/home/data/mappers/home_feed_mapper.dart';
import 'package:culcul/features/home/data/weekly_api.dart';
import 'package:culcul/features/home/domain/entities/home_video.dart';
import 'package:culcul/features/home/domain/repositories/weekly_repository.dart'
    as domain;
import 'package:culcul/features/home/models/home_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weekly_repository.g.dart';

@riverpod
domain.WeeklyRepository weeklyRepository(Ref ref) {
  return WeeklyRepositoryImpl(ref.watch(weeklyApiProvider));
}

class WeeklyRepositoryImpl extends BaseRepository implements domain.WeeklyRepository {
  final WeeklyApi _api;

  WeeklyRepositoryImpl(this._api);

  Future<WeeklyModel> getWeeklyListModel() {
    return requestApi(() => _api.getWeeklyList());
  }

  @override
  Future<HomeWeeklyFeed> getWeeklyList() async {
    return (await getWeeklyListModel()).toDomain();
  }
}
