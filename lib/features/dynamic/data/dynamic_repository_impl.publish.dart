part of 'dynamic_repository_impl.dart';

mixin _DynamicRepositoryPublishApis on _DynamicRepositoryAccess {
  Future<String?> _getCsrfToken() async {
    final cookies = await this.cookieJar.loadForRequest(
      Uri.parse('https://bilibili.com'),
    );
    for (final cookie in cookies) {
      if (cookie.name == 'bili_jct') {
        return cookie.value;
      }
    }
    return null;
  }

  Future<Result<String, AppError>> getPublishCsrf() {
    return requestResult(() async {
      final csrf = await _getCsrfToken();
      if (csrf == null || csrf.isEmpty) {
        throw const AuthException('Missing bili_jct csrf token');
      }
      return csrf;
    });
  }

  Future<Result<void, AppError>> likeDynamic(String id, bool like) async {
    return requestResult(() async {
      final csrf = await _getCsrfToken();
      final response = await api.likeDynamic(
        body: {'dyn_id_str': id, 'up': like ? 1 : 2},
        csrf: csrf ?? '',
      );
      if (!response.isSuccess) {
        throw ServerException(response.message, code: response.code);
      }
    });
  }

  Future<Result<List<DynamicUploadImageData>, AppError>> uploadImagesWithCsrf({
    required List<File> files,
    required String csrf,
  }) async {
    if (files.isEmpty) {
      return const Success(<DynamicUploadImageData>[]);
    }

    return requestResult(() async {
      return concurrencyExecutor.mapConcurrent<File, DynamicUploadImageData>(
        items: files,
        profile: NetworkConcurrencyProfile.upload,
        scope: 'dynamic_publish_upload',
        mapper: (file) async {
          final uploadResult = await requestApiResult(
            () => api.uploadImage(file: file, csrf: csrf),
          );
          return uploadResult.when(
            success: (data) => data,
            failure: (error) => throw error,
          );
        },
      );
    });
  }

  Future<Result<void, AppError>> publishDynamic({
    required String content,
    required String csrf,
    List<DynamicUploadImageData> images = const [],
  }) async {
    return requestResult(() async {
      final pics = images
          .map(
            (img) => <String, dynamic>{
              'img_src': img.imageUrl,
              'img_width': img.width,
              'img_height': img.height,
            },
          )
          .toList();

      final Map<String, dynamic> dynReq = {
        'content': {
          'contents': <Map<String, dynamic>>[
            <String, dynamic>{'raw_text': content, 'type': 1, 'biz_id': ''},
          ],
        },
        'scene': images.isNotEmpty ? 2 : 1,
      };

      if (images.isNotEmpty) {
        dynReq['pics'] = pics;
      }

      final response = await api.createDynamic(csrf: csrf, body: {'dyn_req': dynReq});

      if (!response.isSuccess) {
        throw ServerException(response.message, code: response.code);
      }
    });
  }
}
