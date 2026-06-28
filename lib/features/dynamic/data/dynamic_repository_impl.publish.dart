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
    return _requestExecutor.run(() async {
      final csrf = await _getCsrfToken();
      if (csrf == null || csrf.isEmpty) {
        throw const AppError.auth('Missing bili_jct csrf token');
      }
      return csrf;
    });
  }

  Future<Result<void, AppError>> likeDynamic(String id, bool like) async {
    return _requestExecutor.run(() async {
      final csrf = await _getCsrfToken();
      final response = await api.likeDynamic(
        body: {'dyn_id_str': id, 'up': like ? 1 : 2},
        csrf: csrf ?? '',
      );
      if (!response.isSuccess) {
        throw AppError.server(response.message, code: response.code);
      }
    });
  }

  Future<Result<List<UploadedImage>, AppError>> uploadImagesWithCsrf({
    required List<PublishMediaAsset> files,
    required String csrf,
  }) async {
    if (files.isEmpty) {
      return const Success(<UploadedImage>[]);
    }

    return _requestExecutor.run(() async {
      return concurrencyExecutor.mapConcurrent<PublishMediaAsset, UploadedImage>(
        items: files,
        profile: NetworkConcurrencyProfile.upload,
        mapper: (asset) async {
          final file = File(asset.path);
          final uploadResult = await _requestExecutor.runApiDirect(
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
    List<UploadedImage> images = const [],
  }) async {
    return _requestExecutor.run(() async {
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
        throw AppError.server(response.message, code: response.code);
      }
    });
  }
}
