import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/core/data/network/models/api_response.dart';
import 'package:culcul/features/dynamic/data/dtos/dynamic_dtos.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'emote_api.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class EmoteApi {
  factory EmoteApi(Dio dio, {String baseUrl}) = _EmoteApi;

  @GET('/x/emote/user/panel/web')
  Future<ApiResponse<EmoteResponse>> getUserEmotes({
    @Query('business') String business = 'dynamic',
  });
}
