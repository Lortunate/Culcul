import 'package:cilixili/data/sources/api/api_provider.dart';
import 'package:cilixili/data/sources/api/video_api.dart';
import 'package:cilixili/data/sources/api/helpers/wbi_helper.dart';
import 'package:cilixili/data/sources/api/helpers/wbi_provider.dart';
import 'package:cilixili/data/models/home/video_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_repository.g.dart';

@riverpod
HomeRepository homeRepository(Ref ref) {
  return HomeRepository(
    api: ref.watch(videoApiProvider),
    wbiHelper: ref.watch(wbiHelperProvider),
  );
}

class HomeRepository {
  final VideoApi api;
  final WbiHelper wbiHelper;

  HomeRepository({required this.api, required this.wbiHelper});

  Future<List<VideoModel>> fetchRecommend({int page = 1}) async {
    final params = {
      'fresh_type': 4,
      'ps': 20,
      'fresh_idx': page,
      'fresh_idx_1h': page,
    };

    final signedParams = wbiHelper.sign(params);
    final response = await api.fetchRecommend(signedParams);

    if (response.isSuccess) {
      final items = response.data?.item ?? [];
      return items
          .where((e) => e['goto'] == 'av')
          .map((e) => VideoModel.fromJson(e))
          .toList();
    } else {
      throw Exception(response.message);
    }
  }
}
