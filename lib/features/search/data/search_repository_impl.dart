import 'dart:convert';

import 'package:culcul/core/errors/app_error.dart';
import 'package:dio/dio.dart';
import 'package:culcul/core/data/network/dio_client.dart';
import 'package:culcul/core/data/network/endpoint_policy.dart';
import 'package:culcul/core/data/network/request_executor.dart';
import 'package:culcul/core/perf/dev_logger.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/utils/json_utils.dart';
import 'package:culcul/features/search/data/search_api.dart';
import 'package:culcul/features/search/application/search_query.dart';
import 'package:culcul/features/search/application/search_result.dart';
import 'package:culcul/features/search/application/search_trending_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_repository_impl.g.dart';

@riverpod
SearchRepositoryImpl searchRepository(Ref ref) {
  return SearchRepositoryImpl(api: SearchApi(ref.watch(dioClientProvider)));
}

class SearchRepositoryImpl {
  final SearchApi api;
  final RequestExecutor _requestExecutor;

  SearchRepositoryImpl({
    required this.api,
    RequestExecutor requestExecutor = const RequestExecutor(),
  }) : _requestExecutor = requestExecutor;

  RequestExecutionOptions _requestOptions({
    required EndpointRequestClass requestClass,
    CancelToken? cancelToken,
  }) {
    return RequestExecutionOptions(requestClass: requestClass, cancelToken: cancelToken);
  }

  Future<Result<List<String>, AppError>> getSuggestions(
    String term, {
    CancelToken? cancelToken,
  }) async {
    if (term.isEmpty) return const Success(<String>[]);
    final options = _requestOptions(
      requestClass: EndpointRequestClass.search,
      cancelToken: cancelToken,
    );
    final result = await _requestExecutor.run(
      () => api.fetchSearchSuggestions(
        term,
        extras: options.toDioExtras(),
        cancelToken: cancelToken,
      ),
      options: options,
    );
    return result.map((responseStr) {
      try {
        // Intentionally synchronous: suggestion responses are small (<1KB)
        // and this runs inside result.map() which requires a sync callback.
        final json = JsonUtils.asStringKeyedMap(jsonDecode(responseStr));
        final result = JsonUtils.asStringKeyedMap(json?['result']);
        return JsonUtils.parseObjectList(result?['tag'])
            .map((tag) {
              final value = tag['value'];
              if (value is String) return value;
              final term = tag['term'];
              if (term is String) return term;
              return '';
            })
            .where((text) => text.isNotEmpty)
            .toList(growable: false);
      } catch (e) {
        return const <String>[];
      }
    });
  }

  Future<Result<String?, AppError>> getDefaultSearch({bool forceRefresh = false}) async {
    final options = _requestOptions(requestClass: EndpointRequestClass.search);
    final result = await _requestExecutor.runApiDirect(
      () => api.fetchDefaultSearch(
        forceRefresh: forceRefresh ? true : null,
        extras: options.toDioExtras(),
      ),
      options: options,
    );
    return result.map(
      (data) => JsonUtils.asStringKeyedMap(data)?['show_name'] as String?,
    );
  }

  Future<Result<List<SearchTrendingItem>, AppError>> getTrendingRanking({
    bool forceRefresh = false,
  }) async {
    final options = _requestOptions(requestClass: EndpointRequestClass.search);
    return _requestExecutor.runApi<List<SearchTrendingItem>, Object>(
      () => api.fetchTrendingRanking(
        forceRefresh: forceRefresh ? true : null,
        extras: options.toDioExtras(),
      ),
      transform: (data) {
        final map = JsonUtils.asStringKeyedMap(data);
        final list = map?['list'];
        return JsonUtils.parseObjectList(list).map(SearchTrendingItem.fromJson).toList();
      },
      options: options,
    );
  }

  Future<Result<SearchResultPage, AppError>> search({
    required SearchQuery query,
    CancelToken? cancelToken,
  }) async {
    final options = _requestOptions(
      requestClass: EndpointRequestClass.search,
      cancelToken: cancelToken,
    );
    return _requestExecutor.runApi<SearchResultPage, Object>(
      () => query.type == SearchType.all
          ? api.fetchSearchAll(
              keyword: query.keyword,
              page: query.page,
              searchType: query.type.apiValue,
              order: query.order.apiValue,
              duration: query.duration.apiValue,
              extras: options.toDioExtras(),
              cancelToken: cancelToken,
            )
          : api.fetchSearchByType(
              keyword: query.keyword,
              page: query.page,
              searchType: query.type.apiValue,
              order: query.order.apiValue,
              duration: query.duration.apiValue,
              extras: options.toDioExtras(),
              cancelToken: cancelToken,
            ),
      transform: _parseSearchResultPage,
      options: options,
    );
  }
}

SearchResultPage _parseSearchResultPage(Object data) {
  final map = JsonUtils.asStringKeyedMap(data);
  if (map == null) {
    throw const FormatException('Invalid search result response');
  }

  final page = JsonUtils.parseInt(map['page']);
  final numPages = JsonUtils.parseInt(map['numPages']);
  if (page == null || numPages == null) {
    throw const FormatException('Invalid search result pagination');
  }

  return SearchResultPage(
    page: page,
    numPages: numPages,
    items: _parseSearchResultEntries(map['result']),
  );
}

List<SearchResultEntry> _parseSearchResultEntries(Object? json) {
  final entries = <SearchResultEntry>[];
  var droppedUnknownTypeCount = 0;
  if (json is List) {
    for (final element in JsonUtils.parseObjectList(json)) {
      if (element.containsKey('result_type') && element.containsKey('data')) {
        final type = element['result_type'];
        final rawDataList = element['data'];
        if (type is String &&
            _supportedSearchResultTypes.contains(type) &&
            rawDataList is List) {
          for (final itemJson in rawDataList) {
            final item = JsonUtils.asStringKeyedMap(itemJson);
            if (item == null) {
              droppedUnknownTypeCount++;
              continue;
            }
            try {
              entries.add(_parseSearchResultEntry(type, item));
            } catch (_) {
              droppedUnknownTypeCount++;
            }
          }
        } else {
          droppedUnknownTypeCount += rawDataList is List ? rawDataList.length : 1;
        }
      } else {
        final type = element['type'];
        if (type is! String || !_supportedSearchResultTypes.contains(type)) {
          droppedUnknownTypeCount++;
          continue;
        }
        try {
          entries.add(_parseSearchResultEntry(type, element));
        } catch (_) {
          droppedUnknownTypeCount++;
        }
      }
    }
  }

  if (droppedUnknownTypeCount > 0) {
    DevLogger.log('list', 'drop_unknown_search_type', <String, Object?>{
      'source': 'search.result_converter',
      'count': droppedUnknownTypeCount,
    });
  }
  return entries;
}

const Set<String> _supportedSearchResultTypes = <String>{
  'video',
  'bili_user',
  'media_bangumi',
  'article',
  'topic',
};

SearchResultEntry _parseSearchResultEntry(String type, Map<String, dynamic> item) {
  return switch (type) {
    'video' => SearchVideoEntry(
      bvid: JsonUtils.parseStringWithDefault(item['bvid']),
      title: JsonUtils.parseStringWithDefault(item['title']),
      author: JsonUtils.parseStringWithDefault(item['author']),
      coverUrl: JsonUtils.parseStringWithDefault(item['pic']),
      durationText: JsonUtils.parseStringWithDefault(item['duration']),
      typeName: JsonUtils.parseStringWithDefault(item['typename']),
      playCount: item['play'],
      viewCount: item['view'],
      videoReviewCount: JsonUtils.parseInt(item['video_review']),
      danmakuCount: JsonUtils.parseInt(item['danmaku']),
    ),
    'bili_user' => SearchUserEntry(
      mid: JsonUtils.parseIntWithDefault(item['mid']),
      name: JsonUtils.parseStringWithDefault(item['uname']),
      avatarUrl: JsonUtils.parseStringWithDefault(
        item['upic'],
        JsonUtils.parseStringWithDefault(item['upic_url']),
      ),
      sign: item['usign'] as String?,
      fans: JsonUtils.parseInt(item['fans']),
      videos: JsonUtils.parseInt(item['videos']),
    ),
    'media_bangumi' => SearchBangumiEntry(
      title: JsonUtils.parseStringWithDefault(item['title']),
      coverUrl: JsonUtils.parseStringWithDefault(
        item['cover'],
        JsonUtils.parseStringWithDefault(item['pic']),
      ),
      seasonTypeName: JsonUtils.parseStringWithDefault(item['season_type_name']),
      areas: JsonUtils.parseStringWithDefault(item['areas']),
      styles: JsonUtils.parseStringWithDefault(item['styles']),
      label: item['label'] as String?,
    ),
    'article' => SearchArticleEntry(
      title: JsonUtils.parseStringWithDefault(item['title']),
      imageUrls: JsonUtils.parseStringListWithDefault(item['image_urls']),
      author: JsonUtils.parseStringWithDefault(
        item['author'],
        JsonUtils.parseStringWithDefault(item['uname']),
      ),
      viewCount: item['view'],
      reviewCount: JsonUtils.parseInt(item['review']),
    ),
    'topic' => SearchTopicEntry(
      topicId: JsonUtils.parseIntWithDefault(item['tp_id']),
      title: JsonUtils.parseStringWithDefault(item['title']),
      description: item['description'] as String?,
      coverUrl: item['cover'] as String?,
      updateCount: JsonUtils.parseInt(item['update']),
    ),
    _ => throw FormatException('Unsupported search result type: $type'),
  };
}
