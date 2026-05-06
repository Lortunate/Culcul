import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/shared/network/models/api_response.dart';
import 'package:culcul/features/ranking/data/dtos/ranking_response_dto.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'ranking_api.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class RankingApi {
  factory RankingApi(Dio dio, {String baseUrl}) = _RankingApi;

  @GET(ApiConstants.ranking)
  @Headers({'x-bili-wbi': 'true'})
  Future<ApiResponse<RankingResponseDto>> fetchRanking({@Query('rid') int? rid});
}
