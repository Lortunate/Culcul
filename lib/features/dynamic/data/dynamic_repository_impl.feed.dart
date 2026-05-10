part of 'dynamic_repository_impl.dart';

mixin _DynamicRepositoryFeedApis on _DynamicRepositoryAccess {
  Future<Result<DynamicData, AppError>> getFeed(domain.DynamicFeedQuery query) {
    return requestApiResult(
      () => api.getDynamicFeed(type: query.type, offset: query.offset, page: 1),
    );
  }

  Future<Result<DynamicData, AppError>> getSpaceDynamicFeed(
    domain.SpaceDynamicFeedQuery query,
  ) {
    return requestApiResult(
      () => api.getSpaceDynamicFeed(
        hostMid: query.hostMid,
        offset: query.offset,
        forceRefresh: query.forceRefresh ? true : null,
        cancelToken: query.cancelToken?.dioToken,
      ),
    );
  }

  Future<Result<DynamicData, AppError>> getTopicFeed(domain.TopicDynamicFeedQuery query) {
    return requestApiResult(
      () => api.getTopicFeed(topicId: query.topicId, offset: query.offset),
    );
  }

  Future<Result<DynamicItem, AppError>> getDetail(String id) async {
    final result = await requestApiResult(() => api.getDynamicDetail(id: id));
    return result.map((data) => data.item);
  }

  Future<Result<ArticleDetailData, AppError>> getArticleDetail(String url) async {
    return requestResult(() async {
      final uri = Uri.parse(url);
      if (uri.path.contains('/opus/')) {
        return _getOpusDetail(uri);
      }

      if (uri.path.contains('/read/cv')) {
        return _getReadArticleDetail(uri);
      }

      throw const UnknownException('Unsupported article url');
    });
  }

  Future<ArticleDetailData> _getReadArticleDetail(Uri uri) async {
    final articleId = ArticleDetailParser.extractArticleId(uri);
    if (articleId == null) {
      throw const UnknownException('Invalid article url');
    }

    final requestStopwatch = Stopwatch()..start();
    final response = await dio.get<Map<String, dynamic>>(
      '/x/article/view',
      queryParameters: {'id': articleId},
      options: Options(
        headers: {'Referer': uri.toString(), 'Origin': 'https://www.bilibili.com'},
      ),
    );
    FeatureFlowPerfLogger.log(
      chain: 'dynamic.article_detail',
      stage: 'request',
      fields: <String, Object?>{
        'source': 'read',
        'articleId': articleId,
        'ms': requestStopwatch.elapsedMilliseconds,
      },
    );

    final parseStopwatch = Stopwatch()..start();
    final payload = response.data ?? const <String, dynamic>{};
    if (payload['code'] != 0) {
      throw ServerException(payload['message']?.toString() ?? 'Failed to load article');
    }

    final data = payload['data'];
    if (data is! Map<String, dynamic>) {
      throw const UnknownException('Invalid article payload');
    }
    final detail = ArticleDetailParser.fromArticleView(sourceUri: uri, data: data);
    FeatureFlowPerfLogger.log(
      chain: 'dynamic.article_detail',
      stage: 'parse',
      fields: <String, Object?>{
        'source': 'read',
        'articleId': articleId,
        'ms': parseStopwatch.elapsedMilliseconds,
        'blocks': detail.blocks.length,
      },
    );
    return detail;
  }

  Future<ArticleDetailData> _getOpusDetail(Uri uri) async {
    final requestStopwatch = Stopwatch()..start();
    final response = await dio.get<String>(
      uri.toString(),
      options: Options(
        responseType: ResponseType.plain,
        headers: {
          'Referer': uri.toString(),
          'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
        },
      ),
    );
    FeatureFlowPerfLogger.log(
      chain: 'dynamic.article_detail',
      stage: 'request',
      fields: <String, Object?>{
        'source': 'opus',
        'uri': uri.path,
        'ms': requestStopwatch.elapsedMilliseconds,
      },
    );

    final parseStopwatch = Stopwatch()..start();
    final html = response.data ?? '';
    final initialState = await ArticleDetailParser.extractInitialState(html);
    if (initialState == null) {
      throw const UnknownException('Failed to parse article page');
    }
    final detail = ArticleDetailParser.fromOpusState(sourceUri: uri, state: initialState);
    FeatureFlowPerfLogger.log(
      chain: 'dynamic.article_detail',
      stage: 'parse',
      fields: <String, Object?>{
        'source': 'opus',
        'uri': uri.path,
        'ms': parseStopwatch.elapsedMilliseconds,
        'blocks': detail.blocks.length,
      },
    );
    return detail;
  }
}
