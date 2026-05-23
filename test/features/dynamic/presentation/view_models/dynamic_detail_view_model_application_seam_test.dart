import 'package:cookie_jar/cookie_jar.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/services/comment_service.dart';
import 'package:culcul/features/dynamic/application/dynamic_detail_application_providers.dart';
import 'package:culcul/features/dynamic/application/dynamic_detail_port.dart';
import 'package:culcul/features/dynamic/application/models/dynamic_response.dart';
import 'package:culcul/features/dynamic/data/dynamic_api.dart';
import 'package:culcul/features/dynamic/data/dynamic_repository_impl.dart';
import 'package:culcul/features/dynamic/domain/entities/dynamic_queries.dart';
import 'package:culcul/features/dynamic/presentation/view_models/dynamic_detail_view_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('dynamic detail reads through the dynamic detail application port', () async {
    final port = _FakeDynamicDetailPort(detail: _dynamicItem);
    final provider = dynamicDetailViewModelProvider('dynamic-1');
    final container = _containerWith(port);
    addTearDown(container.dispose);
    final subscription = container.listen(provider, (_, _) {}, fireImmediately: true);
    addTearDown(subscription.close);

    await pumpEventQueue();

    expect(port.detailRequests, contains('dynamic-1'));
    expect(container.read(provider).post, _dynamicItem);
  });

  test(
    'dynamic detail like action reads through the dynamic detail application port',
    () async {
      final port = _FakeDynamicDetailPort(detail: _dynamicItem);
      final provider = dynamicDetailViewModelProvider('dynamic-1');
      final container = _containerWith(port);
      addTearDown(container.dispose);
      final subscription = container.listen(provider, (_, _) {}, fireImmediately: true);
      addTearDown(subscription.close);

      final notifier = container.read(provider.notifier);
      await pumpEventQueue();
      await notifier.toggleLike();

      expect(port.likeRequests, const [('dynamic-1', true)]);
      final likedItem = container.read(provider).post!;
      expect(likedItem.modules.moduleStat!.like.status, isTrue);
      expect(likedItem.modules.moduleStat!.like.count, 2);
    },
  );
}

ProviderContainer _containerWith(_FakeDynamicDetailPort port) {
  return ProviderContainer(
    overrides: [
      dynamicDetailPortProvider.overrideWithValue(port),
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

final class _FakeDynamicDetailPort implements DynamicDetailPort {
  _FakeDynamicDetailPort({DynamicItem? detail, DynamicData? feed, DynamicData? topicFeed})
    : detail = detail ?? _dynamicItem,
      feed = feed ?? _feedWith(_dynamicItem),
      topicFeed = topicFeed ?? _feedWith(_dynamicItem);

  final DynamicItem detail;
  final DynamicData feed;
  final DynamicData topicFeed;
  final detailRequests = <String>[];
  final feedQueries = <DynamicFeedQuery>[];
  final topicQueries = <TopicDynamicFeedQuery>[];
  final likeRequests = <(String id, bool like)>[];

  @override
  Future<Result<DynamicItem, AppError>> getDetail(String id) async {
    detailRequests.add(id);
    return Success(detail);
  }

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
  Future<Result<DynamicItem, AppError>> getDetail(String id) {
    throw StateError('dynamicRepositoryProvider should not be read by detail UI');
  }

  @override
  Future<Result<void, AppError>> likeDynamic(String id, bool like) {
    throw StateError('dynamicRepositoryProvider should not be read by detail UI');
  }
}

final class _UnsupportedDynamicApi implements DynamicApi {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}
