import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/dio_client.dart';
import 'package:culcul/core/data/network/network_concurrency_executor.dart';
import 'package:culcul/core/data/network/network_concurrency_profiles.dart';
import 'package:culcul/core/perf/dev_logger.dart';
import 'package:culcul/core/data/network/request_executor.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/bootstrap/providers/cookie_jar_provider.dart';
import 'package:culcul/core/models/uploaded_image_contract.dart';
import 'package:culcul/features/video/comment_api.dart';
import 'package:culcul/features/dynamic/data/article_parsing/article_detail_parser.dart';
import 'package:culcul/features/dynamic/data/dynamic_api.dart';
import 'package:culcul/features/dynamic/models/article_detail_data.dart';
import 'package:culcul/features/dynamic/application/models/dynamic_response.dart';
import 'package:culcul/features/dynamic/application/models/dynamic_item_extensions.dart';
import 'package:culcul/core/models/comment_contract.dart';
import 'package:culcul/features/dynamic/models/dynamic_publish_command.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dynamic_repository_impl.comment.dart';
part 'dynamic_repository_impl.comment_target.dart';
part 'dynamic_repository_impl.feed.dart';
part 'dynamic_repository_impl.publish.dart';
part 'dynamic_repository_impl.g.dart';

@riverpod
DynamicRepositoryImpl dynamicRepository(Ref ref) {
  return DynamicRepositoryImpl(
    DynamicApi(ref.watch(dioClientProvider)),
    ref.watch(dioClientProvider),
    ref.watch(cookieJarProvider),
    commentService: ref.watch(commentServiceProvider),
  );
}

class DynamicRepositoryImpl
    with
        _DynamicRepositoryAccess,
        _DynamicRepositoryCommentApis,
        _DynamicRepositoryFeedApis,
        _DynamicRepositoryPublishApis {
  final DynamicApi _api;
  final Dio _dio;
  final CookieJar _cookieJar;
  final CommentApi _commentService;
  @override
  final RequestExecutor _requestExecutor;
  final NetworkConcurrencyExecutor _concurrencyExecutor;

  DynamicRepositoryImpl(
    this._api,
    this._dio,
    this._cookieJar, {
    required CommentApi commentService,
    RequestExecutor? requestExecutor,
    NetworkConcurrencyExecutor? concurrencyExecutor,
  }) : _commentService = commentService,
       _requestExecutor = requestExecutor ?? const RequestExecutor(),
       _concurrencyExecutor = concurrencyExecutor ?? const NetworkConcurrencyExecutor();

  @override
  DynamicApi get api => _api;

  @override
  Dio get dio => _dio;

  @override
  CookieJar get cookieJar => _cookieJar;

  @override
  CommentApi get sharedCommentApi => _commentService;

  @override
  NetworkConcurrencyExecutor get concurrencyExecutor => _concurrencyExecutor;
}

mixin _DynamicRepositoryAccess {
  DynamicApi get api;
  Dio get dio;
  CookieJar get cookieJar;
  CommentApi get sharedCommentApi;
  RequestExecutor get _requestExecutor;
  NetworkConcurrencyExecutor get concurrencyExecutor;
}
