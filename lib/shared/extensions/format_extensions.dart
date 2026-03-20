import 'package:culcul/core/utils/format_utils.dart';

extension FormatIntExtension on int {
  String get formatNumber => FormatUtils.formatNumber(this);
  String get formatDuration => FormatUtils.formatDuration(this);
  String formatTimestamp() => FormatUtils.formatTimestamp(this);
  String get formatFileSize => FormatUtils.formatFileSize(this);

  /// Convenience method to format timestamp using timeago
  String get timeAgo => FormatUtils.formatTimestamp(this);
}

extension FormatDurationExtension on Duration {
  String get formatDuration => FormatUtils.formatDuration(inSeconds);
}

extension FormatStringExtension on String {
  int get parseDuration => FormatUtils.parseDurationString(this);
  String get capitalize => FormatUtils.capitalize(this);
  String truncate(int maxLength, {String suffix = '...'}) =>
      FormatUtils.truncate(this, maxLength, suffix: suffix);
  String get camelCaseToTitle => FormatUtils.camelCaseToTitle(this);
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

  String toIsoDate() {
    return '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
  }
  
  String toChatTime() {
     final now = DateTime.now();
     if (year == now.year && month == now.month && day == now.day) {
       return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
     } else if (year == now.year) {
       return '$month月$day日 ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
     } else {
       return '$year年$month月$day日';
     }
  }
}
