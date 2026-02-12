import 'package:culcul/i18n/strings.g.dart';
import 'package:timeago/timeago.dart' as timeago;

class TimeAgoUtils {
  static bool _initialized = false;

  static void _ensureInitialized() {
    if (_initialized) return;
    timeago.setLocaleMessages('zh_CN', timeago.ZhCnMessages());
    timeago.setLocaleMessages('zh_TW', timeago.ZhMessages());
    timeago.setLocaleMessages('en_short', timeago.EnShortMessages());
    _initialized = true;
  }

  static String formatTimeAgo(int timestamp, {String? locale}) {
    _ensureInitialized();
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return formatDateTime(date, locale: locale);
  }

  static String formatDateTime(DateTime dateTime, {String? locale}) {
    _ensureInitialized();
    final effectiveLocale = locale ?? _getAppLocale();
    return timeago.format(dateTime, locale: effectiveLocale);
  }

  static String _getAppLocale() {
    final currentLocale = LocaleSettings.currentLocale;
    return switch (currentLocale) {
      AppLocale.zh => 'zh_CN',
      AppLocale.zhHant => 'zh_TW',
      AppLocale.en => 'en_short',
    };
  }
}
