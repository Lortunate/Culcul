part of 'dynamic_repository_impl.dart';

_DynamicCommentTarget _resolveDynamicCommentTarget(DynamicItem post) {
  String? referer;
  if (post.type == 'DYNAMIC_TYPE_ARTICLE') {
    referer = _extractDynamicArticleUrl(post);
  }
  referer ??= post.linkCard?.url;
  if (referer == null || referer.isEmpty) {
    referer = 'https://www.bilibili.com/';
  }

  if (post.commentId != null && post.commentType != null) {
    return _DynamicCommentTarget(
      oid: post.commentId!,
      type: post.commentType!,
      referer: referer,
    );
  }

  if (post.type == 'DYNAMIC_TYPE_AV') {
    if (post.videoContent != null) {
      return _DynamicCommentTarget(
        oid: post.videoContent!.aid ?? '0',
        type: 1,
        referer: referer,
      );
    }
  } else if (post.type == 'DYNAMIC_TYPE_DRAW' ||
      post.type == 'DYNAMIC_TYPE_WORD' ||
      post.type == 'DYNAMIC_TYPE_FORWARD') {
    int type = 17;
    if (post.type == 'DYNAMIC_TYPE_DRAW') type = 11;
    return _DynamicCommentTarget(oid: post.id, type: type, referer: referer);
  } else if (post.type == 'DYNAMIC_TYPE_ARTICLE') {
    final articleOid = _extractDynamicArticleOid(post);
    if (articleOid != null) {
      return _DynamicCommentTarget(oid: articleOid, type: 12, referer: referer);
    }
  }

  return _DynamicCommentTarget(oid: post.id, type: 17, referer: referer);
}

String? _extractDynamicArticleUrl(DynamicItem post) {
  final candidate =
      post.linkCard?.url ??
      post.modules.moduleDynamic.major?.article?.jumpUrl ??
      post.modules.moduleDynamic.major?.opus?.jumpUrl ??
      '';
  if (candidate.isEmpty) return null;

  final uri = Uri.tryParse(candidate);
  if (uri == null) return candidate;
  final articleId = ArticleDetailParser.extractArticleId(uri);
  if (articleId == null) return candidate;
  return 'https://www.bilibili.com/read/cv$articleId/';
}

String? _extractDynamicArticleOid(DynamicItem post) {
  final candidate =
      post.linkCard?.url ??
      post.modules.moduleDynamic.major?.article?.jumpUrl ??
      post.modules.moduleDynamic.major?.opus?.jumpUrl ??
      '';
  final uri = candidate.isNotEmpty ? Uri.tryParse(candidate) : null;

  if (uri != null) {
    final articleId = ArticleDetailParser.extractArticleId(uri);
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

class _DynamicCommentTarget {
  final String oid;
  final int type;
  final String? referer;

  const _DynamicCommentTarget({
    required this.oid,
    required this.type,
    required this.referer,
  });
}
