import 'package:culcul/core/constants/api_constants.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import '../models/response/api_response.dart';
import '../models/history/history_model.dart';

part 'history_api.g.dart';

@RestApi()
abstract class HistoryApi {
  factory HistoryApi(Dio dio, {String baseUrl}) = _HistoryApi;

  @GET(ApiConstants.historyCursor)
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<HistoryResponseData>> getHistoryCursor(
    @Query('max') int max,
    @Query('view_at') int viewAt,
    @Query('business') String business,
    @Query('ps') int ps,
  );
}
