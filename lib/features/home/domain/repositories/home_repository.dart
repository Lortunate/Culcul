import 'package:culcul/features/home/domain/entities/home_video.dart';

abstract class HomeRepository {
  Future<List<HomeVideo>> fetchRecommend({int page = 1, bool forceRefresh = false});

  Future<List<HomeVideo>> fetchPopular({
    int page = 1,
    int pageSize = 20,
    bool forceRefresh = false,
  });
}
