import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/core/data/network/models/api_response.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'history_api.g.dart';

@RestApi()
abstract class HistoryApi {
  factory HistoryApi(Dio dio, {String baseUrl}) = _HistoryApi;

  @GET(ApiConstants.historyCursor)
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<Object>> getHistoryCursor(
    @Query('max') int max,
    @Query('view_at') int viewAt,
    @Query('business') String business,
    @Query('ps') int ps,
  );
}
