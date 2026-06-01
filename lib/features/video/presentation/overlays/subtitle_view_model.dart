import 'package:culcul/features/video/application/models/subtitle.dart';
import 'package:culcul/features/video/data/video_repository_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:culcul/features/video/presentation/detail/video_detail_view_model.dart';

part 'subtitle_view_model.g.dart';

final class SubtitleState {
  const SubtitleState({
    this.availableSubtitles = const [],
    this.selectedSubtitle,
    this.content = const [],
    this.isLoading = false,
    this.isEnabled = false,
    this.error,
  });

  final List<SubtitleInfo> availableSubtitles;
  final SubtitleInfo? selectedSubtitle;
  final List<SubtitleItem> content;
  final bool isLoading;
  final bool isEnabled;
  final String? error;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SubtitleState &&
            listEquals(other.availableSubtitles, availableSubtitles) &&
            other.selectedSubtitle == selectedSubtitle &&
            listEquals(other.content, content) &&
            other.isLoading == isLoading &&
            other.isEnabled == isEnabled &&
            other.error == error;
  }

  @override
  int get hashCode => Object.hash(
    Object.hashAll(availableSubtitles),
    selectedSubtitle,
    Object.hashAll(content),
    isLoading,
    isEnabled,
    error,
  );

  @override
  String toString() {
    return 'SubtitleState('
        'availableSubtitles: $availableSubtitles, '
        'selectedSubtitle: $selectedSubtitle, '
        'content: $content, '
        'isLoading: $isLoading, '
        'isEnabled: $isEnabled, '
        'error: $error'
        ')';
  }
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
      state = SubtitleState(
        availableSubtitles: state.availableSubtitles,
        selectedSubtitle: state.selectedSubtitle,
        content: state.content,
        isLoading: state.isLoading,
        error: state.error,
      );
    } else {
      state = SubtitleState(
        availableSubtitles: state.availableSubtitles,
        selectedSubtitle: state.selectedSubtitle,
        content: state.content,
        isLoading: state.isLoading,
        isEnabled: true,
        error: state.error,
      );
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

    state = SubtitleState(
      availableSubtitles: state.availableSubtitles,
      selectedSubtitle: info,
      content: state.content,
      isLoading: true,
      isEnabled: state.isEnabled,
    );

    await _loadSubtitleContent(info);
  }

  Future<void> _loadSubtitleContent(SubtitleInfo info) async {
    final result = await ref
        .read(videoRepositoryProvider)
        .fetchSubtitleContent(info.subtitleUrl);
    state = result.when(
      success: (content) => SubtitleState(
        availableSubtitles: state.availableSubtitles,
        selectedSubtitle: state.selectedSubtitle,
        content: content.body,
        isEnabled: state.isEnabled,
        error: state.error,
      ),
      failure: (error) => SubtitleState(
        availableSubtitles: state.availableSubtitles,
        selectedSubtitle: state.selectedSubtitle,
        content: state.content,
        isEnabled: state.isEnabled,
        error: error.message,
      ),
    );
  }
}
