import 'dart:io';

import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/data/api/resource_api.dart';
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
    final tempDir = await getTemporaryDirectory();
    // Handle query parameters or other chars in url for filename
    final uri = Uri.parse(formattedUrl);
    final fileName = uri.pathSegments.last;
    final savePath = '${tempDir.path}/$fileName';

    final bytes = await _resourceApi.fetchBytes(formattedUrl);
    await File(savePath).writeAsBytes(bytes, flush: true);
    await Gal.putImage(savePath);
  }
}
