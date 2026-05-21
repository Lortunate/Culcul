import 'package:culcul/core/contracts/relation_port.dart';
import 'package:culcul/core/contracts/relation_user_contract.dart';
import 'package:culcul/core/data/network/api_response_decoder.dart';
import 'package:culcul/core/data/network/dio_client.dart';
import 'package:culcul/core/data/network/models/api_response.dart';
import 'package:culcul/core/data/network/request_executor.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'relation_service.g.dart';

@Riverpod(keepAlive: true)
RelationPort relationPort(Ref ref) {
  return RelationService(ref.watch(dioClientProvider));
}

class RelationService implements RelationPort {
  static const int defaultPageSize = 50;

  final Dio _dio;
  final RequestExecutor _requestExecutor;

  RelationService(this._dio, {RequestExecutor? requestExecutor})
    : _requestExecutor = requestExecutor ?? const RequestExecutor();

  @override
  Future<Result<List<ProfileRelationUser>, AppError>> getFollowings(
    int vmid, {
    int page = 1,
  }) {
    return _getRelationUsers('/x/relation/followings', vmid: vmid, page: page);
  }

  @override
  Future<Result<List<ProfileRelationUser>, AppError>> getFollowers(
    int vmid, {
    int page = 1,
  }) {
    return _getRelationUsers('/x/relation/followers', vmid: vmid, page: page);
  }

  @override
  Future<Result<void, AppError>> modifyRelation({
    required int mid,
    required bool isFollow,
  }) {
    return _requestExecutor.runUnit(
      () => _postApiResponse(
        '/x/relation/modify',
        data: <String, dynamic>{'fid': mid, 'act': isFollow ? 1 : 2, 're_src': 11},
        headers: const <String, Object>{
          'content-type': 'application/x-www-form-urlencoded',
          'x-bili-csrf': 'true',
        },
      ),
    );
  }

  Future<Result<List<ProfileRelationUser>, AppError>> _getRelationUsers(
    String path, {
    required int vmid,
    required int page,
  }) {
    return _requestExecutor.runApi<List<ProfileRelationUser>, Map<String, dynamic>>(
      () => _getApiResponse(
        path,
        queryParameters: <String, dynamic>{
          'vmid': vmid,
          'pn': page,
          'ps': defaultPageSize,
        },
      ),
      transform: _parseRelationUsers,
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> _getApiResponse(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      path,
      queryParameters: queryParameters,
    );
    return decodeApiResponse(response, _asMap, nullBody: const <String, dynamic>{});
  }

  Future<ApiResponse<dynamic>> _postApiResponse(
    String path, {
    Map<String, dynamic>? data,
    Map<String, Object>? headers,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      path,
      data: data,
      options: Options(headers: headers),
    );
    return decodeApiResponse(
      response,
      (json) => json,
      nullBody: const <String, dynamic>{},
    );
  }

  List<ProfileRelationUser> _parseRelationUsers(Map<String, dynamic> data) {
    final list = data['list'];
    if (list is! List) {
      return const <ProfileRelationUser>[];
    }

    return list.map((item) => _parseRelationUser(_asMap(item))).toList(growable: false);
  }

  ProfileRelationUser _parseRelationUser(Map<String, dynamic> json) {
    final officialVerifyJson = json['official_verify'];
    final vipJson = json['vip'];
    return ProfileRelationUser(
      mid: _readInt(json['mid']),
      uname: _readString(json['uname']),
      face: _readString(json['face']),
      sign: _readString(json['sign']),
      attribute: _readInt(json['attribute']),
      officialVerify: officialVerifyJson is Map
          ? OfficialVerify.fromJson(_asMap(officialVerifyJson))
          : null,
      vip: vipJson is Map ? VipInfo.fromJson(_asMap(vipJson)) : null,
      mtime: _readInt(json['mtime']),
      special: _readInt(json['special']),
    );
  }

  Map<String, dynamic> _asMap(Object? value) {
    if (value is Map<String, dynamic>) {
      return value;
    }
    if (value is Map) {
      return Map<String, dynamic>.from(value);
    }
    return const <String, dynamic>{};
  }

  int _readInt(Object? value) {
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  String _readString(Object? value) {
    return value?.toString() ?? '';
  }
}
