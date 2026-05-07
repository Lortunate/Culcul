import 'package:culcul/core/utils/json_compute.dart';

final class ArticleDetailParser {
  const ArticleDetailParser._();

  static final _cvRegex = RegExp(r'/cv(\d+)');
  static final _opusRegex = RegExp(r'/opus/(\d+)');
  static final _initialStateRegex = RegExp(
    r'window\.__INITIAL_STATE__\s*=\s*(\{.*?\})\s*;\s*\(function',
    dotAll: true,
  );

  static int? extractArticleId(Uri uri) {
    final path = uri.path;
    final readMatch = _cvRegex.firstMatch(path);
    if (readMatch != null) return int.tryParse(readMatch.group(1)!);

    final opusMatch = _opusRegex.firstMatch(path);
    if (opusMatch != null) return int.tryParse(opusMatch.group(1)!);

    return int.tryParse(uri.queryParameters['id'] ?? '');
  }

  static Future<Map<String, dynamic>?> extractInitialState(String html) async {
    final match = _initialStateRegex.firstMatch(html);
    if (match == null) return null;

    try {
      final data = match.group(1);
      if (data == null || data.isEmpty) return null;
      final decoded = await jsonDecodeCompute(data);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return decoded.cast<String, dynamic>();
    } catch (_) {
      return null;
    }
    return null;
  }
}
