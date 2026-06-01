import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/core/data/network/models/api_response.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'ranking_api.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class RankingApi {
  factory RankingApi(Dio dio, {String baseUrl}) = _RankingApi;

  @GET(ApiConstants.ranking)
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<Object>> fetchRanking({@Query('rid') int? rid});
}
