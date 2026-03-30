import 'dart:io';

import 'package:culcul/data/models/dynamic/dynamic_response.dart';
import 'package:culcul/features/dynamic/presentation/view_model/dynamic_view_model.dart';
import 'package:culcul/features/dynamic/data/dynamic_repository.dart';
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
    try {
      final uploadedImages = <DynamicUploadImageData>[];
      for (final image in images) {
        final data = await ref.read(dynamicRepositoryProvider).uploadImage(image);
        uploadedImages.add(data);
      }

      await ref
          .read(dynamicRepositoryProvider)
          .publishDynamic(content: trimmed, images: uploadedImages);
      ref.invalidate(dynamicProvider);
      return null;
    } catch (e) {
      return e.toString();
    } finally {
      state = state.copyWith(isPublishing: false);
    }
  }
}
