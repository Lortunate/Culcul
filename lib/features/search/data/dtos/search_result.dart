import 'package:culcul/shared/perf/list_perf_logger.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_result.freezed.dart';
part 'search_result.g.dart';

@freezed
sealed class SearchResultResponse with _$SearchResultResponse {
  const factory SearchResultResponse({
    required int code,
    required String message,
    required int ttl,
    SearchResultData? data,
  }) = _SearchResultResponse;

  factory SearchResultResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResultResponseFromJson(json);
}

@freezed
sealed class SearchResultData with _$SearchResultData {
  const factory SearchResultData({
    @JsonKey(name: 'seid') required String seid,
    @JsonKey(name: 'page') required int page,
    @JsonKey(name: 'pagesize') required int pageSize,
    @JsonKey(name: 'numResults') required int numResults,
    @JsonKey(name: 'numPages') required int numPages,
    @JsonKey(name: 'result')
    @_SearchResultConverter()
    @Default([])
    List<SearchResultItem> result,
  }) = _SearchResultData;

  factory SearchResultData.fromJson(Map<String, dynamic> json) =>
      _$SearchResultDataFromJson(json);
}

@Freezed(unionKey: 'type')
sealed class SearchResultItem with _$SearchResultItem {
  @FreezedUnionValue('video')
  const factory SearchResultItem.video({
    String? type,
    String? title,
    String? author,
    String? pic,
    String? bvid,
    String? duration,
    dynamic play,
    dynamic view,
    @JsonKey(name: 'video_review') int? videoReview,
    int? danmaku,
    int? favorites,
    int? review,
    int? pubdate,
    String? typename,
    String? arcurl,
  }) = SearchVideoModel;

  @FreezedUnionValue('bili_user')
  const factory SearchResultItem.user({
    String? type,
    String? uname,
    String? upic,
    @JsonKey(name: 'upic_url') String? upicUrl,
    String? usign,
    int? fans,
    int? videos,
    int? level,
    int? mid,
  }) = SearchUserModel;

  @FreezedUnionValue('media_bangumi')
  const factory SearchResultItem.bangumi({
    String? type,
    String? title,
    String? cover,
    String? pic,
    @JsonKey(name: 'season_id') int? seasonId,
    @JsonKey(name: 'pgc_season_id') int? pgcSeasonId,
    @JsonKey(name: 'season_type_name') String? seasonTypeName,
    String? areas,
    String? styles,
    String? label,
    @JsonKey(name: 'goto_url') String? gotoUrl,
  }) = SearchBangumiModel;

  @FreezedUnionValue('article')
  const factory SearchResultItem.article({
    String? type,
    String? title,
    @JsonKey(name: 'image_urls') List<String>? imageUrls,
    String? author,
    String? uname,
    dynamic view,
    int? review,
    @JsonKey(name: 'pub_time') int? pubTime,
  }) = SearchArticleModel;

  @FreezedUnionValue('topic')
  const factory SearchResultItem.topic({
    String? type,
    String? title,
    String? description,
    String? cover,
    @JsonKey(name: 'tp_id') int? tpId,
    @JsonKey(name: 'arcurl') String? arcurl,
    String? author,
    int? update,
  }) = SearchTopicModel;

  factory SearchResultItem.fromJson(Map<String, dynamic> json) =>
      _$SearchResultItemFromJson(json);
}

class _SearchResultConverter implements JsonConverter<List<SearchResultItem>, dynamic> {
  const _SearchResultConverter();

  static const Set<String> _supportedTypes = <String>{
    'video',
    'bili_user',
    'media_bangumi',
    'article',
    'topic',
  };

  @override
  List<SearchResultItem> fromJson(dynamic json) {
    final items = <SearchResultItem>[];
    var droppedUnknownTypeCount = 0;
    if (json is List) {
      for (final element in json) {
        if (element is Map<String, dynamic>) {
          if (element.containsKey('result_type') && element.containsKey('data')) {
            final type = element['result_type'] as String?;
            final dataList = element['data'] as List?;
            if (type != null && _supportedTypes.contains(type) && dataList != null) {
              for (final itemJson in dataList) {
                if (itemJson is Map<String, dynamic>) {
                  final map = Map<String, dynamic>.from(itemJson);
                  map['type'] = type;
                  try {
                    items.add(SearchResultItem.fromJson(map));
                  } catch (_) {
                    droppedUnknownTypeCount++;
                  }
                }
              }
            } else {
              droppedUnknownTypeCount += dataList?.length ?? 1;
            }
          } else {
            final type = element['type'] as String?;
            if (type == null || !_supportedTypes.contains(type)) {
              droppedUnknownTypeCount++;
              continue;
            }
            try {
              items.add(SearchResultItem.fromJson(element));
            } catch (_) {
              droppedUnknownTypeCount++;
            }
          }
        }
      }
    }

    if (droppedUnknownTypeCount > 0) {
      ListPerfLogger.log(
        ListPerfEvent.dropUnknownSearchType,
        fields: <String, Object?>{
          'source': 'search.result_converter',
          'count': droppedUnknownTypeCount,
        },
      );
    }
    return items;
  }

  @override
  dynamic toJson(List<SearchResultItem> object) => object.map((e) => e.toJson()).toList();
}
