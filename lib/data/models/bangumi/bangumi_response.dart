import 'package:freezed_annotation/freezed_annotation.dart';

part 'bangumi_response.freezed.dart';
part 'bangumi_response.g.dart';

@Freezed(genericArgumentFactories: true)
abstract class BangumiApiResponse<T> with _$BangumiApiResponse<T> {
  const factory BangumiApiResponse({
    required int code,
    required String message,
    T? result,
  }) = _BangumiApiResponse;

  factory BangumiApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$BangumiApiResponseFromJson(json, fromJsonT);
}
