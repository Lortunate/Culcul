class JsonUtils {
  JsonUtils._();

  static int? parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
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
    return value.map((e) => parseStringWithDefault(e)).toList();
  }
}

