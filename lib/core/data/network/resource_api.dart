import 'package:culcul/core/data/network/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod/riverpod.dart';

part 'resource_api.g.dart';

final basicResourceApiProvider = Provider<ResourceApi>(
  (ref) => ResourceApi(ref.watch(basicDioProvider)),
);

@RestApi()
abstract class ResourceApi {
  factory ResourceApi(Dio dio, {String baseUrl}) = _ResourceApi;

  @GET('/x/web-interface/nav')
  Future<dynamic> fetchNav();

  @GET('{url}')
  Future<dynamic> fetchJson(@Path('url') String url);

  @GET('{url}')
  @DioResponseType(ResponseType.bytes)
  Future<List<int>> fetchBytes(@Path('url') String url);
}
