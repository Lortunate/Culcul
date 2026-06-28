import 'package:culcul/core/models/relation_user_contract.dart';
import 'package:culcul/core/data/network/api_response_decoder.dart';
import 'package:culcul/core/data/network/dio_client.dart';
import 'package:culcul/core/data/network/request_executor.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/utils/json_utils.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'relation_api.g.dart';

@Riverpod(keepAlive: true)
RelationApi relationService(Ref ref) {
  return RelationApi(ref.watch(dioClientProvider));
}

class RelationApi {
  static const int defaultPageSize = 50;

  final Dio _dio;
  final RequestExecutor _requestExecutor;

  RelationApi(this._dio, {RequestExecutor? requestExecutor})
    : _requestExecutor = requestExecutor ?? const RequestExecutor();

  Future<Result<List<ProfileRelationUser>, AppError>> getFollowings(
    int vmid, {
    int page = 1,
  }) {
    return _getRelationUsers('/x/relation/followings', vmid: vmid, page: page);
  }

  Future<Result<List<ProfileRelationUser>, AppError>> getFollowers(
    int vmid, {
    int page = 1,
  }) {
    return _getRelationUsers('/x/relation/followers', vmid: vmid, page: page);
  }

  Future<Result<void, AppError>> modifyRelation({
    required int mid,
    required bool isFollow,
  }) {
    return _requestExecutor.runUnit(() async {
      final response = await _dio.post<Map<String, dynamic>>(
        '/x/relation/modify',
        data: <String, dynamic>{'fid': mid, 'act': isFollow ? 1 : 2, 're_src': 11},
        options: Options(
          headers: const <String, Object>{
            'content-type': 'application/x-www-form-urlencoded',
            'x-bili-csrf': 'true',
          },
        ),
      );
      return decodeApiResponse(
        response,
        (json) => json,
        nullBody: const <String, dynamic>{},
      );
    });
  }

  Future<Result<List<ProfileRelationUser>, AppError>> _getRelationUsers(
    String path, {
    required int vmid,
    required int page,
  }) {
    return _requestExecutor.runApi<List<ProfileRelationUser>, Map<String, dynamic>>(
      () async {
        final response = await _dio.get<Map<String, dynamic>>(
          path,
          queryParameters: <String, dynamic>{
            'vmid': vmid,
            'pn': page,
            'ps': defaultPageSize,
          },
        );
        return decodeApiResponse(
          response,
          (json) => JsonUtils.asStringKeyedMap(json) ?? const <String, dynamic>{},
          nullBody: const <String, dynamic>{},
        );
      },
      transform: (data) {
        final list = data['list'];
        if (list is! List) {
          return const <ProfileRelationUser>[];
        }
        return list
            .map((item) {
              final json = JsonUtils.asStringKeyedMap(item) ?? const <String, dynamic>{};
              final officialVerifyJson = json['official_verify'];
              final vipJson = json['vip'];
              return ProfileRelationUser(
                mid: JsonUtils.parseIntWithDefault(json['mid']),
                uname: JsonUtils.parseStringWithDefault(json['uname']),
                face: JsonUtils.parseStringWithDefault(json['face']),
                sign: JsonUtils.parseStringWithDefault(json['sign']),
                attribute: JsonUtils.parseIntWithDefault(json['attribute']),
                officialVerify: officialVerifyJson is Map
                    ? OfficialVerify.fromJson(
                        JsonUtils.asStringKeyedMap(officialVerifyJson) ??
                            const <String, dynamic>{},
                      )
                    : null,
                vip: vipJson is Map
                    ? VipInfo.fromJson(
                        JsonUtils.asStringKeyedMap(vipJson) ?? const <String, dynamic>{},
                      )
                    : null,
                mtime: JsonUtils.parseIntWithDefault(json['mtime']),
                special: JsonUtils.parseIntWithDefault(json['special']),
              );
            })
            .toList(growable: false);
      },
    );
  }
}
