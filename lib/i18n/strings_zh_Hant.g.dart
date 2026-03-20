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
	@override late final _TranslationsFavZhHant fav = _TranslationsFavZhHant._(_root);
	@override late final _TranslationsSearchZhHant search = _TranslationsSearchZhHant._(_root);
	@override late final _TranslationsVideoZhHant video = _TranslationsVideoZhHant._(_root);
	@override late final _TranslationsCommonZhHant common = _TranslationsCommonZhHant._(_root);
	@override late final _TranslationsErrorZhHant error = _TranslationsErrorZhHant._(_root);
	@override late final _TranslationsFormatZhHant format = _TranslationsFormatZhHant._(_root);
	@override late final _TranslationsToViewZhHant to_view = _TranslationsToViewZhHant._(_root);
	@override late final _TranslationsSubscriptionZhHant subscription = _TranslationsSubscriptionZhHant._(_root);
	@override late final _TranslationsNotificationZhHant notification = _TranslationsNotificationZhHant._(_root);
	@override late final _TranslationsLiveZhHant live = _TranslationsLiveZhHant._(_root);
}

// Path: nav
class _TranslationsNavZhHant implements TranslationsNavEn {
	_TranslationsNavZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get home => '首頁';
	@override String get moments => '動態';
	@override String get ranking => '排行榜';
	@override String get mine => '我的';
}

// Path: home
class _TranslationsHomeZhHant implements TranslationsHomeEn {
	_TranslationsHomeZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsHomeTabsZhHant tabs = _TranslationsHomeTabsZhHant._(_root);
	@override String get search_hint => '搜尋影片...';
}

// Path: moments
class _TranslationsMomentsZhHant implements TranslationsMomentsEn {
	_TranslationsMomentsZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '動態';
	@override late final _TranslationsMomentsTabsZhHant tabs = _TranslationsMomentsTabsZhHant._(_root);
	@override late final _TranslationsMomentsActionsZhHant actions = _TranslationsMomentsActionsZhHant._(_root);
	@override String get like_coming_soon => '按讚功能開發中';
	@override String empty({required Object tab}) => '${tab} 動態暫未實現';
}

// Path: ranking
class _TranslationsRankingZhHant implements TranslationsRankingEn {
	_TranslationsRankingZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '排行榜';
}

// Path: settings
class _TranslationsSettingsZhHant implements TranslationsSettingsEn {
	_TranslationsSettingsZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '設定';
	@override String get language => '通用設定';
	@override String get change_language => '切換語言';
	@override String get chinese => '簡體中文';
	@override String get traditional_chinese => '繁體中文';
	@override String get english => 'English';
	@override String get appearance => '外觀設定';
	@override String get system_mode => '跟隨系統';
	@override String get dark_mode => '深色模式';
	@override String get light_mode => '淺色模式';
	@override String get cache => '快取管理';
	@override String get clear_cache => '清理快取';
	@override String get user_agreement => '使用者協議';
	@override String get privacy_policy => '隱私權政策';
	@override String get about => '關於';
	@override String get version => '目前版本';
}

// Path: auth
class _TranslationsAuthZhHant implements TranslationsAuthEn {
	_TranslationsAuthZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get login => '登入';
	@override String get logout => '登出';
	@override String get account_login => '帳號登入';
	@override String get sms_login => '驗證碼登入';
	@override String get qr_login => 'QR Code 登入';
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
}

// Path: fav
class _TranslationsFavZhHant implements TranslationsFavEn {
	_TranslationsFavZhHant._(this._root);

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
}

// Path: video
class _TranslationsVideoZhHant implements TranslationsVideoEn {
	_TranslationsVideoZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsVideoTabsZhHant tabs = _TranslationsVideoTabsZhHant._(_root);
	@override String get recommend => '推薦影片';
	@override String get comment_empty => '評論區建設中...';
	@override String comment_count({required Object count}) => '${count} 條評論';
	@override String get comment_sort_hot => '按熱度';
	@override String get comment_sort_time => '按時間';
	@override String get all_comments => '全部評論';
	@override String get comment_detail => '評論詳情';
	@override String get related_replies => '相關回覆';
	@override String replies({required Object count}) => '查看全部 ${count} 條回覆';
	@override String get load_failed => '影片載入失敗';
	@override String get tags => '標籤';
	@override String get no_desc => '暫無簡介';
	@override String get expand_all => '展開全部';
	@override late final _TranslationsVideoQualityZhHant quality = _TranslationsVideoQualityZhHant._(_root);
	@override late final _TranslationsVideoPlaybackZhHant playback = _TranslationsVideoPlaybackZhHant._(_root);
	@override late final _TranslationsVideoActionsZhHant actions = _TranslationsVideoActionsZhHant._(_root);
	@override String reply_to({required Object name}) => '回覆 @${name} : ';
	@override String get parts => '影片分段';
	@override String get expand => '展開';
	@override String get collapse => '收起';
	@override String get comment_hint => '發個友善的評論';
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

// Path: to_view
class _TranslationsToViewZhHant implements TranslationsToViewEn {
	_TranslationsToViewZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '稍後再看';
	@override String get clear_all => '清空稍後再看';
	@override String get clear_all_confirm => '確定要清空稍後再看列表嗎？';
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
}

// Path: moments.tabs
class _TranslationsMomentsTabsZhHant implements TranslationsMomentsTabsEn {
	_TranslationsMomentsTabsZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get all => '全部';
	@override String get video => '影片';
	@override String get comprehensive => '綜合';
}

// Path: moments.actions
class _TranslationsMomentsActionsZhHant implements TranslationsMomentsActionsEn {
	_TranslationsMomentsActionsZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get forward => '轉發';
	@override String get comment => '評論';
	@override String get like => '讚';
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
	@override String get dynamic => '動態';
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
	@override String get collection => '我的收藏';
	@override String get later => '稍後再看';
	@override String get theme => '個人裝扮';
	@override String get creative_center => '創作中心';
	@override String get orders => '會員購訂單';
	@override String get customer_service => '聯繫客服';
}

// Path: video.tabs
class _TranslationsVideoTabsZhHant implements TranslationsVideoTabsEn {
	_TranslationsVideoTabsZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get info => '簡介';
	@override String get comment => '評論';
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
	@override String get p144 => '144P 極速';
}

// Path: video.playback
class _TranslationsVideoPlaybackZhHant implements TranslationsVideoPlaybackEn {
	_TranslationsVideoPlaybackZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get speed => '倍速';
	@override String get quality => '畫質';
	@override String get danmaku => '彈幕';
	@override String get full_screen => '全螢幕';
	@override String get retry => '重試播放';
}

// Path: video.actions
class _TranslationsVideoActionsZhHant implements TranslationsVideoActionsEn {
	_TranslationsVideoActionsZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get like => '讚';
	@override String get unlike => '不喜歡';
	@override String get coin => '投幣';
	@override String get favorite => '收藏';
	@override String get share => '分享';
	@override String get followed => '已關注';
	@override String get follow => '關注';
	@override String get reply => '回覆';
}

// Path: subscription.tabs
class _TranslationsSubscriptionTabsZhHant implements TranslationsSubscriptionTabsEn {
	_TranslationsSubscriptionTabsZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get video => '影片';
	@override String get anime => '番劇';
	@override String get series => '影視';
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
			'nav.mine' => '我的',
			'home.tabs.live' => '直播',
			'home.tabs.recommend' => '推薦',
			'home.tabs.hot' => '熱門',
			'home.tabs.anime' => '動畫',
			'home.tabs.cinema' => '影視',
			'home.tabs.new_journey' => '新征程',
			'home.search_hint' => '搜尋影片...',
			'moments.title' => '動態',
			'moments.tabs.all' => '全部',
			'moments.tabs.video' => '影片',
			'moments.tabs.comprehensive' => '綜合',
			'moments.actions.forward' => '轉發',
			'moments.actions.comment' => '評論',
			'moments.actions.like' => '讚',
			'moments.like_coming_soon' => '按讚功能開發中',
			'moments.empty' => ({required Object tab}) => '${tab} 動態暫未實現',
			'ranking.title' => '排行榜',
			'settings.title' => '設定',
			'settings.language' => '通用設定',
			'settings.change_language' => '切換語言',
			'settings.chinese' => '簡體中文',
			'settings.traditional_chinese' => '繁體中文',
			'settings.english' => 'English',
			'settings.appearance' => '外觀設定',
			'settings.system_mode' => '跟隨系統',
			'settings.dark_mode' => '深色模式',
			'settings.light_mode' => '淺色模式',
			'settings.cache' => '快取管理',
			'settings.clear_cache' => '清理快取',
			'settings.user_agreement' => '使用者協議',
			'settings.privacy_policy' => '隱私權政策',
			'settings.about' => '關於',
			'settings.version' => '目前版本',
			'auth.login' => '登入',
			'auth.logout' => '登出',
			'auth.account_login' => '帳號登入',
			'auth.sms_login' => '驗證碼登入',
			'auth.qr_login' => 'QR Code 登入',
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
			'profile.login' => '登入',
			'profile.not_logged_in' => '未登入',
			'profile.login_hint' => '點擊登入體驗更多功能',
			'profile.stats.dynamic' => '動態',
			'profile.stats.following' => '關注',
			'profile.stats.followers' => '粉絲',
			'profile.stats.likes' => '獲讚',
			'profile.actions.message' => '私訊',
			'profile.vip.premium' => '大會員',
			'profile.vip.annual_premium' => '年度大會員',
			'profile.menu.history' => '歷史記錄',
			'profile.menu.download' => '離線快取',
			'profile.menu.collection' => '我的收藏',
			'profile.menu.later' => '稍後再看',
			'profile.menu.theme' => '個人裝扮',
			'profile.menu.creative_center' => '創作中心',
			'profile.menu.orders' => '會員購訂單',
			'profile.menu.customer_service' => '聯繫客服',
			'fav.title' => '我的收藏',
			'fav.created' => '創建的',
			'fav.collected' => '收藏的',
			'fav.private' => '私密',
			'fav.public' => '公開',
			'fav.play' => '播放',
			'fav.count' => ({required Object count}) => '共 ${count} 個內容',
			'fav.search_hint' => '搜尋收藏內容',
			'search.placeholder' => '大家都在搜：culcul',
			'search.button' => '搜尋',
			'search.history' => '搜尋歷史',
			'search.hot_search' => '熱搜榜',
			'search.clear_history' => '清空歷史',
			'search.suggestion' => '搜尋建議',
			'search.no_result' => '沒有找到相關內容',
			'search.trending' => '大家都在搜',
			'video.tabs.info' => '簡介',
			'video.tabs.comment' => '評論',
			'video.recommend' => '推薦影片',
			'video.comment_empty' => '評論區建設中...',
			'video.comment_count' => ({required Object count}) => '${count} 條評論',
			'video.comment_sort_hot' => '按熱度',
			'video.comment_sort_time' => '按時間',
			'video.all_comments' => '全部評論',
			'video.comment_detail' => '評論詳情',
			'video.related_replies' => '相關回覆',
			'video.replies' => ({required Object count}) => '查看全部 ${count} 條回覆',
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
			'video.quality.p144' => '144P 極速',
			'video.playback.speed' => '倍速',
			'video.playback.quality' => '畫質',
			'video.playback.danmaku' => '彈幕',
			'video.playback.full_screen' => '全螢幕',
			'video.playback.retry' => '重試播放',
			'video.actions.like' => '讚',
			'video.actions.unlike' => '不喜歡',
			'video.actions.coin' => '投幣',
			'video.actions.favorite' => '收藏',
			'video.actions.share' => '分享',
			'video.actions.followed' => '已關注',
			'video.actions.follow' => '關注',
			'video.actions.reply' => '回覆',
			'video.reply_to' => ({required Object name}) => '回覆 @${name} : ',
			'video.parts' => '影片分段',
			'video.expand' => '展開',
			'video.collapse' => '收起',
			'video.comment_hint' => '發個友善的評論',
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
			'error.connection_timeout' => '連線逾時',
			'error.send_timeout' => '請求逾時',
			'error.receive_timeout' => '回應逾時',
			'error.bad_response' => ({required Object code}) => '伺服器回應錯誤: ${code}',
			'error.cancel' => '請求取消',
			'error.network' => '網路連線異常',
			'format.hundred_million' => '億',
			'format.ten_thousand' => '萬',
			'format.hours_ago' => ({required Object hours}) => '${hours}小時前',
			'format.minutes_ago' => ({required Object minutes}) => '${minutes}分鐘前',
			'format.just_now' => '剛剛',
			'to_view.title' => '稍後再看',
			'to_view.clear_all' => '清空稍後再看',
			'to_view.clear_all_confirm' => '確定要清空稍後再看列表嗎？',
			'subscription.title' => '訂閱',
			'subscription.tabs.video' => '影片',
			'subscription.tabs.anime' => '番劇',
			'subscription.tabs.series' => '影視',
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
			'live.header.online' => ({required Object count}) => '${count}人看過',
			'live.header.guard' => ({required Object count}) => '${count}人艦隊',
			'live.tags.hot' => '熱門榜',
			'live.tags.popularity' => '人氣榜',
			'live.tags.more_play' => '更多幫玩',
			'live.danmaku.system_notice' => '系統提示',
			'live.danmaku.system_notice_colon' => '系統提示:',
			'live.danmaku.admin' => '房管',
			_ => null,
		};
	}
}
