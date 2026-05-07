import 'dart:io';

import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/core/data/network/resource_api.dart';
import 'package:culcul/core/data/network/resource_api_provider.dart';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'media_service.g.dart';

@riverpod
MediaService mediaService(Ref ref) {
  return MediaService(ref.watch(basicResourceApiProvider));
}

class MediaService {
  final ResourceApi _resourceApi;

  MediaService(this._resourceApi);

  Future<void> saveImage(String url) async {
    final formattedUrl = FormatUtils.formatImageUrl(url);
    if (formattedUrl.isEmpty) {
      throw Exception('Invalid image URL');
    }

    final tempDir = await getTemporaryDirectory();
    final uri = Uri.parse(formattedUrl);
    final fileName = _buildFileName(uri);
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

  String _buildFileName(Uri uri) {
    final fallbackName = 'culcul_image_${DateTime.now().millisecondsSinceEpoch}.jpg';
    if (uri.pathSegments.isEmpty) {
      return fallbackName;
    }

    final rawName = uri.pathSegments.last.trim();
    if (rawName.isEmpty) {
      return fallbackName;
    }

    final dotIndex = rawName.lastIndexOf('.');
    final hasValidExt = dotIndex > 0 && dotIndex < rawName.length - 1;
    final extension = hasValidExt ? rawName.substring(dotIndex).toLowerCase() : '.jpg';
    final baseName = hasValidExt ? rawName.substring(0, dotIndex) : rawName;
    final safeBaseName = baseName.replaceAll(RegExp(r'[^A-Za-z0-9_-]'), '_');
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final normalizedBase = safeBaseName.isEmpty ? 'culcul_image' : safeBaseName;

    return '${normalizedBase}_$timestamp$extension';
  }
}
