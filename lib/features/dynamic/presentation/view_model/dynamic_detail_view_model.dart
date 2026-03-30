import 'package:culcul/data/models/dynamic/dynamic_extension.dart';
import 'package:culcul/data/models/dynamic/dynamic_response.dart';
import 'package:culcul/features/dynamic/data/dynamic_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dynamic_detail_view_model.g.dart';

class DynamicDetailUiState {
  final DynamicItem? post;
  final bool isLoading;
  final String? error;

  const DynamicDetailUiState({this.post, this.isLoading = true, this.error});

  DynamicDetailUiState copyWith({DynamicItem? post, bool? isLoading, String? error}) {
    return DynamicDetailUiState(
      post: post ?? this.post,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

@riverpod
class DynamicDetailViewModel extends _$DynamicDetailViewModel {
  late final String _dynamicId;

  @override
  DynamicDetailUiState build(String dynamicId) {
    _dynamicId = dynamicId;
    Future.microtask(loadDetail);
    return const DynamicDetailUiState();
  }

  Future<void> loadDetail() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final data = await ref.read(dynamicRepositoryProvider).getDetail(_dynamicId);
      state = state.copyWith(post: data, isLoading: false, error: null);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<String?> toggleLike() async {
    final item = state.post;
    if (item == null) return null;

    final newStatus = !item.isLiked;
    final newLikeCount = item.likeCount + (newStatus ? 1 : -1);
    final newStatLike = item.modules.moduleStat?.like.copyWith(
      count: newLikeCount,
      status: newStatus,
    );

    if (item.modules.moduleStat == null || newStatLike == null) return null;

    final nextItem = item.copyWith(
      modules: item.modules.copyWith(
        moduleStat: item.modules.moduleStat!.copyWith(like: newStatLike),
      ),
    );

    state = state.copyWith(post: nextItem);
    try {
      await ref.read(dynamicRepositoryProvider).likeDynamic(item.id, newStatus);
      return null;
    } catch (e) {
      state = state.copyWith(post: item);
      return e.toString();
    }
  }
}
