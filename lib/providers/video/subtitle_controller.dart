import 'package:culcul/core/types/result.dart';
import 'package:culcul/data/models/subtitle.dart';
import 'package:culcul/providers/video/video_detail_controller.dart';
import 'package:culcul/repositories/video_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'subtitle_controller.freezed.dart';
part 'subtitle_controller.g.dart';

@freezed
abstract class SubtitleState with _$SubtitleState {
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
      return SubtitleState(
        availableSubtitles: videoDetail!.subtitle!.list,
      );
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

    state = state.copyWith(
      selectedSubtitle: info,
      isLoading: true,
      error: null,
    );

    await _loadSubtitleContent(info);
  }

  Future<void> _loadSubtitleContent(SubtitleInfo info) async {
    final repo = ref.read(videoRepositoryProvider);
    final result = await repo.fetchSubtitleContent(info.subtitleUrl);

    switch (result) {
      case Success(value: final content):
        state = state.copyWith(
          content: content.body,
          isLoading: false,
        );
      case Failure(exception: final e):
        state = state.copyWith(
          isLoading: false,
          error: e.toString(),
        );
    }
  }
}
