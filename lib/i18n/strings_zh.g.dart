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
class TranslationsZh with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsZh({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.zh,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <zh>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsZh _root = this; // ignore: unused_field

	@override 
	TranslationsZh $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsZh(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsNavZh nav = _TranslationsNavZh._(_root);
	@override late final _TranslationsHomeZh home = _TranslationsHomeZh._(_root);
	@override late final _TranslationsMomentsZh moments = _TranslationsMomentsZh._(_root);
	@override late final _TranslationsRankingZh ranking = _TranslationsRankingZh._(_root);
	@override late final _TranslationsSettingsZh settings = _TranslationsSettingsZh._(_root);
	@override late final _TranslationsAuthZh auth = _TranslationsAuthZh._(_root);
	@override late final _TranslationsProfileZh profile = _TranslationsProfileZh._(_root);
	@override late final _TranslationsFavZh fav = _TranslationsFavZh._(_root);
	@override late final _TranslationsSearchZh search = _TranslationsSearchZh._(_root);
	@override late final _TranslationsVideoZh video = _TranslationsVideoZh._(_root);
	@override late final _TranslationsCommonZh common = _TranslationsCommonZh._(_root);
	@override late final _TranslationsErrorZh error = _TranslationsErrorZh._(_root);
	@override late final _TranslationsFormatZh format = _TranslationsFormatZh._(_root);
	@override late final _TranslationsToViewZh to_view = _TranslationsToViewZh._(_root);
	@override late final _TranslationsSubscriptionZh subscription = _TranslationsSubscriptionZh._(_root);
	@override late final _TranslationsNotificationZh notification = _TranslationsNotificationZh._(_root);
	@override late final _TranslationsLiveZh live = _TranslationsLiveZh._(_root);
}

// Path: nav
class _TranslationsNavZh implements TranslationsNavEn {
	_TranslationsNavZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get home => '首页';
	@override String get moments => '动态';
	@override String get ranking => '排行榜';
	@override String get mine => '我的';
}

// Path: home
class _TranslationsHomeZh implements TranslationsHomeEn {
	_TranslationsHomeZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsHomeTabsZh tabs = _TranslationsHomeTabsZh._(_root);
	@override String get search_hint => '搜索视频...';
}

// Path: moments
class _TranslationsMomentsZh implements TranslationsMomentsEn {
	_TranslationsMomentsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '动态';
	@override late final _TranslationsMomentsTabsZh tabs = _TranslationsMomentsTabsZh._(_root);
	@override late final _TranslationsMomentsActionsZh actions = _TranslationsMomentsActionsZh._(_root);
	@override String get like_coming_soon => '点赞功能开发中';
	@override String empty({required Object tab}) => '${tab} 动态暂未实现';
}

// Path: ranking
class _TranslationsRankingZh implements TranslationsRankingEn {
	_TranslationsRankingZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '排行榜';
}

// Path: settings
class _TranslationsSettingsZh implements TranslationsSettingsEn {
	_TranslationsSettingsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '设置';
	@override String get language => '通用设置';
	@override String get change_language => '切换语言';
	@override String get chinese => '简体中文';
	@override String get traditional_chinese => '繁体中文';
	@override String get english => 'English';
	@override String get appearance => '外观设置';
	@override String get system_mode => '跟随系统';
	@override String get dark_mode => '深色模式';
	@override String get light_mode => '浅色模式';
	@override String get cache => '缓存管理';
	@override String get clear_cache => '清理缓存';
	@override String get user_agreement => '用户协议';
	@override String get privacy_policy => '隐私政策';
	@override String get about => '关于';
	@override String get version => '当前版本';
}

// Path: auth
class _TranslationsAuthZh implements TranslationsAuthEn {
	_TranslationsAuthZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get login => '登录';
	@override String get logout => '退出登录';
	@override String get account_login => '账号登录';
	@override String get sms_login => '验证码登录';
	@override String get qr_login => '二维码登录';
	@override String get username => '账号';
	@override String get username_hint => '手机号/邮箱';
	@override String get password => '密码';
	@override String get phone => '手机号';
	@override String get sms_code => '验证码';
	@override String get get_code => '获取验证码';
	@override String get_code_retry({required Object seconds}) => '重新获取(${seconds} s)';
	@override String get qr_hint => '请使用 culcul 客户端扫码登录';
	@override String get qr_refresh => '刷新二维码';
	@override late final _TranslationsAuthQrStatusZh qr_status = _TranslationsAuthQrStatusZh._(_root);
	@override String get sms_sent => '验证码已发送';
	@override String get subtitle => '第三方轻量化客户端';
}

// Path: profile
class _TranslationsProfileZh implements TranslationsProfileEn {
	_TranslationsProfileZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get login => '登录';
	@override String get not_logged_in => '未登录';
	@override String get login_hint => '点击登录体验更多功能';
	@override late final _TranslationsProfileStatsZh stats = _TranslationsProfileStatsZh._(_root);
	@override late final _TranslationsProfileActionsZh actions = _TranslationsProfileActionsZh._(_root);
	@override late final _TranslationsProfileVipZh vip = _TranslationsProfileVipZh._(_root);
	@override late final _TranslationsProfileMenuZh menu = _TranslationsProfileMenuZh._(_root);
}

// Path: fav
class _TranslationsFavZh implements TranslationsFavEn {
	_TranslationsFavZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '我的收藏';
	@override String get created => '创建的';
	@override String get collected => '收藏的';
	@override String get private => '私密';
	@override String get public => '公开';
	@override String get play => '播放';
	@override String count({required Object count}) => '共 ${count} 个内容';
	@override String get search_hint => '搜索收藏内容';
}

// Path: search
class _TranslationsSearchZh implements TranslationsSearchEn {
	_TranslationsSearchZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get placeholder => '大家都在搜：culcul';
	@override String get button => '搜索';
	@override String get history => '搜索历史';
	@override String get hot_search => '热搜榜';
	@override String get clear_history => '清空历史';
	@override String get suggestion => '搜索建议';
	@override String get no_result => '没有找到相关内容';
	@override String get trending => '大家都在搜';
}

// Path: video
class _TranslationsVideoZh implements TranslationsVideoEn {
	_TranslationsVideoZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsVideoTabsZh tabs = _TranslationsVideoTabsZh._(_root);
	@override String get recommend => '推荐视频';
	@override String get comment_empty => '评论区建设中...';
	@override String comment_count({required Object count}) => '${count} 条评论';
	@override String get comment_sort_hot => '按热度';
	@override String get comment_sort_time => '按时间';
	@override String get all_comments => '全部评论';
	@override String get comment_detail => '评论详情';
	@override String get related_replies => '相关回复';
	@override String replies({required Object count}) => '查看全部 ${count} 条回复';
	@override String get load_failed => '视频加载失败';
	@override String get tags => '标签';
	@override String get no_desc => '暂无简介';
	@override String get expand_all => '展开全部';
	@override late final _TranslationsVideoQualityZh quality = _TranslationsVideoQualityZh._(_root);
	@override late final _TranslationsVideoPlaybackZh playback = _TranslationsVideoPlaybackZh._(_root);
	@override late final _TranslationsVideoActionsZh actions = _TranslationsVideoActionsZh._(_root);
	@override String reply_to({required Object name}) => '回复 @${name} : ';
	@override String get parts => '视频分段';
	@override String get expand => '展开';
	@override String get collapse => '收起';
	@override String get comment_hint => '发个友善的评论';
}

// Path: common
class _TranslationsCommonZh implements TranslationsCommonEn {
	_TranslationsCommonZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get no_content => '暂无内容';
	@override String coming_soon({required Object tab}) => '${tab} 内容暂未实现';
	@override String get loading => '加载中...';
	@override String get error => '出错了';
	@override String get retry => '重试';
	@override String get refresh => '刷新';
	@override String get load_more => '加载更多';
	@override String get no_more => '没有更多了';
	@override String get cancel => '取消';
	@override String get confirm => '确定';
	@override String get save => '保存';
	@override String get delete => '删除';
	@override String view_count({required Object count}) => '${count}次播放';
	@override String danmaku_count({required Object count}) => '${count}条弹幕';
	@override String get pull_down_to_refresh => '下拉可以刷新';
	@override String get release_to_refresh => '松开立即刷新';
	@override String get refresh_completed => '刷新成功';
	@override String get refresh_failed => '刷新失败';
	@override String get pull_up_to_load_more => '上拉加载更多';
	@override String get release_to_load_more => '松开加载更多';
	@override String get load_failed => '加载失败';
	@override String get load_completed => '加载完成';
	@override String get no_more_content => '没有更多内容了';
	@override String get up => 'UP';
}

// Path: error
class _TranslationsErrorZh implements TranslationsErrorEn {
	_TranslationsErrorZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get connection_timeout => '连接超时';
	@override String get send_timeout => '请求超时';
	@override String get receive_timeout => '响应超时';
	@override String bad_response({required Object code}) => '服务器响应错误: ${code}';
	@override String get cancel => '请求取消';
	@override String get network => '网络连接异常';
}

// Path: format
class _TranslationsFormatZh implements TranslationsFormatEn {
	_TranslationsFormatZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get hundred_million => '亿';
	@override String get ten_thousand => '万';
	@override String hours_ago({required Object hours}) => '${hours}小时前';
	@override String minutes_ago({required Object minutes}) => '${minutes}分钟前';
	@override String get just_now => '刚刚';
}

// Path: to_view
class _TranslationsToViewZh implements TranslationsToViewEn {
	_TranslationsToViewZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '稍后再看';
	@override String get clear_all => '清空稍后再看';
	@override String get clear_all_confirm => '确定要清空稍后再看列表吗？';
}

// Path: subscription
class _TranslationsSubscriptionZh implements TranslationsSubscriptionEn {
	_TranslationsSubscriptionZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '订阅';
	@override late final _TranslationsSubscriptionTabsZh tabs = _TranslationsSubscriptionTabsZh._(_root);
	@override String empty({required Object tab}) => '${tab} 暂无内容';
}

// Path: notification
class _TranslationsNotificationZh implements TranslationsNotificationEn {
	_TranslationsNotificationZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '消息';
	@override late final _TranslationsNotificationTypesZh types = _TranslationsNotificationTypesZh._(_root);
	@override String get related_content => '相关内容';
	@override String navigation_error({required Object type, required Object id}) => '无法跳转到内容: ${type} ${id}';
	@override late final _TranslationsNotificationChatZh chat = _TranslationsNotificationChatZh._(_root);
}

// Path: live
class _TranslationsLiveZh implements TranslationsLiveEn {
	_TranslationsLiveZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsLiveHeaderZh header = _TranslationsLiveHeaderZh._(_root);
	@override late final _TranslationsLiveTagsZh tags = _TranslationsLiveTagsZh._(_root);
	@override late final _TranslationsLiveDanmakuZh danmaku = _TranslationsLiveDanmakuZh._(_root);
}

// Path: home.tabs
class _TranslationsHomeTabsZh implements TranslationsHomeTabsEn {
	_TranslationsHomeTabsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get live => '直播';
	@override String get recommend => '推荐';
	@override String get hot => '热门';
	@override String get anime => '动画';
	@override String get cinema => '影视';
	@override String get new_journey => '新征程';
}

// Path: moments.tabs
class _TranslationsMomentsTabsZh implements TranslationsMomentsTabsEn {
	_TranslationsMomentsTabsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get all => '全部';
	@override String get video => '视频';
	@override String get comprehensive => '综合';
}

// Path: moments.actions
class _TranslationsMomentsActionsZh implements TranslationsMomentsActionsEn {
	_TranslationsMomentsActionsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get forward => '转发';
	@override String get comment => '评论';
	@override String get like => '点赞';
}

// Path: auth.qr_status
class _TranslationsAuthQrStatusZh implements TranslationsAuthQrStatusEn {
	_TranslationsAuthQrStatusZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get loading => '加载中...';
	@override String get success => '登录成功';
	@override String get scanned => '已扫描，请在手机上确认';
	@override String get expired => '二维码已过期';
	@override String get error => '加载二维码失败';
}

// Path: profile.stats
class _TranslationsProfileStatsZh implements TranslationsProfileStatsEn {
	_TranslationsProfileStatsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get dynamic => '动态';
	@override String get following => '关注';
	@override String get followers => '粉丝';
	@override String get likes => '获赞';
}

// Path: profile.actions
class _TranslationsProfileActionsZh implements TranslationsProfileActionsEn {
	_TranslationsProfileActionsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get message => '私信';
}

// Path: profile.vip
class _TranslationsProfileVipZh implements TranslationsProfileVipEn {
	_TranslationsProfileVipZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get premium => '大会员';
	@override String get annual_premium => '年度大会员';
}

// Path: profile.menu
class _TranslationsProfileMenuZh implements TranslationsProfileMenuEn {
	_TranslationsProfileMenuZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get history => '历史记录';
	@override String get download => '离线缓存';
	@override String get collection => '我的收藏';
	@override String get later => '稍后再看';
	@override String get theme => '个性装扮';
	@override String get creative_center => '创作中心';
	@override String get orders => '会员购订单';
	@override String get customer_service => '联系客服';
}

// Path: video.tabs
class _TranslationsVideoTabsZh implements TranslationsVideoTabsEn {
	_TranslationsVideoTabsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get info => '简介';
	@override String get comment => '评论';
}

// Path: video.quality
class _TranslationsVideoQualityZh implements TranslationsVideoQualityEn {
	_TranslationsVideoQualityZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get p4k => '4K 超清';
	@override String get p1080 => '1080P 高清';
	@override String get p720 => '720P 高清';
	@override String get p480 => '480P 清晰';
	@override String get p360 => '360P 流畅';
	@override String get p240 => '240P 流畅';
	@override String get p144 => '144P 极速';
}

// Path: video.playback
class _TranslationsVideoPlaybackZh implements TranslationsVideoPlaybackEn {
	_TranslationsVideoPlaybackZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get speed => '倍速';
	@override String get quality => '清晰度';
	@override String get danmaku => '弹幕';
	@override String get full_screen => '全屏';
	@override String get retry => '重试播放';
}

// Path: video.actions
class _TranslationsVideoActionsZh implements TranslationsVideoActionsEn {
	_TranslationsVideoActionsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get like => '点赞';
	@override String get unlike => '不喜欢';
	@override String get coin => '投币';
	@override String get favorite => '收藏';
	@override String get share => '分享';
	@override String get followed => '已关注';
	@override String get follow => '关注';
	@override String get reply => '回复';
}

// Path: subscription.tabs
class _TranslationsSubscriptionTabsZh implements TranslationsSubscriptionTabsEn {
	_TranslationsSubscriptionTabsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get video => '视频';
	@override String get anime => '番剧';
	@override String get series => '影视';
}

// Path: notification.types
class _TranslationsNotificationTypesZh implements TranslationsNotificationTypesEn {
	_TranslationsNotificationTypesZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get like => '赞了我的评论';
	@override String get at => '@了我';
	@override String get reply => '回复了我';
	@override String get system => '系统通知';
}

// Path: notification.chat
class _TranslationsNotificationChatZh implements TranslationsNotificationChatEn {
	_TranslationsNotificationChatZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get message_withdrawn => '消息已撤回';
	@override String unsupported_type({required Object type}) => '[不支持的消息类型: ${type}]';
}

// Path: live.header
class _TranslationsLiveHeaderZh implements TranslationsLiveHeaderEn {
	_TranslationsLiveHeaderZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String online({required Object count}) => '${count}人看过';
	@override String guard({required Object count}) => '${count}人舰队';
}

// Path: live.tags
class _TranslationsLiveTagsZh implements TranslationsLiveTagsEn {
	_TranslationsLiveTagsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get hot => '热门榜';
	@override String get popularity => '人气榜';
	@override String get more_play => '更多帮玩';
}

// Path: live.danmaku
class _TranslationsLiveDanmakuZh implements TranslationsLiveDanmakuEn {
	_TranslationsLiveDanmakuZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get system_notice => '系统提示';
	@override String get system_notice_colon => '系统提示:';
	@override String get admin => '房管';
}

/// The flat map containing all translations for locale <zh>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsZh {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'nav.home' => '首页',
			'nav.moments' => '动态',
			'nav.ranking' => '排行榜',
			'nav.mine' => '我的',
			'home.tabs.live' => '直播',
			'home.tabs.recommend' => '推荐',
			'home.tabs.hot' => '热门',
			'home.tabs.anime' => '动画',
			'home.tabs.cinema' => '影视',
			'home.tabs.new_journey' => '新征程',
			'home.search_hint' => '搜索视频...',
			'moments.title' => '动态',
			'moments.tabs.all' => '全部',
			'moments.tabs.video' => '视频',
			'moments.tabs.comprehensive' => '综合',
			'moments.actions.forward' => '转发',
			'moments.actions.comment' => '评论',
			'moments.actions.like' => '点赞',
			'moments.like_coming_soon' => '点赞功能开发中',
			'moments.empty' => ({required Object tab}) => '${tab} 动态暂未实现',
			'ranking.title' => '排行榜',
			'settings.title' => '设置',
			'settings.language' => '通用设置',
			'settings.change_language' => '切换语言',
			'settings.chinese' => '简体中文',
			'settings.traditional_chinese' => '繁体中文',
			'settings.english' => 'English',
			'settings.appearance' => '外观设置',
			'settings.system_mode' => '跟随系统',
			'settings.dark_mode' => '深色模式',
			'settings.light_mode' => '浅色模式',
			'settings.cache' => '缓存管理',
			'settings.clear_cache' => '清理缓存',
			'settings.user_agreement' => '用户协议',
			'settings.privacy_policy' => '隐私政策',
			'settings.about' => '关于',
			'settings.version' => '当前版本',
			'auth.login' => '登录',
			'auth.logout' => '退出登录',
			'auth.account_login' => '账号登录',
			'auth.sms_login' => '验证码登录',
			'auth.qr_login' => '二维码登录',
			'auth.username' => '账号',
			'auth.username_hint' => '手机号/邮箱',
			'auth.password' => '密码',
			'auth.phone' => '手机号',
			'auth.sms_code' => '验证码',
			'auth.get_code' => '获取验证码',
			'auth.get_code_retry' => ({required Object seconds}) => '重新获取(${seconds} s)',
			'auth.qr_hint' => '请使用 culcul 客户端扫码登录',
			'auth.qr_refresh' => '刷新二维码',
			'auth.qr_status.loading' => '加载中...',
			'auth.qr_status.success' => '登录成功',
			'auth.qr_status.scanned' => '已扫描，请在手机上确认',
			'auth.qr_status.expired' => '二维码已过期',
			'auth.qr_status.error' => '加载二维码失败',
			'auth.sms_sent' => '验证码已发送',
			'auth.subtitle' => '第三方轻量化客户端',
			'profile.login' => '登录',
			'profile.not_logged_in' => '未登录',
			'profile.login_hint' => '点击登录体验更多功能',
			'profile.stats.dynamic' => '动态',
			'profile.stats.following' => '关注',
			'profile.stats.followers' => '粉丝',
			'profile.stats.likes' => '获赞',
			'profile.actions.message' => '私信',
			'profile.vip.premium' => '大会员',
			'profile.vip.annual_premium' => '年度大会员',
			'profile.menu.history' => '历史记录',
			'profile.menu.download' => '离线缓存',
			'profile.menu.collection' => '我的收藏',
			'profile.menu.later' => '稍后再看',
			'profile.menu.theme' => '个性装扮',
			'profile.menu.creative_center' => '创作中心',
			'profile.menu.orders' => '会员购订单',
			'profile.menu.customer_service' => '联系客服',
			'fav.title' => '我的收藏',
			'fav.created' => '创建的',
			'fav.collected' => '收藏的',
			'fav.private' => '私密',
			'fav.public' => '公开',
			'fav.play' => '播放',
			'fav.count' => ({required Object count}) => '共 ${count} 个内容',
			'fav.search_hint' => '搜索收藏内容',
			'search.placeholder' => '大家都在搜：culcul',
			'search.button' => '搜索',
			'search.history' => '搜索历史',
			'search.hot_search' => '热搜榜',
			'search.clear_history' => '清空历史',
			'search.suggestion' => '搜索建议',
			'search.no_result' => '没有找到相关内容',
			'search.trending' => '大家都在搜',
			'video.tabs.info' => '简介',
			'video.tabs.comment' => '评论',
			'video.recommend' => '推荐视频',
			'video.comment_empty' => '评论区建设中...',
			'video.comment_count' => ({required Object count}) => '${count} 条评论',
			'video.comment_sort_hot' => '按热度',
			'video.comment_sort_time' => '按时间',
			'video.all_comments' => '全部评论',
			'video.comment_detail' => '评论详情',
			'video.related_replies' => '相关回复',
			'video.replies' => ({required Object count}) => '查看全部 ${count} 条回复',
			'video.load_failed' => '视频加载失败',
			'video.tags' => '标签',
			'video.no_desc' => '暂无简介',
			'video.expand_all' => '展开全部',
			'video.quality.p4k' => '4K 超清',
			'video.quality.p1080' => '1080P 高清',
			'video.quality.p720' => '720P 高清',
			'video.quality.p480' => '480P 清晰',
			'video.quality.p360' => '360P 流畅',
			'video.quality.p240' => '240P 流畅',
			'video.quality.p144' => '144P 极速',
			'video.playback.speed' => '倍速',
			'video.playback.quality' => '清晰度',
			'video.playback.danmaku' => '弹幕',
			'video.playback.full_screen' => '全屏',
			'video.playback.retry' => '重试播放',
			'video.actions.like' => '点赞',
			'video.actions.unlike' => '不喜欢',
			'video.actions.coin' => '投币',
			'video.actions.favorite' => '收藏',
			'video.actions.share' => '分享',
			'video.actions.followed' => '已关注',
			'video.actions.follow' => '关注',
			'video.actions.reply' => '回复',
			'video.reply_to' => ({required Object name}) => '回复 @${name} : ',
			'video.parts' => '视频分段',
			'video.expand' => '展开',
			'video.collapse' => '收起',
			'video.comment_hint' => '发个友善的评论',
			'common.no_content' => '暂无内容',
			'common.coming_soon' => ({required Object tab}) => '${tab} 内容暂未实现',
			'common.loading' => '加载中...',
			'common.error' => '出错了',
			'common.retry' => '重试',
			'common.refresh' => '刷新',
			'common.load_more' => '加载更多',
			'common.no_more' => '没有更多了',
			'common.cancel' => '取消',
			'common.confirm' => '确定',
			'common.save' => '保存',
			'common.delete' => '删除',
			'common.view_count' => ({required Object count}) => '${count}次播放',
			'common.danmaku_count' => ({required Object count}) => '${count}条弹幕',
			'common.pull_down_to_refresh' => '下拉可以刷新',
			'common.release_to_refresh' => '松开立即刷新',
			'common.refresh_completed' => '刷新成功',
			'common.refresh_failed' => '刷新失败',
			'common.pull_up_to_load_more' => '上拉加载更多',
			'common.release_to_load_more' => '松开加载更多',
			'common.load_failed' => '加载失败',
			'common.load_completed' => '加载完成',
			'common.no_more_content' => '没有更多内容了',
			'common.up' => 'UP',
			'error.connection_timeout' => '连接超时',
			'error.send_timeout' => '请求超时',
			'error.receive_timeout' => '响应超时',
			'error.bad_response' => ({required Object code}) => '服务器响应错误: ${code}',
			'error.cancel' => '请求取消',
			'error.network' => '网络连接异常',
			'format.hundred_million' => '亿',
			'format.ten_thousand' => '万',
			'format.hours_ago' => ({required Object hours}) => '${hours}小时前',
			'format.minutes_ago' => ({required Object minutes}) => '${minutes}分钟前',
			'format.just_now' => '刚刚',
			'to_view.title' => '稍后再看',
			'to_view.clear_all' => '清空稍后再看',
			'to_view.clear_all_confirm' => '确定要清空稍后再看列表吗？',
			'subscription.title' => '订阅',
			'subscription.tabs.video' => '视频',
			'subscription.tabs.anime' => '番剧',
			'subscription.tabs.series' => '影视',
			'subscription.empty' => ({required Object tab}) => '${tab} 暂无内容',
			'notification.title' => '消息',
			'notification.types.like' => '赞了我的评论',
			'notification.types.at' => '@了我',
			'notification.types.reply' => '回复了我',
			'notification.types.system' => '系统通知',
			'notification.related_content' => '相关内容',
			'notification.navigation_error' => ({required Object type, required Object id}) => '无法跳转到内容: ${type} ${id}',
			'notification.chat.message_withdrawn' => '消息已撤回',
			'notification.chat.unsupported_type' => ({required Object type}) => '[不支持的消息类型: ${type}]',
			'live.header.online' => ({required Object count}) => '${count}人看过',
			'live.header.guard' => ({required Object count}) => '${count}人舰队',
			'live.tags.hot' => '热门榜',
			'live.tags.popularity' => '人气榜',
			'live.tags.more_play' => '更多帮玩',
			'live.danmaku.system_notice' => '系统提示',
			'live.danmaku.system_notice_colon' => '系统提示:',
			'live.danmaku.admin' => '房管',
			_ => null,
		};
	}
}
