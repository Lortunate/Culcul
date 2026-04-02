// ignore_for_file: invalid_use_of_internal_member
import 'package:culcul/core/pagination/paged_async_notifier.dart';
import 'package:culcul/features/home/home.dart';
import 'package:culcul/features/home/domain/entities/home_video.dart';
import 'package:culcul/features/home/presentation/view_models/home_video_paging_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_popular_view_model.g.dart';

@Riverpod(keepAlive: true)
class HomePopular extends _$HomePopular
    with OffsetPagedAsyncNotifier<HomeVideo>, HomeVideoPagingViewModel {
  @override
  Future<List<HomeVideo>> build() async {
    return buildFirstPage();
  }

  @override
  Future<List<HomeVideo>> fetchPage(int page, {bool refresh = false}) async {
    final result = await ref
        .read(homeRepositoryProvider)
        .fetchPopular(page: page, forceRefresh: refresh);
    return result.when(
      success: (items) => items,
      failure: (error) => throw error.toException(),
    );
  }
}
