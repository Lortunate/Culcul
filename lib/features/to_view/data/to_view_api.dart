import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/core/data/network/models/api_response.dart';
import 'package:culcul/features/to_view/data/dtos/to_view_model_dto.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'to_view_api.g.dart';

@RestApi()
abstract class ToViewApi {
  factory ToViewApi(Dio dio, {String baseUrl}) = _ToViewApi;

  @GET(ApiConstants.toView)
  Future<ApiResponse<ToViewListResponseDto>> getToViewList();

  @POST(ApiConstants.toViewAdd)
  @FormUrlEncoded()
  @Headers({'x-bili-csrf': 'true'})
  Future<void> addToView(@Field('aid') int aid);

  @POST(ApiConstants.toViewDel)
  @FormUrlEncoded()
  @Headers({'x-bili-csrf': 'true'})
  Future<void> deleteToView(@Field('aid') int aid);

  @POST(ApiConstants.toViewClear)
  @Headers({'x-bili-csrf': 'true'})
  Future<void> clearToView();
}
