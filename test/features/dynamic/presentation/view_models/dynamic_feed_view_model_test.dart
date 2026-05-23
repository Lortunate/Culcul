import 'package:cookie_jar/cookie_jar.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/services/comment_service.dart';
import 'package:culcul/features/dynamic/application/dynamic_feed_application_providers.dart';
import 'package:culcul/features/dynamic/application/dynamic_feed_port.dart';
import 'package:culcul/features/dynamic/application/models/dynamic_response.dart';
import 'package:culcul/features/dynamic/data/dynamic_api.dart';
import 'package:culcul/features/dynamic/data/dynamic_repository_impl.dart';
import 'package:culcul/features/dynamic/domain/entities/dynamic_queries.dart';
import 'package:culcul/features/dynamic/presentation/view_models/dynamic_view_model.dart';
import 'package:culcul/features/dynamic/presentation/view_models/topic_dynamic_view_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('dynamic feed reads through the dynamic feed application port', () async {
    final port = _FakeDynamicFeedPort(feed: _feedWith(_dynamicItem));
    final container = _containerWith(port);
    addTearDown(container.dispose);

    final items = await container.read(dynamicProvider('all').future);

    expect(items, const [_dynamicItem]);
    expect(port.feedQueries.single.type, isNull);
    expect(port.feedQueries.single.offset, isNull);
  });

  test('topic feed reads through the dynamic feed application port', () async {
    final port = _FakeDynamicFeedPort(topicFeed: _feedWith(_dynamicItem));
    final container = _containerWith(port);
    addTearDown(container.dispose);

    final items = await container.read(topicDynamicProvider(topicId: 42).future);

    expect(items, const [_dynamicItem]);
    expect(port.topicQueries.single.topicId, 42);
    expect(port.topicQueries.single.offset, isNull);
  });

  test('feed like actions read through the dynamic feed application port', () async {
    final port = _FakeDynamicFeedPort(feed: _feedWith(_dynamicItem));
    final provider = dynamicProvider('all');
    final container = _containerWith(port);
    addTearDown(container.dispose);

    await container.read(provider.future);
    await container.read(provider.notifier).toggleLike('dynamic-1', false);

    expect(port.likeRequests, const [('dynamic-1', true)]);
    final likedItem = container.read(provider).value!.single;
    expect(likedItem.modules.moduleStat!.like.status, isTrue);
    expect(likedItem.modules.moduleStat!.like.count, 2);
  });
}

ProviderContainer _containerWith(_FakeDynamicFeedPort port) {
  return ProviderContainer(
    overrides: [
      dynamicFeedPortProvider.overrideWithValue(port),
      dynamicRepositoryProvider.overrideWithValue(_ThrowingDynamicRepository()),
    ],
  );
}

DynamicData _feedWith(DynamicItem item) {
  return DynamicData(
    hasMore: false,
    items: [item],
    offset: '',
    updateBaseline: '',
    updateNum: 0,
  );
}

const _dynamicItem = DynamicItem(
  idStr: 'dynamic-1',
  type: 'DYNAMIC_TYPE_WORD',
  visible: true,
  modules: DynamicModules(
    moduleAuthor: ModuleAuthor(
      mid: 1,
      name: 'Author',
      avatar: 'https://example.test/avatar.png',
      pubTime: 'now',
      pubAction: 'published',
    ),
    moduleDynamic: ModuleDynamic(),
    moduleStat: ModuleStat(
      like: StatLike(count: 1, status: false),
      comment: StatCommon(count: 0),
      forward: StatCommon(count: 0),
    ),
  ),
);

final class _FakeDynamicFeedPort implements DynamicFeedPort {
  _FakeDynamicFeedPort({DynamicData? feed, DynamicData? topicFeed})
    : feed = feed ?? _feedWith(_dynamicItem),
      topicFeed = topicFeed ?? _feedWith(_dynamicItem);

  final DynamicData feed;
  final DynamicData topicFeed;
  final feedQueries = <DynamicFeedQuery>[];
  final topicQueries = <TopicDynamicFeedQuery>[];
  final likeRequests = <(String id, bool like)>[];

  @override
  Future<Result<DynamicData, AppError>> getFeed(DynamicFeedQuery query) async {
    feedQueries.add(query);
    return Success(feed);
  }

  @override
  Future<Result<DynamicData, AppError>> getTopicFeed(TopicDynamicFeedQuery query) async {
    topicQueries.add(query);
    return Success(topicFeed);
  }

  @override
  Future<Result<void, AppError>> likeDynamic(String id, bool like) async {
    likeRequests.add((id, like));
    return const Success(null);
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
  Future<Result<DynamicData, AppError>> getFeed(DynamicFeedQuery query) {
    throw StateError('dynamicRepositoryProvider should not be read by feed UI');
  }

  @override
  Future<Result<DynamicData, AppError>> getTopicFeed(TopicDynamicFeedQuery query) {
    throw StateError('dynamicRepositoryProvider should not be read by feed UI');
  }

  @override
  Future<Result<void, AppError>> likeDynamic(String id, bool like) {
    throw StateError('dynamicRepositoryProvider should not be read by feed UI');
  }
}

final class _UnsupportedDynamicApi implements DynamicApi {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}
