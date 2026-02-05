import 'package:culcul/core/types/result.dart';
import 'package:culcul/data/api/weekly_api.dart';
import 'package:culcul/data/models/weekly_model.dart';

class WeeklyRepository {
  final WeeklyApi _api;

  WeeklyRepository(this._api);

  Future<Result<WeeklyModel, Exception>> getWeeklyList() async {
    try {
      final response = await _api.getWeeklyList();
      if (response.code == 0) {
        return Success(response.data!);
      } else {
        return Failure(Exception(response.message));
      }
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }
}
