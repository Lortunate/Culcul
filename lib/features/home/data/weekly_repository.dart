import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/core/base_repository.dart';
import 'package:culcul/core/result.dart';
import 'package:culcul/data/api/weekly_api.dart';
import 'package:culcul/data/models/feed/weekly_model.dart';

class WeeklyRepository extends BaseRepository {
  final WeeklyApi _api;

  WeeklyRepository(this._api);

  Future<Result<WeeklyModel, AppException>> getWeeklyList() {
    return safeApiCall(() => _api.getWeeklyList());
  }
}

