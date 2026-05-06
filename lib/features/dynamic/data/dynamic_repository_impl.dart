import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/shared/network/dio_client.dart';
import 'package:culcul/shared/network/network_concurrency_executor.dart';
import 'package:culcul/shared/network/network_concurrency_profiles.dart';
import 'package:culcul/core/perf/feature_flow_perf_logger.dart';
import 'package:culcul/shared/network/request_executor.dart';
import 'package:culcul/shared/network/request_executor_binding.dart';
import 'package:culcul/core/bootstrap/providers/cookie_jar_provider.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/dynamic/data/article_detail_parser.dart';
import 'package:culcul/features/dynamic/data/dynamic_api.dart';
import 'package:culcul/features/dynamic/domain/entities/article_detail_data.dart';
import 'package:culcul/features/dynamic/domain/entities/dynamic_entities.dart';
import 'package:culcul/features/dynamic/domain/repositories/dynamic_repository.dart'
    as domain;
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dynamic_repository_impl.comment.dart';
part 'dynamic_repository_impl.comment_target.dart';
part 'dynamic_repository_impl.feed.dart';
part 'dynamic_repository_impl.publish.dart';
part 'dynamic_repository_impl.g.dart';

@riverpod
domain.DynamicRepository dynamicRepository(Ref ref) {
  return DynamicRepositoryImpl(
    DynamicApi(ref.watch(dioClientProvider)),
    ref.watch(dioClientProvider),
    ref.watch(cookieJarProvider),
  );
}

class DynamicRepositoryImpl
    with
        RequestExecutorBinding,
        _DynamicRepositoryAccess,
        _DynamicRepositoryCommentApis,
        _DynamicRepositoryFeedApis,
        _DynamicRepositoryPublishApis
    implements domain.DynamicRepository {
  final DynamicApi _api;
  final Dio _dio;
  final CookieJar _cookieJar;
  final RequestExecutor _requestExecutor;
  final NetworkConcurrencyExecutor _concurrencyExecutor;

  DynamicRepositoryImpl(
    this._api,
    this._dio,
    this._cookieJar, {
    RequestExecutor? requestExecutor,
    NetworkConcurrencyExecutor? concurrencyExecutor,
  }) : _requestExecutor = requestExecutor ?? const RequestExecutor(),
       _concurrencyExecutor = concurrencyExecutor ?? const NetworkConcurrencyExecutor();

  @override
  RequestExecutor get requestExecutor => _requestExecutor;

  @override
  DynamicApi get api => _api;

  @override
  Dio get dio => _dio;

  @override
  CookieJar get cookieJar => _cookieJar;

  @override
  NetworkConcurrencyExecutor get concurrencyExecutor => _concurrencyExecutor;
}

mixin _DynamicRepositoryAccess on RequestExecutorBinding {
  DynamicApi get api;
  Dio get dio;
  CookieJar get cookieJar;
  NetworkConcurrencyExecutor get concurrencyExecutor;
}
