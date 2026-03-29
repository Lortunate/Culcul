import 'package:culcul/core/base_repository.dart';
import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/data/api/weekly_api.dart';
import 'package:culcul/data/models/feed/weekly_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weekly_repository.g.dart';

@riverpod
WeeklyRepository weeklyRepository(Ref ref) {
  return WeeklyRepository(ref.watch(weeklyApiProvider));
}

class WeeklyRepository extends BaseRepository {
  final WeeklyApi _api;

  WeeklyRepository(this._api);

  Future<WeeklyModel> getWeeklyList() {
    return requestApi(() => _api.getWeeklyList());
  }
}
