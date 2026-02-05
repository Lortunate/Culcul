import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/data/models/bangumi/bangumi_response.dart';
import 'package:culcul/data/models/bangumi/timeline_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'bangumi_api.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class BangumiApi {
  factory BangumiApi(Dio dio, {String baseUrl}) = _BangumiApi;

  @GET('/pgc/web/timeline')
  Future<BangumiApiResponse<List<TimelineResponse>>> fetchTimeline(
    @Query('types') int types,
    @Query('before') int before,
    @Query('after') int after,
  );
}
