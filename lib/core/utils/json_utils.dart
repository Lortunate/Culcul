class JsonUtils {
  JsonUtils._();

  static int? parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) {
      if (value.isEmpty) return null;
      return int.tryParse(value);
    }
    return null;
  }

  static int parseIntWithDefault(dynamic value, [int defaultValue = 0]) {
    return parseInt(value) ?? defaultValue;
  }

  static String parseStringWithDefault(dynamic value, [String defaultValue = '']) {
    if (value == null) return defaultValue;
    if (value is String) return value;
    return value.toString();
  }

  static List<String> parseStringListWithDefault(dynamic value) {
    if (value is! List) return const [];
    return value.map(parseStringWithDefault).toList();
  }

  static Map<String, dynamic>? asStringKeyedMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      try {
        return Map<String, dynamic>.from(value);
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  static List<Map<String, dynamic>> parseObjectList(dynamic value) {
    if (value is! List) return const [];
    final objects = <Map<String, dynamic>>[];
    for (final item in value) {
      final map = asStringKeyedMap(item);
      if (map != null) {
        objects.add(map);
      }
    }
    return objects;
  }
}
