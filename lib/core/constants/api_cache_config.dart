class ApiCacheConfig {
  static const Map<String, int> config = {
    // Home & Feed
    '/x/web-interface/wbi/index/top/feed/rcmd': 300, // 5 min
    '/x/web-interface/popular': 1800, // 30 min
    '/x/web-interface/ranking/v2': 1800, // 30 min
    '/x/web-interface/popular/weekly': 3600, // 1 hour
    
    // Video Detail
    '/x/web-interface/view': 600, // 10 min
    '/x/web-interface/archive/related': 900, // 15 min
    '/x/tag/archive/tags': 86400, // 24 hours
    '/x/v2/reply': 30, // 30 sec
    '/x/v2/reply/reply': 30, // 30 sec
    
    // User & Profile
    '/x/space/wbi/acc/info': 600, // 10 min
    '/x/space/upstat': 600,
    '/x/web-interface/nav': 600, // User info
    '/x/relation/stat': 60,
    '/x/relation/followers': 60,
    '/x/relation/followings': 60,

    // Dynamic
    '/x/polymer/web-dynamic/v1/feed/all': 60, // 1 min
    
    // Search
    '/x/web-interface/search/all/v2': 60,
    '/x/web-interface/search/type': 60,
    '/x/web-interface/wbi/search/all/v2': 60,
    '/x/web-interface/wbi/search/type': 60,
    '/x/v2/search/trending/ranking': 1800, // 30 min
    '/x/web-interface/wbi/search/default': 3600, // 1 hour

    // Fav
    '/x/v3/fav/folder/created/list-all': 60,
    '/x/v3/fav/folder/collected/list': 60,
    '/x/v3/fav/resource/list': 60,

    // History
    '/x/web-interface/history/cursor': 30,
  };
}
