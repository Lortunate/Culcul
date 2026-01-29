import 'package:cilixili/i18n/strings.g.dart';

class FormatUtils {
  FormatUtils._();

  /// Formats large numbers into a readable string (e.g., 1.2万, 1.5亿).
  static String formatNumber(int num) {
    final isZh = t.format.ten_thousand == '万';
    if (isZh) {
      if (num >= 100000000) {
        return '${(num / 100000000).toStringAsFixed(1)}${t.format.hundred_million}';
      }
      if (num >= 10000) {
        return '${(num / 10000).toStringAsFixed(1)}${t.format.ten_thousand}';
      }
    } else {
      if (num >= 1000000) {
        return '${(num / 1000000).toStringAsFixed(1)}M';
      }
      if (num >= 1000) {
        return '${(num / 1000).toStringAsFixed(1)}K';
      }
    }
    return num.toString();
  }

  /// Formats seconds into HH:MM:SS or MM:SS format.
  static String formatDuration(int seconds) {
    final d = Duration(seconds: seconds);
    final hours = d.inHours;
    final minutes = d.inMinutes.remainder(60);
    final sec = d.inSeconds.remainder(60);
    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}';
  }

  /// Formats a timestamp into a relative time string (e.g., 刚刚, 5分钟前, 10-24).
  static String formatTimestamp(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays > 365) {
      return '${date.year}-${date.month}-${date.day}';
    } else if (diff.inDays > 1) {
      return '${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    } else if (diff.inHours >= 1) {
      return t.format.hours_ago(hours: diff.inHours);
    } else if (diff.inMinutes >= 1) {
      return t.format.minutes_ago(minutes: diff.inMinutes);
    } else {
      return t.format.just_now;
    }
  }
}
