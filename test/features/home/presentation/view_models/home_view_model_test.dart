import 'package:culcul/core/bootstrap/providers/cache_store_provider.dart';
import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/home/application/home_application_providers.dart';
import 'package:culcul/features/home/application/home_port.dart';
import 'package:culcul/features/home/data/home_repository_impl.dart';
import 'package:culcul/features/home/presentation/view_models/home_popular_view_model.dart';
import 'package:culcul/features/home/presentation/view_models/home_recommend_view_model.dart';
import 'package:culcul/features/home/presentation/view_models/weekly_view_model.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('popular feed reads through the home application port', () async {
    final video = _videoModel(bvid: 'BV-popular');
    final port = _FakeHomePort(popular: [video]);
    final container = _homeContainer(port);
    addTearDown(container.dispose);

    final videos = await container.read(homePopularProvider.future);

    expect(videos, [video]);
    expect(port.popularPages, const [1]);
    expect(port.popularForceRefreshValues, const [false]);
  });

  test('recommend feed reads through the home application port', () async {
    final video = _videoModel(bvid: 'BV-recommend');
    final port = _FakeHomePort(recommend: [video]);
    final container = _homeContainer(port);
    addTearDown(container.dispose);

    final videos = await container.read(homeRecommendProvider.future);

    expect(videos, [video]);
    expect(port.recommendPages, const [1]);
    expect(port.recommendForceRefreshValues, const [false]);
  });

  test('weekly list reads through the home application port', () async {
    final video = _videoModel(bvid: 'BV-weekly');
    final port = _FakeHomePort(weekly: [video]);
    final container = _homeContainer(port);
    addTearDown(container.dispose);

    final videos = await container.read(weeklyListProvider.future);

    expect(videos, [video]);
    expect(port.weeklyRequestCount, 1);
  });
}

ProviderContainer _homeContainer(_FakeHomePort port) {
  return ProviderContainer(
    overrides: [
      cacheStoreProvider.overrideWithValue(MemCacheStore()),
      homePortProvider.overrideWithValue(port),
      homeRepositoryImplProvider.overrideWithValue(_ThrowingHomeRepository()),
    ],
  );
}

VideoModel _videoModel({required String bvid}) {
  return VideoModel(
    bvid: bvid,
    title: 'Title $bvid',
    pic: 'https://example.test/$bvid.jpg',
    owner: const VideoOwner(mid: 1, name: 'owner'),
    stat: const VideoStat(view: 1),
    duration: 60,
    pubDate: 1,
  );
}

final class _FakeHomePort implements HomePort {
  _FakeHomePort({
    this.recommend = const <VideoModel>[],
    this.popular = const <VideoModel>[],
    this.weekly = const <VideoModel>[],
  });

  final List<VideoModel> recommend;
  final List<VideoModel> popular;
  final List<VideoModel> weekly;
  final List<int> recommendPages = [];
  final List<bool> recommendForceRefreshValues = [];
  final List<int> popularPages = [];
  final List<bool> popularForceRefreshValues = [];
  int weeklyRequestCount = 0;

  @override
  Future<Result<List<VideoModel>, AppError>> fetchRecommendPage({
    required int page,
    bool forceRefresh = false,
  }) async {
    recommendPages.add(page);
    recommendForceRefreshValues.add(forceRefresh);
    return Success(recommend);
  }

  @override
  Future<Result<List<VideoModel>, AppError>> fetchPopularPage({
    required int page,
    bool forceRefresh = false,
  }) async {
    popularPages.add(page);
    popularForceRefreshValues.add(forceRefresh);
    return Success(popular);
  }

  @override
  Future<Result<List<VideoModel>, AppError>> fetchWeeklyList() async {
    weeklyRequestCount++;
    return Success(weekly);
  }
}

final class _ThrowingHomeRepository extends HomeRepositoryImpl {
  _ThrowingHomeRepository() : super.test();

  @override
  Future<Result<List<VideoModel>, AppError>> fetchRecommendPage({
    required int page,
    bool forceRefresh = false,
  }) {
    throw StateError('homeRepositoryImplProvider should not be read by UI state');
  }

  @override
  Future<Result<List<VideoModel>, AppError>> fetchPopularPage({
    required int page,
    bool forceRefresh = false,
  }) {
    throw StateError('homeRepositoryImplProvider should not be read by UI state');
  }

  @override
  Future<Result<List<VideoModel>, AppError>> fetchWeeklyList() {
    throw StateError('homeRepositoryImplProvider should not be read by UI state');
  }
}
