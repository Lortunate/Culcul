import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/data/models/response/api_response.dart';
import 'package:culcul/data/models/feed/ranking_response.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'ranking_api.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class RankingApi {
  factory RankingApi(Dio dio, {String baseUrl}) = _RankingApi;

  @GET(ApiConstants.ranking)
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<RankingResponse>> fetchRanking({
    @Query('rid') int? rid,
  });
}
