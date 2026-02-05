class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://api.bilibili.com';
  static const String liveBaseUrl = 'https://api.live.bilibili.com';
  static const String nav = '/x/web-interface/nav';
  static const String feedRcmd = '/x/web-interface/wbi/index/top/feed/rcmd';
  static const String popular = '/x/web-interface/popular';
  static const String ranking = '/x/web-interface/ranking/v2';
  static const String videoView = '/x/web-interface/view';
  static const String videoPlayUrl = '/x/player/wbi/playurl';
  static const String related = '/x/web-interface/archive/related';
  static const String videoTags = '/x/tag/archive/tags';

  static const String userAgent =
      'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36';
  static const String referer = 'https://www.bilibili.com/';

  // Auth
  static const String passportBaseUrl = 'https://passport.bilibili.com';
  static const String captcha = '/x/passport-login/captcha?source=main_web';
  static const String smsSend = '/x/passport-login/web/sms/send';
  static const String smsLogin = '/x/passport-login/web/login/sms';
  static const String qrGenerate = '/x/passport-login/web/qrcode/generate';
  static const String qrPoll = '/x/passport-login/web/qrcode/poll';
  static const String userInfo = '/x/web-interface/nav';
}
