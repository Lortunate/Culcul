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
}
