class ApiConstants {
  ApiConstants._();

  // Base URLs
  static const String baseUrl = 'https://api.bilibili.com';
  static const String liveBaseUrl = 'https://api.live.bilibili.com';
  static const String passportBaseUrl = 'https://passport.bilibili.com';

  // API Endpoints
  static const String nav = '/x/web-interface/nav';
  static const String userInfo = '/x/web-interface/nav';
  static const String feedRcmd = '/x/web-interface/wbi/index/top/feed/rcmd';
  static const String popular = '/x/web-interface/popular';
  static const String ranking = '/x/web-interface/ranking/v2';
  static const String videoView = '/x/web-interface/view';
  static const String videoPagelist = '/x/player/pagelist';
  static const String videoPlayUrl = '/x/player/wbi/playurl';
  static const String playerInfo = '/x/player/wbi/v2';
  static const String related = '/x/web-interface/archive/related';
  static const String videoTags = '/x/tag/archive/tags';
  static const String reply = '/x/v2/reply';
  static const String replyReply = '/x/v2/reply/reply';
  static const String replyAction = '/x/v2/reply/action';
  static const String replyHate = '/x/v2/reply/hate';
  static const String replyAdd = '/x/v2/reply/add';
  static const String historyReport = '/x/v2/history/report';
  static const String historyCursor = '/x/web-interface/history/cursor';

  // Favorite List API
  static const String favCreatedList = '/x/v3/fav/folder/created/list-all';
  static const String favCollectedList = '/x/v3/fav/folder/collected/list';
  static const String favResourceList = '/x/v3/fav/resource/list';
  static const String favFolderAdd = '/x/v3/fav/folder/add';
  static const String favFolderEdit = '/x/v3/fav/folder/edit';
  static const String favFolderDel = '/x/v3/fav/folder/del';
  static const String favResourceBatchDel = '/x/v3/fav/resource/batch-del';
  static const String favResourceClean = '/x/v3/fav/resource/clean';

  // Auth API
  static const String captcha = '/x/passport-login/captcha?source=main_web';
  static const String smsSend = '/x/passport-login/web/sms/send';
  static const String smsLogin = '/x/passport-login/web/login/sms';
  static const String qrGenerate = '/x/passport-login/web/qrcode/generate';
  static const String qrPoll = '/x/passport-login/web/qrcode/poll';
  static const String cookieInfo = '/x/passport-login/web/cookie/info';
  static const String cookieRefresh = '/x/passport-login/web/cookie/refresh';

  // Network Configuration
  static const String userAgent =
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
      '(KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36';
  static const String referer = 'https://www.bilibili.com/';

  // Cache Configuration
  static const Map<String, int> cacheConfig = {
    videoView: 120,
    related: 120,
    videoTags: 180,
  };
}
