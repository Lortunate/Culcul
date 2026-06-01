///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsZhHant with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsZhHant({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.zhHant,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <zh-Hant>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsZhHant _root = this; // ignore: unused_field

	@override 
	TranslationsZhHant $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsZhHant(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsNavZhHant nav = _TranslationsNavZhHant._(_root);
	@override late final _TranslationsHomeZhHant home = _TranslationsHomeZhHant._(_root);
	@override late final _TranslationsMomentsZhHant moments = _TranslationsMomentsZhHant._(_root);
	@override late final _TranslationsRankingZhHant ranking = _TranslationsRankingZhHant._(_root);
	@override late final _TranslationsSettingsZhHant settings = _TranslationsSettingsZhHant._(_root);
	@override late final _TranslationsAuthZhHant auth = _TranslationsAuthZhHant._(_root);
	@override late final _TranslationsProfileZhHant profile = _TranslationsProfileZhHant._(_root);
	@override late final _TranslationsFavoritesZhHant favorites = _TranslationsFavoritesZhHant._(_root);
	@override late final _TranslationsSearchZhHant search = _TranslationsSearchZhHant._(_root);
	@override late final _TranslationsVideoZhHant video = _TranslationsVideoZhHant._(_root);
	@override late final _TranslationsActionsZhHant actions = _TranslationsActionsZhHant._(_root);
	@override late final _TranslationsCommonZhHant common = _TranslationsCommonZhHant._(_root);
	@override late final _TranslationsErrorZhHant error = _TranslationsErrorZhHant._(_root);
	@override late final _TranslationsFormatZhHant format = _TranslationsFormatZhHant._(_root);
	@override late final _TranslationsWatchLaterZhHant watch_later = _TranslationsWatchLaterZhHant._(_root);
	@override late final _TranslationsSubscriptionZhHant subscription = _TranslationsSubscriptionZhHant._(_root);
	@override late final _TranslationsNotificationZhHant notification = _TranslationsNotificationZhHant._(_root);
	@override late final _TranslationsLiveZhHant live = _TranslationsLiveZhHant._(_root);
	@override late final _TranslationsHistoryZhHant history = _TranslationsHistoryZhHant._(_root);
}

// Path: nav
class _TranslationsNavZhHant implements TranslationsNavEn {
	_TranslationsNavZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get home => '首頁';
	@override String get moments => '動態';
	@override String get ranking => '排行榜';
	@override String get profile => '我的';
}

// Path: home
class _TranslationsHomeZhHant implements TranslationsHomeEn {
	_TranslationsHomeZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsHomeTabsZhHant tabs = _TranslationsHomeTabsZhHant._(_root);
	@override String get search_hint => '搜尋影片...';
	@override late final _TranslationsHomeVideoMoreZhHant video_more = _TranslationsHomeVideoMoreZhHant._(_root);
}

// Path: moments
class _TranslationsMomentsZhHant implements TranslationsMomentsEn {
	_TranslationsMomentsZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '動態';
	@override late final _TranslationsMomentsTabsZhHant tabs = _TranslationsMomentsTabsZhHant._(_root);
	@override String get like_coming_soon => '按讚功能開發中';
	@override String empty({required Object tab}) => '${tab} 動態暫未實現';
	@override String get recently_followed => '最近關注';
	@override String get topic_search_hint => '搜索話題';
	@override String get topic_search_empty => '輸入關鍵詞搜索話題';
	@override String get topic_search_no_result => '未找到相關話題';
	@override String topic_updates({required Object count}) => '更新 ${count} 條動態';
	@override String get no_comments => '暫無評論，快來搶沙發吧~';
	@override String get comment_hint => '友善評論，文明發言';
	@override String get publish => '發佈';
	@override String get publish_title => '發佈動態';
	@override String get publish_action => '發佈';
	@override String get publish_hint => '分享你的新鮮事...';
	@override String get publish_success => '發佈成功';
	@override String publish_failed({required Object error}) => '發佈失敗: ${error}';
	@override String get discard_title => '提示';
	@override String get discard_confirm => '確定要放棄編輯嗎？';
	@override String get discard_action => '放棄';
	@override String get forward_post => '轉發動態';
	@override String get reserve => '預約';
	@override String get reserved => '已預約';
	@override String get vote => '投票';
	@override String vote_stats({required Object participants, required Object options}) => '${participants}人蔘與 · ${options}個選項';
	@override String get copy_link => '複製鏈接';
	@override String get open_in_browser => '瀏覽器打開';
	@override String get copied_link => '已複製動態鏈接';
	@override String get open_link_failed => '無法打開鏈接';
	@override String operation_failed({required Object message}) => '操作失敗: ${message}';
	@override String get detail_title => '動態詳情';
}

// Path: ranking
class _TranslationsRankingZhHant implements TranslationsRankingEn {
	_TranslationsRankingZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '排行榜';
	@override late final _TranslationsRankingCategoriesZhHant categories = _TranslationsRankingCategoriesZhHant._(_root);
}

// Path: settings
class _TranslationsSettingsZhHant implements TranslationsSettingsEn {
	_TranslationsSettingsZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '設定';
	@override late final _TranslationsSettingsSectionsZhHant sections = _TranslationsSettingsSectionsZhHant._(_root);
	@override String get language => '切換語言';
	@override String get appearance => '外觀設定';
	@override String get chinese => '簡體中文';
	@override String get traditional_chinese => '繁體中文';
	@override String get english => 'English';
	@override late final _TranslationsSettingsThemeModeZhHant theme_mode = _TranslationsSettingsThemeModeZhHant._(_root);
	@override String get clear_cache => '清理快取';
	@override String get user_agreement => '使用者協議';
	@override String get privacy_policy => '隱私權政策';
	@override String get version => '目前版本';
}

// Path: auth
class _TranslationsAuthZhHant implements TranslationsAuthEn {
	_TranslationsAuthZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get login => '登入';
	@override String get logout => '登出';
	@override late final _TranslationsAuthMethodsZhHant methods = _TranslationsAuthMethodsZhHant._(_root);
	@override String get username => '帳號';
	@override String get username_hint => '手機號碼/電子信箱';
	@override String get password => '密碼';
	@override String get phone => '手機號碼';
	@override String get sms_code => '驗證碼';
	@override String get get_code => '獲取驗證碼';
	@override String get_code_retry({required Object seconds}) => '重新獲取(${seconds} s)';
	@override String get qr_hint => '請使用 culcul 客戶端掃描登入';
	@override String get qr_refresh => '重新整理 QR Code';
	@override late final _TranslationsAuthQrStatusZhHant qr_status = _TranslationsAuthQrStatusZhHant._(_root);
	@override String get sms_sent => '驗證碼已發送';
	@override String get subtitle => '第三方輕量化客戶端';
	@override String get select_country => '選擇地區';
	@override String get search_country_hint => '搜索國家或地區';
	@override String get no_search_result => '未找到相關結果';
	@override String get welcome_back => '歡迎回來';
	@override String get please_enter_username_password => '請輸入帳號和密碼';
	@override String get ok => '確定';
}

// Path: profile
class _TranslationsProfileZhHant implements TranslationsProfileEn {
	_TranslationsProfileZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get login => '登入';
	@override String get not_logged_in => '未登入';
	@override String get login_hint => '點擊登入體驗更多功能';
	@override late final _TranslationsProfileStatsZhHant stats = _TranslationsProfileStatsZhHant._(_root);
	@override late final _TranslationsProfileActionsZhHant actions = _TranslationsProfileActionsZhHant._(_root);
	@override late final _TranslationsProfileVipZhHant vip = _TranslationsProfileVipZhHant._(_root);
	@override late final _TranslationsProfileMenuZhHant menu = _TranslationsProfileMenuZhHant._(_root);
	@override late final _TranslationsProfileTabsZhHant tabs = _TranslationsProfileTabsZhHant._(_root);
	@override late final _TranslationsProfileHomeTabZhHant home_tab = _TranslationsProfileHomeTabZhHant._(_root);
	@override late final _TranslationsProfileFollowingsZhHant followings = _TranslationsProfileFollowingsZhHant._(_root);
	@override late final _TranslationsProfileFollowersZhHant followers = _TranslationsProfileFollowersZhHant._(_root);
	@override late final _TranslationsProfileRelationZhHant relation = _TranslationsProfileRelationZhHant._(_root);
	@override String get privacy_title => '該用戶設置了隱私';
	@override String get privacy_message => '無法查看關注/粉絲列表';
	@override String get verified_badge => 'bilibili認證';
	@override String get logout_confirm => '確定要退出登錄嗎？';
	@override String get space_search_coming_soon => '空間搜索開發中';
}

// Path: favorites
class _TranslationsFavoritesZhHant implements TranslationsFavoritesEn {
	_TranslationsFavoritesZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '我的收藏';
	@override String get created => '創建的';
	@override String get collected => '收藏的';
	@override String get private => '私密';
	@override String get public => '公開';
	@override String get play => '播放';
	@override String count({required Object count}) => '共 ${count} 個內容';
	@override String get search_hint => '搜尋收藏內容';
	@override String folder_item_count({required Object count}) => '${count}個內容';
	@override String get new_folder => '新建收藏夾';
	@override String get edit_folder => '編輯收藏夾';
	@override String get delete_folder => '刪除收藏夾';
	@override String get delete_folder_confirm => '確定要刪除這個收藏夾嗎？';
	@override String delete_with_count({required Object count}) => '刪除 (${count})';
	@override String get edit_info => '編輯信息';
	@override String get manage_resources => '管理內容';
	@override String get only_visible_to_me => '僅自己可見';
	@override String get folder_title => '標題';
	@override String get folder_intro => '簡介';
}

// Path: search
class _TranslationsSearchZhHant implements TranslationsSearchEn {
	_TranslationsSearchZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get placeholder => '大家都在搜：culcul';
	@override String get button => '搜尋';
	@override String get history => '搜尋歷史';
	@override String get hot_search => '熱搜榜';
	@override String get clear_history => '清空歷史';
	@override String get suggestion => '搜尋建議';
	@override String get no_result => '沒有找到相關內容';
	@override String get trending => '大家都在搜';
	@override late final _TranslationsSearchTabsZhHant tabs = _TranslationsSearchTabsZhHant._(_root);
	@override late final _TranslationsSearchStatusZhHant status = _TranslationsSearchStatusZhHant._(_root);
	@override late final _TranslationsSearchFilterZhHant filter = _TranslationsSearchFilterZhHant._(_root);
}

// Path: video
class _TranslationsVideoZhHant implements TranslationsVideoEn {
	_TranslationsVideoZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsVideoTabsZhHant tabs = _TranslationsVideoTabsZhHant._(_root);
	@override String get recommend => '推薦影片';
	@override late final _TranslationsVideoCommentZhHant comment = _TranslationsVideoCommentZhHant._(_root);
	@override String get load_failed => '影片載入失敗';
	@override String get tags => '標籤';
	@override String get no_desc => '暫無簡介';
	@override String get expand_all => '展開全部';
	@override late final _TranslationsVideoQualityZhHant quality = _TranslationsVideoQualityZhHant._(_root);
	@override late final _TranslationsVideoPlayerZhHant player = _TranslationsVideoPlayerZhHant._(_root);
	@override late final _TranslationsVideoActionsZhHant actions = _TranslationsVideoActionsZhHant._(_root);
	@override String reply_to({required Object name}) => '回覆 @${name} : ';
	@override String get parts => '影片分段';
	@override String get expand => '展開';
	@override String get collapse => '收起';
	@override String get listen => '聽視頻';
	@override late final _TranslationsVideoListenSettingsZhHant listen_settings = _TranslationsVideoListenSettingsZhHant._(_root);
	@override String watching_count({required Object count}) => '${count}人正在看';
	@override String get detail_page => '詳情頁';
}

// Path: actions
class _TranslationsActionsZhHant implements TranslationsActionsEn {
	_TranslationsActionsZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get like => '讚';
	@override String get unlike => '不喜歡';
	@override String get follow => '關注';
	@override String get followed => '已關注';
	@override String get share => '分享';
	@override String get reply => '回覆';
	@override String get comment => '評論';
	@override String get forward => '轉發';
}

// Path: common
class _TranslationsCommonZhHant implements TranslationsCommonEn {
	_TranslationsCommonZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get no_content => '暫無內容';
	@override String coming_soon({required Object tab}) => '${tab} 內容暫未實現';
	@override String get loading => '載入中...';
	@override String get error => '出錯了';
	@override String get retry => '重試';
	@override String get refresh => '重新整理';
	@override String get load_more => '載入更多';
	@override String get no_more => '沒有更多了';
	@override String get cancel => '取消';
	@override String get confirm => '確定';
	@override String get save => '保存';
	@override String get delete => '刪除';
	@override String view_count({required Object count}) => '${count}次播放';
	@override String danmaku_count({required Object count}) => '${count}條彈幕';
	@override String get pull_down_to_refresh => '下拉可以重新整理';
	@override String get release_to_refresh => '鬆開立即重新整理';
	@override String get refresh_completed => '重新整理成功';
	@override String get refresh_failed => '重新整理失敗';
	@override String get pull_up_to_load_more => '上拉載入更多';
	@override String get release_to_load_more => '鬆開載入更多';
	@override String get load_failed => '載入失敗';
	@override String get load_completed => '載入完成';
	@override String get no_more_content => '沒有更多內容了';
	@override String get up => 'UP';
	@override String get save_image => '保存圖片';
	@override String get saving => '保存中...';
	@override String get save_success => '已保存到系統相冊';
	@override String save_failed({required Object message}) => '保存失敗：${message}';
	@override String get slide_to_switch => '左右滑動切換';
	@override String get no_data => '暫無數據';
}

// Path: error
class _TranslationsErrorZhHant implements TranslationsErrorEn {
	_TranslationsErrorZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get connection_timeout => '連線逾時';
	@override String get send_timeout => '請求逾時';
	@override String get receive_timeout => '回應逾時';
	@override String bad_response({required Object code}) => '伺服器回應錯誤: ${code}';
	@override String get cancel => '請求取消';
	@override String get network => '網路連線異常';
	@override String get auth_failed => '登入失效，請重新登入';
	@override String get server_error => '伺服器請求異常';
	@override String get details => '錯誤詳情';
	@override String get view_details => '查看詳情';
	@override String get stack_trace => '堆疊資訊';
}

// Path: format
class _TranslationsFormatZhHant implements TranslationsFormatEn {
	_TranslationsFormatZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get hundred_million => '億';
	@override String get ten_thousand => '萬';
	@override String hours_ago({required Object hours}) => '${hours}小時前';
	@override String minutes_ago({required Object minutes}) => '${minutes}分鐘前';
	@override String get just_now => '剛剛';
}

// Path: watch_later
class _TranslationsWatchLaterZhHant implements TranslationsWatchLaterEn {
	_TranslationsWatchLaterZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '稍後再看';
	@override String get clear_all => '清空稍後再看';
	@override String get clear_all_confirm => '確定要清空稍後再看列表嗎？';
	@override String watch_to({required Object progress}) => '觀看至 ${progress}';
	@override String get add_success => '已添加至稍後再看';
}

// Path: subscription
class _TranslationsSubscriptionZhHant implements TranslationsSubscriptionEn {
	_TranslationsSubscriptionZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '訂閱';
	@override late final _TranslationsSubscriptionTabsZhHant tabs = _TranslationsSubscriptionTabsZhHant._(_root);
	@override String empty({required Object tab}) => '${tab} 暫無內容';
}

// Path: notification
class _TranslationsNotificationZhHant implements TranslationsNotificationEn {
	_TranslationsNotificationZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '訊息';
	@override late final _TranslationsNotificationTypesZhHant types = _TranslationsNotificationTypesZhHant._(_root);
	@override String get related_content => '相關內容';
	@override String navigation_error({required Object type, required Object id}) => '無法跳轉到內容: ${type} ${id}';
	@override late final _TranslationsNotificationChatZhHant chat = _TranslationsNotificationChatZhHant._(_root);
	@override String get empty => '暫無通知';
}

// Path: live
class _TranslationsLiveZhHant implements TranslationsLiveEn {
	_TranslationsLiveZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsLiveHeaderZhHant header = _TranslationsLiveHeaderZhHant._(_root);
	@override late final _TranslationsLiveTagsZhHant tags = _TranslationsLiveTagsZhHant._(_root);
	@override late final _TranslationsLiveDanmakuZhHant danmaku = _TranslationsLiveDanmakuZhHant._(_root);
}

// Path: history
class _TranslationsHistoryZhHant implements TranslationsHistoryEn {
	_TranslationsHistoryZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get empty => '暫無歷史記錄';
}

// Path: home.tabs
class _TranslationsHomeTabsZhHant implements TranslationsHomeTabsEn {
	_TranslationsHomeTabsZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get live => '直播';
	@override String get recommend => '推薦';
	@override String get hot => '熱門';
	@override String get anime => '動畫';
	@override String get cinema => '影視';
	@override String get new_journey => '新征程';
	@override String get weekly_must_watch => '每週必看';
}

// Path: home.video_more
class _TranslationsHomeVideoMoreZhHant implements TranslationsHomeVideoMoreEn {
	_TranslationsHomeVideoMoreZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get watch_later => '稍後再看';
	@override String get download_cover => '下載封面';
	@override String get invalid_video_id => '無法獲取視頻ID';
	@override String get added_to_watch_later => '已添加至稍後再看';
	@override String add_failed({required Object error}) => '添加失敗: ${error}';
	@override String download_failed({required Object error}) => '下載失敗: ${error}';
}

// Path: moments.tabs
class _TranslationsMomentsTabsZhHant implements TranslationsMomentsTabsEn {
	_TranslationsMomentsTabsZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get all => '全部';
	@override String get video => '影片';
	@override String get pgc => '番劇/影視';
}

// Path: ranking.categories
class _TranslationsRankingCategoriesZhHant implements TranslationsRankingCategoriesEn {
	_TranslationsRankingCategoriesZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get all => '全站';
	@override String get animation => '動畫';
	@override String get bangumi => '番劇';
	@override String get guochuang => '國創';
	@override String get music => '音樂';
	@override String get dance => '舞蹈';
	@override String get game => '遊戲';
	@override String get knowledge => '知識';
	@override String get technology => '科技';
	@override String get sports => '運動';
	@override String get car => '汽車';
	@override String get life => '生活';
	@override String get food => '美食';
	@override String get animal => '動物';
	@override String get kichiku => '鬼畜';
	@override String get fashion => '時尚';
	@override String get information => '資訊';
	@override String get entertainment => '娛樂';
	@override String get film => '影視';
	@override String get documentary => '紀錄片';
	@override String get movie => '電影';
	@override String get tv => '電視劇';
	@override String get tech_digital => '科技數碼';
	@override String get short_play => '小劇場';
	@override String get fashion_beauty => '時尚美妝';
	@override String get sports_fitness => '體育運動';
	@override String get vlog => 'vlog';
	@override String get painting => '繪畫';
	@override String get ai => '人工智能';
	@override String get home => '家裝房產';
	@override String get outdoor => '戶外潮流';
	@override String get fitness => '健身';
	@override String get craft => '手工';
	@override String get travel => '旅遊出行';
	@override String get three_rural => '三農';
	@override String get parenting => '親子';
	@override String get health => '健康';
	@override String get emotion => '情感';
	@override String get life_interest => '生活興趣';
	@override String get life_experience => '生活經驗';
}

// Path: settings.sections
class _TranslationsSettingsSectionsZhHant implements TranslationsSettingsSectionsEn {
	_TranslationsSettingsSectionsZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get general => '通用設定';
	@override String get appearance => '外觀設定';
	@override String get storage => '儲存管理';
	@override String get about => '關於';
}

// Path: settings.theme_mode
class _TranslationsSettingsThemeModeZhHant implements TranslationsSettingsThemeModeEn {
	_TranslationsSettingsThemeModeZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get system => '跟隨系統';
	@override String get dark => '深色模式';
	@override String get light => '淺色模式';
}

// Path: auth.methods
class _TranslationsAuthMethodsZhHant implements TranslationsAuthMethodsEn {
	_TranslationsAuthMethodsZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get account => '帳號';
	@override String get sms => '驗證碼';
	@override String get qr => '二維碼';
}

// Path: auth.qr_status
class _TranslationsAuthQrStatusZhHant implements TranslationsAuthQrStatusEn {
	_TranslationsAuthQrStatusZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get loading => '載入中...';
	@override String get success => '登入成功';
	@override String get scanned => '已掃描，請在手機上確認';
	@override String get expired => 'QR Code 已過期';
	@override String get error => '載入 QR Code 失敗';
}

// Path: profile.stats
class _TranslationsProfileStatsZhHant implements TranslationsProfileStatsEn {
	_TranslationsProfileStatsZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get posts => '動態';
	@override String get following => '關注';
	@override String get followers => '粉絲';
	@override String get likes => '獲讚';
}

// Path: profile.actions
class _TranslationsProfileActionsZhHant implements TranslationsProfileActionsEn {
	_TranslationsProfileActionsZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get message => '私訊';
	@override String get edit_profile => '編輯資料';
}

// Path: profile.vip
class _TranslationsProfileVipZhHant implements TranslationsProfileVipEn {
	_TranslationsProfileVipZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get premium => '大會員';
	@override String get annual_premium => '年度大會員';
}

// Path: profile.menu
class _TranslationsProfileMenuZhHant implements TranslationsProfileMenuEn {
	_TranslationsProfileMenuZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get history => '歷史記錄';
	@override String get download => '離線快取';
	@override String get favorites => '我的收藏';
	@override String get watch_later => '稍後再看';
	@override String get appearance => '外觀設定';
	@override String get creative_center => '創作中心';
	@override String get orders => '會員購訂單';
	@override String get support => '聯繫客服';
	@override String get blacklist => '加入黑名單';
	@override String get report => '舉報';
}

// Path: profile.tabs
class _TranslationsProfileTabsZhHant implements TranslationsProfileTabsEn {
	_TranslationsProfileTabsZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get home => '主頁';
	@override String get moments => '動態';
	@override String get contribution => '投稿';
}

// Path: profile.home_tab
class _TranslationsProfileHomeTabZhHant implements TranslationsProfileHomeTabEn {
	_TranslationsProfileHomeTabZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String recent_videos({required Object count}) => '視頻 ${count}';
	@override String get view_more => '查看更多';
	@override String get empty => '暫無內容';
	@override String get sticky => '置頂視頻';
	@override String get sticky_tag => '置頂';
	@override String get masterpiece => '代表作';
}

// Path: profile.followings
class _TranslationsProfileFollowingsZhHant implements TranslationsProfileFollowingsEn {
	_TranslationsProfileFollowingsZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '我的關注';
	@override String get empty => '暫無關注';
}

// Path: profile.followers
class _TranslationsProfileFollowersZhHant implements TranslationsProfileFollowersEn {
	_TranslationsProfileFollowersZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '我的粉絲';
	@override String get empty => '暫無粉絲';
}

// Path: profile.relation
class _TranslationsProfileRelationZhHant implements TranslationsProfileRelationEn {
	_TranslationsProfileRelationZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get none => '關注';
	@override String get followed => '已關注';
	@override String get mutual => '互粉';
	@override String get blacklisted => '已拉黑';
	@override String failed({required Object error}) => '操作失敗: ${error}';
}

// Path: search.tabs
class _TranslationsSearchTabsZhHant implements TranslationsSearchTabsEn {
	_TranslationsSearchTabsZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get all => '綜合';
	@override String get video => '視頻';
	@override String get anime => '番劇';
	@override String get user => '用戶';
	@override String get article => '專欄';
}

// Path: search.status
class _TranslationsSearchStatusZhHant implements TranslationsSearchStatusEn {
	_TranslationsSearchStatusZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get loading => '正在獲取建議...';
	@override String get empty => '未發現相關搜索建議';
	@override String get failed => '獲取建議失敗';
}

// Path: search.filter
class _TranslationsSearchFilterZhHant implements TranslationsSearchFilterEn {
	_TranslationsSearchFilterZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get sort_default => '綜合排序';
	@override String get sort_newest => '最新發布';
	@override String get sort_click => '最多點擊';
	@override String get sort_danmaku => '最多彈幕';
	@override String get sort_favorite => '最多收藏';
	@override String get duration_all => '全部時長';
	@override String get duration_short => '10分鐘以下';
	@override String get duration_medium => '10-30分鐘';
	@override String get duration_long => '30-60分鐘';
	@override String get duration_extra_long => '60分鐘以上';
}

// Path: video.tabs
class _TranslationsVideoTabsZhHant implements TranslationsVideoTabsEn {
	_TranslationsVideoTabsZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get info => '簡介';
	@override String get comment => '評論';
}

// Path: video.comment
class _TranslationsVideoCommentZhHant implements TranslationsVideoCommentEn {
	_TranslationsVideoCommentZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get empty => '暫無評論，快來搶沙發吧！';
	@override String count({required Object count}) => '${count} 條評論';
	@override String get sort_hot => '按熱度';
	@override String get sort_time => '按時間';
	@override String get all => '全部評論';
	@override String get detail => '評論詳情';
	@override String get related_replies => '相關回覆';
	@override String replies({required Object count}) => '查看全部 ${count} 條回覆';
	@override String get hint => '發個友善的評論';
}

// Path: video.quality
class _TranslationsVideoQualityZhHant implements TranslationsVideoQualityEn {
	_TranslationsVideoQualityZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get p4k => '4K 超清';
	@override String get p1080 => '1080P 高清';
	@override String get p720 => '720P 高清';
	@override String get p480 => '480P 清晰';
	@override String get p360 => '360P 流暢';
	@override String get p240 => '240P 流暢';
	@override String get p144 => '144P 极速';
	@override String get p8k => '8K 超高清';
	@override String get p_dolby => '杜比視界';
	@override String get p_hdr => 'HDR 真彩';
	@override String get p1080_60 => '1080P 60幀';
	@override String get p1080_high => '1080P 高碼率';
	@override String get p720_60 => '720P 60幀';
	@override String get unknown => '未知';
	@override String get auto => '自動';
}

// Path: video.player
class _TranslationsVideoPlayerZhHant implements TranslationsVideoPlayerEn {
	_TranslationsVideoPlayerZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get speed => '倍速';
	@override String get quality => '解析度';
	@override String get danmaku => '彈幕';
	@override String get full_screen => '全螢幕';
	@override String get retry => '重試播放';
	@override String get brightness => '亮度';
	@override String get volume => '音量';
	@override String get panel_title => '播放設定';
	@override String get panel_subtitle => '優先保留播放時最常調整的控制項';
	@override String get danmaku_settings => '彈幕設置';
	@override String get danmaku_section_hint => '調整彈幕可見度、區域、速度與類型';
	@override String get danmaku_opacity => '不透明度';
	@override String get danmaku_scale => '字號縮放';
	@override String get danmaku_area => '顯示區域';
	@override String get danmaku_speed => '彈幕速度';
	@override String get danmaku_type_scroll => '滾動';
	@override String get danmaku_type_top => '頂部';
	@override String get danmaku_type_bottom => '底部';
	@override String get danmaku_type_color => '彩色';
	@override String speed_playing({required Object speedx}) => '${speedx} 倍速播放中';
	@override String get speed_default => '標準速度';
	@override String get speed_section_hint => '從慢放到高倍速都可以直接切換';
	@override String get choose_quality => '選擇畫質';
	@override String get choose_speed => '播放速度';
	@override String get quality_section_hint => '優先展示當前影片實際支援的解析度';
	@override String get quality_unavailable => '當前影片暫時沒有可切換的畫質';
	@override String get danmaku_closed => '已關閉彈幕';
}

// Path: video.actions
class _TranslationsVideoActionsZhHant implements TranslationsVideoActionsEn {
	_TranslationsVideoActionsZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get coin => '投幣';
	@override String get favorite => '收藏';
}

// Path: video.listen_settings
class _TranslationsVideoListenSettingsZhHant implements TranslationsVideoListenSettingsEn {
	_TranslationsVideoListenSettingsZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '聽視頻設定';
	@override String get sleep_timer => '定時關閉';
	@override String get timer_off => '未開啟';
	@override String remaining({required Object time}) => '剩餘 ${time}';
	@override String preset_minutes({required Object minutes}) => '${minutes} 分鐘';
	@override String custom_hint({required Object min, required Object max}) => '自訂分鐘（${min}-${max}）';
	@override String custom_invalid_range({required Object min, required Object max}) => '請輸入 ${min}-${max} 之間的分鐘數';
	@override String get minutes_unit => '分鐘';
	@override String get set_custom => '設定';
	@override String get disable => '關閉定時';
}

// Path: subscription.tabs
class _TranslationsSubscriptionTabsZhHant implements TranslationsSubscriptionTabsEn {
	_TranslationsSubscriptionTabsZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get video => '影片';
	@override String get anime => '番劇';
	@override String get cinema => '影視';
}

// Path: notification.types
class _TranslationsNotificationTypesZhHant implements TranslationsNotificationTypesEn {
	_TranslationsNotificationTypesZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get like => '讚了我的評論';
	@override String get at => '@了我';
	@override String get reply => '回覆了我';
	@override String get system => '系統通知';
}

// Path: notification.chat
class _TranslationsNotificationChatZhHant implements TranslationsNotificationChatEn {
	_TranslationsNotificationChatZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get message_withdrawn => '訊息已撤回';
	@override String unsupported_type({required Object type}) => '[不支援的訊息類型: ${type}]';
	@override String get no_message => '暫無消息';
	@override String get input_hint => '發個消息...';
	@override String get page_not_developed => '用戶詳情頁暫未開發';
	@override String send_failed({required Object error}) => '發送失敗: ${error}';
	@override String get summary_text => '文字訊息';
	@override String get summary_image => '圖片';
	@override String get summary_notice => '系統通知';
	@override String get summary_video => '影片';
	@override String get summary_article => '專欄';
	@override String get summary_card => '卡片';
	@override String get summary_share => '分享內容';
	@override String get summary_unknown => '未知訊息';
}

// Path: live.header
class _TranslationsLiveHeaderZhHant implements TranslationsLiveHeaderEn {
	_TranslationsLiveHeaderZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String online({required Object count}) => '${count}人看過';
	@override String guard({required Object count}) => '${count}人艦隊';
}

// Path: live.tags
class _TranslationsLiveTagsZhHant implements TranslationsLiveTagsEn {
	_TranslationsLiveTagsZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get hot => '熱門榜';
	@override String get popularity => '人氣榜';
	@override String get more_play => '更多幫玩';
}

// Path: live.danmaku
class _TranslationsLiveDanmakuZhHant implements TranslationsLiveDanmakuEn {
	_TranslationsLiveDanmakuZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get system_notice => '系統提示';
	@override String get system_notice_colon => '系統提示:';
	@override String get admin => '房管';
	@override String get input_hint => '發個彈幕唄~';
	@override String get support_hint => '彈幕支持下~';
	@override String get welcome => '歡迎來到直播間~ 喜歡主播點個關注哦';
	@override String get enter_room => '進入直播間';
	@override String get followed => '關注了主播';
	@override String get shared => '分享了直播間';
	@override String gift_feed({required Object giftName, required Object num}) => '投餵了 ${giftName} x${num}';
}

/// The flat map containing all translations for locale <zh-Hant>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsZhHant {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'nav.home' => '首頁',
			'nav.moments' => '動態',
			'nav.ranking' => '排行榜',
			'nav.profile' => '我的',
			'home.tabs.live' => '直播',
			'home.tabs.recommend' => '推薦',
			'home.tabs.hot' => '熱門',
			'home.tabs.anime' => '動畫',
			'home.tabs.cinema' => '影視',
			'home.tabs.new_journey' => '新征程',
			'home.tabs.weekly_must_watch' => '每週必看',
			'home.search_hint' => '搜尋影片...',
			'home.video_more.watch_later' => '稍後再看',
			'home.video_more.download_cover' => '下載封面',
			'home.video_more.invalid_video_id' => '無法獲取視頻ID',
			'home.video_more.added_to_watch_later' => '已添加至稍後再看',
			'home.video_more.add_failed' => ({required Object error}) => '添加失敗: ${error}',
			'home.video_more.download_failed' => ({required Object error}) => '下載失敗: ${error}',
			'moments.title' => '動態',
			'moments.tabs.all' => '全部',
			'moments.tabs.video' => '影片',
			'moments.tabs.pgc' => '番劇/影視',
			'moments.like_coming_soon' => '按讚功能開發中',
			'moments.empty' => ({required Object tab}) => '${tab} 動態暫未實現',
			'moments.recently_followed' => '最近關注',
			'moments.topic_search_hint' => '搜索話題',
			'moments.topic_search_empty' => '輸入關鍵詞搜索話題',
			'moments.topic_search_no_result' => '未找到相關話題',
			'moments.topic_updates' => ({required Object count}) => '更新 ${count} 條動態',
			'moments.no_comments' => '暫無評論，快來搶沙發吧~',
			'moments.comment_hint' => '友善評論，文明發言',
			'moments.publish' => '發佈',
			'moments.publish_title' => '發佈動態',
			'moments.publish_action' => '發佈',
			'moments.publish_hint' => '分享你的新鮮事...',
			'moments.publish_success' => '發佈成功',
			'moments.publish_failed' => ({required Object error}) => '發佈失敗: ${error}',
			'moments.discard_title' => '提示',
			'moments.discard_confirm' => '確定要放棄編輯嗎？',
			'moments.discard_action' => '放棄',
			'moments.forward_post' => '轉發動態',
			'moments.reserve' => '預約',
			'moments.reserved' => '已預約',
			'moments.vote' => '投票',
			'moments.vote_stats' => ({required Object participants, required Object options}) => '${participants}人蔘與 · ${options}個選項',
			'moments.copy_link' => '複製鏈接',
			'moments.open_in_browser' => '瀏覽器打開',
			'moments.copied_link' => '已複製動態鏈接',
			'moments.open_link_failed' => '無法打開鏈接',
			'moments.operation_failed' => ({required Object message}) => '操作失敗: ${message}',
			'moments.detail_title' => '動態詳情',
			'ranking.title' => '排行榜',
			'ranking.categories.all' => '全站',
			'ranking.categories.animation' => '動畫',
			'ranking.categories.bangumi' => '番劇',
			'ranking.categories.guochuang' => '國創',
			'ranking.categories.music' => '音樂',
			'ranking.categories.dance' => '舞蹈',
			'ranking.categories.game' => '遊戲',
			'ranking.categories.knowledge' => '知識',
			'ranking.categories.technology' => '科技',
			'ranking.categories.sports' => '運動',
			'ranking.categories.car' => '汽車',
			'ranking.categories.life' => '生活',
			'ranking.categories.food' => '美食',
			'ranking.categories.animal' => '動物',
			'ranking.categories.kichiku' => '鬼畜',
			'ranking.categories.fashion' => '時尚',
			'ranking.categories.information' => '資訊',
			'ranking.categories.entertainment' => '娛樂',
			'ranking.categories.film' => '影視',
			'ranking.categories.documentary' => '紀錄片',
			'ranking.categories.movie' => '電影',
			'ranking.categories.tv' => '電視劇',
			'ranking.categories.tech_digital' => '科技數碼',
			'ranking.categories.short_play' => '小劇場',
			'ranking.categories.fashion_beauty' => '時尚美妝',
			'ranking.categories.sports_fitness' => '體育運動',
			'ranking.categories.vlog' => 'vlog',
			'ranking.categories.painting' => '繪畫',
			'ranking.categories.ai' => '人工智能',
			'ranking.categories.home' => '家裝房產',
			'ranking.categories.outdoor' => '戶外潮流',
			'ranking.categories.fitness' => '健身',
			'ranking.categories.craft' => '手工',
			'ranking.categories.travel' => '旅遊出行',
			'ranking.categories.three_rural' => '三農',
			'ranking.categories.parenting' => '親子',
			'ranking.categories.health' => '健康',
			'ranking.categories.emotion' => '情感',
			'ranking.categories.life_interest' => '生活興趣',
			'ranking.categories.life_experience' => '生活經驗',
			'settings.title' => '設定',
			'settings.sections.general' => '通用設定',
			'settings.sections.appearance' => '外觀設定',
			'settings.sections.storage' => '儲存管理',
			'settings.sections.about' => '關於',
			'settings.language' => '切換語言',
			'settings.appearance' => '外觀設定',
			'settings.chinese' => '簡體中文',
			'settings.traditional_chinese' => '繁體中文',
			'settings.english' => 'English',
			'settings.theme_mode.system' => '跟隨系統',
			'settings.theme_mode.dark' => '深色模式',
			'settings.theme_mode.light' => '淺色模式',
			'settings.clear_cache' => '清理快取',
			'settings.user_agreement' => '使用者協議',
			'settings.privacy_policy' => '隱私權政策',
			'settings.version' => '目前版本',
			'auth.login' => '登入',
			'auth.logout' => '登出',
			'auth.methods.account' => '帳號',
			'auth.methods.sms' => '驗證碼',
			'auth.methods.qr' => '二維碼',
			'auth.username' => '帳號',
			'auth.username_hint' => '手機號碼/電子信箱',
			'auth.password' => '密碼',
			'auth.phone' => '手機號碼',
			'auth.sms_code' => '驗證碼',
			'auth.get_code' => '獲取驗證碼',
			'auth.get_code_retry' => ({required Object seconds}) => '重新獲取(${seconds} s)',
			'auth.qr_hint' => '請使用 culcul 客戶端掃描登入',
			'auth.qr_refresh' => '重新整理 QR Code',
			'auth.qr_status.loading' => '載入中...',
			'auth.qr_status.success' => '登入成功',
			'auth.qr_status.scanned' => '已掃描，請在手機上確認',
			'auth.qr_status.expired' => 'QR Code 已過期',
			'auth.qr_status.error' => '載入 QR Code 失敗',
			'auth.sms_sent' => '驗證碼已發送',
			'auth.subtitle' => '第三方輕量化客戶端',
			'auth.select_country' => '選擇地區',
			'auth.search_country_hint' => '搜索國家或地區',
			'auth.no_search_result' => '未找到相關結果',
			'auth.welcome_back' => '歡迎回來',
			'auth.please_enter_username_password' => '請輸入帳號和密碼',
			'auth.ok' => '確定',
			'profile.login' => '登入',
			'profile.not_logged_in' => '未登入',
			'profile.login_hint' => '點擊登入體驗更多功能',
			'profile.stats.posts' => '動態',
			'profile.stats.following' => '關注',
			'profile.stats.followers' => '粉絲',
			'profile.stats.likes' => '獲讚',
			'profile.actions.message' => '私訊',
			'profile.actions.edit_profile' => '編輯資料',
			'profile.vip.premium' => '大會員',
			'profile.vip.annual_premium' => '年度大會員',
			'profile.menu.history' => '歷史記錄',
			'profile.menu.download' => '離線快取',
			'profile.menu.favorites' => '我的收藏',
			'profile.menu.watch_later' => '稍後再看',
			'profile.menu.appearance' => '外觀設定',
			'profile.menu.creative_center' => '創作中心',
			'profile.menu.orders' => '會員購訂單',
			'profile.menu.support' => '聯繫客服',
			'profile.menu.blacklist' => '加入黑名單',
			'profile.menu.report' => '舉報',
			'profile.tabs.home' => '主頁',
			'profile.tabs.moments' => '動態',
			'profile.tabs.contribution' => '投稿',
			'profile.home_tab.recent_videos' => ({required Object count}) => '視頻 ${count}',
			'profile.home_tab.view_more' => '查看更多',
			'profile.home_tab.empty' => '暫無內容',
			'profile.home_tab.sticky' => '置頂視頻',
			'profile.home_tab.sticky_tag' => '置頂',
			'profile.home_tab.masterpiece' => '代表作',
			'profile.followings.title' => '我的關注',
			'profile.followings.empty' => '暫無關注',
			'profile.followers.title' => '我的粉絲',
			'profile.followers.empty' => '暫無粉絲',
			'profile.relation.none' => '關注',
			'profile.relation.followed' => '已關注',
			'profile.relation.mutual' => '互粉',
			'profile.relation.blacklisted' => '已拉黑',
			'profile.relation.failed' => ({required Object error}) => '操作失敗: ${error}',
			'profile.privacy_title' => '該用戶設置了隱私',
			'profile.privacy_message' => '無法查看關注/粉絲列表',
			'profile.verified_badge' => 'bilibili認證',
			'profile.logout_confirm' => '確定要退出登錄嗎？',
			'profile.space_search_coming_soon' => '空間搜索開發中',
			'favorites.title' => '我的收藏',
			'favorites.created' => '創建的',
			'favorites.collected' => '收藏的',
			'favorites.private' => '私密',
			'favorites.public' => '公開',
			'favorites.play' => '播放',
			'favorites.count' => ({required Object count}) => '共 ${count} 個內容',
			'favorites.search_hint' => '搜尋收藏內容',
			'favorites.folder_item_count' => ({required Object count}) => '${count}個內容',
			'favorites.new_folder' => '新建收藏夾',
			'favorites.edit_folder' => '編輯收藏夾',
			'favorites.delete_folder' => '刪除收藏夾',
			'favorites.delete_folder_confirm' => '確定要刪除這個收藏夾嗎？',
			'favorites.delete_with_count' => ({required Object count}) => '刪除 (${count})',
			'favorites.edit_info' => '編輯信息',
			'favorites.manage_resources' => '管理內容',
			'favorites.only_visible_to_me' => '僅自己可見',
			'favorites.folder_title' => '標題',
			'favorites.folder_intro' => '簡介',
			'search.placeholder' => '大家都在搜：culcul',
			'search.button' => '搜尋',
			'search.history' => '搜尋歷史',
			'search.hot_search' => '熱搜榜',
			'search.clear_history' => '清空歷史',
			'search.suggestion' => '搜尋建議',
			'search.no_result' => '沒有找到相關內容',
			'search.trending' => '大家都在搜',
			'search.tabs.all' => '綜合',
			'search.tabs.video' => '視頻',
			'search.tabs.anime' => '番劇',
			'search.tabs.user' => '用戶',
			'search.tabs.article' => '專欄',
			'search.status.loading' => '正在獲取建議...',
			'search.status.empty' => '未發現相關搜索建議',
			'search.status.failed' => '獲取建議失敗',
			'search.filter.sort_default' => '綜合排序',
			'search.filter.sort_newest' => '最新發布',
			'search.filter.sort_click' => '最多點擊',
			'search.filter.sort_danmaku' => '最多彈幕',
			'search.filter.sort_favorite' => '最多收藏',
			'search.filter.duration_all' => '全部時長',
			'search.filter.duration_short' => '10分鐘以下',
			'search.filter.duration_medium' => '10-30分鐘',
			'search.filter.duration_long' => '30-60分鐘',
			'search.filter.duration_extra_long' => '60分鐘以上',
			'video.tabs.info' => '簡介',
			'video.tabs.comment' => '評論',
			'video.recommend' => '推薦影片',
			'video.comment.empty' => '暫無評論，快來搶沙發吧！',
			'video.comment.count' => ({required Object count}) => '${count} 條評論',
			'video.comment.sort_hot' => '按熱度',
			'video.comment.sort_time' => '按時間',
			'video.comment.all' => '全部評論',
			'video.comment.detail' => '評論詳情',
			'video.comment.related_replies' => '相關回覆',
			'video.comment.replies' => ({required Object count}) => '查看全部 ${count} 條回覆',
			'video.comment.hint' => '發個友善的評論',
			'video.load_failed' => '影片載入失敗',
			'video.tags' => '標籤',
			'video.no_desc' => '暫無簡介',
			'video.expand_all' => '展開全部',
			'video.quality.p4k' => '4K 超清',
			'video.quality.p1080' => '1080P 高清',
			'video.quality.p720' => '720P 高清',
			'video.quality.p480' => '480P 清晰',
			'video.quality.p360' => '360P 流暢',
			'video.quality.p240' => '240P 流暢',
			'video.quality.p144' => '144P 极速',
			'video.quality.p8k' => '8K 超高清',
			'video.quality.p_dolby' => '杜比視界',
			'video.quality.p_hdr' => 'HDR 真彩',
			'video.quality.p1080_60' => '1080P 60幀',
			'video.quality.p1080_high' => '1080P 高碼率',
			'video.quality.p720_60' => '720P 60幀',
			'video.quality.unknown' => '未知',
			'video.quality.auto' => '自動',
			'video.player.speed' => '倍速',
			'video.player.quality' => '解析度',
			'video.player.danmaku' => '彈幕',
			'video.player.full_screen' => '全螢幕',
			'video.player.retry' => '重試播放',
			'video.player.brightness' => '亮度',
			'video.player.volume' => '音量',
			'video.player.panel_title' => '播放設定',
			'video.player.panel_subtitle' => '優先保留播放時最常調整的控制項',
			'video.player.danmaku_settings' => '彈幕設置',
			'video.player.danmaku_section_hint' => '調整彈幕可見度、區域、速度與類型',
			'video.player.danmaku_opacity' => '不透明度',
			'video.player.danmaku_scale' => '字號縮放',
			'video.player.danmaku_area' => '顯示區域',
			'video.player.danmaku_speed' => '彈幕速度',
			'video.player.danmaku_type_scroll' => '滾動',
			'video.player.danmaku_type_top' => '頂部',
			'video.player.danmaku_type_bottom' => '底部',
			'video.player.danmaku_type_color' => '彩色',
			'video.player.speed_playing' => ({required Object speedx}) => '${speedx} 倍速播放中',
			'video.player.speed_default' => '標準速度',
			'video.player.speed_section_hint' => '從慢放到高倍速都可以直接切換',
			'video.player.choose_quality' => '選擇畫質',
			'video.player.choose_speed' => '播放速度',
			'video.player.quality_section_hint' => '優先展示當前影片實際支援的解析度',
			'video.player.quality_unavailable' => '當前影片暫時沒有可切換的畫質',
			'video.player.danmaku_closed' => '已關閉彈幕',
			'video.actions.coin' => '投幣',
			'video.actions.favorite' => '收藏',
			'video.reply_to' => ({required Object name}) => '回覆 @${name} : ',
			'video.parts' => '影片分段',
			'video.expand' => '展開',
			'video.collapse' => '收起',
			'video.listen' => '聽視頻',
			'video.listen_settings.title' => '聽視頻設定',
			'video.listen_settings.sleep_timer' => '定時關閉',
			'video.listen_settings.timer_off' => '未開啟',
			'video.listen_settings.remaining' => ({required Object time}) => '剩餘 ${time}',
			'video.listen_settings.preset_minutes' => ({required Object minutes}) => '${minutes} 分鐘',
			'video.listen_settings.custom_hint' => ({required Object min, required Object max}) => '自訂分鐘（${min}-${max}）',
			'video.listen_settings.custom_invalid_range' => ({required Object min, required Object max}) => '請輸入 ${min}-${max} 之間的分鐘數',
			'video.listen_settings.minutes_unit' => '分鐘',
			'video.listen_settings.set_custom' => '設定',
			'video.listen_settings.disable' => '關閉定時',
			'video.watching_count' => ({required Object count}) => '${count}人正在看',
			'video.detail_page' => '詳情頁',
			'actions.like' => '讚',
			'actions.unlike' => '不喜歡',
			'actions.follow' => '關注',
			'actions.followed' => '已關注',
			'actions.share' => '分享',
			'actions.reply' => '回覆',
			'actions.comment' => '評論',
			'actions.forward' => '轉發',
			'common.no_content' => '暫無內容',
			'common.coming_soon' => ({required Object tab}) => '${tab} 內容暫未實現',
			'common.loading' => '載入中...',
			'common.error' => '出錯了',
			'common.retry' => '重試',
			'common.refresh' => '重新整理',
			'common.load_more' => '載入更多',
			'common.no_more' => '沒有更多了',
			'common.cancel' => '取消',
			'common.confirm' => '確定',
			'common.save' => '保存',
			'common.delete' => '刪除',
			'common.view_count' => ({required Object count}) => '${count}次播放',
			'common.danmaku_count' => ({required Object count}) => '${count}條彈幕',
			'common.pull_down_to_refresh' => '下拉可以重新整理',
			'common.release_to_refresh' => '鬆開立即重新整理',
			'common.refresh_completed' => '重新整理成功',
			'common.refresh_failed' => '重新整理失敗',
			'common.pull_up_to_load_more' => '上拉載入更多',
			'common.release_to_load_more' => '鬆開載入更多',
			'common.load_failed' => '載入失敗',
			'common.load_completed' => '載入完成',
			'common.no_more_content' => '沒有更多內容了',
			'common.up' => 'UP',
			'common.save_image' => '保存圖片',
			'common.saving' => '保存中...',
			'common.save_success' => '已保存到系統相冊',
			'common.save_failed' => ({required Object message}) => '保存失敗：${message}',
			'common.slide_to_switch' => '左右滑動切換',
			'common.no_data' => '暫無數據',
			'error.connection_timeout' => '連線逾時',
			'error.send_timeout' => '請求逾時',
			'error.receive_timeout' => '回應逾時',
			'error.bad_response' => ({required Object code}) => '伺服器回應錯誤: ${code}',
			'error.cancel' => '請求取消',
			'error.network' => '網路連線異常',
			'error.auth_failed' => '登入失效，請重新登入',
			'error.server_error' => '伺服器請求異常',
			'error.details' => '錯誤詳情',
			'error.view_details' => '查看詳情',
			'error.stack_trace' => '堆疊資訊',
			'format.hundred_million' => '億',
			'format.ten_thousand' => '萬',
			'format.hours_ago' => ({required Object hours}) => '${hours}小時前',
			'format.minutes_ago' => ({required Object minutes}) => '${minutes}分鐘前',
			'format.just_now' => '剛剛',
			'watch_later.title' => '稍後再看',
			'watch_later.clear_all' => '清空稍後再看',
			'watch_later.clear_all_confirm' => '確定要清空稍後再看列表嗎？',
			'watch_later.watch_to' => ({required Object progress}) => '觀看至 ${progress}',
			'watch_later.add_success' => '已添加至稍後再看',
			'subscription.title' => '訂閱',
			'subscription.tabs.video' => '影片',
			'subscription.tabs.anime' => '番劇',
			'subscription.tabs.cinema' => '影視',
			'subscription.empty' => ({required Object tab}) => '${tab} 暫無內容',
			'notification.title' => '訊息',
			'notification.types.like' => '讚了我的評論',
			'notification.types.at' => '@了我',
			'notification.types.reply' => '回覆了我',
			'notification.types.system' => '系統通知',
			'notification.related_content' => '相關內容',
			'notification.navigation_error' => ({required Object type, required Object id}) => '無法跳轉到內容: ${type} ${id}',
			'notification.chat.message_withdrawn' => '訊息已撤回',
			'notification.chat.unsupported_type' => ({required Object type}) => '[不支援的訊息類型: ${type}]',
			'notification.chat.no_message' => '暫無消息',
			'notification.chat.input_hint' => '發個消息...',
			'notification.chat.page_not_developed' => '用戶詳情頁暫未開發',
			'notification.chat.send_failed' => ({required Object error}) => '發送失敗: ${error}',
			'notification.chat.summary_text' => '文字訊息',
			'notification.chat.summary_image' => '圖片',
			'notification.chat.summary_notice' => '系統通知',
			'notification.chat.summary_video' => '影片',
			'notification.chat.summary_article' => '專欄',
			'notification.chat.summary_card' => '卡片',
			'notification.chat.summary_share' => '分享內容',
			'notification.chat.summary_unknown' => '未知訊息',
			'notification.empty' => '暫無通知',
			'live.header.online' => ({required Object count}) => '${count}人看過',
			'live.header.guard' => ({required Object count}) => '${count}人艦隊',
			'live.tags.hot' => '熱門榜',
			'live.tags.popularity' => '人氣榜',
			'live.tags.more_play' => '更多幫玩',
			'live.danmaku.system_notice' => '系統提示',
			'live.danmaku.system_notice_colon' => '系統提示:',
			'live.danmaku.admin' => '房管',
			'live.danmaku.input_hint' => '發個彈幕唄~',
			'live.danmaku.support_hint' => '彈幕支持下~',
			'live.danmaku.welcome' => '歡迎來到直播間~ 喜歡主播點個關注哦',
			'live.danmaku.enter_room' => '進入直播間',
			'live.danmaku.followed' => '關注了主播',
			'live.danmaku.shared' => '分享了直播間',
			'live.danmaku.gift_feed' => ({required Object giftName, required Object num}) => '投餵了 ${giftName} x${num}',
			'history.empty' => '暫無歷史記錄',
			_ => null,
		};
	}
}
