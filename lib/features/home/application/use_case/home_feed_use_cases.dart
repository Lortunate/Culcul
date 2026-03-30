import 'package:culcul/features/home/data/home_repository.dart';
import 'package:culcul/features/home/data/weekly_repository.dart';
import 'package:culcul/features/home/data/mappers/home_feed_mapper.dart';
import 'package:culcul/features/home/domain/entities/home_video.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_feed_use_cases.g.dart';

@riverpod
HomeFeedUseCases homeFeedUseCases(Ref ref) {
  return HomeFeedUseCases(
    homeRepository: ref.read(homeRepositoryProvider),
    weeklyRepository: ref.read(weeklyRepositoryProvider),
  );
}

class HomeFeedUseCases {
  final HomeRepository _homeRepository;
  final WeeklyRepository _weeklyRepository;

  const HomeFeedUseCases({
    required HomeRepository homeRepository,
    required WeeklyRepository weeklyRepository,
  }) : _homeRepository = homeRepository,
       _weeklyRepository = weeklyRepository;

  Future<List<HomeVideo>> loadRecommendPage({
    required int page,
    bool refresh = false,
  }) async {
    return (await _homeRepository.fetchRecommend(
      page: page,
      forceRefresh: refresh,
    )).map((item) => item.toDomain()).toList();
  }

  Future<List<HomeVideo>> loadPopularPage({
    required int page,
    bool refresh = false,
  }) async {
    return (await _homeRepository.fetchPopular(
      page: page,
      forceRefresh: refresh,
    )).map((item) => item.toDomain()).toList();
  }

  Future<HomeWeeklyFeed> loadWeekly() async {
    return (await _weeklyRepository.getWeeklyList()).toDomain();
  }
}
