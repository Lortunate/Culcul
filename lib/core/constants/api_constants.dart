class UIConstants {
  UIConstants._();

  static const double screenPadding = 12.0;
  static const double itemSpacing = 12.0;
  static const double radius = 8.0;

  static const Duration animDuration = Duration(milliseconds: 200);
  static const Duration shimmerDuration = Duration(milliseconds: 1500);
}

class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://api.bilibili.com';
  static const String nav = '/x/web-interface/nav';
  static const String feedRcmd = '/x/web-interface/wbi/index/top/feed/rcmd';
  static const String videoView = '/x/web-interface/view';
  static const String videoPlayUrl = '/x/player/wbi/playurl';
  static const String related = '/x/web-interface/archive/related';

  // Headers
  static const String userAgent =
      'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36';
  static const String referer = 'https://www.bilibili.com/';
}
