import 'package:culcul/core/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'danmaku_api.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class DanmakuApi {
  factory DanmakuApi(Dio dio, {String baseUrl}) = _DanmakuApi;

  @GET('/x/v2/dm/web/seg.so')
  @DioResponseType(ResponseType.bytes)
  Future<List<int>> fetchDanmakuSegment({
    @Query('type') int type = 1,
    @Query('oid') required int oid,
    @Query('pid') required int pid,
    @Query('segment_index') required int segmentIndex,
  });

  @GET('/x/v2/dm/web/view')
  @DioResponseType(ResponseType.bytes)
  Future<List<int>> fetchDanmakuView({
    @Query('type') int type = 1,
    @Query('oid') required int oid,
    @Query('pid') required int pid,
  });
}

