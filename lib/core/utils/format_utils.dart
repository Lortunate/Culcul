import 'package:culcul/i18n/strings.g.dart';

class FormatUtils {
  FormatUtils._();

  static String stripHtmlTags(String htmlString) {
    return htmlString.replaceAll(RegExp(r'<[^>]*>'), '');
  }

  static String formatImageUrl(String? url) {
    if (url == null || url.isEmpty) return '';
    if (url.startsWith('//')) {
      return 'https:$url';
    }
    return url;
  }

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

  static String formatAnyNumber(dynamic value) {
    if (value == null) return '0';
    if (value is int) return formatNumber(value);
    if (value is String) {
      final intValue = int.tryParse(value);
      if (intValue != null) return formatNumber(intValue);
      return value;
    }
    return value.toString();
  }

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

  static int parseDurationString(String? duration) {
    if (duration == null || duration.isEmpty) return 0;
    final parts = duration.split(':');
    try {
      if (parts.length == 2) {
        return int.parse(parts[0]) * 60 + int.parse(parts[1]);
      } else if (parts.length == 3) {
        return int.parse(parts[0]) * 3600 +
            int.parse(parts[1]) * 60 +
            int.parse(parts[2]);
      }
    } catch (_) {}
    return 0;
  }

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
