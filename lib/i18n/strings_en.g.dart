///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final TranslationsNavEn nav = TranslationsNavEn._(_root);
	late final TranslationsHomeEn home = TranslationsHomeEn._(_root);
	late final TranslationsMomentsEn moments = TranslationsMomentsEn._(_root);
	late final TranslationsRankingEn ranking = TranslationsRankingEn._(_root);
	late final TranslationsSettingsEn settings = TranslationsSettingsEn._(_root);
	late final TranslationsAuthEn auth = TranslationsAuthEn._(_root);
	late final TranslationsProfileEn profile = TranslationsProfileEn._(_root);
	late final TranslationsFavEn fav = TranslationsFavEn._(_root);
	late final TranslationsSearchEn search = TranslationsSearchEn._(_root);
	late final TranslationsVideoEn video = TranslationsVideoEn._(_root);
	late final TranslationsCommonEn common = TranslationsCommonEn._(_root);
	late final TranslationsErrorEn error = TranslationsErrorEn._(_root);
	late final TranslationsFormatEn format = TranslationsFormatEn._(_root);
	late final TranslationsToViewEn to_view = TranslationsToViewEn._(_root);
	late final TranslationsSubscriptionEn subscription = TranslationsSubscriptionEn._(_root);
	late final TranslationsNotificationEn notification = TranslationsNotificationEn._(_root);
	late final TranslationsLiveEn live = TranslationsLiveEn._(_root);
}

// Path: nav
class TranslationsNavEn {
	TranslationsNavEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Home'
	String get home => 'Home';

	/// en: 'Moments'
	String get moments => 'Moments';

	/// en: 'Ranking'
	String get ranking => 'Ranking';

	/// en: 'Mine'
	String get mine => 'Mine';
}

// Path: home
class TranslationsHomeEn {
	TranslationsHomeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsHomeTabsEn tabs = TranslationsHomeTabsEn._(_root);

	/// en: 'Search...'
	String get search_hint => 'Search...';
}

// Path: moments
class TranslationsMomentsEn {
	TranslationsMomentsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Moments'
	String get title => 'Moments';

	late final TranslationsMomentsTabsEn tabs = TranslationsMomentsTabsEn._(_root);
	late final TranslationsMomentsActionsEn actions = TranslationsMomentsActionsEn._(_root);

	/// en: 'Like feature coming soon'
	String get like_coming_soon => 'Like feature coming soon';

	/// en: '$tab dynamic not implemented'
	String empty({required Object tab}) => '${tab} dynamic not implemented';
}

// Path: ranking
class TranslationsRankingEn {
	TranslationsRankingEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Ranking'
	String get title => 'Ranking';
}

// Path: settings
class TranslationsSettingsEn {
	TranslationsSettingsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Settings'
	String get title => 'Settings';

	/// en: 'General'
	String get language => 'General';

	/// en: 'Change Language'
	String get change_language => 'Change Language';

	/// en: 'Simplified Chinese'
	String get chinese => 'Simplified Chinese';

	/// en: 'Traditional Chinese'
	String get traditional_chinese => 'Traditional Chinese';

	/// en: 'English'
	String get english => 'English';

	/// en: 'Appearance'
	String get appearance => 'Appearance';

	/// en: 'Follow System'
	String get system_mode => 'Follow System';

	/// en: 'Dark Mode'
	String get dark_mode => 'Dark Mode';

	/// en: 'Light Mode'
	String get light_mode => 'Light Mode';

	/// en: 'Cache Management'
	String get cache => 'Cache Management';

	/// en: 'Clear Cache'
	String get clear_cache => 'Clear Cache';

	/// en: 'User Agreement'
	String get user_agreement => 'User Agreement';

	/// en: 'Privacy Policy'
	String get privacy_policy => 'Privacy Policy';

	/// en: 'About'
	String get about => 'About';

	/// en: 'Version'
	String get version => 'Version';
}

// Path: auth
class TranslationsAuthEn {
	TranslationsAuthEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Login'
	String get login => 'Login';

	/// en: 'Logout'
	String get logout => 'Logout';

	/// en: 'Account Login'
	String get account_login => 'Account Login';

	/// en: 'SMS Login'
	String get sms_login => 'SMS Login';

	/// en: 'QR Login'
	String get qr_login => 'QR Login';

	/// en: 'Account'
	String get username => 'Account';

	/// en: 'Phone/Email'
	String get username_hint => 'Phone/Email';

	/// en: 'Password'
	String get password => 'Password';

	/// en: 'Phone Number'
	String get phone => 'Phone Number';

	/// en: 'SMS Code'
	String get sms_code => 'SMS Code';

	/// en: 'Get Code'
	String get get_code => 'Get Code';

	/// en: 'Resend ($seconds s)'
	String get_code_retry({required Object seconds}) => 'Resend (${seconds} s)';

	/// en: 'Scan with culcul app'
	String get qr_hint => 'Scan with culcul app';

	/// en: 'Refresh QR Code'
	String get qr_refresh => 'Refresh QR Code';

	late final TranslationsAuthQrStatusEn qr_status = TranslationsAuthQrStatusEn._(_root);

	/// en: 'SMS Code sent'
	String get sms_sent => 'SMS Code sent';

	/// en: 'Third-party lightweight client'
	String get subtitle => 'Third-party lightweight client';
}

// Path: profile
class TranslationsProfileEn {
	TranslationsProfileEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Login'
	String get login => 'Login';

	/// en: 'Not Logged In'
	String get not_logged_in => 'Not Logged In';

	/// en: 'Tap to login for more features'
	String get login_hint => 'Tap to login for more features';

	late final TranslationsProfileStatsEn stats = TranslationsProfileStatsEn._(_root);
	late final TranslationsProfileActionsEn actions = TranslationsProfileActionsEn._(_root);
	late final TranslationsProfileVipEn vip = TranslationsProfileVipEn._(_root);
	late final TranslationsProfileMenuEn menu = TranslationsProfileMenuEn._(_root);
}

// Path: fav
class TranslationsFavEn {
	TranslationsFavEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'My Favorites'
	String get title => 'My Favorites';

	/// en: 'Created'
	String get created => 'Created';

	/// en: 'Collected'
	String get collected => 'Collected';

	/// en: 'Private'
	String get private => 'Private';

	/// en: 'Public'
	String get public => 'Public';

	/// en: 'Play'
	String get play => 'Play';

	/// en: '$count items'
	String count({required Object count}) => '${count} items';

	/// en: 'Search favorites'
	String get search_hint => 'Search favorites';
}

// Path: search
class TranslationsSearchEn {
	TranslationsSearchEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Trending: culcul'
	String get placeholder => 'Trending: culcul';

	/// en: 'Search'
	String get button => 'Search';

	/// en: 'History'
	String get history => 'History';

	/// en: 'Hot Search'
	String get hot_search => 'Hot Search';

	/// en: 'Clear History'
	String get clear_history => 'Clear History';

	/// en: 'Suggestions'
	String get suggestion => 'Suggestions';

	/// en: 'No results found'
	String get no_result => 'No results found';

	/// en: 'Trending Now'
	String get trending => 'Trending Now';
}

// Path: video
class TranslationsVideoEn {
	TranslationsVideoEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsVideoTabsEn tabs = TranslationsVideoTabsEn._(_root);

	/// en: 'Recommendations'
	String get recommend => 'Recommendations';

	/// en: 'Comments coming soon...'
	String get comment_empty => 'Comments coming soon...';

	/// en: '$count comments'
	String comment_count({required Object count}) => '${count} comments';

	/// en: 'Hot'
	String get comment_sort_hot => 'Hot';

	/// en: 'Newest'
	String get comment_sort_time => 'Newest';

	/// en: 'All Comments'
	String get all_comments => 'All Comments';

	/// en: 'Comment Detail'
	String get comment_detail => 'Comment Detail';

	/// en: 'Related Replies'
	String get related_replies => 'Related Replies';

	/// en: 'View all $count replies'
	String replies({required Object count}) => 'View all ${count} replies';

	/// en: 'Failed to load video'
	String get load_failed => 'Failed to load video';

	/// en: 'Tags'
	String get tags => 'Tags';

	/// en: 'No description'
	String get no_desc => 'No description';

	/// en: 'Expand All'
	String get expand_all => 'Expand All';

	late final TranslationsVideoQualityEn quality = TranslationsVideoQualityEn._(_root);
	late final TranslationsVideoPlaybackEn playback = TranslationsVideoPlaybackEn._(_root);
	late final TranslationsVideoActionsEn actions = TranslationsVideoActionsEn._(_root);

	/// en: 'Reply @$name : '
	String reply_to({required Object name}) => 'Reply @${name} : ';

	/// en: 'Video Parts'
	String get parts => 'Video Parts';

	/// en: 'Expand'
	String get expand => 'Expand';

	/// en: 'Collapse'
	String get collapse => 'Collapse';

	/// en: 'Write a friendly comment'
	String get comment_hint => 'Write a friendly comment';
}

// Path: common
class TranslationsCommonEn {
	TranslationsCommonEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No content available'
	String get no_content => 'No content available';

	/// en: '$tab Content Coming Soon'
	String coming_soon({required Object tab}) => '${tab} Content Coming Soon';

	/// en: 'Loading...'
	String get loading => 'Loading...';

	/// en: 'Error occurred'
	String get error => 'Error occurred';

	/// en: 'Retry'
	String get retry => 'Retry';

	/// en: 'Refresh'
	String get refresh => 'Refresh';

	/// en: 'Load More'
	String get load_more => 'Load More';

	/// en: 'No more content'
	String get no_more => 'No more content';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Confirm'
	String get confirm => 'Confirm';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: '$count views'
	String view_count({required Object count}) => '${count} views';

	/// en: '$count danmaku'
	String danmaku_count({required Object count}) => '${count} danmaku';

	/// en: 'Pull to refresh'
	String get pull_down_to_refresh => 'Pull to refresh';

	/// en: 'Release to refresh'
	String get release_to_refresh => 'Release to refresh';

	/// en: 'Refresh completed'
	String get refresh_completed => 'Refresh completed';

	/// en: 'Refresh failed'
	String get refresh_failed => 'Refresh failed';

	/// en: 'Pull up to load more'
	String get pull_up_to_load_more => 'Pull up to load more';

	/// en: 'Release to load more'
	String get release_to_load_more => 'Release to load more';

	/// en: 'Load failed'
	String get load_failed => 'Load failed';

	/// en: 'Load completed'
	String get load_completed => 'Load completed';

	/// en: 'No more content'
	String get no_more_content => 'No more content';

	/// en: 'UP'
	String get up => 'UP';
}

// Path: error
class TranslationsErrorEn {
	TranslationsErrorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Connection Timeout'
	String get connection_timeout => 'Connection Timeout';

	/// en: 'Send Timeout'
	String get send_timeout => 'Send Timeout';

	/// en: 'Receive Timeout'
	String get receive_timeout => 'Receive Timeout';

	/// en: 'Server Error: $code'
	String bad_response({required Object code}) => 'Server Error: ${code}';

	/// en: 'Request Canceled'
	String get cancel => 'Request Canceled';

	/// en: 'Network Error'
	String get network => 'Network Error';
}

// Path: format
class TranslationsFormatEn {
	TranslationsFormatEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '100M'
	String get hundred_million => '100M';

	/// en: '10K'
	String get ten_thousand => '10K';

	/// en: '$hours h ago'
	String hours_ago({required Object hours}) => '${hours} h ago';

	/// en: '$minutes m ago'
	String minutes_ago({required Object minutes}) => '${minutes} m ago';

	/// en: 'just now'
	String get just_now => 'just now';
}

// Path: to_view
class TranslationsToViewEn {
	TranslationsToViewEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Watch Later'
	String get title => 'Watch Later';

	/// en: 'Clear All'
	String get clear_all => 'Clear All';

	/// en: 'Are you sure to clear watch later list?'
	String get clear_all_confirm => 'Are you sure to clear watch later list?';
}

// Path: subscription
class TranslationsSubscriptionEn {
	TranslationsSubscriptionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Subscription'
	String get title => 'Subscription';

	late final TranslationsSubscriptionTabsEn tabs = TranslationsSubscriptionTabsEn._(_root);

	/// en: 'No content in $tab'
	String empty({required Object tab}) => 'No content in ${tab}';
}

// Path: notification
class TranslationsNotificationEn {
	TranslationsNotificationEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Messages'
	String get title => 'Messages';

	late final TranslationsNotificationTypesEn types = TranslationsNotificationTypesEn._(_root);

	/// en: 'Related Content'
	String get related_content => 'Related Content';

	/// en: 'Unable to navigate to content: $type $id'
	String navigation_error({required Object type, required Object id}) => 'Unable to navigate to content: ${type} ${id}';

	late final TranslationsNotificationChatEn chat = TranslationsNotificationChatEn._(_root);
}

// Path: live
class TranslationsLiveEn {
	TranslationsLiveEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsLiveHeaderEn header = TranslationsLiveHeaderEn._(_root);
	late final TranslationsLiveTagsEn tags = TranslationsLiveTagsEn._(_root);
	late final TranslationsLiveDanmakuEn danmaku = TranslationsLiveDanmakuEn._(_root);
}

// Path: home.tabs
class TranslationsHomeTabsEn {
	TranslationsHomeTabsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Live'
	String get live => 'Live';

	/// en: 'For You'
	String get recommend => 'For You';

	/// en: 'Trending'
	String get hot => 'Trending';

	/// en: 'Anime'
	String get anime => 'Anime';

	/// en: 'Movies'
	String get cinema => 'Movies';

	/// en: 'New Journey'
	String get new_journey => 'New Journey';
}

// Path: moments.tabs
class TranslationsMomentsTabsEn {
	TranslationsMomentsTabsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'All'
	String get all => 'All';

	/// en: 'Video'
	String get video => 'Video';

	/// en: 'General'
	String get comprehensive => 'General';
}

// Path: moments.actions
class TranslationsMomentsActionsEn {
	TranslationsMomentsActionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Share'
	String get forward => 'Share';

	/// en: 'Comment'
	String get comment => 'Comment';

	/// en: 'Like'
	String get like => 'Like';
}

// Path: auth.qr_status
class TranslationsAuthQrStatusEn {
	TranslationsAuthQrStatusEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Loading...'
	String get loading => 'Loading...';

	/// en: 'Login Successful'
	String get success => 'Login Successful';

	/// en: 'Scanned. Confirm on phone.'
	String get scanned => 'Scanned. Confirm on phone.';

	/// en: 'QR Code Expired'
	String get expired => 'QR Code Expired';

	/// en: 'Error loading QR Code'
	String get error => 'Error loading QR Code';
}

// Path: profile.stats
class TranslationsProfileStatsEn {
	TranslationsProfileStatsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Moments'
	String get dynamic => 'Moments';

	/// en: 'Following'
	String get following => 'Following';

	/// en: 'Followers'
	String get followers => 'Followers';

	/// en: 'Likes'
	String get likes => 'Likes';
}

// Path: profile.actions
class TranslationsProfileActionsEn {
	TranslationsProfileActionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Message'
	String get message => 'Message';
}

// Path: profile.vip
class TranslationsProfileVipEn {
	TranslationsProfileVipEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Premium'
	String get premium => 'Premium';

	/// en: 'Annual Premium'
	String get annual_premium => 'Annual Premium';
}

// Path: profile.menu
class TranslationsProfileMenuEn {
	TranslationsProfileMenuEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'History'
	String get history => 'History';

	/// en: 'Downloads'
	String get download => 'Downloads';

	/// en: 'My Favorites'
	String get collection => 'My Favorites';

	/// en: 'Watch Later'
	String get later => 'Watch Later';

	/// en: 'Theme'
	String get theme => 'Theme';

	/// en: 'Creative Center'
	String get creative_center => 'Creative Center';

	/// en: 'Orders'
	String get orders => 'Orders';

	/// en: 'Customer Service'
	String get customer_service => 'Customer Service';
}

// Path: video.tabs
class TranslationsVideoTabsEn {
	TranslationsVideoTabsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Info'
	String get info => 'Info';

	/// en: 'Comment'
	String get comment => 'Comment';
}

// Path: video.quality
class TranslationsVideoQualityEn {
	TranslationsVideoQualityEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '4K Ultra HD'
	String get p4k => '4K Ultra HD';

	/// en: '1080P Full HD'
	String get p1080 => '1080P Full HD';

	/// en: '720P HD'
	String get p720 => '720P HD';

	/// en: '480P SD'
	String get p480 => '480P SD';

	/// en: '360P'
	String get p360 => '360P';

	/// en: '240P'
	String get p240 => '240P';

	/// en: '144P'
	String get p144 => '144P';
}

// Path: video.playback
class TranslationsVideoPlaybackEn {
	TranslationsVideoPlaybackEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Speed'
	String get speed => 'Speed';

	/// en: 'Quality'
	String get quality => 'Quality';

	/// en: 'Danmaku'
	String get danmaku => 'Danmaku';

	/// en: 'Full Screen'
	String get full_screen => 'Full Screen';

	/// en: 'Retry Playback'
	String get retry => 'Retry Playback';
}

// Path: video.actions
class TranslationsVideoActionsEn {
	TranslationsVideoActionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Like'
	String get like => 'Like';

	/// en: 'Dislike'
	String get unlike => 'Dislike';

	/// en: 'Coin'
	String get coin => 'Coin';

	/// en: 'Favorite'
	String get favorite => 'Favorite';

	/// en: 'Share'
	String get share => 'Share';

	/// en: 'Followed'
	String get followed => 'Followed';

	/// en: 'Follow'
	String get follow => 'Follow';

	/// en: 'Reply'
	String get reply => 'Reply';
}

// Path: subscription.tabs
class TranslationsSubscriptionTabsEn {
	TranslationsSubscriptionTabsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Video'
	String get video => 'Video';

	/// en: 'Anime'
	String get anime => 'Anime';

	/// en: 'Series'
	String get series => 'Series';
}

// Path: notification.types
class TranslationsNotificationTypesEn {
	TranslationsNotificationTypesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Liked my comment'
	String get like => 'Liked my comment';

	/// en: 'Mentioned me'
	String get at => 'Mentioned me';

	/// en: 'Replied to me'
	String get reply => 'Replied to me';

	/// en: 'System Notification'
	String get system => 'System Notification';
}

// Path: notification.chat
class TranslationsNotificationChatEn {
	TranslationsNotificationChatEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Message withdrawn'
	String get message_withdrawn => 'Message withdrawn';

	/// en: '[Unsupported message type: $type]'
	String unsupported_type({required Object type}) => '[Unsupported message type: ${type}]';
}

// Path: live.header
class TranslationsLiveHeaderEn {
	TranslationsLiveHeaderEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '$count watched'
	String online({required Object count}) => '${count} watched';

	/// en: '$count fleet'
	String guard({required Object count}) => '${count} fleet';
}

// Path: live.tags
class TranslationsLiveTagsEn {
	TranslationsLiveTagsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Hot'
	String get hot => 'Hot';

	/// en: 'Popular'
	String get popularity => 'Popular';

	/// en: 'More'
	String get more_play => 'More';
}

// Path: live.danmaku
class TranslationsLiveDanmakuEn {
	TranslationsLiveDanmakuEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'System Notice'
	String get system_notice => 'System Notice';

	/// en: 'System Notice:'
	String get system_notice_colon => 'System Notice:';

	/// en: 'Admin'
	String get admin => 'Admin';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'nav.home' => 'Home',
			'nav.moments' => 'Moments',
			'nav.ranking' => 'Ranking',
			'nav.mine' => 'Mine',
			'home.tabs.live' => 'Live',
			'home.tabs.recommend' => 'For You',
			'home.tabs.hot' => 'Trending',
			'home.tabs.anime' => 'Anime',
			'home.tabs.cinema' => 'Movies',
			'home.tabs.new_journey' => 'New Journey',
			'home.search_hint' => 'Search...',
			'moments.title' => 'Moments',
			'moments.tabs.all' => 'All',
			'moments.tabs.video' => 'Video',
			'moments.tabs.comprehensive' => 'General',
			'moments.actions.forward' => 'Share',
			'moments.actions.comment' => 'Comment',
			'moments.actions.like' => 'Like',
			'moments.like_coming_soon' => 'Like feature coming soon',
			'moments.empty' => ({required Object tab}) => '${tab} dynamic not implemented',
			'ranking.title' => 'Ranking',
			'settings.title' => 'Settings',
			'settings.language' => 'General',
			'settings.change_language' => 'Change Language',
			'settings.chinese' => 'Simplified Chinese',
			'settings.traditional_chinese' => 'Traditional Chinese',
			'settings.english' => 'English',
			'settings.appearance' => 'Appearance',
			'settings.system_mode' => 'Follow System',
			'settings.dark_mode' => 'Dark Mode',
			'settings.light_mode' => 'Light Mode',
			'settings.cache' => 'Cache Management',
			'settings.clear_cache' => 'Clear Cache',
			'settings.user_agreement' => 'User Agreement',
			'settings.privacy_policy' => 'Privacy Policy',
			'settings.about' => 'About',
			'settings.version' => 'Version',
			'auth.login' => 'Login',
			'auth.logout' => 'Logout',
			'auth.account_login' => 'Account Login',
			'auth.sms_login' => 'SMS Login',
			'auth.qr_login' => 'QR Login',
			'auth.username' => 'Account',
			'auth.username_hint' => 'Phone/Email',
			'auth.password' => 'Password',
			'auth.phone' => 'Phone Number',
			'auth.sms_code' => 'SMS Code',
			'auth.get_code' => 'Get Code',
			'auth.get_code_retry' => ({required Object seconds}) => 'Resend (${seconds} s)',
			'auth.qr_hint' => 'Scan with culcul app',
			'auth.qr_refresh' => 'Refresh QR Code',
			'auth.qr_status.loading' => 'Loading...',
			'auth.qr_status.success' => 'Login Successful',
			'auth.qr_status.scanned' => 'Scanned. Confirm on phone.',
			'auth.qr_status.expired' => 'QR Code Expired',
			'auth.qr_status.error' => 'Error loading QR Code',
			'auth.sms_sent' => 'SMS Code sent',
			'auth.subtitle' => 'Third-party lightweight client',
			'profile.login' => 'Login',
			'profile.not_logged_in' => 'Not Logged In',
			'profile.login_hint' => 'Tap to login for more features',
			'profile.stats.dynamic' => 'Moments',
			'profile.stats.following' => 'Following',
			'profile.stats.followers' => 'Followers',
			'profile.stats.likes' => 'Likes',
			'profile.actions.message' => 'Message',
			'profile.vip.premium' => 'Premium',
			'profile.vip.annual_premium' => 'Annual Premium',
			'profile.menu.history' => 'History',
			'profile.menu.download' => 'Downloads',
			'profile.menu.collection' => 'My Favorites',
			'profile.menu.later' => 'Watch Later',
			'profile.menu.theme' => 'Theme',
			'profile.menu.creative_center' => 'Creative Center',
			'profile.menu.orders' => 'Orders',
			'profile.menu.customer_service' => 'Customer Service',
			'fav.title' => 'My Favorites',
			'fav.created' => 'Created',
			'fav.collected' => 'Collected',
			'fav.private' => 'Private',
			'fav.public' => 'Public',
			'fav.play' => 'Play',
			'fav.count' => ({required Object count}) => '${count} items',
			'fav.search_hint' => 'Search favorites',
			'search.placeholder' => 'Trending: culcul',
			'search.button' => 'Search',
			'search.history' => 'History',
			'search.hot_search' => 'Hot Search',
			'search.clear_history' => 'Clear History',
			'search.suggestion' => 'Suggestions',
			'search.no_result' => 'No results found',
			'search.trending' => 'Trending Now',
			'video.tabs.info' => 'Info',
			'video.tabs.comment' => 'Comment',
			'video.recommend' => 'Recommendations',
			'video.comment_empty' => 'Comments coming soon...',
			'video.comment_count' => ({required Object count}) => '${count} comments',
			'video.comment_sort_hot' => 'Hot',
			'video.comment_sort_time' => 'Newest',
			'video.all_comments' => 'All Comments',
			'video.comment_detail' => 'Comment Detail',
			'video.related_replies' => 'Related Replies',
			'video.replies' => ({required Object count}) => 'View all ${count} replies',
			'video.load_failed' => 'Failed to load video',
			'video.tags' => 'Tags',
			'video.no_desc' => 'No description',
			'video.expand_all' => 'Expand All',
			'video.quality.p4k' => '4K Ultra HD',
			'video.quality.p1080' => '1080P Full HD',
			'video.quality.p720' => '720P HD',
			'video.quality.p480' => '480P SD',
			'video.quality.p360' => '360P',
			'video.quality.p240' => '240P',
			'video.quality.p144' => '144P',
			'video.playback.speed' => 'Speed',
			'video.playback.quality' => 'Quality',
			'video.playback.danmaku' => 'Danmaku',
			'video.playback.full_screen' => 'Full Screen',
			'video.playback.retry' => 'Retry Playback',
			'video.actions.like' => 'Like',
			'video.actions.unlike' => 'Dislike',
			'video.actions.coin' => 'Coin',
			'video.actions.favorite' => 'Favorite',
			'video.actions.share' => 'Share',
			'video.actions.followed' => 'Followed',
			'video.actions.follow' => 'Follow',
			'video.actions.reply' => 'Reply',
			'video.reply_to' => ({required Object name}) => 'Reply @${name} : ',
			'video.parts' => 'Video Parts',
			'video.expand' => 'Expand',
			'video.collapse' => 'Collapse',
			'video.comment_hint' => 'Write a friendly comment',
			'common.no_content' => 'No content available',
			'common.coming_soon' => ({required Object tab}) => '${tab} Content Coming Soon',
			'common.loading' => 'Loading...',
			'common.error' => 'Error occurred',
			'common.retry' => 'Retry',
			'common.refresh' => 'Refresh',
			'common.load_more' => 'Load More',
			'common.no_more' => 'No more content',
			'common.cancel' => 'Cancel',
			'common.confirm' => 'Confirm',
			'common.save' => 'Save',
			'common.delete' => 'Delete',
			'common.view_count' => ({required Object count}) => '${count} views',
			'common.danmaku_count' => ({required Object count}) => '${count} danmaku',
			'common.pull_down_to_refresh' => 'Pull to refresh',
			'common.release_to_refresh' => 'Release to refresh',
			'common.refresh_completed' => 'Refresh completed',
			'common.refresh_failed' => 'Refresh failed',
			'common.pull_up_to_load_more' => 'Pull up to load more',
			'common.release_to_load_more' => 'Release to load more',
			'common.load_failed' => 'Load failed',
			'common.load_completed' => 'Load completed',
			'common.no_more_content' => 'No more content',
			'common.up' => 'UP',
			'error.connection_timeout' => 'Connection Timeout',
			'error.send_timeout' => 'Send Timeout',
			'error.receive_timeout' => 'Receive Timeout',
			'error.bad_response' => ({required Object code}) => 'Server Error: ${code}',
			'error.cancel' => 'Request Canceled',
			'error.network' => 'Network Error',
			'format.hundred_million' => '100M',
			'format.ten_thousand' => '10K',
			'format.hours_ago' => ({required Object hours}) => '${hours} h ago',
			'format.minutes_ago' => ({required Object minutes}) => '${minutes} m ago',
			'format.just_now' => 'just now',
			'to_view.title' => 'Watch Later',
			'to_view.clear_all' => 'Clear All',
			'to_view.clear_all_confirm' => 'Are you sure to clear watch later list?',
			'subscription.title' => 'Subscription',
			'subscription.tabs.video' => 'Video',
			'subscription.tabs.anime' => 'Anime',
			'subscription.tabs.series' => 'Series',
			'subscription.empty' => ({required Object tab}) => 'No content in ${tab}',
			'notification.title' => 'Messages',
			'notification.types.like' => 'Liked my comment',
			'notification.types.at' => 'Mentioned me',
			'notification.types.reply' => 'Replied to me',
			'notification.types.system' => 'System Notification',
			'notification.related_content' => 'Related Content',
			'notification.navigation_error' => ({required Object type, required Object id}) => 'Unable to navigate to content: ${type} ${id}',
			'notification.chat.message_withdrawn' => 'Message withdrawn',
			'notification.chat.unsupported_type' => ({required Object type}) => '[Unsupported message type: ${type}]',
			'live.header.online' => ({required Object count}) => '${count} watched',
			'live.header.guard' => ({required Object count}) => '${count} fleet',
			'live.tags.hot' => 'Hot',
			'live.tags.popularity' => 'Popular',
			'live.tags.more_play' => 'More',
			'live.danmaku.system_notice' => 'System Notice',
			'live.danmaku.system_notice_colon' => 'System Notice:',
			'live.danmaku.admin' => 'Admin',
			_ => null,
		};
	}
}
