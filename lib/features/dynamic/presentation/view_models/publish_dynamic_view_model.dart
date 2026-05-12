import 'dart:io';

import 'package:culcul/features/dynamic/domain/entities/dynamic_publish_command.dart';
import 'package:culcul/features/dynamic/application/dynamic_workflows.dart';
import 'package:culcul/features/dynamic/presentation/view_models/dynamic_view_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'publish_dynamic_view_model.freezed.dart';
part 'publish_dynamic_view_model.g.dart';

@freezed
sealed class PublishDynamicUiState with _$PublishDynamicUiState {
  const factory PublishDynamicUiState({
    @Default(false) bool isPublishing,
  }) = _PublishDynamicUiState;
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

    // Hardening the public seam by converting presentation primitives (File)
    // into domain-shaped assets (PublishMediaAsset).
    // In a real scenario, we would decode image dimensions here.
    final assets = images.map((f) => PublishMediaAsset(
      path: f.path,
      width: 0, // Placeholder
      height: 0, // Placeholder
    )).toList();

    final result = await ref
        .read(publishDynamicWorkflowProvider)
        .call(content: trimmed, images: assets);
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
