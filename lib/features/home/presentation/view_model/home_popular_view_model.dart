// ignore_for_file: invalid_use_of_internal_member
import 'package:culcul/core/pagination/paged_async_notifier.dart';
import 'package:culcul/data/models/video/video_model.dart';
import 'package:culcul/features/home/data/home_repository.dart';
import 'package:culcul/features/home/presentation/view_model/home_video_paging_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_popular_view_model.g.dart';

@Riverpod(keepAlive: true)
class HomePopular extends _$HomePopular
    with OffsetPagedAsyncNotifier<VideoModel>, HomeVideoPagingViewModel {
  @override
  Future<List<VideoModel>> build() async {
    return buildFirstPage();
  }

  @override
  Future<List<VideoModel>> fetchPage(int page, {bool refresh = false}) async {
    return ref
        .read(homeRepositoryProvider)
        .fetchPopular(page: page, forceRefresh: refresh);
  }
}
