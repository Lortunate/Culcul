import 'package:culcul/core/utils/json_utils.dart';
import 'package:culcul/core/utils/json_compute.dart';
import 'package:culcul/features/dynamic/domain/entities/article_detail_data.dart';
import 'package:html/dom.dart' as html_dom;
import 'package:html/parser.dart' as html_parser;

part 'article_detail_parser.mapper.dart';
part 'article_detail_parser.parser.dart';
part 'article_detail_parser.tokenizer.dart';

final _colorStyleRegex = RegExp(r'color:\s*([^;]+)', caseSensitive: false);
final _whitespaceRegex = RegExp(r'\s+');
final _fontSizeStyleRegex = RegExp(
  r'font-size:\s*(\d+(?:\.\d+)?)px',
  caseSensitive: false,
);

class ArticleDetailParser {
  static int? extractArticleId(Uri uri) => _extractArticleId(uri);

  static Future<Map<String, dynamic>?> extractInitialState(String html) async {
    final regex = RegExp(
      r'window\.__INITIAL_STATE__\s*=\s*(\{.*?\})\s*;\s*\(function',
      dotAll: true,
    );
    final match = regex.firstMatch(html);
    if (match == null) return null;

    try {
      final data = match.group(1);
      if (data == null || data.isEmpty) return null;
      final decoded = await jsonDecodeCompute(data);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return decoded.cast<String, dynamic>();
      return null;
    } catch (_) {
      return null;
    }
  }

  static ArticleDetailData fromArticleView({
    required Uri sourceUri,
    required Map<String, dynamic> data,
  }) {
    final author = _asMap(data['author']);
    final stats = _asMap(data['stats']);
    final content = (data['content'] ?? '').toString();
    final articleId = _extractArticleId(sourceUri);

    return ArticleDetailData(
      url: sourceUri.toString(),
      commentOid: articleId?.toString() ?? '',
      commentType: 12,
      title: _string(data['title']) ?? '',
      summary: _string(data['summary']) ?? '',
      bannerUrl: _string(data['banner_url']),
      authorName: _string(author['name']) ?? _string(data['author_name']) ?? '',
      authorMid:
          JsonUtils.parseInt(author['mid']) ?? JsonUtils.parseInt(data['mid']) ?? 0,
      authorAvatar: _string(author['face']) ?? '',
      publishTime: JsonUtils.parseInt(data['publish_time']) ?? 0,
      stats: ArticleStats(
        view: JsonUtils.parseInt(stats['view']) ?? 0,
        favorite: JsonUtils.parseInt(stats['favorite']) ?? 0,
        like: JsonUtils.parseInt(stats['like']) ?? 0,
        dislike: JsonUtils.parseInt(stats['dislike']) ?? 0,
        reply: JsonUtils.parseInt(stats['reply']) ?? 0,
        share: JsonUtils.parseInt(stats['share']) ?? 0,
        coin: JsonUtils.parseInt(stats['coin']) ?? 0,
        dynamicCount: JsonUtils.parseInt(stats['dynamic']) ?? 0,
      ),
      blocks: _parseHtmlContent(content),
    );
  }

  static ArticleDetailData fromOpusState({
    required Uri sourceUri,
    required Map<String, dynamic> state,
  }) {
    final detail = _asMap(state['detail']);
    final basic = _asMap(detail['basic']);
    final modules =
        (detail['modules'] as List?)?.cast<Map<String, dynamic>>() ?? const [];

    final title = _firstNonEmptyString([
      _string(basic['title']),
      _string(_findModule(modules, 'MODULE_TYPE_TITLE')['module_title']?['text']),
      _string(detail['title']),
    ]);

    final authorModule = _findModule(modules, 'MODULE_TYPE_AUTHOR');
    final authorData = _asMap(authorModule['module_author']);
    final topModule = _findModule(modules, 'MODULE_TYPE_TOP');
    final contentModule = _findModule(modules, 'MODULE_TYPE_CONTENT');
    final statModule = _findModule(modules, 'MODULE_TYPE_STAT');

    final topDisplay = _asMap(_asMap(topModule['module_top'])['display']);
    final album = _asMap(topDisplay['album']);
    final pics = (album['pics'] as List?)?.cast<Map<String, dynamic>>() ?? const [];
    final articleId = _extractArticleId(sourceUri);

    return ArticleDetailData(
      url: sourceUri.toString(),
      commentOid: articleId?.toString() ?? '',
      commentType: 12,
      title: title,
      summary: _string(detail['summary']) ?? _string(basic['summary']) ?? '',
      bannerUrl: _firstNonEmptyString([
        pics.isNotEmpty ? _string(pics.first['url']) : null,
      ]),
      authorName: _firstNonEmptyString([
        _string(authorData['name']),
        _string(basic['author_name']),
      ]),
      authorMid:
          JsonUtils.parseInt(authorData['mid']) ?? JsonUtils.parseInt(basic['uid']) ?? 0,
      authorAvatar: _firstNonEmptyString([
        _string(authorData['face']),
        _string(_asMap(authorData['avatar'])['face']),
      ]),
      publishTime:
          JsonUtils.parseInt(authorData['pub_ts']) ??
          JsonUtils.parseInt(_asMap(detail['pub_info'])['pub_time']) ??
          0,
      stats: ArticleStats(
        view:
            JsonUtils.parseInt(
              _asMap(_asMap(statModule['module_stat'])['view'])['count'],
            ) ??
            0,
        favorite:
            JsonUtils.parseInt(
              _asMap(_asMap(statModule['module_stat'])['favorite'])['count'],
            ) ??
            0,
        like:
            JsonUtils.parseInt(
              _asMap(_asMap(statModule['module_stat'])['like'])['count'],
            ) ??
            0,
        dislike:
            JsonUtils.parseInt(
              _asMap(_asMap(statModule['module_stat'])['dislike'])['count'],
            ) ??
            0,
        reply:
            JsonUtils.parseInt(
              _asMap(_asMap(statModule['module_stat'])['comment'])['count'],
            ) ??
            0,
        share:
            JsonUtils.parseInt(
              _asMap(_asMap(statModule['module_stat'])['forward'])['count'],
            ) ??
            0,
        coin:
            JsonUtils.parseInt(
              _asMap(_asMap(statModule['module_stat'])['coin'])['count'],
            ) ??
            0,
        dynamicCount: 0,
      ),
      blocks: _parseOpusBlocks(
        (contentModule['module_content'] as Map?)?.cast<String, dynamic>(),
      ),
    );
  }
}
