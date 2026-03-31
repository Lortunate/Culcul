import 'dart:io';

import 'package:culcul/features/dynamic/application/dynamic_workflows.dart';
import 'package:culcul/features/dynamic/presentation/view_models/dynamic_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'publish_dynamic_view_model.g.dart';

class PublishDynamicUiState {
  final bool isPublishing;

  const PublishDynamicUiState({this.isPublishing = false});

  PublishDynamicUiState copyWith({bool? isPublishing}) {
    return PublishDynamicUiState(isPublishing: isPublishing ?? this.isPublishing);
  }
}

@riverpod
class PublishDynamicViewModel extends _$PublishDynamicViewModel {
  @override
  PublishDynamicUiState build() => const PublishDynamicUiState();

  Future<String?> publish({required String content, required List<File> images}) async {
    final trimmed = content.trim();
    if (trimmed.isEmpty && images.isEmpty) return null;
    if (state.isPublishing) return null;

    state = state.copyWith(isPublishing: true);
    final result = await ref
        .read(publishDynamicWorkflowProvider)
        .call(content: trimmed, images: images);
    final error = result.when(
      success: (_) {
        ref.invalidate(dynamicProvider);
        return null;
      },
      failure: (error) => error.message,
    );
    state = state.copyWith(isPublishing: false);
    return error;
  }
}
