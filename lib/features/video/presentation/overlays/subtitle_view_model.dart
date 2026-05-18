import 'package:culcul/features/video/data/dtos/subtitle_dto.dart';
import 'package:culcul/features/video/data/video_repository_impl.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../detail/video_detail_view_model.dart';

part 'subtitle_view_model.freezed.dart';
part 'subtitle_view_model.g.dart';

@freezed
sealed class SubtitleState with _$SubtitleState {
  const factory SubtitleState({
    @Default([]) List<SubtitleInfo> availableSubtitles,
    SubtitleInfo? selectedSubtitle,
    @Default([]) List<SubtitleItem> content,
    @Default(false) bool isLoading,
    @Default(false) bool isEnabled,
    String? error,
  }) = _SubtitleState;
}

@riverpod
class SubtitleController extends _$SubtitleController {
  @override
  SubtitleState build(String bvid) {
    // Listen to video detail changes to initialize subtitles
    final videoDetail = ref.watch(videoDetailControllerProvider(bvid)).videoDetail;

    if (videoDetail?.subtitle?.list.isNotEmpty == true) {
      // If we have subtitles but haven't initialized them yet
      // or if the available subtitles list has changed (unlikely but possible)
      // Note: This logic might need refinement if we want to persist user selection
      return SubtitleState(availableSubtitles: videoDetail!.subtitle!.list);
    }

    return const SubtitleState();
  }

  Future<void> toggleSubtitle() async {
    if (state.isEnabled) {
      state = state.copyWith(isEnabled: false);
    } else {
      state = state.copyWith(isEnabled: true);
      if (state.selectedSubtitle == null && state.availableSubtitles.isNotEmpty) {
        // Select first by default
        await selectSubtitle(state.availableSubtitles.first);
      } else if (state.content.isEmpty && state.selectedSubtitle != null) {
        // Retry loading if empty
        await _loadSubtitleContent(state.selectedSubtitle!);
      }
    }
  }

  Future<void> selectSubtitle(SubtitleInfo info) async {
    if (state.selectedSubtitle == info && state.content.isNotEmpty) return;

    state = state.copyWith(selectedSubtitle: info, isLoading: true, error: null);

    await _loadSubtitleContent(info);
  }

  Future<void> _loadSubtitleContent(SubtitleInfo info) async {
    final result = await ref
        .read(videoRepositoryProvider)
        .fetchSubtitleContent(info.subtitleUrl);
    state = result.when(
      success: (content) => state.copyWith(content: content.body, isLoading: false),
      failure: (error) => state.copyWith(isLoading: false, error: error.message),
    );
  }
}
