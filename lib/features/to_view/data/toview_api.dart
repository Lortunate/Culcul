import 'package:culcul/core/network/models/api_response.dart';
import 'package:culcul/features/to_view/models/to_view_models.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'toview_api.g.dart';

@RestApi()
abstract class ToViewApi {
  factory ToViewApi(Dio dio, {String baseUrl}) = _ToViewApi;

  @GET('/x/v2/history/toview')
  Future<ApiResponse<ToViewListResponse>> getToViewList();

  @POST('/x/v2/history/toview/add')
  @FormUrlEncoded()
  @Headers({'x-bili-csrf': 'true'})
  Future<void> addToView(@Field('aid') int aid);

  @POST('/x/v2/history/toview/del')
  @FormUrlEncoded()
  @Headers({'x-bili-csrf': 'true'})
  Future<void> deleteToView(@Field('aid') int aid);

  @POST('/x/v2/history/toview/clear')
  @Headers({'x-bili-csrf': 'true'})
  Future<void> clearToView();
}
