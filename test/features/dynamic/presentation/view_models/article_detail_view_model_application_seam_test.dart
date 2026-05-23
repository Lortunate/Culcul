import 'package:cookie_jar/cookie_jar.dart';
import 'package:culcul/core/contracts/comment_contract.dart';
import 'package:culcul/core/contracts/relation_user_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/services/comment_service.dart';
import 'package:culcul/features/dynamic/application/article_detail_application_providers.dart';
import 'package:culcul/features/dynamic/application/article_detail_port.dart';
import 'package:culcul/features/dynamic/data/dynamic_api.dart';
import 'package:culcul/features/dynamic/data/dynamic_repository_impl.dart';
import 'package:culcul/features/dynamic/domain/entities/article_detail_data.dart';
import 'package:culcul/features/dynamic/presentation/view_models/article_detail_view_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('article detail load and comments read through application port', () async {
    final port = _FakeArticleDetailPort(
      detail: _articleDetail,
      commentPages: [
        const CommentResponse(replies: [_comment], cursor: _endCursor),
      ],
    );
    final provider = articleDetailViewModelProvider(_articleUrl);
    final container = _containerWith(port);
    addTearDown(container.dispose);
    final subscription = container.listen(provider, (_, _) {}, fireImmediately: true);
    addTearDown(subscription.close);

    await pumpEventQueue();

    expect(port.detailRequests, const [_articleUrl]);
    expect(port.commentListRequests, const [(_articleUrl, null)]);
    final state = container.read(provider);
    expect(state.detail, _articleDetail);
    expect(state.comments, const [_comment]);
  });

  test('article comments load next page through application port', () async {
    final port = _FakeArticleDetailPort(
      detail: _articleDetail,
      commentPages: [
        const CommentResponse(replies: [_comment], cursor: _nextCursor),
        const CommentResponse(replies: [_secondComment], cursor: _endCursor),
      ],
    );
    final provider = articleDetailViewModelProvider(_articleUrl);
    final container = _containerWith(port);
    addTearDown(container.dispose);
    final subscription = container.listen(provider, (_, _) {}, fireImmediately: true);
    addTearDown(subscription.close);

    final notifier = container.read(provider.notifier);
    await pumpEventQueue();
    await notifier.loadComments();

    expect(port.commentListRequests, const [(_articleUrl, null), (_articleUrl, 2)]);
    final state = container.read(provider);
    expect(state.comments, const [_comment, _secondComment]);
    expect(state.commentsHasMore, isFalse);
  });

  test('article comment actions read through application port', () async {
    final port = _FakeArticleDetailPort(
      detail: _articleDetail,
      commentPages: [
        const CommentResponse(replies: [_comment], cursor: _endCursor),
        const CommentResponse(replies: [_comment], cursor: _endCursor),
        CommentResponse(
          replies: [_comment.copyWith(action: 1, like: 2)],
          cursor: _endCursor,
        ),
      ],
    );
    final provider = articleDetailViewModelProvider(_articleUrl);
    final container = _containerWith(port);
    addTearDown(container.dispose);
    final subscription = container.listen(provider, (_, _) {}, fireImmediately: true);
    addTearDown(subscription.close);

    final notifier = container.read(provider.notifier);
    await pumpEventQueue();
    await notifier.submitComment(' hello ');
    await notifier.toggleCommentLike(_comment);

    expect(port.replyRequests, const [(_articleUrl, 0, 0, 'hello')]);
    expect(port.likeRequests, const [(_articleUrl, 1001, true)]);
    final liked = container.read(provider).comments.single;
    expect(liked.action, 1);
    expect(liked.like, 2);
  });

  test('article reply sends root and parent through application port', () async {
    final port = _FakeArticleDetailPort(
      detail: _articleDetail,
      commentPages: [
        const CommentResponse(replies: [_secondComment], cursor: _endCursor),
        const CommentResponse(replies: [_secondComment], cursor: _endCursor),
      ],
    );
    final provider = articleDetailViewModelProvider(_articleUrl);
    final container = _containerWith(port);
    addTearDown(container.dispose);
    final subscription = container.listen(provider, (_, _) {}, fireImmediately: true);
    addTearDown(subscription.close);

    final notifier = container.read(provider.notifier);
    await pumpEventQueue();
    await notifier.submitReply(_secondComment, 'reply text');

    expect(port.replyRequests, const [(_articleUrl, 1002, 1002, 'reply text')]);
    expect(port.commentListRequests, const [(_articleUrl, null), (_articleUrl, null)]);
  });

  test('article comment like rolls back when application port fails', () async {
    final port = _FakeArticleDetailPort(
      detail: _articleDetail,
      commentPages: [
        const CommentResponse(replies: [_comment], cursor: _endCursor),
      ],
      likeResult: const Failure(AppError.data('like failed')),
    );
    final provider = articleDetailViewModelProvider(_articleUrl);
    final container = _containerWith(port);
    addTearDown(container.dispose);
    final subscription = container.listen(provider, (_, _) {}, fireImmediately: true);
    addTearDown(subscription.close);

    final notifier = container.read(provider.notifier);
    await pumpEventQueue();
    await notifier.toggleCommentLike(_comment);

    expect(port.likeRequests, const [(_articleUrl, 1001, true)]);
    expect(container.read(provider).comments, const [_comment]);
  });
}

ProviderContainer _containerWith(_FakeArticleDetailPort port) {
  return ProviderContainer(
    overrides: [
      articleDetailPortProvider.overrideWithValue(port),
      dynamicRepositoryProvider.overrideWithValue(_ThrowingDynamicRepository()),
    ],
  );
}

const _articleUrl = 'https://www.bilibili.com/read/cv12345/';

const _articleDetail = ArticleDetailData(
  url: _articleUrl,
  commentOid: '12345',
  commentType: 12,
  title: 'Article title',
  summary: 'Summary',
  authorName: 'Author',
  authorMid: 42,
  authorAvatar: 'https://example.test/avatar.png',
  publishTime: 1,
  stats: ArticleStats(
    view: 1,
    favorite: 0,
    like: 0,
    dislike: 0,
    reply: 1,
    share: 0,
    coin: 0,
    dynamicCount: 0,
  ),
  blocks: [],
);

const _endCursor = CommentCursor(isEnd: true);
const _nextCursor = CommentCursor(next: 2);

const _comment = CommentItem(
  rpid: 1001,
  oid: 12345,
  type: 12,
  mid: 7,
  root: 0,
  parent: 0,
  ctime: 1,
  like: 1,
  member: CommentMember(
    mid: '7',
    uname: 'Commenter',
    sex: '',
    sign: '',
    avatar: 'https://example.test/commenter.png',
    rank: '',
    levelInfo: CommentLevelInfo(
      currentLevel: 1,
      currentMin: 0,
      currentExp: 0,
      nextExp: 0,
    ),
    pendant: CommentPendant(pid: 0, name: '', image: '', expire: 0),
    nameplate: CommentNameplate(
      nid: 0,
      name: '',
      image: '',
      imageSmall: '',
      level: '',
      condition: '',
    ),
    officialVerify: OfficialVerify(),
    vip: CommentVip(),
  ),
  content: CommentContent(message: 'hello'),
);

const _secondComment = CommentItem(
  rpid: 1002,
  oid: 12345,
  type: 12,
  mid: 8,
  root: 0,
  parent: 0,
  ctime: 2,
  member: CommentMember(
    mid: '8',
    uname: 'Second commenter',
    sex: '',
    sign: '',
    avatar: 'https://example.test/commenter-2.png',
    rank: '',
    levelInfo: CommentLevelInfo(
      currentLevel: 1,
      currentMin: 0,
      currentExp: 0,
      nextExp: 0,
    ),
    pendant: CommentPendant(pid: 0, name: '', image: '', expire: 0),
    nameplate: CommentNameplate(
      nid: 0,
      name: '',
      image: '',
      imageSmall: '',
      level: '',
      condition: '',
    ),
    officialVerify: OfficialVerify(),
    vip: CommentVip(),
  ),
  content: CommentContent(message: 'second'),
);

final class _FakeArticleDetailPort implements ArticleDetailPort {
  _FakeArticleDetailPort({
    required this.detail,
    required List<CommentResponse> commentPages,
    this.likeResult = const Success(null),
  }) : _commentPages = List<CommentResponse>.from(commentPages);

  final ArticleDetailData detail;
  final List<CommentResponse> _commentPages;
  final Result<void, AppError> likeResult;
  final detailRequests = <String>[];
  final commentListRequests = <(String url, int? next)>[];
  final replyRequests = <(String url, int root, int parent, String message)>[];
  final likeRequests = <(String url, int rpid, bool isLiked)>[];

  @override
  Future<Result<ArticleDetailData, AppError>> getArticleDetail(String url) async {
    detailRequests.add(url);
    return Success(detail);
  }

  @override
  Future<Result<CommentResponse, AppError>> getArticleCommentList({
    required ArticleDetailData article,
    int? next,
  }) async {
    commentListRequests.add((article.url, next));
    if (_commentPages.isEmpty) {
      return const Success(CommentResponse());
    }
    return Success(_commentPages.removeAt(0));
  }

  @override
  Future<Result<CommentItem, AppError>> addArticleCommentReply({
    required ArticleDetailData article,
    required int root,
    required int parent,
    required String message,
  }) async {
    replyRequests.add((article.url, root, parent, message));
    return Success(
      _comment.copyWith(
        root: root,
        parent: parent,
        content: CommentContent(message: message),
      ),
    );
  }

  @override
  Future<Result<void, AppError>> likeArticleComment({
    required ArticleDetailData article,
    required int rpid,
    required bool isLiked,
  }) async {
    likeRequests.add((article.url, rpid, isLiked));
    return likeResult;
  }
}

final class _ThrowingDynamicRepository extends DynamicRepositoryImpl {
  _ThrowingDynamicRepository()
    : super(
        _UnsupportedDynamicApi(),
        Dio(),
        CookieJar(),
        commentService: CommentService(Dio()),
      );

  @override
  Future<Result<ArticleDetailData, AppError>> getArticleDetail(String url) {
    throw StateError('dynamicRepositoryProvider should not be read by article UI');
  }

  @override
  Future<Result<CommentResponse, AppError>> getArticleCommentList({
    required ArticleDetailData article,
    int? next,
  }) {
    throw StateError('dynamicRepositoryProvider should not be read by article UI');
  }

  @override
  Future<Result<CommentItem, AppError>> addArticleCommentReply({
    required ArticleDetailData article,
    required int root,
    required int parent,
    required String message,
  }) {
    throw StateError('dynamicRepositoryProvider should not be read by article UI');
  }

  @override
  Future<Result<void, AppError>> likeArticleComment({
    required ArticleDetailData article,
    required int rpid,
    required bool isLiked,
  }) {
    throw StateError('dynamicRepositoryProvider should not be read by article UI');
  }
}

final class _UnsupportedDynamicApi implements DynamicApi {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}
