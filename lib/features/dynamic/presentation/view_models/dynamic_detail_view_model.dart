import 'package:culcul/features/dynamic/domain/entities/dynamic_entities.dart';
import 'dart:async';

import 'package:culcul/features/dynamic/feature_scope.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dynamic_detail_view_model.freezed.dart';
part 'dynamic_detail_view_model.g.dart';

@freezed
sealed class DynamicDetailUiState with _$DynamicDetailUiState {
  const factory DynamicDetailUiState({
    DynamicItem? post,
    @Default(true) bool isLoading,
    AppError? error,
  }) = _DynamicDetailUiState;
}

@riverpod
class DynamicDetailViewModel extends _$DynamicDetailViewModel {
  late final String _dynamicId;

  @override
  DynamicDetailUiState build(String dynamicId) {
    _dynamicId = dynamicId;
    unawaited(Future<void>.microtask(loadDetail));
    return const DynamicDetailUiState();
  }

  Future<void> loadDetail() async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await ref.read(dynamicRepositoryProvider).getDetail(_dynamicId);
    state = result.when(
      success: (data) => state.copyWith(post: data, isLoading: false, error: null),
      failure: (error) => state.copyWith(isLoading: false, error: error),
    );
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
    final result = await ref
        .read(dynamicRepositoryProvider)
        .likeDynamic(item.id, newStatus);
    if (result.isFailure) {
      state = state.copyWith(post: item);
      return result.errorOrNull?.message;
    }
    return null;
  }
}
