import 'package:culcul/core/utils/format_utils.dart';

extension FormatIntExtension on int {
  String get formatNumber => FormatUtils.formatNumber(this);
  String get formatDuration => FormatUtils.formatDuration(this);
  String formatTimestamp() => FormatUtils.formatTimestamp(this);
}

extension FormatStringExtension on String {
  int get parseDuration => FormatUtils.parseDurationString(this);
}

extension FormatOptionalStringExtension on String? {
  int get parseDuration => FormatUtils.parseDurationString(this);
  String get formatImageUrl => FormatUtils.formatImageUrl(this);
}

extension FormatDateTimeExtension on DateTime {
  String toSimpleDate() {
    final now = DateTime.now();
    if (year == now.year && month == now.month && day == now.day) {
      return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    } else if (year == now.year) {
      return '${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
    } else {
      return '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
    }
  }
}
