import 'package:culcul/features/search/data/dtos/default_search.dart';
import 'package:culcul/features/search/data/dtos/search_result.dart';
import 'package:culcul/features/search/data/dtos/search_suggestion.dart';
import 'package:culcul/core/contracts/search_result_contract.dart';

extension DefaultSearchDataMapper on DefaultSearchData {
  String toDomain() => showName;
}

extension SearchSuggestionTagMapper on SearchSuggestionTag {
  String? toDomain() {
    final displayValue = value ?? term ?? '';
    if (displayValue.isEmpty) return null;
    return displayValue;
  }
}

extension SearchResultDataMapper on SearchResultData {
  SearchResultPage toDomain() {
    return SearchResultPage(
      page: page,
      numPages: numPages,
      items: result.map((item) => item.toDomain()).toList(),
    );
  }
}

extension SearchResultItemMapper on SearchResultItem {
  SearchResultEntry toDomain() {
    return when(
      video:
          (
            type,
            title,
            author,
            pic,
            bvid,
            duration,
            play,
            view,
            videoReview,
            danmaku,
            favorites,
            review,
            pubdate,
            typename,
            arcurl,
          ) => SearchVideoEntry(
            bvid: bvid ?? '',
            title: title ?? '',
            author: author ?? '',
            coverUrl: pic ?? '',
            durationText: duration ?? '',
            typeName: typename ?? '',
            playCount: play,
            viewCount: view,
            videoReviewCount: videoReview,
            danmakuCount: danmaku,
          ),
      user: (type, uname, upic, upicUrl, usign, fans, videos, level, mid) =>
          SearchUserEntry(
            mid: mid ?? 0,
            name: uname ?? '',
            avatarUrl: upic ?? upicUrl ?? '',
            sign: usign,
            fans: fans,
            videos: videos,
          ),
      bangumi:
          (
            type,
            title,
            cover,
            pic,
            seasonId,
            pgcSeasonId,
            seasonTypeName,
            areas,
            styles,
            label,
            gotoUrl,
          ) => SearchBangumiEntry(
            title: title ?? '',
            coverUrl: cover ?? pic ?? '',
            seasonTypeName: seasonTypeName ?? '',
            areas: areas ?? '',
            styles: styles ?? '',
            label: label,
          ),
      article: (type, title, imageUrls, author, uname, view, review, pubTime) =>
          SearchArticleEntry(
            title: title ?? '',
            imageUrls: imageUrls ?? const [],
            author: author ?? uname ?? '',
            viewCount: view,
            reviewCount: review,
          ),
      topic: (type, title, description, cover, tpId, arcurl, author, update) =>
          SearchTopicEntry(
            topicId: tpId ?? 0,
            title: title ?? '',
            description: description,
            coverUrl: cover,
            updateCount: update,
          ),
    );
  }
}
