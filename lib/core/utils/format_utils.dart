import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/core/utils/timeago_utils.dart';

class FormatUtils {
  FormatUtils._();

  // String utilities
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

  // Number formatting
  static String formatNumber(int num) {
    final isZh =
        LocaleSettings.currentLocale == AppLocale.zh ||
        LocaleSettings.currentLocale == AppLocale.zhHant;
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

  // Duration formatting
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

  // Date/time formatting
  static String formatTimestamp(int timestamp) {
    return TimeAgoUtils.formatTimeAgo(timestamp);
  }

  // Additional formatting utilities
  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '${bytes}B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)}KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)}MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)}GB';
  }

  static String capitalize(String str) {
    if (str.isEmpty) return str;
    return str[0].toUpperCase() + str.substring(1).toLowerCase();
  }

  static String truncate(String str, int maxLength, {String suffix = '...'}) {
    if (str.length <= maxLength) return str;
    return str.substring(0, maxLength - suffix.length) + suffix;
  }

  static String camelCaseToTitle(String camelCase) {
    final result = camelCase.replaceAllMapped(
      RegExp(r'([A-Z])'),
      (match) => ' ${match.group(0)}',
    );
    return capitalize(result.trim());
  }
}
