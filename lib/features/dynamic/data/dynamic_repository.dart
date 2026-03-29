import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/providers/cookie_jar_provider.dart';
import 'package:culcul/core/base_repository.dart';
import 'package:culcul/data/api/dynamic_api.dart';
import 'package:culcul/data/network/dio_client.dart';
import 'package:culcul/features/dynamic/data/article_detail_data.dart';
import 'package:culcul/data/models/comment/comment_model.dart';
import 'package:culcul/data/models/dynamic/dynamic_extension.dart';
import 'package:culcul/data/models/dynamic/dynamic_response.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dynamic_repository.g.dart';

@riverpod
DynamicRepository dynamicRepository(Ref ref) {
  return DynamicRepository(
    ref.watch(dynamicApiProvider),
    ref.watch(dioClientProvider),
    ref.watch(cookieJarProvider),
  );
}

class DynamicRepository extends BaseRepository {
  final DynamicApi _api;
  final Dio _dio;
  final CookieJar _cookieJar;

  DynamicRepository(this._api, this._dio, this._cookieJar);

  Future<String?> _getCsrfToken() async {
    final cookies = await _cookieJar.loadForRequest(Uri.parse('https://bilibili.com'));
    for (var cookie in cookies) {
      if (cookie.name == 'bili_jct') {
        return cookie.value;
      }
    }
    return null;
  }

  Future<CommentResponse> getComments(
    DynamicItem post, {
    int sort = 1,
    int page = 1,
  }) async {
    final params = _getCommentParams(post);
    if (params == null) {
      throw const UnknownException('Unsupported dynamic type for comments');
    }

    return getCommentList(
      oid: params['oid'] as String,
      type: params['type'] as int,
      sort: sort,
      page: page,
      referer: _getCommentReferer(post),
    );
  }

  Future<CommentItem> addReply({
    required DynamicItem post,
    required String message,
    required int root,
    required int parent,
  }) async {
    final params = _getCommentParams(post);
    if (params == null) {
      throw const UnknownException('Unsupported dynamic type for comments');
    }

    return addCommentReply(
      oid: params['oid'] as String,
      type: params['type'] as int,
      root: root,
      parent: parent,
      message: message,
      referer: _getCommentReferer(post),
    );
  }

  Future<void> likeComment({
    required DynamicItem post,
    required int rpid,
    required bool isLiked,
  }) async {
    final params = _getCommentParams(post);
    if (params == null) {
      throw const UnknownException('Unsupported dynamic type for comments');
    }

    return likeCommentByTarget(
      oid: params['oid'] as String,
      type: params['type'] as int,
      rpid: rpid,
      isLiked: isLiked,
      referer: _getCommentReferer(post),
    );
  }

  Future<CommentResponse> getCommentList({
    required String oid,
    required int type,
    int sort = 1,
    int page = 1,
    String? referer,
  }) {
    return requestApi(
      () => _api.getComments(
        oid: oid,
        type: type,
        sort: sort,
        pn: page,
        ps: 20,
        referer: referer,
        origin: referer == null ? null : 'https://www.bilibili.com',
      ),
    );
  }

  Future<CommentResponse> getArticleCommentList({
    required String oid,
    int mode = 3,
    int? next,
    String? referer,
  }) {
    return requestApi(
      () => _api.getArticleComments(
        oid: oid,
        mode: mode,
        next: next,
        referer: referer,
        origin: referer == null ? null : 'https://www.bilibili.com',
      ),
    );
  }

  Future<CommentItem> addCommentReply({
    required String oid,
    required int type,
    required int root,
    required int parent,
    required String message,
    String? referer,
  }) {
    return requestApi(
      () => _api.addReply(
        oid: oid,
        type: type,
        root: root,
        parent: parent,
        message: message,
        referer: referer,
        origin: referer == null ? null : 'https://www.bilibili.com',
      ),
    );
  }

  Future<void> likeCommentByTarget({
    required String oid,
    required int type,
    required int rpid,
    required bool isLiked,
    String? referer,
  }) {
    return requestVoid(
      () => _api.actionComment(
        oid: oid,
        type: type,
        rpid: rpid,
        action: isLiked ? 1 : 0,
        referer: referer,
        origin: referer == null ? null : 'https://www.bilibili.com',
      ),
    );
  }

  Map<String, dynamic>? _getCommentParams(DynamicItem post) {
    if (post.commentId != null && post.commentType != null) {
      return {'oid': post.commentId!, 'type': post.commentType!};
    }

    if (post.type == 'DYNAMIC_TYPE_AV') {
      if (post.videoContent != null) {
        // Use AID as oid, type 1
        return {'oid': post.videoContent!.aid ?? '0', 'type': 1};
      }
    } else if (post.type == 'DYNAMIC_TYPE_DRAW' ||
        post.type == 'DYNAMIC_TYPE_WORD' ||
        post.type == 'DYNAMIC_TYPE_FORWARD') {
      // Use dynamic ID (parsed) as oid, type 11 (draw) or 17 (word/forward)
      int type = 17;
      if (post.type == 'DYNAMIC_TYPE_DRAW') type = 11;
      return {'oid': post.id, 'type': type};
    } else if (post.type == 'DYNAMIC_TYPE_ARTICLE') {
      final articleOid = _extractArticleOid(post);
      if (articleOid != null) {
        return {'oid': articleOid, 'type': 12};
      }
    }

    // Fallback: try parsing ID and assume type 17 (most common for modern dynamics)
    return {'oid': post.id, 'type': 17};
  }

  String? _getCommentReferer(DynamicItem post) {
    if (post.type == 'DYNAMIC_TYPE_ARTICLE') {
      final articleUrl = _extractArticleUrl(post);
      if (articleUrl != null) return articleUrl;
    }

    final linkCardUrl = post.linkCard?.url;
    if (linkCardUrl != null && linkCardUrl.isNotEmpty) {
      return linkCardUrl;
    }

    return 'https://www.bilibili.com/';
  }

  String? _extractArticleUrl(DynamicItem post) {
    final candidate =
        post.linkCard?.url ??
        post.modules.moduleDynamic.major?.article?.jumpUrl ??
        post.modules.moduleDynamic.major?.opus?.jumpUrl ??
        '';
    if (candidate.isEmpty) return null;

    final uri = Uri.tryParse(candidate);
    if (uri == null) return candidate;
    final articleId = _extractArticleId(uri);
    if (articleId == null) return candidate;
    return 'https://www.bilibili.com/read/cv$articleId/';
  }

  String? _extractArticleOid(DynamicItem post) {
    final candidate =
        post.linkCard?.url ??
        post.modules.moduleDynamic.major?.article?.jumpUrl ??
        post.modules.moduleDynamic.major?.opus?.jumpUrl ??
        '';
    final uri = candidate.isNotEmpty ? Uri.tryParse(candidate) : null;

    if (uri != null) {
      final articleId = _extractArticleId(uri);
      if (articleId != null) {
        return articleId.toString();
      }
    }

    if (post.id.isNotEmpty) {
      final articleId = int.tryParse(post.id);
      if (articleId != null) {
        return articleId.toString();
      }
    }

    return null;
  }

  Future<DynamicData> getFeed({String? type, String? offset, int page = 1}) {
    return requestApi(() => _api.getDynamicFeed(type: type, offset: offset, page: page));
  }

  Future<DynamicData> getSpaceDynamicFeed({required int hostMid, String? offset}) {
    return requestApi(() => _api.getSpaceDynamicFeed(hostMid: hostMid, offset: offset));
  }

  Future<DynamicData> getTopicFeed({required int topicId, String? offset}) {
    return requestApi(() => _api.getTopicFeed(topicId: topicId, offset: offset));
  }

  Future<DynamicItem> getDetail(String id) async {
    final data = await requestApi(() => _api.getDynamicDetail(id: id));
    return data.item;
  }

  Future<ArticleDetailData> getArticleDetail(String url) async {
    final uri = Uri.parse(url);
    if (uri.path.contains('/opus/')) {
      return _getOpusDetail(uri);
    }

    if (uri.path.contains('/read/cv')) {
      return _getReadArticleDetail(uri);
    }

    throw const UnknownException('Unsupported article url');
  }

  Future<ArticleDetailData> _getReadArticleDetail(Uri uri) async {
    final articleId = _extractArticleId(uri);
    if (articleId == null) {
      throw const UnknownException('Invalid article url');
    }

    final response = await _dio.get<Map<String, dynamic>>(
      '/x/article/view',
      queryParameters: {'id': articleId},
      options: Options(
        headers: {'Referer': uri.toString(), 'Origin': 'https://www.bilibili.com'},
      ),
    );

    final payload = response.data ?? const <String, dynamic>{};
    if (payload['code'] != 0) {
      throw ServerException(payload['message']?.toString() ?? 'Failed to load article');
    }

    final data = payload['data'];
    if (data is! Map<String, dynamic>) {
      throw const UnknownException('Invalid article payload');
    }

    return ArticleDetailData.fromArticleView(sourceUri: uri, data: data);
  }

  Future<ArticleDetailData> _getOpusDetail(Uri uri) async {
    final response = await _dio.get<String>(
      uri.toString(),
      options: Options(
        responseType: ResponseType.plain,
        headers: {
          'Referer': uri.toString(),
          'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
        },
      ),
    );

    final html = response.data ?? '';
    final initialState = _extractInitialState(html);
    if (initialState == null) {
      throw const UnknownException('Failed to parse article page');
    }

    return ArticleDetailData.fromOpusState(sourceUri: uri, state: initialState);
  }

  Map<String, dynamic>? _extractInitialState(String html) {
    final match = RegExp(
      r'window\.__INITIAL_STATE__\s*=\s*(\{.*?\})\s*;\s*\(function',
      dotAll: true,
    ).firstMatch(html);
    if (match == null) return null;

    try {
      final data = match.group(1);
      if (data == null || data.isEmpty) return null;
      final decoded = jsonDecode(data);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return decoded.cast<String, dynamic>();
    } catch (_) {
      return null;
    }
    return null;
  }

  int? _extractArticleId(Uri uri) {
    final path = uri.path;
    final match = RegExp(r'/cv(\d+)').firstMatch(path);
    if (match != null) return int.tryParse(match.group(1)!);
    final opusMatch = RegExp(r'/opus/(\d+)').firstMatch(path);
    if (opusMatch != null) return int.tryParse(opusMatch.group(1)!);
    return int.tryParse(uri.queryParameters['id'] ?? '');
  }

  Future<void> likeDynamic(String id, bool like) async {
    // We wrap the whole block in safeCall to catch any errors during token retrieval
    return request(() async {
      final csrf = await _getCsrfToken();
      final response = await _api.likeDynamic(
        body: {'dyn_id_str': id, 'up': like ? 1 : 2},
        csrf: csrf ?? '',
      );
      if (!response.isSuccess) {
        throw ServerException(response.message, code: response.code);
      }
    });
  }

  Future<DynamicUploadImageData> uploadImage(File file) async {
    return requestApi(() async {
      final csrf = await _getCsrfToken();
      return _api.uploadImage(file: file, csrf: csrf ?? '');
    });
  }

  Future<void> publishDynamic({
    required String content,
    List<DynamicUploadImageData> images = const [],
  }) async {
    return request(() async {
      final csrf = await _getCsrfToken();

      // Construct dyn_req
      final List<Map<String, dynamic>> contents = [];
      contents.add({'raw_text': content, 'type': 1, 'biz_id': ''});

      final List<Map<String, dynamic>> pics = [];
      for (var img in images) {
        pics.add({
          'img_src': img.imageUrl,
          'img_width': img.width,
          'img_height': img.height,
        });
      }

      final Map<String, dynamic> dynReq = {
        'content': {'contents': contents},
        'scene': images.isNotEmpty ? 2 : 1, // 1: text, 2: image
      };

      if (images.isNotEmpty) {
        dynReq['pics'] = pics;
      }

      final response = await _api.createDynamic(
        csrf: csrf ?? '',
        body: {'dyn_req': dynReq},
      );

      if (!response.isSuccess) {
        throw ServerException(response.message, code: response.code);
      }
    });
  }
}
