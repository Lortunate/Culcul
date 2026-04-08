part of 'dynamic_repository_impl.dart';

mixin _DynamicRepositoryCommentApis on _DynamicRepositoryAccess {
  Future<Result<CommentResponse, AppError>> getComments(
    DynamicItem post, {
    CommentSort sort = CommentSort.hot,
    int page = 1,
  }) {
    final target = _resolveDynamicCommentTarget(post);

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
  }) {
    final target = _resolveDynamicCommentTarget(post);

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
  }) {
    final target = _resolveDynamicCommentTarget(post);

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
}
