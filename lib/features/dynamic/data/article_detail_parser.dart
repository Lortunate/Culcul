import 'dart:convert';

final class ArticleDetailParser {
  const ArticleDetailParser._();

  static int? extractArticleId(Uri uri) {
    final path = uri.path;
    final readMatch = RegExp(r'/cv(\d+)').firstMatch(path);
    if (readMatch != null) return int.tryParse(readMatch.group(1)!);

    final opusMatch = RegExp(r'/opus/(\d+)').firstMatch(path);
    if (opusMatch != null) return int.tryParse(opusMatch.group(1)!);

    return int.tryParse(uri.queryParameters['id'] ?? '');
  }

  static Map<String, dynamic>? extractInitialState(String html) {
    final match = RegExp(
      r'window\.__INITIAL_STATE__\s*=\s*(\{.*?\})\s*;\s*\(function',
      dotAll: true,
    ).firstMatch(html);
    if (match == null) return null;

    try {
      final data = match.group(1);
      if (data == null || data.isEmpty) return null;
      final decoded = jsonDecode(data);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return decoded.cast<String, dynamic>();
    } catch (_) {
      return null;
    }
    return null;
  }
}
