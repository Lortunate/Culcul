part of 'dynamic_repository_impl.dart';

mixin _DynamicRepositoryCommentApis on _DynamicRepositoryAccess {
  Future<Result<CommentResponse, AppError>> getComments(
    DynamicItem post, {
    CommentSort sort = CommentSort.hot,
    int page = 1,
  }) async {
    final target = _resolveCommentTarget(post);
    if (target == null) {
      return Failure(AppError.data('Unsupported dynamic type for comments'));
    }

    return getCommentList(
      oid: target.oid,
      type: target.type,
      sort: sort,
      page: page,
      referer: target.referer,
    );
  }

  Future<Result<CommentItem, AppError>> addReply({
    required DynamicItem post,
    required String message,
    required int root,
    required int parent,
  }) async {
    final target = _resolveCommentTarget(post);
    if (target == null) {
      return Failure(AppError.data('Unsupported dynamic type for comments'));
    }

    return _addCommentReply(
      oid: target.oid,
      type: target.type,
      root: root,
      parent: parent,
      message: message,
      referer: target.referer,
    );
  }

  Future<Result<void, AppError>> likeComment({
    required DynamicItem post,
    required int rpid,
    required bool isLiked,
  }) async {
    final target = _resolveCommentTarget(post);
    if (target == null) {
      return Failure(AppError.data('Unsupported dynamic type for comments'));
    }

    return _likeCommentByTarget(
      oid: target.oid,
      type: target.type,
      rpid: rpid,
      isLiked: isLiked,
      referer: target.referer,
    );
  }

  Future<Result<CommentResponse, AppError>> getCommentList({
    required String oid,
    required int type,
    CommentSort sort = CommentSort.hot,
    int page = 1,
    String? referer,
  }) {
    return requestApiResult(
      () => api.getComments(
        oid: oid,
        type: type,
        sort: sort.apiValue,
        pn: page,
        ps: 20,
        referer: referer,
        origin: referer == null ? null : 'https://www.bilibili.com',
      ),
    );
  }

  Future<Result<CommentResponse, AppError>> getArticleCommentList({
    required ArticleDetailData article,
    int? next,
  }) {
    final referer = article.url;
    return requestApiResult(
      () => api.getArticleComments(
        oid: article.commentOid,
        mode: 3,
        next: next,
        referer: referer,
        origin: 'https://www.bilibili.com',
      ),
    );
  }

  Future<Result<CommentItem, AppError>> addArticleCommentReply({
    required ArticleDetailData article,
    required int root,
    required int parent,
    required String message,
  }) {
    return _addCommentReply(
      oid: article.commentOid,
      type: article.commentType,
      root: root,
      parent: parent,
      message: message,
      referer: article.url,
    );
  }

  Future<Result<CommentItem, AppError>> _addCommentReply({
    required String oid,
    required int type,
    required int root,
    required int parent,
    required String message,
    String? referer,
  }) {
    return requestApiResult(
      () => api.addReply(
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

  Future<Result<void, AppError>> likeArticleComment({
    required ArticleDetailData article,
    required int rpid,
    required bool isLiked,
  }) {
    return _likeCommentByTarget(
      oid: article.commentOid,
      type: article.commentType,
      rpid: rpid,
      isLiked: isLiked,
      referer: article.url,
    );
  }

  Future<Result<void, AppError>> _likeCommentByTarget({
    required String oid,
    required int type,
    required int rpid,
    required bool isLiked,
    String? referer,
  }) {
    return requestVoidResult(
      () => api.actionComment(
        oid: oid,
        type: type,
        rpid: rpid,
        action: isLiked ? 1 : 0,
        referer: referer,
        origin: referer == null ? null : 'https://www.bilibili.com',
      ),
    );
  }

  _DynamicCommentTarget? _resolveCommentTarget(DynamicItem post) {
    final referer = _getCommentReferer(post);
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
      final articleOid = _extractArticleOid(post);
      if (articleOid != null) {
        return _DynamicCommentTarget(oid: articleOid, type: 12, referer: referer);
      }
    }

    return _DynamicCommentTarget(oid: post.id, type: 17, referer: referer);
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
    final articleId = _extractArticleIdFromUri(uri);
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
      final articleId = _extractArticleIdFromUri(uri);
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
