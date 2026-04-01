import 'package:culcul/features/search/data/dtos/search_dtos.dart';
import 'package:culcul/features/search/domain/entities/search_default_hint.dart';
import 'package:culcul/core/contracts/search_result_contract.dart';
import 'package:culcul/features/search/domain/entities/search_suggestion_entry.dart';
import 'package:culcul/features/search/domain/entities/search_trending_keyword.dart';

extension DefaultSearchDataMapper on DefaultSearchData {
  SearchDefaultHint toDomain() => SearchDefaultHint(text: showName);
}

extension SearchSuggestionTagMapper on SearchSuggestionTag {
  SearchSuggestionEntry? toDomain() {
    final displayValue = value ?? term ?? '';
    if (displayValue.isEmpty) return null;
    return SearchSuggestionEntry(value: displayValue);
  }
}

extension TrendingItemMapper on TrendingItem {
  SearchTrendingKeyword toDomain() {
    return SearchTrendingKeyword(position: position, keyword: keyword, label: showName);
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
