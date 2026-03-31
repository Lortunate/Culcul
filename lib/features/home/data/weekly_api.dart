import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/core/network/models/api_response.dart';
import 'package:culcul/features/home/models/home_models.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'weekly_api.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class WeeklyApi {
  factory WeeklyApi(Dio dio, {String baseUrl}) = _WeeklyApi;

  @GET('/x/web-interface/popular/weekly')
  Future<ApiResponse<WeeklyModel>> getWeeklyList();
}
