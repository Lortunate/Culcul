import 'dart:io';

import 'package:culcul/core/data/network/resource_api.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'media_utils.g.dart';

@riverpod
MediaUtils mediaService(Ref ref) {
  return MediaUtils(ref.watch(basicResourceApiProvider));
}

class MediaUtils {
  final ResourceApi _resourceApi;

  MediaUtils(this._resourceApi);

  Future<void> saveImage(String url) async {
    final formattedUrl = FormatUtils.formatImageUrl(url);
    if (formattedUrl.isEmpty) {
      throw const AppError.unknown('Invalid image URL');
    }

    final tempDir = await getTemporaryDirectory();
    final uri = Uri.parse(formattedUrl);
    final fallbackName = 'culcul_image_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final rawName = uri.pathSegments.isEmpty ? '' : uri.pathSegments.last.trim();
    final String fileName;
    if (rawName.isEmpty) {
      fileName = fallbackName;
    } else {
      final dotIndex = rawName.lastIndexOf('.');
      final hasValidExt = dotIndex > 0 && dotIndex < rawName.length - 1;
      final extension = hasValidExt ? rawName.substring(dotIndex).toLowerCase() : '.jpg';
      final baseName = hasValidExt ? rawName.substring(0, dotIndex) : rawName;
      final safeBaseName = baseName.replaceAll(RegExp(r'[^A-Za-z0-9_-]'), '_');
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final normalizedBase = safeBaseName.isEmpty ? 'culcul_image' : safeBaseName;

      fileName = '${normalizedBase}_$timestamp$extension';
    }
    final savePath = '${tempDir.path}/$fileName';

    final tempFile = File(savePath);
    try {
      final bytes = await _resourceApi.fetchBytes(formattedUrl);
      await tempFile.writeAsBytes(bytes, flush: true);
      await Gal.putImage(savePath);
    } finally {
      if (await tempFile.exists()) {
        await tempFile.delete();
      }
    }
  }
}
