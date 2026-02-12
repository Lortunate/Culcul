import 'package:culcul/core/utils/format_utils.dart';
import 'package:dio/dio.dart';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'media_service.g.dart';

@riverpod
MediaService mediaService(Ref ref) {
  // Use a fresh Dio instance for downloads to avoid interference with API interceptors
  return MediaService(Dio());
}

class MediaService {
  final Dio _dio;

  MediaService(this._dio);

  Future<void> saveImage(String url) async {
    final formattedUrl = FormatUtils.formatImageUrl(url);
    final tempDir = await getTemporaryDirectory();
    // Handle query parameters or other chars in url for filename
    final uri = Uri.parse(formattedUrl);
    final fileName = uri.pathSegments.last;
    final savePath = '${tempDir.path}/$fileName';

    await _dio.download(formattedUrl, savePath);
    await Gal.putImage(savePath);
  }
}
