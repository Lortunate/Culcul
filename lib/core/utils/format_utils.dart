import 'package:culcul/i18n/strings.g.dart';
import 'package:timeago/timeago.dart' as timeago;

/// Formatting utilities for numbers, durations, dates, and strings.
class FormatUtils {
  FormatUtils._();

  static final _htmlTagRegex = RegExp(r'<[^>]*>');
  static bool _timeagoInitialized = false;

  // String utilities
  static String stripHtmlTags(String htmlString) {
    return htmlString.replaceAll(_htmlTagRegex, '');
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
  static String formatTimeAgo(int timestamp, {String? locale}) {
    if (!_timeagoInitialized) {
      timeago.setLocaleMessages('zh_CN', timeago.ZhCnMessages());
      timeago.setLocaleMessages('zh_TW', timeago.ZhMessages());
      timeago.setLocaleMessages('en_short', timeago.EnShortMessages());
      _timeagoInitialized = true;
    }
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final effectiveLocale =
        locale ??
        switch (LocaleSettings.currentLocale) {
          AppLocale.zh => 'zh_CN',
          AppLocale.zhHant => 'zh_TW',
          AppLocale.en => 'en_short',
        };
    return timeago.format(dateTime, locale: effectiveLocale);
  }

  static String formatSimpleDate(DateTime dateTime) {
    final now = DateTime.now();
    if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day) {
      return '${dateTime.hour.toString().padLeft(2, '0')}:'
          '${dateTime.minute.toString().padLeft(2, '0')}';
    }
    if (dateTime.year == now.year) {
      return '${dateTime.month.toString().padLeft(2, '0')}-'
          '${dateTime.day.toString().padLeft(2, '0')}';
    }
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-'
        '${dateTime.day.toString().padLeft(2, '0')}';
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
}

// ── Extensions for idiomatic usage ──

extension FormatIntExtension on int {
  String get formatNumber => FormatUtils.formatNumber(this);
  String get formatDuration => FormatUtils.formatDuration(this);
}

extension FormatDurationExtension on Duration {
  String get formatDuration => FormatUtils.formatDuration(inSeconds);
}
