import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/shared/network/models/api_response.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'auth_api.g.dart';

@RestApi(baseUrl: ApiConstants.passportBaseUrl)
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @GET(ApiConstants.captcha)
  Future<ApiResponse<dynamic>> getCaptcha();

  @GET('/web/generic/country/list')
  Future<ApiResponse<dynamic>> getCountryList();

  @POST(ApiConstants.smsSend)
  @FormUrlEncoded()
  Future<ApiResponse<dynamic>> sendSms(
    @Field('cid') int cid,
    @Field('tel') String phone,
    @Field('source') String source,
    @Field('token') String token,
    @Field('challenge') String challenge,
    @Field('validate') String validate,
    @Field('seccode') String seccode,
  );

  @GET('/x/passport-login/web/key')
  Future<ApiResponse<dynamic>> getKey();

  @POST('/x/passport-login/web/login')
  @FormUrlEncoded()
  Future<ApiResponse<dynamic>> loginWithPassword(
    @Field('username') String username,
    @Field('password') String password,
    @Field('keep') int keep,
    @Field('token') String token,
    @Field('challenge') String challenge,
    @Field('validate') String validate,
    @Field('seccode') String seccode,
    @Field('source') String source,
  );

  @POST(ApiConstants.smsLogin)
  @FormUrlEncoded()
  Future<ApiResponse<dynamic>> loginWithSms(
    @Field('cid') int cid,
    @Field('tel') String phone,
    @Field('code') String code,
    @Field('source') String source,
    @Field('captcha_key') String? captchaKey,
  );

  @GET(ApiConstants.qrGenerate)
  Future<ApiResponse<dynamic>> getQrCode();

  @GET(ApiConstants.qrPoll)
  Future<ApiResponse<dynamic>> pollQrCode(@Query('qrcode_key') String authCode);

  @POST('/login/exit/v2')
  @FormUrlEncoded()
  @Headers({'x-bili-csrf': 'true'})
  Future<ApiResponse<dynamic>> logout();

  @GET('${ApiConstants.baseUrl}${ApiConstants.userInfo}')
  Future<ApiResponse<dynamic>> getCurrentUser();
}
