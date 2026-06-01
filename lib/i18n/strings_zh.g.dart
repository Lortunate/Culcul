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
	@override late final _TranslationsFavoritesZh favorites = _TranslationsFavoritesZh._(_root);
	@override late final _TranslationsSearchZh search = _TranslationsSearchZh._(_root);
	@override late final _TranslationsVideoZh video = _TranslationsVideoZh._(_root);
	@override late final _TranslationsActionsZh actions = _TranslationsActionsZh._(_root);
	@override late final _TranslationsCommonZh common = _TranslationsCommonZh._(_root);
	@override late final _TranslationsErrorZh error = _TranslationsErrorZh._(_root);
	@override late final _TranslationsFormatZh format = _TranslationsFormatZh._(_root);
	@override late final _TranslationsWatchLaterZh watch_later = _TranslationsWatchLaterZh._(_root);
	@override late final _TranslationsSubscriptionZh subscription = _TranslationsSubscriptionZh._(_root);
	@override late final _TranslationsNotificationZh notification = _TranslationsNotificationZh._(_root);
	@override late final _TranslationsLiveZh live = _TranslationsLiveZh._(_root);
	@override late final _TranslationsHistoryZh history = _TranslationsHistoryZh._(_root);
}

// Path: nav
class _TranslationsNavZh implements TranslationsNavEn {
	_TranslationsNavZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get home => '首页';
	@override String get moments => '动态';
	@override String get ranking => '排行榜';
	@override String get profile => '我的';
}

// Path: home
class _TranslationsHomeZh implements TranslationsHomeEn {
	_TranslationsHomeZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsHomeTabsZh tabs = _TranslationsHomeTabsZh._(_root);
	@override String get search_hint => '搜索视频...';
	@override late final _TranslationsHomeVideoMoreZh video_more = _TranslationsHomeVideoMoreZh._(_root);
}

// Path: moments
class _TranslationsMomentsZh implements TranslationsMomentsEn {
	_TranslationsMomentsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '动态';
	@override late final _TranslationsMomentsTabsZh tabs = _TranslationsMomentsTabsZh._(_root);
	@override String get like_coming_soon => '点赞功能开发中';
	@override String empty({required Object tab}) => '${tab} 动态暂未实现';
	@override String get recently_followed => '最近关注';
	@override String get topic_search_hint => '搜索话题';
	@override String get topic_search_empty => '输入关键词搜索话题';
	@override String get topic_search_no_result => '未找到相关话题';
	@override String topic_updates({required Object count}) => '更新 ${count} 条动态';
	@override String get no_comments => '暂无评论，快来抢沙发吧~';
	@override String get comment_hint => '友善评论，文明发言';
	@override String get publish => '发布';
	@override String get publish_title => '发布动态';
	@override String get publish_action => '发布';
	@override String get publish_hint => '分享你的新鲜事...';
	@override String get publish_success => '发布成功';
	@override String publish_failed({required Object error}) => '发布失败: ${error}';
	@override String get discard_title => '提示';
	@override String get discard_confirm => '确定要放弃编辑吗？';
	@override String get discard_action => '放弃';
	@override String get forward_post => '转发动态';
	@override String get reserve => '预约';
	@override String get reserved => '已预约';
	@override String get vote => '投票';
	@override String vote_stats({required Object participants, required Object options}) => '${participants}人参与 · ${options}个选项';
	@override String get copy_link => '复制链接';
	@override String get open_in_browser => '浏览器打开';
	@override String get copied_link => '已复制动态链接';
	@override String get open_link_failed => '无法打开链接';
	@override String operation_failed({required Object message}) => '操作失败: ${message}';
	@override String get detail_title => '动态详情';
}

// Path: ranking
class _TranslationsRankingZh implements TranslationsRankingEn {
	_TranslationsRankingZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '排行榜';
	@override late final _TranslationsRankingCategoriesZh categories = _TranslationsRankingCategoriesZh._(_root);
}

// Path: settings
class _TranslationsSettingsZh implements TranslationsSettingsEn {
	_TranslationsSettingsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '设置';
	@override late final _TranslationsSettingsSectionsZh sections = _TranslationsSettingsSectionsZh._(_root);
	@override String get language => '切换语言';
	@override String get appearance => '外观设置';
	@override String get chinese => '简体中文';
	@override String get traditional_chinese => '繁体中文';
	@override String get english => 'English';
	@override late final _TranslationsSettingsThemeModeZh theme_mode = _TranslationsSettingsThemeModeZh._(_root);
	@override String get clear_cache => '清理缓存';
	@override String get user_agreement => '用户协议';
	@override String get privacy_policy => '隐私政策';
	@override String get version => '当前版本';
}

// Path: auth
class _TranslationsAuthZh implements TranslationsAuthEn {
	_TranslationsAuthZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get login => '登录';
	@override String get logout => '退出登录';
	@override late final _TranslationsAuthMethodsZh methods = _TranslationsAuthMethodsZh._(_root);
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
	@override String get select_country => '选择地区';
	@override String get search_country_hint => '搜索国家或地区';
	@override String get no_search_result => '未找到相关结果';
	@override String get welcome_back => '欢迎回来';
	@override String get please_enter_username_password => '请输入账号和密码';
	@override String get ok => '确定';
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
	@override late final _TranslationsProfileTabsZh tabs = _TranslationsProfileTabsZh._(_root);
	@override late final _TranslationsProfileHomeTabZh home_tab = _TranslationsProfileHomeTabZh._(_root);
	@override late final _TranslationsProfileFollowingsZh followings = _TranslationsProfileFollowingsZh._(_root);
	@override late final _TranslationsProfileFollowersZh followers = _TranslationsProfileFollowersZh._(_root);
	@override late final _TranslationsProfileRelationZh relation = _TranslationsProfileRelationZh._(_root);
	@override String get privacy_title => '该用户设置了隐私';
	@override String get privacy_message => '无法查看关注/粉丝列表';
	@override String get verified_badge => 'bilibili认证';
	@override String get logout_confirm => '确定要退出登录吗？';
	@override String get space_search_coming_soon => '空间搜索开发中';
}

// Path: favorites
class _TranslationsFavoritesZh implements TranslationsFavoritesEn {
	_TranslationsFavoritesZh._(this._root);

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
	@override String folder_item_count({required Object count}) => '${count}个内容';
	@override String get new_folder => '新建收藏夹';
	@override String get edit_folder => '编辑收藏夹';
	@override String get delete_folder => '删除收藏夹';
	@override String get delete_folder_confirm => '确定要删除这个收藏夹吗？';
	@override String delete_with_count({required Object count}) => '删除 (${count})';
	@override String get edit_info => '编辑信息';
	@override String get manage_resources => '管理内容';
	@override String get only_visible_to_me => '仅自己可见';
	@override String get folder_title => '标题';
	@override String get folder_intro => '简介';
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
	@override late final _TranslationsSearchTabsZh tabs = _TranslationsSearchTabsZh._(_root);
	@override late final _TranslationsSearchStatusZh status = _TranslationsSearchStatusZh._(_root);
	@override late final _TranslationsSearchFilterZh filter = _TranslationsSearchFilterZh._(_root);
}

// Path: video
class _TranslationsVideoZh implements TranslationsVideoEn {
	_TranslationsVideoZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsVideoTabsZh tabs = _TranslationsVideoTabsZh._(_root);
	@override String get recommend => '推荐视频';
	@override late final _TranslationsVideoCommentZh comment = _TranslationsVideoCommentZh._(_root);
	@override String get load_failed => '视频加载失败';
	@override String get tags => '标签';
	@override String get no_desc => '暂无简介';
	@override String get expand_all => '展开全部';
	@override late final _TranslationsVideoQualityZh quality = _TranslationsVideoQualityZh._(_root);
	@override late final _TranslationsVideoPlayerZh player = _TranslationsVideoPlayerZh._(_root);
	@override late final _TranslationsVideoActionsZh actions = _TranslationsVideoActionsZh._(_root);
	@override String reply_to({required Object name}) => '回复 @${name} : ';
	@override String get parts => '视频分段';
	@override String get expand => '展开';
	@override String get collapse => '收起';
	@override String get listen => '听视频';
	@override late final _TranslationsVideoListenSettingsZh listen_settings = _TranslationsVideoListenSettingsZh._(_root);
	@override String watching_count({required Object count}) => '${count}人正在看';
	@override String get detail_page => '详情页';
}

// Path: actions
class _TranslationsActionsZh implements TranslationsActionsEn {
	_TranslationsActionsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get like => '点赞';
	@override String get unlike => '不喜欢';
	@override String get follow => '关注';
	@override String get followed => '已关注';
	@override String get share => '分享';
	@override String get reply => '回复';
	@override String get comment => '评论';
	@override String get forward => '转发';
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
	@override String get save_image => '保存图片';
	@override String get saving => '保存中...';
	@override String get save_success => '已保存到系统相册';
	@override String save_failed({required Object message}) => '保存失败：${message}';
	@override String get slide_to_switch => '左右滑动切换';
	@override String get no_data => '暂无数据';
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
	@override String get auth_failed => '登录失效，请重新登录';
	@override String get server_error => '服务器请求异常';
	@override String get details => '错误详情';
	@override String get view_details => '查看详情';
	@override String get stack_trace => '堆栈信息';
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

// Path: watch_later
class _TranslationsWatchLaterZh implements TranslationsWatchLaterEn {
	_TranslationsWatchLaterZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '稍后再看';
	@override String get clear_all => '清空稍后再看';
	@override String get clear_all_confirm => '确定要清空稍后再看列表吗？';
	@override String watch_to({required Object progress}) => '观看至 ${progress}';
	@override String get add_success => '已添加至稍后再看';
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
	@override String get empty => '暂无通知';
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

// Path: history
class _TranslationsHistoryZh implements TranslationsHistoryEn {
	_TranslationsHistoryZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get empty => '暂无历史记录';
}

// Path: home.tabs
class _TranslationsHomeTabsZh implements TranslationsHomeTabsEn {
	_TranslationsHomeTabsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get live => '直播';
	@override String get recommend => '推荐';
	@override String get hot => '热门';
	@override String get anime => '番剧';
	@override String get cinema => '影视';
	@override String get new_journey => '新征程';
	@override String get weekly_must_watch => '每周必看';
}

// Path: home.video_more
class _TranslationsHomeVideoMoreZh implements TranslationsHomeVideoMoreEn {
	_TranslationsHomeVideoMoreZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get watch_later => '稍后再看';
	@override String get download_cover => '下载封面';
	@override String get invalid_video_id => '无法获取视频ID';
	@override String get added_to_watch_later => '已添加至稍后再看';
	@override String add_failed({required Object error}) => '添加失败: ${error}';
	@override String download_failed({required Object error}) => '下载失败: ${error}';
}

// Path: moments.tabs
class _TranslationsMomentsTabsZh implements TranslationsMomentsTabsEn {
	_TranslationsMomentsTabsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get all => '全部';
	@override String get video => '视频';
	@override String get pgc => '番剧/影视';
}

// Path: ranking.categories
class _TranslationsRankingCategoriesZh implements TranslationsRankingCategoriesEn {
	_TranslationsRankingCategoriesZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get all => '全站';
	@override String get animation => '动画';
	@override String get bangumi => '番剧';
	@override String get guochuang => '国创';
	@override String get music => '音乐';
	@override String get dance => '舞蹈';
	@override String get game => '游戏';
	@override String get knowledge => '知识';
	@override String get technology => '科技';
	@override String get sports => '运动';
	@override String get car => '汽车';
	@override String get life => '生活';
	@override String get food => '美食';
	@override String get animal => '动物';
	@override String get kichiku => '鬼畜';
	@override String get fashion => '时尚';
	@override String get information => '资讯';
	@override String get entertainment => '娱乐';
	@override String get film => '影视';
	@override String get documentary => '纪录片';
	@override String get movie => '电影';
	@override String get tv => '电视剧';
	@override String get tech_digital => '科技数码';
	@override String get short_play => '小剧场';
	@override String get fashion_beauty => '时尚美妆';
	@override String get sports_fitness => '体育运动';
	@override String get vlog => 'vlog';
	@override String get painting => '绘画';
	@override String get ai => '人工智能';
	@override String get home => '家装房产';
	@override String get outdoor => '户外潮流';
	@override String get fitness => '健身';
	@override String get craft => '手工';
	@override String get travel => '旅游出行';
	@override String get three_rural => '三农';
	@override String get parenting => '亲子';
	@override String get health => '健康';
	@override String get emotion => '情感';
	@override String get life_interest => '生活兴趣';
	@override String get life_experience => '生活经验';
}

// Path: settings.sections
class _TranslationsSettingsSectionsZh implements TranslationsSettingsSectionsEn {
	_TranslationsSettingsSectionsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get general => '通用设置';
	@override String get appearance => '外观设置';
	@override String get storage => '存储管理';
	@override String get about => '关于';
}

// Path: settings.theme_mode
class _TranslationsSettingsThemeModeZh implements TranslationsSettingsThemeModeEn {
	_TranslationsSettingsThemeModeZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get system => '跟随系统';
	@override String get dark => '深色模式';
	@override String get light => '浅色模式';
}

// Path: auth.methods
class _TranslationsAuthMethodsZh implements TranslationsAuthMethodsEn {
	_TranslationsAuthMethodsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get account => '账号';
	@override String get sms => '验证码';
	@override String get qr => '二维码';
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
	@override String get posts => '动态';
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
	@override String get edit_profile => '编辑资料';
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
	@override String get favorites => '我的收藏';
	@override String get watch_later => '稍后再看';
	@override String get appearance => '外观设置';
	@override String get creative_center => '创作中心';
	@override String get orders => '会员购订单';
	@override String get support => '联系客服';
	@override String get blacklist => '加入黑名单';
	@override String get report => '举报';
}

// Path: profile.tabs
class _TranslationsProfileTabsZh implements TranslationsProfileTabsEn {
	_TranslationsProfileTabsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get home => '主页';
	@override String get moments => '动态';
	@override String get contribution => '投稿';
}

// Path: profile.home_tab
class _TranslationsProfileHomeTabZh implements TranslationsProfileHomeTabEn {
	_TranslationsProfileHomeTabZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String recent_videos({required Object count}) => '视频 ${count}';
	@override String get view_more => '查看更多';
	@override String get empty => '暂无内容';
	@override String get sticky => '置顶视频';
	@override String get sticky_tag => '置顶';
	@override String get masterpiece => '代表作';
}

// Path: profile.followings
class _TranslationsProfileFollowingsZh implements TranslationsProfileFollowingsEn {
	_TranslationsProfileFollowingsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '我的关注';
	@override String get empty => '暂无关注';
}

// Path: profile.followers
class _TranslationsProfileFollowersZh implements TranslationsProfileFollowersEn {
	_TranslationsProfileFollowersZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '我的粉丝';
	@override String get empty => '暂无粉丝';
}

// Path: profile.relation
class _TranslationsProfileRelationZh implements TranslationsProfileRelationEn {
	_TranslationsProfileRelationZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get none => '关注';
	@override String get followed => '已关注';
	@override String get mutual => '互粉';
	@override String get blacklisted => '已拉黑';
	@override String failed({required Object error}) => '操作失败: ${error}';
}

// Path: search.tabs
class _TranslationsSearchTabsZh implements TranslationsSearchTabsEn {
	_TranslationsSearchTabsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get all => '综合';
	@override String get video => '视频';
	@override String get anime => '番剧';
	@override String get user => '用户';
	@override String get article => '专栏';
}

// Path: search.status
class _TranslationsSearchStatusZh implements TranslationsSearchStatusEn {
	_TranslationsSearchStatusZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get loading => '正在获取建议...';
	@override String get empty => '未发现相关搜索建议';
	@override String get failed => '获取建议失败';
}

// Path: search.filter
class _TranslationsSearchFilterZh implements TranslationsSearchFilterEn {
	_TranslationsSearchFilterZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get sort_default => '综合排序';
	@override String get sort_newest => '最新发布';
	@override String get sort_click => '最多点击';
	@override String get sort_danmaku => '最多弹幕';
	@override String get sort_favorite => '最多收藏';
	@override String get duration_all => '全部时长';
	@override String get duration_short => '10分钟以下';
	@override String get duration_medium => '10-30分钟';
	@override String get duration_long => '30-60分钟';
	@override String get duration_extra_long => '60分钟以上';
}

// Path: video.tabs
class _TranslationsVideoTabsZh implements TranslationsVideoTabsEn {
	_TranslationsVideoTabsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get info => '简介';
	@override String get comment => '评论';
}

// Path: video.comment
class _TranslationsVideoCommentZh implements TranslationsVideoCommentEn {
	_TranslationsVideoCommentZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get empty => '暂无评论，快来抢沙发吧！';
	@override String count({required Object count}) => '${count} 条评论';
	@override String get sort_hot => '按热度';
	@override String get sort_time => '按时间';
	@override String get all => '全部评论';
	@override String get detail => '评论详情';
	@override String get related_replies => '相关回复';
	@override String replies({required Object count}) => '查看全部 ${count} 条回复';
	@override String get hint => '发个友善的评论';
}

// Path: video.quality
class _TranslationsVideoQualityZh implements TranslationsVideoQualityEn {
	_TranslationsVideoQualityZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get p8k => '8K 超高清';
	@override String get p_dolby => '杜比视界';
	@override String get p_hdr => 'HDR 真彩';
	@override String get p4k => '4K 超清';
	@override String get p1080_60 => '1080P 60帧';
	@override String get p1080_high => '1080P 高码率';
	@override String get p1080 => '1080P 高清';
	@override String get p720_60 => '720P 60帧';
	@override String get p720 => '720P 高清';
	@override String get p480 => '480P 清晰';
	@override String get p360 => '360P 流畅';
	@override String get p240 => '240P 流畅';
	@override String get p144 => '144P 极速';
	@override String get unknown => '未知';
	@override String get auto => '自动';
}

// Path: video.player
class _TranslationsVideoPlayerZh implements TranslationsVideoPlayerEn {
	_TranslationsVideoPlayerZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get speed => '倍速';
	@override String get quality => '清晰度';
	@override String get danmaku => '弹幕';
	@override String get full_screen => '全屏';
	@override String get retry => '重试播放';
	@override String get brightness => '亮度';
	@override String get volume => '音量';
	@override String get panel_title => '播放设置';
	@override String get panel_subtitle => '优先处理最常用的播放与弹幕选项';
	@override String get danmaku_settings => '弹幕设置';
	@override String get danmaku_section_hint => '控制弹幕显示强度、区域和类型';
	@override String get danmaku_opacity => '不透明度';
	@override String get danmaku_scale => '字号缩放';
	@override String get danmaku_area => '显示区域';
	@override String get danmaku_speed => '弹幕速度';
	@override String get danmaku_type_scroll => '滚动';
	@override String get danmaku_type_top => '顶部';
	@override String get danmaku_type_bottom => '底部';
	@override String get danmaku_type_color => '彩色';
	@override String speed_playing({required Object speedx}) => '${speedx} 倍速播放中';
	@override String get speed_default => '标准速度';
	@override String get speed_section_hint => '从慢放到高倍速都可以直接切换';
	@override String get choose_quality => '选择画质';
	@override String get choose_speed => '播放速度';
	@override String get quality_section_hint => '优先展示当前视频实际支持的清晰度';
	@override String get quality_unavailable => '当前视频暂时没有可切换的画质';
	@override String get danmaku_closed => '已关闭弹幕';
}

// Path: video.actions
class _TranslationsVideoActionsZh implements TranslationsVideoActionsEn {
	_TranslationsVideoActionsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get coin => '投币';
	@override String get favorite => '收藏';
}

// Path: video.listen_settings
class _TranslationsVideoListenSettingsZh implements TranslationsVideoListenSettingsEn {
	_TranslationsVideoListenSettingsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '听视频设置';
	@override String get sleep_timer => '定时关闭';
	@override String get timer_off => '未开启';
	@override String remaining({required Object time}) => '剩余 ${time}';
	@override String preset_minutes({required Object minutes}) => '${minutes} 分钟';
	@override String custom_hint({required Object min, required Object max}) => '自定义分钟（${min}-${max}）';
	@override String custom_invalid_range({required Object min, required Object max}) => '请输入 ${min}-${max} 之间的分钟数';
	@override String get minutes_unit => '分钟';
	@override String get set_custom => '设置';
	@override String get disable => '关闭定时';
}

// Path: subscription.tabs
class _TranslationsSubscriptionTabsZh implements TranslationsSubscriptionTabsEn {
	_TranslationsSubscriptionTabsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get video => '视频';
	@override String get anime => '番剧';
	@override String get cinema => '影视';
}

// Path: notification.types
class _TranslationsNotificationTypesZh implements TranslationsNotificationTypesEn {
	_TranslationsNotificationTypesZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get like => '收到的赞';
	@override String get at => '@我';
	@override String get reply => '回复我的';
	@override String get system => '系统通知';
}

// Path: notification.chat
class _TranslationsNotificationChatZh implements TranslationsNotificationChatEn {
	_TranslationsNotificationChatZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get message_withdrawn => '消息已撤回';
	@override String unsupported_type({required Object type}) => '[不支持的消息类型: ${type}]';
	@override String get no_message => '暂无消息';
	@override String get input_hint => '发个消息...';
	@override String get page_not_developed => '用户详情页暂未开发';
	@override String send_failed({required Object error}) => '发送失败: ${error}';
	@override String get summary_text => '文本消息';
	@override String get summary_image => '图片';
	@override String get summary_notice => '系统通知';
	@override String get summary_video => '视频';
	@override String get summary_article => '专栏';
	@override String get summary_card => '卡片';
	@override String get summary_share => '分享';
	@override String get summary_unknown => '未知消息';
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
	@override String get system_notice => '系统消息';
	@override String get system_notice_colon => '系统提示:';
	@override String get admin => '房管';
	@override String get input_hint => '发个弹幕呗~';
	@override String get support_hint => '弹幕支持下~';
	@override String get welcome => '欢迎来到直播间~ 喜欢主播点个关注哦';
	@override String get enter_room => '进入直播间';
	@override String get followed => '关注了主播';
	@override String get shared => '分享了直播间';
	@override String gift_feed({required Object giftName, required Object num}) => '投喂了 ${giftName} x${num}';
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
			'nav.profile' => '我的',
			'home.tabs.live' => '直播',
			'home.tabs.recommend' => '推荐',
			'home.tabs.hot' => '热门',
			'home.tabs.anime' => '番剧',
			'home.tabs.cinema' => '影视',
			'home.tabs.new_journey' => '新征程',
			'home.tabs.weekly_must_watch' => '每周必看',
			'home.search_hint' => '搜索视频...',
			'home.video_more.watch_later' => '稍后再看',
			'home.video_more.download_cover' => '下载封面',
			'home.video_more.invalid_video_id' => '无法获取视频ID',
			'home.video_more.added_to_watch_later' => '已添加至稍后再看',
			'home.video_more.add_failed' => ({required Object error}) => '添加失败: ${error}',
			'home.video_more.download_failed' => ({required Object error}) => '下载失败: ${error}',
			'moments.title' => '动态',
			'moments.tabs.all' => '全部',
			'moments.tabs.video' => '视频',
			'moments.tabs.pgc' => '番剧/影视',
			'moments.like_coming_soon' => '点赞功能开发中',
			'moments.empty' => ({required Object tab}) => '${tab} 动态暂未实现',
			'moments.recently_followed' => '最近关注',
			'moments.topic_search_hint' => '搜索话题',
			'moments.topic_search_empty' => '输入关键词搜索话题',
			'moments.topic_search_no_result' => '未找到相关话题',
			'moments.topic_updates' => ({required Object count}) => '更新 ${count} 条动态',
			'moments.no_comments' => '暂无评论，快来抢沙发吧~',
			'moments.comment_hint' => '友善评论，文明发言',
			'moments.publish' => '发布',
			'moments.publish_title' => '发布动态',
			'moments.publish_action' => '发布',
			'moments.publish_hint' => '分享你的新鲜事...',
			'moments.publish_success' => '发布成功',
			'moments.publish_failed' => ({required Object error}) => '发布失败: ${error}',
			'moments.discard_title' => '提示',
			'moments.discard_confirm' => '确定要放弃编辑吗？',
			'moments.discard_action' => '放弃',
			'moments.forward_post' => '转发动态',
			'moments.reserve' => '预约',
			'moments.reserved' => '已预约',
			'moments.vote' => '投票',
			'moments.vote_stats' => ({required Object participants, required Object options}) => '${participants}人参与 · ${options}个选项',
			'moments.copy_link' => '复制链接',
			'moments.open_in_browser' => '浏览器打开',
			'moments.copied_link' => '已复制动态链接',
			'moments.open_link_failed' => '无法打开链接',
			'moments.operation_failed' => ({required Object message}) => '操作失败: ${message}',
			'moments.detail_title' => '动态详情',
			'ranking.title' => '排行榜',
			'ranking.categories.all' => '全站',
			'ranking.categories.animation' => '动画',
			'ranking.categories.bangumi' => '番剧',
			'ranking.categories.guochuang' => '国创',
			'ranking.categories.music' => '音乐',
			'ranking.categories.dance' => '舞蹈',
			'ranking.categories.game' => '游戏',
			'ranking.categories.knowledge' => '知识',
			'ranking.categories.technology' => '科技',
			'ranking.categories.sports' => '运动',
			'ranking.categories.car' => '汽车',
			'ranking.categories.life' => '生活',
			'ranking.categories.food' => '美食',
			'ranking.categories.animal' => '动物',
			'ranking.categories.kichiku' => '鬼畜',
			'ranking.categories.fashion' => '时尚',
			'ranking.categories.information' => '资讯',
			'ranking.categories.entertainment' => '娱乐',
			'ranking.categories.film' => '影视',
			'ranking.categories.documentary' => '纪录片',
			'ranking.categories.movie' => '电影',
			'ranking.categories.tv' => '电视剧',
			'ranking.categories.tech_digital' => '科技数码',
			'ranking.categories.short_play' => '小剧场',
			'ranking.categories.fashion_beauty' => '时尚美妆',
			'ranking.categories.sports_fitness' => '体育运动',
			'ranking.categories.vlog' => 'vlog',
			'ranking.categories.painting' => '绘画',
			'ranking.categories.ai' => '人工智能',
			'ranking.categories.home' => '家装房产',
			'ranking.categories.outdoor' => '户外潮流',
			'ranking.categories.fitness' => '健身',
			'ranking.categories.craft' => '手工',
			'ranking.categories.travel' => '旅游出行',
			'ranking.categories.three_rural' => '三农',
			'ranking.categories.parenting' => '亲子',
			'ranking.categories.health' => '健康',
			'ranking.categories.emotion' => '情感',
			'ranking.categories.life_interest' => '生活兴趣',
			'ranking.categories.life_experience' => '生活经验',
			'settings.title' => '设置',
			'settings.sections.general' => '通用设置',
			'settings.sections.appearance' => '外观设置',
			'settings.sections.storage' => '存储管理',
			'settings.sections.about' => '关于',
			'settings.language' => '切换语言',
			'settings.appearance' => '外观设置',
			'settings.chinese' => '简体中文',
			'settings.traditional_chinese' => '繁体中文',
			'settings.english' => 'English',
			'settings.theme_mode.system' => '跟随系统',
			'settings.theme_mode.dark' => '深色模式',
			'settings.theme_mode.light' => '浅色模式',
			'settings.clear_cache' => '清理缓存',
			'settings.user_agreement' => '用户协议',
			'settings.privacy_policy' => '隐私政策',
			'settings.version' => '当前版本',
			'auth.login' => '登录',
			'auth.logout' => '退出登录',
			'auth.methods.account' => '账号',
			'auth.methods.sms' => '验证码',
			'auth.methods.qr' => '二维码',
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
			'auth.select_country' => '选择地区',
			'auth.search_country_hint' => '搜索国家或地区',
			'auth.no_search_result' => '未找到相关结果',
			'auth.welcome_back' => '欢迎回来',
			'auth.please_enter_username_password' => '请输入账号和密码',
			'auth.ok' => '确定',
			'profile.login' => '登录',
			'profile.not_logged_in' => '未登录',
			'profile.login_hint' => '点击登录体验更多功能',
			'profile.stats.posts' => '动态',
			'profile.stats.following' => '关注',
			'profile.stats.followers' => '粉丝',
			'profile.stats.likes' => '获赞',
			'profile.actions.message' => '私信',
			'profile.actions.edit_profile' => '编辑资料',
			'profile.vip.premium' => '大会员',
			'profile.vip.annual_premium' => '年度大会员',
			'profile.menu.history' => '历史记录',
			'profile.menu.download' => '离线缓存',
			'profile.menu.favorites' => '我的收藏',
			'profile.menu.watch_later' => '稍后再看',
			'profile.menu.appearance' => '外观设置',
			'profile.menu.creative_center' => '创作中心',
			'profile.menu.orders' => '会员购订单',
			'profile.menu.support' => '联系客服',
			'profile.menu.blacklist' => '加入黑名单',
			'profile.menu.report' => '举报',
			'profile.tabs.home' => '主页',
			'profile.tabs.moments' => '动态',
			'profile.tabs.contribution' => '投稿',
			'profile.home_tab.recent_videos' => ({required Object count}) => '视频 ${count}',
			'profile.home_tab.view_more' => '查看更多',
			'profile.home_tab.empty' => '暂无内容',
			'profile.home_tab.sticky' => '置顶视频',
			'profile.home_tab.sticky_tag' => '置顶',
			'profile.home_tab.masterpiece' => '代表作',
			'profile.followings.title' => '我的关注',
			'profile.followings.empty' => '暂无关注',
			'profile.followers.title' => '我的粉丝',
			'profile.followers.empty' => '暂无粉丝',
			'profile.relation.none' => '关注',
			'profile.relation.followed' => '已关注',
			'profile.relation.mutual' => '互粉',
			'profile.relation.blacklisted' => '已拉黑',
			'profile.relation.failed' => ({required Object error}) => '操作失败: ${error}',
			'profile.privacy_title' => '该用户设置了隐私',
			'profile.privacy_message' => '无法查看关注/粉丝列表',
			'profile.verified_badge' => 'bilibili认证',
			'profile.logout_confirm' => '确定要退出登录吗？',
			'profile.space_search_coming_soon' => '空间搜索开发中',
			'favorites.title' => '我的收藏',
			'favorites.created' => '创建的',
			'favorites.collected' => '收藏的',
			'favorites.private' => '私密',
			'favorites.public' => '公开',
			'favorites.play' => '播放',
			'favorites.count' => ({required Object count}) => '共 ${count} 个内容',
			'favorites.search_hint' => '搜索收藏内容',
			'favorites.folder_item_count' => ({required Object count}) => '${count}个内容',
			'favorites.new_folder' => '新建收藏夹',
			'favorites.edit_folder' => '编辑收藏夹',
			'favorites.delete_folder' => '删除收藏夹',
			'favorites.delete_folder_confirm' => '确定要删除这个收藏夹吗？',
			'favorites.delete_with_count' => ({required Object count}) => '删除 (${count})',
			'favorites.edit_info' => '编辑信息',
			'favorites.manage_resources' => '管理内容',
			'favorites.only_visible_to_me' => '仅自己可见',
			'favorites.folder_title' => '标题',
			'favorites.folder_intro' => '简介',
			'search.placeholder' => '大家都在搜：culcul',
			'search.button' => '搜索',
			'search.history' => '搜索历史',
			'search.hot_search' => '热搜榜',
			'search.clear_history' => '清空历史',
			'search.suggestion' => '搜索建议',
			'search.no_result' => '没有找到相关内容',
			'search.trending' => '大家都在搜',
			'search.tabs.all' => '综合',
			'search.tabs.video' => '视频',
			'search.tabs.anime' => '番剧',
			'search.tabs.user' => '用户',
			'search.tabs.article' => '专栏',
			'search.status.loading' => '正在获取建议...',
			'search.status.empty' => '未发现相关搜索建议',
			'search.status.failed' => '获取建议失败',
			'search.filter.sort_default' => '综合排序',
			'search.filter.sort_newest' => '最新发布',
			'search.filter.sort_click' => '最多点击',
			'search.filter.sort_danmaku' => '最多弹幕',
			'search.filter.sort_favorite' => '最多收藏',
			'search.filter.duration_all' => '全部时长',
			'search.filter.duration_short' => '10分钟以下',
			'search.filter.duration_medium' => '10-30分钟',
			'search.filter.duration_long' => '30-60分钟',
			'search.filter.duration_extra_long' => '60分钟以上',
			'video.tabs.info' => '简介',
			'video.tabs.comment' => '评论',
			'video.recommend' => '推荐视频',
			'video.comment.empty' => '暂无评论，快来抢沙发吧！',
			'video.comment.count' => ({required Object count}) => '${count} 条评论',
			'video.comment.sort_hot' => '按热度',
			'video.comment.sort_time' => '按时间',
			'video.comment.all' => '全部评论',
			'video.comment.detail' => '评论详情',
			'video.comment.related_replies' => '相关回复',
			'video.comment.replies' => ({required Object count}) => '查看全部 ${count} 条回复',
			'video.comment.hint' => '发个友善的评论',
			'video.load_failed' => '视频加载失败',
			'video.tags' => '标签',
			'video.no_desc' => '暂无简介',
			'video.expand_all' => '展开全部',
			'video.quality.p8k' => '8K 超高清',
			'video.quality.p_dolby' => '杜比视界',
			'video.quality.p_hdr' => 'HDR 真彩',
			'video.quality.p4k' => '4K 超清',
			'video.quality.p1080_60' => '1080P 60帧',
			'video.quality.p1080_high' => '1080P 高码率',
			'video.quality.p1080' => '1080P 高清',
			'video.quality.p720_60' => '720P 60帧',
			'video.quality.p720' => '720P 高清',
			'video.quality.p480' => '480P 清晰',
			'video.quality.p360' => '360P 流畅',
			'video.quality.p240' => '240P 流畅',
			'video.quality.p144' => '144P 极速',
			'video.quality.unknown' => '未知',
			'video.quality.auto' => '自动',
			'video.player.speed' => '倍速',
			'video.player.quality' => '清晰度',
			'video.player.danmaku' => '弹幕',
			'video.player.full_screen' => '全屏',
			'video.player.retry' => '重试播放',
			'video.player.brightness' => '亮度',
			'video.player.volume' => '音量',
			'video.player.panel_title' => '播放设置',
			'video.player.panel_subtitle' => '优先处理最常用的播放与弹幕选项',
			'video.player.danmaku_settings' => '弹幕设置',
			'video.player.danmaku_section_hint' => '控制弹幕显示强度、区域和类型',
			'video.player.danmaku_opacity' => '不透明度',
			'video.player.danmaku_scale' => '字号缩放',
			'video.player.danmaku_area' => '显示区域',
			'video.player.danmaku_speed' => '弹幕速度',
			'video.player.danmaku_type_scroll' => '滚动',
			'video.player.danmaku_type_top' => '顶部',
			'video.player.danmaku_type_bottom' => '底部',
			'video.player.danmaku_type_color' => '彩色',
			'video.player.speed_playing' => ({required Object speedx}) => '${speedx} 倍速播放中',
			'video.player.speed_default' => '标准速度',
			'video.player.speed_section_hint' => '从慢放到高倍速都可以直接切换',
			'video.player.choose_quality' => '选择画质',
			'video.player.choose_speed' => '播放速度',
			'video.player.quality_section_hint' => '优先展示当前视频实际支持的清晰度',
			'video.player.quality_unavailable' => '当前视频暂时没有可切换的画质',
			'video.player.danmaku_closed' => '已关闭弹幕',
			'video.actions.coin' => '投币',
			'video.actions.favorite' => '收藏',
			'video.reply_to' => ({required Object name}) => '回复 @${name} : ',
			'video.parts' => '视频分段',
			'video.expand' => '展开',
			'video.collapse' => '收起',
			'video.listen' => '听视频',
			'video.listen_settings.title' => '听视频设置',
			'video.listen_settings.sleep_timer' => '定时关闭',
			'video.listen_settings.timer_off' => '未开启',
			'video.listen_settings.remaining' => ({required Object time}) => '剩余 ${time}',
			'video.listen_settings.preset_minutes' => ({required Object minutes}) => '${minutes} 分钟',
			'video.listen_settings.custom_hint' => ({required Object min, required Object max}) => '自定义分钟（${min}-${max}）',
			'video.listen_settings.custom_invalid_range' => ({required Object min, required Object max}) => '请输入 ${min}-${max} 之间的分钟数',
			'video.listen_settings.minutes_unit' => '分钟',
			'video.listen_settings.set_custom' => '设置',
			'video.listen_settings.disable' => '关闭定时',
			'video.watching_count' => ({required Object count}) => '${count}人正在看',
			'video.detail_page' => '详情页',
			'actions.like' => '点赞',
			'actions.unlike' => '不喜欢',
			'actions.follow' => '关注',
			'actions.followed' => '已关注',
			'actions.share' => '分享',
			'actions.reply' => '回复',
			'actions.comment' => '评论',
			'actions.forward' => '转发',
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
			'common.save_image' => '保存图片',
			'common.saving' => '保存中...',
			'common.save_success' => '已保存到系统相册',
			'common.save_failed' => ({required Object message}) => '保存失败：${message}',
			'common.slide_to_switch' => '左右滑动切换',
			'common.no_data' => '暂无数据',
			'error.connection_timeout' => '连接超时',
			'error.send_timeout' => '请求超时',
			'error.receive_timeout' => '响应超时',
			'error.bad_response' => ({required Object code}) => '服务器响应错误: ${code}',
			'error.cancel' => '请求取消',
			'error.network' => '网络连接异常',
			'error.auth_failed' => '登录失效，请重新登录',
			'error.server_error' => '服务器请求异常',
			'error.details' => '错误详情',
			'error.view_details' => '查看详情',
			'error.stack_trace' => '堆栈信息',
			'format.hundred_million' => '亿',
			'format.ten_thousand' => '万',
			'format.hours_ago' => ({required Object hours}) => '${hours}小时前',
			'format.minutes_ago' => ({required Object minutes}) => '${minutes}分钟前',
			'format.just_now' => '刚刚',
			'watch_later.title' => '稍后再看',
			'watch_later.clear_all' => '清空稍后再看',
			'watch_later.clear_all_confirm' => '确定要清空稍后再看列表吗？',
			'watch_later.watch_to' => ({required Object progress}) => '观看至 ${progress}',
			'watch_later.add_success' => '已添加至稍后再看',
			'subscription.title' => '订阅',
			'subscription.tabs.video' => '视频',
			'subscription.tabs.anime' => '番剧',
			'subscription.tabs.cinema' => '影视',
			'subscription.empty' => ({required Object tab}) => '${tab} 暂无内容',
			'notification.title' => '消息',
			'notification.types.like' => '收到的赞',
			'notification.types.at' => '@我',
			'notification.types.reply' => '回复我的',
			'notification.types.system' => '系统通知',
			'notification.related_content' => '相关内容',
			'notification.navigation_error' => ({required Object type, required Object id}) => '无法跳转到内容: ${type} ${id}',
			'notification.chat.message_withdrawn' => '消息已撤回',
			'notification.chat.unsupported_type' => ({required Object type}) => '[不支持的消息类型: ${type}]',
			'notification.chat.no_message' => '暂无消息',
			'notification.chat.input_hint' => '发个消息...',
			'notification.chat.page_not_developed' => '用户详情页暂未开发',
			'notification.chat.send_failed' => ({required Object error}) => '发送失败: ${error}',
			'notification.chat.summary_text' => '文本消息',
			'notification.chat.summary_image' => '图片',
			'notification.chat.summary_notice' => '系统通知',
			'notification.chat.summary_video' => '视频',
			'notification.chat.summary_article' => '专栏',
			'notification.chat.summary_card' => '卡片',
			'notification.chat.summary_share' => '分享',
			'notification.chat.summary_unknown' => '未知消息',
			'notification.empty' => '暂无通知',
			'live.header.online' => ({required Object count}) => '${count}人看过',
			'live.header.guard' => ({required Object count}) => '${count}人舰队',
			'live.tags.hot' => '热门榜',
			'live.tags.popularity' => '人气榜',
			'live.tags.more_play' => '更多帮玩',
			'live.danmaku.system_notice' => '系统消息',
			'live.danmaku.system_notice_colon' => '系统提示:',
			'live.danmaku.admin' => '房管',
			'live.danmaku.input_hint' => '发个弹幕呗~',
			'live.danmaku.support_hint' => '弹幕支持下~',
			'live.danmaku.welcome' => '欢迎来到直播间~ 喜欢主播点个关注哦',
			'live.danmaku.enter_room' => '进入直播间',
			'live.danmaku.followed' => '关注了主播',
			'live.danmaku.shared' => '分享了直播间',
			'live.danmaku.gift_feed' => ({required Object giftName, required Object num}) => '投喂了 ${giftName} x${num}',
			'history.empty' => '暂无历史记录',
			_ => null,
		};
	}
}
