import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/base_repository.dart';
import 'package:culcul/data/api/video_api.dart';
import 'package:culcul/data/models/video/video_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_repository.g.dart';

@riverpod
HomeRepository homeRepository(Ref ref) {
  return HomeRepository(api: ref.watch(videoApiProvider));
}

class HomeRepository extends BaseRepository {
  final VideoApi api;

  HomeRepository({required this.api});

  Future<List<VideoModel>> fetchRecommend({
    int page = 1,
    bool forceRefresh = false,
  }) async {
    final data = await requestApi(
      () => api.fetchRecommend(
        freshIdx: page,
        freshIdx1h: page,
        forceRefresh: forceRefresh ? true : null,
      ),
    );
    final items = data.item;
    return items.where((e) => e['goto'] == 'av').map(VideoModel.fromJson).toList();
  }

  Future<List<VideoModel>> fetchPopular({
    int page = 1,
    int pageSize = 20,
    bool forceRefresh = false,
  }) async {
    final data = await requestApi(
      () => api.fetchPopular(
        pn: page,
        ps: pageSize,
        forceRefresh: forceRefresh ? true : null,
      ),
    );
    return data.list;
  }
}
