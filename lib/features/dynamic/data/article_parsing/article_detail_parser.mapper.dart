part of 'article_detail_parser.dart';

Future<Map<String, dynamic>?> _parseInitialState(String data) async {
  final decoded = await jsonDecodeCompute(data);
  if (decoded is Map<String, dynamic>) return decoded;
  if (decoded is Map) return decoded.cast<String, dynamic>();
  return null;
}

Map<String, dynamic> _findModule(List<Map<String, dynamic>> modules, String type) {
  for (final module in modules) {
    if (module['module_type'] == type) {
      return module;
    }
  }
  return const {};
}

Map<String, dynamic> _asMap(dynamic value) {
  if (value is Map<String, dynamic>) return value;
  if (value is Map) return value.cast<String, dynamic>();
  return const {};
}

int? _extractArticleId(Uri uri) {
  final path = uri.path;
  final readMatch = RegExp(r'/cv(\d+)').firstMatch(path);
  if (readMatch != null) return int.tryParse(readMatch.group(1)!);

  final opusMatch = RegExp(r'/opus/(\d+)').firstMatch(path);
  if (opusMatch != null) return int.tryParse(opusMatch.group(1)!);

  return int.tryParse(uri.queryParameters['id'] ?? '');
}

String? _string(dynamic value) {
  if (value == null) return null;
  final str = value.toString();
  if (str.isEmpty || str == 'null') return null;
  return str;
}

int? _int(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  return int.tryParse(value.toString());
}

double? _double(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  return double.tryParse(value.toString());
}

String _firstNonEmptyString(List<String?> values) {
  for (final value in values) {
    if (value != null && value.trim().isNotEmpty) return value;
  }
  return '';
}

String _normalizeUrl(String raw) {
  if (raw.isEmpty) return raw;
  if (raw.startsWith('//')) return 'https:$raw';
  if (raw.startsWith('/')) return 'https://www.bilibili.com$raw';
  return raw;
}
