import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/data/models/response/api_response.dart';
import 'package:culcul/data/models/subscription_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'subscription_api.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class SubscriptionApi {
  factory SubscriptionApi(Dio dio, {String baseUrl}) = _SubscriptionApi;

  @GET('/subscriptions/current')
  Future<ApiResponse<SubscriptionModel>> getCurrentSubscription();

  @GET('/subscriptions/history')
  Future<ApiResponse<List<SubscriptionModel>>> getSubscriptionHistory();

  @POST('/subscriptions/subscribe')
  @Headers({'x-bili-csrf': 'true'})
  Future<ApiResponse<SubscriptionModel>> subscribe(
    @Body() Map<String, dynamic> body,
  );

  @POST('/subscriptions/{id}/cancel')
  @Headers({'x-bili-csrf': 'true'})
  Future<ApiResponse<void>> cancelSubscription(
    @Path('id') String subscriptionId,
  );

  @POST('/subscriptions/{id}/renew')
  @Headers({'x-bili-csrf': 'true'})
  Future<ApiResponse<SubscriptionModel>> renewSubscription(
    @Path('id') String subscriptionId,
  );
}
