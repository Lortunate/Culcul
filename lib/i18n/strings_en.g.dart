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
	late final TranslationsFavoritesEn favorites = TranslationsFavoritesEn._(_root);
	late final TranslationsSearchEn search = TranslationsSearchEn._(_root);
	late final TranslationsVideoEn video = TranslationsVideoEn._(_root);
	late final TranslationsActionsEn actions = TranslationsActionsEn._(_root);
	late final TranslationsCommonEn common = TranslationsCommonEn._(_root);
	late final TranslationsErrorEn error = TranslationsErrorEn._(_root);
	late final TranslationsFormatEn format = TranslationsFormatEn._(_root);
	late final TranslationsWatchLaterEn watch_later = TranslationsWatchLaterEn._(_root);
	late final TranslationsSubscriptionEn subscription = TranslationsSubscriptionEn._(_root);
	late final TranslationsNotificationEn notification = TranslationsNotificationEn._(_root);
	late final TranslationsLiveEn live = TranslationsLiveEn._(_root);
	late final TranslationsHistoryEn history = TranslationsHistoryEn._(_root);
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

	/// en: 'Profile'
	String get profile => 'Profile';
}

// Path: home
class TranslationsHomeEn {
	TranslationsHomeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsHomeTabsEn tabs = TranslationsHomeTabsEn._(_root);

	/// en: 'Search...'
	String get search_hint => 'Search...';

	late final TranslationsHomeVideoMoreEn video_more = TranslationsHomeVideoMoreEn._(_root);
}

// Path: moments
class TranslationsMomentsEn {
	TranslationsMomentsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Moments'
	String get title => 'Moments';

	late final TranslationsMomentsTabsEn tabs = TranslationsMomentsTabsEn._(_root);

	/// en: 'Like feature coming soon'
	String get like_coming_soon => 'Like feature coming soon';

	/// en: 'No content available in $tab'
	String empty({required Object tab}) => 'No content available in ${tab}';

	/// en: 'Recently Followed'
	String get recently_followed => 'Recently Followed';

	/// en: 'Search topics'
	String get topic_search_hint => 'Search topics';

	/// en: 'Type keywords to search topics'
	String get topic_search_empty => 'Type keywords to search topics';

	/// en: 'No topics found'
	String get topic_search_no_result => 'No topics found';

	/// en: 'Updated $count posts'
	String topic_updates({required Object count}) => 'Updated ${count} posts';

	/// en: 'No comments yet. Be the first to comment.'
	String get no_comments => 'No comments yet. Be the first to comment.';

	/// en: 'Leave a friendly comment...'
	String get comment_hint => 'Leave a friendly comment...';

	/// en: 'Post'
	String get publish => 'Post';

	/// en: 'Create Post'
	String get publish_title => 'Create Post';

	/// en: 'Post'
	String get publish_action => 'Post';

	/// en: 'Share what is new...'
	String get publish_hint => 'Share what is new...';

	/// en: 'Posted successfully'
	String get publish_success => 'Posted successfully';

	/// en: 'Post failed: $error'
	String publish_failed({required Object error}) => 'Post failed: ${error}';

	/// en: 'Tip'
	String get discard_title => 'Tip';

	/// en: 'Discard your draft?'
	String get discard_confirm => 'Discard your draft?';

	/// en: 'Discard'
	String get discard_action => 'Discard';

	/// en: 'Forward post'
	String get forward_post => 'Forward post';

	/// en: 'Reserve'
	String get reserve => 'Reserve';

	/// en: 'Reserved'
	String get reserved => 'Reserved';

	/// en: 'Vote'
	String get vote => 'Vote';

	/// en: '$participants participants · $options options'
	String vote_stats({required Object participants, required Object options}) => '${participants} participants · ${options} options';

	/// en: 'Copy link'
	String get copy_link => 'Copy link';

	/// en: 'Open in browser'
	String get open_in_browser => 'Open in browser';

	/// en: 'Dynamic link copied'
	String get copied_link => 'Dynamic link copied';

	/// en: 'Unable to open link'
	String get open_link_failed => 'Unable to open link';

	/// en: 'Operation failed: $message'
	String operation_failed({required Object message}) => 'Operation failed: ${message}';

	/// en: 'Moment Details'
	String get detail_title => 'Moment Details';
}

// Path: ranking
class TranslationsRankingEn {
	TranslationsRankingEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Ranking'
	String get title => 'Ranking';

	late final TranslationsRankingCategoriesEn categories = TranslationsRankingCategoriesEn._(_root);
}

// Path: settings
class TranslationsSettingsEn {
	TranslationsSettingsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Settings'
	String get title => 'Settings';

	late final TranslationsSettingsSectionsEn sections = TranslationsSettingsSectionsEn._(_root);

	/// en: 'Language'
	String get language => 'Language';

	/// en: 'Appearance'
	String get appearance => 'Appearance';

	/// en: '简体中文'
	String get chinese => '简体中文';

	/// en: '繁體中文'
	String get traditional_chinese => '繁體中文';

	/// en: 'English'
	String get english => 'English';

	late final TranslationsSettingsThemeModeEn theme_mode = TranslationsSettingsThemeModeEn._(_root);

	/// en: 'Clear Cache'
	String get clear_cache => 'Clear Cache';

	/// en: 'User Agreement'
	String get user_agreement => 'User Agreement';

	/// en: 'Privacy Policy'
	String get privacy_policy => 'Privacy Policy';

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

	late final TranslationsAuthMethodsEn methods = TranslationsAuthMethodsEn._(_root);

	/// en: 'Account'
	String get username => 'Account';

	/// en: 'Phone or Email'
	String get username_hint => 'Phone or Email';

	/// en: 'Password'
	String get password => 'Password';

	/// en: 'Phone Number'
	String get phone => 'Phone Number';

	/// en: 'Verification Code'
	String get sms_code => 'Verification Code';

	/// en: 'Get Code'
	String get get_code => 'Get Code';

	/// en: 'Resend in $seconds s'
	String get_code_retry({required Object seconds}) => 'Resend in ${seconds} s';

	/// en: 'Scan with culcul app'
	String get qr_hint => 'Scan with culcul app';

	/// en: 'Refresh QR Code'
	String get qr_refresh => 'Refresh QR Code';

	late final TranslationsAuthQrStatusEn qr_status = TranslationsAuthQrStatusEn._(_root);

	/// en: 'Code sent'
	String get sms_sent => 'Code sent';

	/// en: 'A lightweight third-party client'
	String get subtitle => 'A lightweight third-party client';

	/// en: 'Select Country/Region'
	String get select_country => 'Select Country/Region';

	/// en: 'Search country or region'
	String get search_country_hint => 'Search country or region';

	/// en: 'No results found'
	String get no_search_result => 'No results found';

	/// en: 'Welcome back'
	String get welcome_back => 'Welcome back';

	/// en: 'Please enter username and password'
	String get please_enter_username_password => 'Please enter username and password';

	/// en: 'OK'
	String get ok => 'OK';
}

// Path: profile
class TranslationsProfileEn {
	TranslationsProfileEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Login'
	String get login => 'Login';

	/// en: 'Not logged in'
	String get not_logged_in => 'Not logged in';

	/// en: 'Sign in to explore more'
	String get login_hint => 'Sign in to explore more';

	late final TranslationsProfileStatsEn stats = TranslationsProfileStatsEn._(_root);
	late final TranslationsProfileActionsEn actions = TranslationsProfileActionsEn._(_root);
	late final TranslationsProfileVipEn vip = TranslationsProfileVipEn._(_root);
	late final TranslationsProfileMenuEn menu = TranslationsProfileMenuEn._(_root);
	late final TranslationsProfileTabsEn tabs = TranslationsProfileTabsEn._(_root);
	late final TranslationsProfileHomeTabEn home_tab = TranslationsProfileHomeTabEn._(_root);
	late final TranslationsProfileFollowingsEn followings = TranslationsProfileFollowingsEn._(_root);
	late final TranslationsProfileFollowersEn followers = TranslationsProfileFollowersEn._(_root);
	late final TranslationsProfileRelationEn relation = TranslationsProfileRelationEn._(_root);

	/// en: 'Privacy enabled'
	String get privacy_title => 'Privacy enabled';

	/// en: 'This user hides their following and followers lists'
	String get privacy_message => 'This user hides their following and followers lists';

	/// en: 'Verified by bilibili'
	String get verified_badge => 'Verified by bilibili';

	/// en: 'Are you sure you want to log out?'
	String get logout_confirm => 'Are you sure you want to log out?';

	/// en: 'Search in Space: coming soon'
	String get space_search_coming_soon => 'Search in Space: coming soon';
}

// Path: favorites
class TranslationsFavoritesEn {
	TranslationsFavoritesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Favorites'
	String get title => 'Favorites';

	/// en: 'Created'
	String get created => 'Created';

	/// en: 'Saved'
	String get collected => 'Saved';

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

	/// en: '$count items'
	String folder_item_count({required Object count}) => '${count} items';

	/// en: 'New Folder'
	String get new_folder => 'New Folder';

	/// en: 'Edit Folder'
	String get edit_folder => 'Edit Folder';

	/// en: 'Delete Folder'
	String get delete_folder => 'Delete Folder';

	/// en: 'Are you sure you want to delete this folder?'
	String get delete_folder_confirm => 'Are you sure you want to delete this folder?';

	/// en: 'Delete ($count)'
	String delete_with_count({required Object count}) => 'Delete (${count})';

	/// en: 'Edit Info'
	String get edit_info => 'Edit Info';

	/// en: 'Manage Resources'
	String get manage_resources => 'Manage Resources';

	/// en: 'Only visible to me'
	String get only_visible_to_me => 'Only visible to me';

	/// en: 'Title'
	String get folder_title => 'Title';

	/// en: 'Intro'
	String get folder_intro => 'Intro';
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

	/// en: 'Trending'
	String get hot_search => 'Trending';

	/// en: 'Clear History'
	String get clear_history => 'Clear History';

	/// en: 'Suggestions'
	String get suggestion => 'Suggestions';

	/// en: 'No results found'
	String get no_result => 'No results found';

	/// en: 'Trending Now'
	String get trending => 'Trending Now';

	late final TranslationsSearchTabsEn tabs = TranslationsSearchTabsEn._(_root);
	late final TranslationsSearchStatusEn status = TranslationsSearchStatusEn._(_root);
	late final TranslationsSearchFilterEn filter = TranslationsSearchFilterEn._(_root);
}

// Path: video
class TranslationsVideoEn {
	TranslationsVideoEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsVideoTabsEn tabs = TranslationsVideoTabsEn._(_root);

	/// en: 'Up Next'
	String get recommend => 'Up Next';

	late final TranslationsVideoCommentEn comment = TranslationsVideoCommentEn._(_root);

	/// en: 'Failed to load video'
	String get load_failed => 'Failed to load video';

	/// en: 'Tags'
	String get tags => 'Tags';

	/// en: 'No description'
	String get no_desc => 'No description';

	/// en: 'Expand All'
	String get expand_all => 'Expand All';

	late final TranslationsVideoQualityEn quality = TranslationsVideoQualityEn._(_root);
	late final TranslationsVideoPlayerEn player = TranslationsVideoPlayerEn._(_root);
	late final TranslationsVideoActionsEn actions = TranslationsVideoActionsEn._(_root);

	/// en: 'Reply to @$name: '
	String reply_to({required Object name}) => 'Reply to @${name}: ';

	/// en: 'Segments'
	String get parts => 'Segments';

	/// en: 'Expand'
	String get expand => 'Expand';

	/// en: 'Collapse'
	String get collapse => 'Collapse';

	/// en: 'Listen Only'
	String get listen => 'Listen Only';

	late final TranslationsVideoListenSettingsEn listen_settings = TranslationsVideoListenSettingsEn._(_root);

	/// en: '$count watching'
	String watching_count({required Object count}) => '${count} watching';

	/// en: 'Detail Page'
	String get detail_page => 'Detail Page';
}

// Path: actions
class TranslationsActionsEn {
	TranslationsActionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Like'
	String get like => 'Like';

	/// en: 'Dislike'
	String get unlike => 'Dislike';

	/// en: 'Follow'
	String get follow => 'Follow';

	/// en: 'Following'
	String get followed => 'Following';

	/// en: 'Share'
	String get share => 'Share';

	/// en: 'Reply'
	String get reply => 'Reply';

	/// en: 'Comment'
	String get comment => 'Comment';

	/// en: 'Forward'
	String get forward => 'Forward';
}

// Path: common
class TranslationsCommonEn {
	TranslationsCommonEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No content'
	String get no_content => 'No content';

	/// en: 'Coming soon: $tab'
	String coming_soon({required Object tab}) => 'Coming soon: ${tab}';

	/// en: 'Loading...'
	String get loading => 'Loading...';

	/// en: 'Something went wrong'
	String get error => 'Something went wrong';

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

	/// en: 'Refresh successful'
	String get refresh_completed => 'Refresh successful';

	/// en: 'Refresh failed'
	String get refresh_failed => 'Refresh failed';

	/// en: 'Pull up to load more'
	String get pull_up_to_load_more => 'Pull up to load more';

	/// en: 'Release to load more'
	String get release_to_load_more => 'Release to load more';

	/// en: 'Failed to load'
	String get load_failed => 'Failed to load';

	/// en: 'Loaded'
	String get load_completed => 'Loaded';

	/// en: 'You've reached the end.'
	String get no_more_content => 'You\'ve reached the end.';

	/// en: 'UP'
	String get up => 'UP';

	/// en: 'Save Image'
	String get save_image => 'Save Image';

	/// en: 'Saving...'
	String get saving => 'Saving...';

	/// en: 'Saved to gallery'
	String get save_success => 'Saved to gallery';

	/// en: 'Failed to save: $message'
	String save_failed({required Object message}) => 'Failed to save: ${message}';

	/// en: 'Swipe to switch'
	String get slide_to_switch => 'Swipe to switch';

	/// en: 'No data'
	String get no_data => 'No data';
}

// Path: error
class TranslationsErrorEn {
	TranslationsErrorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Connection Timed Out'
	String get connection_timeout => 'Connection Timed Out';

	/// en: 'Request Timed Out'
	String get send_timeout => 'Request Timed Out';

	/// en: 'Response Timed Out'
	String get receive_timeout => 'Response Timed Out';

	/// en: 'Server Error ($code)'
	String bad_response({required Object code}) => 'Server Error (${code})';

	/// en: 'Request Canceled'
	String get cancel => 'Request Canceled';

	/// en: 'Network Error'
	String get network => 'Network Error';

	/// en: 'Authentication failed'
	String get auth_failed => 'Authentication failed';

	/// en: 'Server error'
	String get server_error => 'Server error';

	/// en: 'Error Details'
	String get details => 'Error Details';

	/// en: 'View Details'
	String get view_details => 'View Details';

	/// en: 'Stack Trace'
	String get stack_trace => 'Stack Trace';
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

	/// en: 'Just now'
	String get just_now => 'Just now';
}

// Path: watch_later
class TranslationsWatchLaterEn {
	TranslationsWatchLaterEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Watch Later'
	String get title => 'Watch Later';

	/// en: 'Clear All'
	String get clear_all => 'Clear All';

	/// en: 'Are you sure you want to clear your Watch Later list?'
	String get clear_all_confirm => 'Are you sure you want to clear your Watch Later list?';

	/// en: 'Watch to $progress'
	String watch_to({required Object progress}) => 'Watch to ${progress}';

	/// en: 'Added to Watch Later'
	String get add_success => 'Added to Watch Later';
}

// Path: subscription
class TranslationsSubscriptionEn {
	TranslationsSubscriptionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Subscriptions'
	String get title => 'Subscriptions';

	late final TranslationsSubscriptionTabsEn tabs = TranslationsSubscriptionTabsEn._(_root);

	/// en: 'No content in $tab'
	String empty({required Object tab}) => 'No content in ${tab}';
}

// Path: notification
class TranslationsNotificationEn {
	TranslationsNotificationEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Notifications'
	String get title => 'Notifications';

	late final TranslationsNotificationTypesEn types = TranslationsNotificationTypesEn._(_root);

	/// en: 'Related Content'
	String get related_content => 'Related Content';

	/// en: 'Unable to open content: $type $id'
	String navigation_error({required Object type, required Object id}) => 'Unable to open content: ${type} ${id}';

	late final TranslationsNotificationChatEn chat = TranslationsNotificationChatEn._(_root);

	/// en: 'No notifications'
	String get empty => 'No notifications';
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

// Path: history
class TranslationsHistoryEn {
	TranslationsHistoryEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No history found'
	String get empty => 'No history found';
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

	/// en: 'Movies & TV'
	String get cinema => 'Movies & TV';

	/// en: 'New Journey'
	String get new_journey => 'New Journey';

	/// en: 'Weekly Must-Watch'
	String get weekly_must_watch => 'Weekly Must-Watch';
}

// Path: home.video_more
class TranslationsHomeVideoMoreEn {
	TranslationsHomeVideoMoreEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Watch Later'
	String get watch_later => 'Watch Later';

	/// en: 'Download Cover'
	String get download_cover => 'Download Cover';

	/// en: 'Unable to resolve video ID'
	String get invalid_video_id => 'Unable to resolve video ID';

	/// en: 'Added to Watch Later'
	String get added_to_watch_later => 'Added to Watch Later';

	/// en: 'Failed to add: $error'
	String add_failed({required Object error}) => 'Failed to add: ${error}';

	/// en: 'Download failed: $error'
	String download_failed({required Object error}) => 'Download failed: ${error}';
}

// Path: moments.tabs
class TranslationsMomentsTabsEn {
	TranslationsMomentsTabsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'All'
	String get all => 'All';

	/// en: 'Videos'
	String get video => 'Videos';

	/// en: 'Anime/Media'
	String get pgc => 'Anime/Media';
}

// Path: ranking.categories
class TranslationsRankingCategoriesEn {
	TranslationsRankingCategoriesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'All'
	String get all => 'All';

	/// en: 'Animation'
	String get animation => 'Animation';

	/// en: 'Bangumi'
	String get bangumi => 'Bangumi';

	/// en: 'Chinese Original'
	String get guochuang => 'Chinese Original';

	/// en: 'Music'
	String get music => 'Music';

	/// en: 'Dance'
	String get dance => 'Dance';

	/// en: 'Games'
	String get game => 'Games';

	/// en: 'Knowledge'
	String get knowledge => 'Knowledge';

	/// en: 'Technology'
	String get technology => 'Technology';

	/// en: 'Sports'
	String get sports => 'Sports';

	/// en: 'Auto'
	String get car => 'Auto';

	/// en: 'Lifestyle'
	String get life => 'Lifestyle';

	/// en: 'Food'
	String get food => 'Food';

	/// en: 'Animals'
	String get animal => 'Animals';

	/// en: 'Kichiku'
	String get kichiku => 'Kichiku';

	/// en: 'Fashion'
	String get fashion => 'Fashion';

	/// en: 'News'
	String get information => 'News';

	/// en: 'Entertainment'
	String get entertainment => 'Entertainment';

	/// en: 'Film & TV'
	String get film => 'Film & TV';

	/// en: 'Documentaries'
	String get documentary => 'Documentaries';

	/// en: 'Movies'
	String get movie => 'Movies';

	/// en: 'TV Series'
	String get tv => 'TV Series';

	/// en: 'Tech & Digital'
	String get tech_digital => 'Tech & Digital';

	/// en: 'Short Plays'
	String get short_play => 'Short Plays';

	/// en: 'Fashion & Beauty'
	String get fashion_beauty => 'Fashion & Beauty';

	/// en: 'Sports & Fitness'
	String get sports_fitness => 'Sports & Fitness';

	/// en: 'Vlog'
	String get vlog => 'Vlog';

	/// en: 'Drawing'
	String get painting => 'Drawing';

	/// en: 'AI'
	String get ai => 'AI';

	/// en: 'Home & Living'
	String get home => 'Home & Living';

	/// en: 'Outdoor'
	String get outdoor => 'Outdoor';

	/// en: 'Fitness'
	String get fitness => 'Fitness';

	/// en: 'Craft'
	String get craft => 'Craft';

	/// en: 'Travel'
	String get travel => 'Travel';

	/// en: 'Rural Life'
	String get three_rural => 'Rural Life';

	/// en: 'Parenting'
	String get parenting => 'Parenting';

	/// en: 'Health'
	String get health => 'Health';

	/// en: 'Relationships'
	String get emotion => 'Relationships';

	/// en: 'Lifestyle Interests'
	String get life_interest => 'Lifestyle Interests';

	/// en: 'Life Experiences'
	String get life_experience => 'Life Experiences';
}

// Path: settings.sections
class TranslationsSettingsSectionsEn {
	TranslationsSettingsSectionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'General'
	String get general => 'General';

	/// en: 'Appearance'
	String get appearance => 'Appearance';

	/// en: 'Storage'
	String get storage => 'Storage';

	/// en: 'About'
	String get about => 'About';
}

// Path: settings.theme_mode
class TranslationsSettingsThemeModeEn {
	TranslationsSettingsThemeModeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'System Default'
	String get system => 'System Default';

	/// en: 'Dark Mode'
	String get dark => 'Dark Mode';

	/// en: 'Light Mode'
	String get light => 'Light Mode';
}

// Path: auth.methods
class TranslationsAuthMethodsEn {
	TranslationsAuthMethodsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Account'
	String get account => 'Account';

	/// en: 'SMS'
	String get sms => 'SMS';

	/// en: 'QR Code'
	String get qr => 'QR Code';
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

	/// en: 'Scanned. Confirm on your phone.'
	String get scanned => 'Scanned. Confirm on your phone.';

	/// en: 'QR Code Expired'
	String get expired => 'QR Code Expired';

	/// en: 'Failed to load QR Code'
	String get error => 'Failed to load QR Code';
}

// Path: profile.stats
class TranslationsProfileStatsEn {
	TranslationsProfileStatsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Posts'
	String get posts => 'Posts';

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

	/// en: 'Edit Profile'
	String get edit_profile => 'Edit Profile';
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

	/// en: 'Favorites'
	String get favorites => 'Favorites';

	/// en: 'Watch Later'
	String get watch_later => 'Watch Later';

	/// en: 'Appearance'
	String get appearance => 'Appearance';

	/// en: 'Creator Center'
	String get creative_center => 'Creator Center';

	/// en: 'Orders'
	String get orders => 'Orders';

	/// en: 'Support'
	String get support => 'Support';

	/// en: 'Add to blacklist'
	String get blacklist => 'Add to blacklist';

	/// en: 'Report'
	String get report => 'Report';
}

// Path: profile.tabs
class TranslationsProfileTabsEn {
	TranslationsProfileTabsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Home'
	String get home => 'Home';

	/// en: 'Moments'
	String get moments => 'Moments';

	/// en: 'Contributions'
	String get contribution => 'Contributions';
}

// Path: profile.home_tab
class TranslationsProfileHomeTabEn {
	TranslationsProfileHomeTabEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Videos $count'
	String recent_videos({required Object count}) => 'Videos ${count}';

	/// en: 'View More'
	String get view_more => 'View More';

	/// en: 'No content'
	String get empty => 'No content';

	/// en: 'Sticky Video'
	String get sticky => 'Sticky Video';

	/// en: 'Sticky'
	String get sticky_tag => 'Sticky';

	/// en: 'Masterpiece'
	String get masterpiece => 'Masterpiece';
}

// Path: profile.followings
class TranslationsProfileFollowingsEn {
	TranslationsProfileFollowingsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Following'
	String get title => 'Following';

	/// en: 'No following yet'
	String get empty => 'No following yet';
}

// Path: profile.followers
class TranslationsProfileFollowersEn {
	TranslationsProfileFollowersEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Followers'
	String get title => 'Followers';

	/// en: 'No followers yet'
	String get empty => 'No followers yet';
}

// Path: profile.relation
class TranslationsProfileRelationEn {
	TranslationsProfileRelationEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Follow'
	String get none => 'Follow';

	/// en: 'Following'
	String get followed => 'Following';

	/// en: 'Mutual'
	String get mutual => 'Mutual';

	/// en: 'Blacklisted'
	String get blacklisted => 'Blacklisted';

	/// en: 'Failed: $error'
	String failed({required Object error}) => 'Failed: ${error}';
}

// Path: search.tabs
class TranslationsSearchTabsEn {
	TranslationsSearchTabsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'All'
	String get all => 'All';

	/// en: 'Videos'
	String get video => 'Videos';

	/// en: 'Anime'
	String get anime => 'Anime';

	/// en: 'Users'
	String get user => 'Users';

	/// en: 'Articles'
	String get article => 'Articles';
}

// Path: search.status
class TranslationsSearchStatusEn {
	TranslationsSearchStatusEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Loading suggestions...'
	String get loading => 'Loading suggestions...';

	/// en: 'No suggestions found'
	String get empty => 'No suggestions found';

	/// en: 'Failed to load suggestions'
	String get failed => 'Failed to load suggestions';
}

// Path: search.filter
class TranslationsSearchFilterEn {
	TranslationsSearchFilterEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Default'
	String get sort_default => 'Default';

	/// en: 'Newest'
	String get sort_newest => 'Newest';

	/// en: 'Most Views'
	String get sort_click => 'Most Views';

	/// en: 'Most Danmaku'
	String get sort_danmaku => 'Most Danmaku';

	/// en: 'Most Favorites'
	String get sort_favorite => 'Most Favorites';

	/// en: 'All Durations'
	String get duration_all => 'All Durations';

	/// en: '<10m'
	String get duration_short => '<10m';

	/// en: '10-30m'
	String get duration_medium => '10-30m';

	/// en: '30-60m'
	String get duration_long => '30-60m';

	/// en: '>60m'
	String get duration_extra_long => '>60m';
}

// Path: video.tabs
class TranslationsVideoTabsEn {
	TranslationsVideoTabsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'About'
	String get info => 'About';

	/// en: 'Comments'
	String get comment => 'Comments';
}

// Path: video.comment
class TranslationsVideoCommentEn {
	TranslationsVideoCommentEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No comments yet. Be the first to comment!'
	String get empty => 'No comments yet. Be the first to comment!';

	/// en: '$count comments'
	String count({required Object count}) => '${count} comments';

	/// en: 'Top'
	String get sort_hot => 'Top';

	/// en: 'Newest'
	String get sort_time => 'Newest';

	/// en: 'All Comments'
	String get all => 'All Comments';

	/// en: 'Comment Details'
	String get detail => 'Comment Details';

	/// en: 'Related Replies'
	String get related_replies => 'Related Replies';

	/// en: 'View all $count replies'
	String replies({required Object count}) => 'View all ${count} replies';

	/// en: 'Leave a friendly comment...'
	String get hint => 'Leave a friendly comment...';
}

// Path: video.quality
class TranslationsVideoQualityEn {
	TranslationsVideoQualityEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '8K Ultra HD'
	String get p8k => '8K Ultra HD';

	/// en: 'Dolby Vision'
	String get p_dolby => 'Dolby Vision';

	/// en: 'HDR'
	String get p_hdr => 'HDR';

	/// en: '4K Ultra HD'
	String get p4k => '4K Ultra HD';

	/// en: '1080P 60FPS'
	String get p1080_60 => '1080P 60FPS';

	/// en: '1080P High Quality'
	String get p1080_high => '1080P High Quality';

	/// en: '1080P Full HD'
	String get p1080 => '1080P Full HD';

	/// en: '720P 60FPS'
	String get p720_60 => '720P 60FPS';

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

	/// en: 'Unknown'
	String get unknown => 'Unknown';

	/// en: 'Auto'
	String get auto => 'Auto';
}

// Path: video.player
class TranslationsVideoPlayerEn {
	TranslationsVideoPlayerEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Playback Speed'
	String get speed => 'Playback Speed';

	/// en: 'Resolution'
	String get quality => 'Resolution';

	/// en: 'Danmaku'
	String get danmaku => 'Danmaku';

	/// en: 'Full Screen'
	String get full_screen => 'Full Screen';

	/// en: 'Retry'
	String get retry => 'Retry';

	/// en: 'Brightness'
	String get brightness => 'Brightness';

	/// en: 'Volume'
	String get volume => 'Volume';

	/// en: 'Playback Settings'
	String get panel_title => 'Playback Settings';

	/// en: 'Focus on the controls you adjust most during playback'
	String get panel_subtitle => 'Focus on the controls you adjust most during playback';

	/// en: 'Danmaku Settings'
	String get danmaku_settings => 'Danmaku Settings';

	/// en: 'Tune visibility, area, speed and comment types'
	String get danmaku_section_hint => 'Tune visibility, area, speed and comment types';

	/// en: 'Opacity'
	String get danmaku_opacity => 'Opacity';

	/// en: 'Scale'
	String get danmaku_scale => 'Scale';

	/// en: 'Display Area'
	String get danmaku_area => 'Display Area';

	/// en: 'Speed'
	String get danmaku_speed => 'Speed';

	/// en: 'Scroll'
	String get danmaku_type_scroll => 'Scroll';

	/// en: 'Top'
	String get danmaku_type_top => 'Top';

	/// en: 'Bottom'
	String get danmaku_type_bottom => 'Bottom';

	/// en: 'Colorful'
	String get danmaku_type_color => 'Colorful';

	/// en: '$speedx speed playing'
	String speed_playing({required Object speedx}) => '${speedx} speed playing';

	/// en: 'Default speed'
	String get speed_default => 'Default speed';

	/// en: 'Switch instantly from slow playback to high speed'
	String get speed_section_hint => 'Switch instantly from slow playback to high speed';

	/// en: 'Select Quality'
	String get choose_quality => 'Select Quality';

	/// en: 'Playback Speed'
	String get choose_speed => 'Playback Speed';

	/// en: 'Only show resolutions this video can actually play'
	String get quality_section_hint => 'Only show resolutions this video can actually play';

	/// en: 'No switchable video qualities are available right now'
	String get quality_unavailable => 'No switchable video qualities are available right now';

	/// en: 'Danmaku Disabled'
	String get danmaku_closed => 'Danmaku Disabled';
}

// Path: video.actions
class TranslationsVideoActionsEn {
	TranslationsVideoActionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Coin'
	String get coin => 'Coin';

	/// en: 'Favorite'
	String get favorite => 'Favorite';
}

// Path: video.listen_settings
class TranslationsVideoListenSettingsEn {
	TranslationsVideoListenSettingsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Listen Settings'
	String get title => 'Listen Settings';

	/// en: 'Sleep Timer'
	String get sleep_timer => 'Sleep Timer';

	/// en: 'Off'
	String get timer_off => 'Off';

	/// en: '$time remaining'
	String remaining({required Object time}) => '${time} remaining';

	/// en: '$minutes min'
	String preset_minutes({required Object minutes}) => '${minutes} min';

	/// en: 'Custom minutes ($min-$max)'
	String custom_hint({required Object min, required Object max}) => 'Custom minutes (${min}-${max})';

	/// en: 'Enter a value between $min and $max minutes'
	String custom_invalid_range({required Object min, required Object max}) => 'Enter a value between ${min} and ${max} minutes';

	/// en: 'min'
	String get minutes_unit => 'min';

	/// en: 'Set'
	String get set_custom => 'Set';

	/// en: 'Disable timer'
	String get disable => 'Disable timer';
}

// Path: subscription.tabs
class TranslationsSubscriptionTabsEn {
	TranslationsSubscriptionTabsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Videos'
	String get video => 'Videos';

	/// en: 'Anime'
	String get anime => 'Anime';

	/// en: 'Cinema'
	String get cinema => 'Cinema';
}

// Path: notification.types
class TranslationsNotificationTypesEn {
	TranslationsNotificationTypesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Likes'
	String get like => 'Likes';

	/// en: '@Me'
	String get at => '@Me';

	/// en: 'Replies'
	String get reply => 'Replies';

	/// en: 'System'
	String get system => 'System';
}

// Path: notification.chat
class TranslationsNotificationChatEn {
	TranslationsNotificationChatEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Message unsent'
	String get message_withdrawn => 'Message unsent';

	/// en: '[Unsupported message: $type]'
	String unsupported_type({required Object type}) => '[Unsupported message: ${type}]';

	/// en: 'No messages'
	String get no_message => 'No messages';

	/// en: 'Type a message...'
	String get input_hint => 'Type a message...';

	/// en: 'Profile page not developed yet'
	String get page_not_developed => 'Profile page not developed yet';

	/// en: 'Failed to send: $error'
	String send_failed({required Object error}) => 'Failed to send: ${error}';

	/// en: 'Text message'
	String get summary_text => 'Text message';

	/// en: 'Image'
	String get summary_image => 'Image';

	/// en: 'System notice'
	String get summary_notice => 'System notice';

	/// en: 'Video'
	String get summary_video => 'Video';

	/// en: 'Article'
	String get summary_article => 'Article';

	/// en: 'Card'
	String get summary_card => 'Card';

	/// en: 'Shared content'
	String get summary_share => 'Shared content';

	/// en: 'Unknown message'
	String get summary_unknown => 'Unknown message';
}

// Path: live.header
class TranslationsLiveHeaderEn {
	TranslationsLiveHeaderEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '$count viewers'
	String online({required Object count}) => '${count} viewers';

	/// en: 'Fleet: $count'
	String guard({required Object count}) => 'Fleet: ${count}';
}

// Path: live.tags
class TranslationsLiveTagsEn {
	TranslationsLiveTagsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Top'
	String get hot => 'Top';

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

	/// en: 'Notice: '
	String get system_notice_colon => 'Notice: ';

	/// en: 'Admin'
	String get admin => 'Admin';

	/// en: 'Say something...'
	String get input_hint => 'Say something...';

	/// en: 'Send a danmaku...'
	String get support_hint => 'Send a danmaku...';

	/// en: 'Welcome! Tap follow to support the host.'
	String get welcome => 'Welcome! Tap follow to support the host.';

	/// en: 'entered the room'
	String get enter_room => 'entered the room';

	/// en: 'followed the host'
	String get followed => 'followed the host';

	/// en: 'shared the room'
	String get shared => 'shared the room';

	/// en: 'fed $giftName x$num'
	String gift_feed({required Object giftName, required Object num}) => 'fed ${giftName} x${num}';
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
			'nav.profile' => 'Profile',
			'home.tabs.live' => 'Live',
			'home.tabs.recommend' => 'For You',
			'home.tabs.hot' => 'Trending',
			'home.tabs.anime' => 'Anime',
			'home.tabs.cinema' => 'Movies & TV',
			'home.tabs.new_journey' => 'New Journey',
			'home.tabs.weekly_must_watch' => 'Weekly Must-Watch',
			'home.search_hint' => 'Search...',
			'home.video_more.watch_later' => 'Watch Later',
			'home.video_more.download_cover' => 'Download Cover',
			'home.video_more.invalid_video_id' => 'Unable to resolve video ID',
			'home.video_more.added_to_watch_later' => 'Added to Watch Later',
			'home.video_more.add_failed' => ({required Object error}) => 'Failed to add: ${error}',
			'home.video_more.download_failed' => ({required Object error}) => 'Download failed: ${error}',
			'moments.title' => 'Moments',
			'moments.tabs.all' => 'All',
			'moments.tabs.video' => 'Videos',
			'moments.tabs.pgc' => 'Anime/Media',
			'moments.like_coming_soon' => 'Like feature coming soon',
			'moments.empty' => ({required Object tab}) => 'No content available in ${tab}',
			'moments.recently_followed' => 'Recently Followed',
			'moments.topic_search_hint' => 'Search topics',
			'moments.topic_search_empty' => 'Type keywords to search topics',
			'moments.topic_search_no_result' => 'No topics found',
			'moments.topic_updates' => ({required Object count}) => 'Updated ${count} posts',
			'moments.no_comments' => 'No comments yet. Be the first to comment.',
			'moments.comment_hint' => 'Leave a friendly comment...',
			'moments.publish' => 'Post',
			'moments.publish_title' => 'Create Post',
			'moments.publish_action' => 'Post',
			'moments.publish_hint' => 'Share what is new...',
			'moments.publish_success' => 'Posted successfully',
			'moments.publish_failed' => ({required Object error}) => 'Post failed: ${error}',
			'moments.discard_title' => 'Tip',
			'moments.discard_confirm' => 'Discard your draft?',
			'moments.discard_action' => 'Discard',
			'moments.forward_post' => 'Forward post',
			'moments.reserve' => 'Reserve',
			'moments.reserved' => 'Reserved',
			'moments.vote' => 'Vote',
			'moments.vote_stats' => ({required Object participants, required Object options}) => '${participants} participants · ${options} options',
			'moments.copy_link' => 'Copy link',
			'moments.open_in_browser' => 'Open in browser',
			'moments.copied_link' => 'Dynamic link copied',
			'moments.open_link_failed' => 'Unable to open link',
			'moments.operation_failed' => ({required Object message}) => 'Operation failed: ${message}',
			'moments.detail_title' => 'Moment Details',
			'ranking.title' => 'Ranking',
			'ranking.categories.all' => 'All',
			'ranking.categories.animation' => 'Animation',
			'ranking.categories.bangumi' => 'Bangumi',
			'ranking.categories.guochuang' => 'Chinese Original',
			'ranking.categories.music' => 'Music',
			'ranking.categories.dance' => 'Dance',
			'ranking.categories.game' => 'Games',
			'ranking.categories.knowledge' => 'Knowledge',
			'ranking.categories.technology' => 'Technology',
			'ranking.categories.sports' => 'Sports',
			'ranking.categories.car' => 'Auto',
			'ranking.categories.life' => 'Lifestyle',
			'ranking.categories.food' => 'Food',
			'ranking.categories.animal' => 'Animals',
			'ranking.categories.kichiku' => 'Kichiku',
			'ranking.categories.fashion' => 'Fashion',
			'ranking.categories.information' => 'News',
			'ranking.categories.entertainment' => 'Entertainment',
			'ranking.categories.film' => 'Film & TV',
			'ranking.categories.documentary' => 'Documentaries',
			'ranking.categories.movie' => 'Movies',
			'ranking.categories.tv' => 'TV Series',
			'ranking.categories.tech_digital' => 'Tech & Digital',
			'ranking.categories.short_play' => 'Short Plays',
			'ranking.categories.fashion_beauty' => 'Fashion & Beauty',
			'ranking.categories.sports_fitness' => 'Sports & Fitness',
			'ranking.categories.vlog' => 'Vlog',
			'ranking.categories.painting' => 'Drawing',
			'ranking.categories.ai' => 'AI',
			'ranking.categories.home' => 'Home & Living',
			'ranking.categories.outdoor' => 'Outdoor',
			'ranking.categories.fitness' => 'Fitness',
			'ranking.categories.craft' => 'Craft',
			'ranking.categories.travel' => 'Travel',
			'ranking.categories.three_rural' => 'Rural Life',
			'ranking.categories.parenting' => 'Parenting',
			'ranking.categories.health' => 'Health',
			'ranking.categories.emotion' => 'Relationships',
			'ranking.categories.life_interest' => 'Lifestyle Interests',
			'ranking.categories.life_experience' => 'Life Experiences',
			'settings.title' => 'Settings',
			'settings.sections.general' => 'General',
			'settings.sections.appearance' => 'Appearance',
			'settings.sections.storage' => 'Storage',
			'settings.sections.about' => 'About',
			'settings.language' => 'Language',
			'settings.appearance' => 'Appearance',
			'settings.chinese' => '简体中文',
			'settings.traditional_chinese' => '繁體中文',
			'settings.english' => 'English',
			'settings.theme_mode.system' => 'System Default',
			'settings.theme_mode.dark' => 'Dark Mode',
			'settings.theme_mode.light' => 'Light Mode',
			'settings.clear_cache' => 'Clear Cache',
			'settings.user_agreement' => 'User Agreement',
			'settings.privacy_policy' => 'Privacy Policy',
			'settings.version' => 'Version',
			'auth.login' => 'Login',
			'auth.logout' => 'Logout',
			'auth.methods.account' => 'Account',
			'auth.methods.sms' => 'SMS',
			'auth.methods.qr' => 'QR Code',
			'auth.username' => 'Account',
			'auth.username_hint' => 'Phone or Email',
			'auth.password' => 'Password',
			'auth.phone' => 'Phone Number',
			'auth.sms_code' => 'Verification Code',
			'auth.get_code' => 'Get Code',
			'auth.get_code_retry' => ({required Object seconds}) => 'Resend in ${seconds} s',
			'auth.qr_hint' => 'Scan with culcul app',
			'auth.qr_refresh' => 'Refresh QR Code',
			'auth.qr_status.loading' => 'Loading...',
			'auth.qr_status.success' => 'Login Successful',
			'auth.qr_status.scanned' => 'Scanned. Confirm on your phone.',
			'auth.qr_status.expired' => 'QR Code Expired',
			'auth.qr_status.error' => 'Failed to load QR Code',
			'auth.sms_sent' => 'Code sent',
			'auth.subtitle' => 'A lightweight third-party client',
			'auth.select_country' => 'Select Country/Region',
			'auth.search_country_hint' => 'Search country or region',
			'auth.no_search_result' => 'No results found',
			'auth.welcome_back' => 'Welcome back',
			'auth.please_enter_username_password' => 'Please enter username and password',
			'auth.ok' => 'OK',
			'profile.login' => 'Login',
			'profile.not_logged_in' => 'Not logged in',
			'profile.login_hint' => 'Sign in to explore more',
			'profile.stats.posts' => 'Posts',
			'profile.stats.following' => 'Following',
			'profile.stats.followers' => 'Followers',
			'profile.stats.likes' => 'Likes',
			'profile.actions.message' => 'Message',
			'profile.actions.edit_profile' => 'Edit Profile',
			'profile.vip.premium' => 'Premium',
			'profile.vip.annual_premium' => 'Annual Premium',
			'profile.menu.history' => 'History',
			'profile.menu.download' => 'Downloads',
			'profile.menu.favorites' => 'Favorites',
			'profile.menu.watch_later' => 'Watch Later',
			'profile.menu.appearance' => 'Appearance',
			'profile.menu.creative_center' => 'Creator Center',
			'profile.menu.orders' => 'Orders',
			'profile.menu.support' => 'Support',
			'profile.menu.blacklist' => 'Add to blacklist',
			'profile.menu.report' => 'Report',
			'profile.tabs.home' => 'Home',
			'profile.tabs.moments' => 'Moments',
			'profile.tabs.contribution' => 'Contributions',
			'profile.home_tab.recent_videos' => ({required Object count}) => 'Videos ${count}',
			'profile.home_tab.view_more' => 'View More',
			'profile.home_tab.empty' => 'No content',
			'profile.home_tab.sticky' => 'Sticky Video',
			'profile.home_tab.sticky_tag' => 'Sticky',
			'profile.home_tab.masterpiece' => 'Masterpiece',
			'profile.followings.title' => 'Following',
			'profile.followings.empty' => 'No following yet',
			'profile.followers.title' => 'Followers',
			'profile.followers.empty' => 'No followers yet',
			'profile.relation.none' => 'Follow',
			'profile.relation.followed' => 'Following',
			'profile.relation.mutual' => 'Mutual',
			'profile.relation.blacklisted' => 'Blacklisted',
			'profile.relation.failed' => ({required Object error}) => 'Failed: ${error}',
			'profile.privacy_title' => 'Privacy enabled',
			'profile.privacy_message' => 'This user hides their following and followers lists',
			'profile.verified_badge' => 'Verified by bilibili',
			'profile.logout_confirm' => 'Are you sure you want to log out?',
			'profile.space_search_coming_soon' => 'Search in Space: coming soon',
			'favorites.title' => 'Favorites',
			'favorites.created' => 'Created',
			'favorites.collected' => 'Saved',
			'favorites.private' => 'Private',
			'favorites.public' => 'Public',
			'favorites.play' => 'Play',
			'favorites.count' => ({required Object count}) => '${count} items',
			'favorites.search_hint' => 'Search favorites',
			'favorites.folder_item_count' => ({required Object count}) => '${count} items',
			'favorites.new_folder' => 'New Folder',
			'favorites.edit_folder' => 'Edit Folder',
			'favorites.delete_folder' => 'Delete Folder',
			'favorites.delete_folder_confirm' => 'Are you sure you want to delete this folder?',
			'favorites.delete_with_count' => ({required Object count}) => 'Delete (${count})',
			'favorites.edit_info' => 'Edit Info',
			'favorites.manage_resources' => 'Manage Resources',
			'favorites.only_visible_to_me' => 'Only visible to me',
			'favorites.folder_title' => 'Title',
			'favorites.folder_intro' => 'Intro',
			'search.placeholder' => 'Trending: culcul',
			'search.button' => 'Search',
			'search.history' => 'History',
			'search.hot_search' => 'Trending',
			'search.clear_history' => 'Clear History',
			'search.suggestion' => 'Suggestions',
			'search.no_result' => 'No results found',
			'search.trending' => 'Trending Now',
			'search.tabs.all' => 'All',
			'search.tabs.video' => 'Videos',
			'search.tabs.anime' => 'Anime',
			'search.tabs.user' => 'Users',
			'search.tabs.article' => 'Articles',
			'search.status.loading' => 'Loading suggestions...',
			'search.status.empty' => 'No suggestions found',
			'search.status.failed' => 'Failed to load suggestions',
			'search.filter.sort_default' => 'Default',
			'search.filter.sort_newest' => 'Newest',
			'search.filter.sort_click' => 'Most Views',
			'search.filter.sort_danmaku' => 'Most Danmaku',
			'search.filter.sort_favorite' => 'Most Favorites',
			'search.filter.duration_all' => 'All Durations',
			'search.filter.duration_short' => '<10m',
			'search.filter.duration_medium' => '10-30m',
			'search.filter.duration_long' => '30-60m',
			'search.filter.duration_extra_long' => '>60m',
			'video.tabs.info' => 'About',
			'video.tabs.comment' => 'Comments',
			'video.recommend' => 'Up Next',
			'video.comment.empty' => 'No comments yet. Be the first to comment!',
			'video.comment.count' => ({required Object count}) => '${count} comments',
			'video.comment.sort_hot' => 'Top',
			'video.comment.sort_time' => 'Newest',
			'video.comment.all' => 'All Comments',
			'video.comment.detail' => 'Comment Details',
			'video.comment.related_replies' => 'Related Replies',
			'video.comment.replies' => ({required Object count}) => 'View all ${count} replies',
			'video.comment.hint' => 'Leave a friendly comment...',
			'video.load_failed' => 'Failed to load video',
			'video.tags' => 'Tags',
			'video.no_desc' => 'No description',
			'video.expand_all' => 'Expand All',
			'video.quality.p8k' => '8K Ultra HD',
			'video.quality.p_dolby' => 'Dolby Vision',
			'video.quality.p_hdr' => 'HDR',
			'video.quality.p4k' => '4K Ultra HD',
			'video.quality.p1080_60' => '1080P 60FPS',
			'video.quality.p1080_high' => '1080P High Quality',
			'video.quality.p1080' => '1080P Full HD',
			'video.quality.p720_60' => '720P 60FPS',
			'video.quality.p720' => '720P HD',
			'video.quality.p480' => '480P SD',
			'video.quality.p360' => '360P',
			'video.quality.p240' => '240P',
			'video.quality.p144' => '144P',
			'video.quality.unknown' => 'Unknown',
			'video.quality.auto' => 'Auto',
			'video.player.speed' => 'Playback Speed',
			'video.player.quality' => 'Resolution',
			'video.player.danmaku' => 'Danmaku',
			'video.player.full_screen' => 'Full Screen',
			'video.player.retry' => 'Retry',
			'video.player.brightness' => 'Brightness',
			'video.player.volume' => 'Volume',
			'video.player.panel_title' => 'Playback Settings',
			'video.player.panel_subtitle' => 'Focus on the controls you adjust most during playback',
			'video.player.danmaku_settings' => 'Danmaku Settings',
			'video.player.danmaku_section_hint' => 'Tune visibility, area, speed and comment types',
			'video.player.danmaku_opacity' => 'Opacity',
			'video.player.danmaku_scale' => 'Scale',
			'video.player.danmaku_area' => 'Display Area',
			'video.player.danmaku_speed' => 'Speed',
			'video.player.danmaku_type_scroll' => 'Scroll',
			'video.player.danmaku_type_top' => 'Top',
			'video.player.danmaku_type_bottom' => 'Bottom',
			'video.player.danmaku_type_color' => 'Colorful',
			'video.player.speed_playing' => ({required Object speedx}) => '${speedx} speed playing',
			'video.player.speed_default' => 'Default speed',
			'video.player.speed_section_hint' => 'Switch instantly from slow playback to high speed',
			'video.player.choose_quality' => 'Select Quality',
			'video.player.choose_speed' => 'Playback Speed',
			'video.player.quality_section_hint' => 'Only show resolutions this video can actually play',
			'video.player.quality_unavailable' => 'No switchable video qualities are available right now',
			'video.player.danmaku_closed' => 'Danmaku Disabled',
			'video.actions.coin' => 'Coin',
			'video.actions.favorite' => 'Favorite',
			'video.reply_to' => ({required Object name}) => 'Reply to @${name}: ',
			'video.parts' => 'Segments',
			'video.expand' => 'Expand',
			'video.collapse' => 'Collapse',
			'video.listen' => 'Listen Only',
			'video.listen_settings.title' => 'Listen Settings',
			'video.listen_settings.sleep_timer' => 'Sleep Timer',
			'video.listen_settings.timer_off' => 'Off',
			'video.listen_settings.remaining' => ({required Object time}) => '${time} remaining',
			'video.listen_settings.preset_minutes' => ({required Object minutes}) => '${minutes} min',
			'video.listen_settings.custom_hint' => ({required Object min, required Object max}) => 'Custom minutes (${min}-${max})',
			'video.listen_settings.custom_invalid_range' => ({required Object min, required Object max}) => 'Enter a value between ${min} and ${max} minutes',
			'video.listen_settings.minutes_unit' => 'min',
			'video.listen_settings.set_custom' => 'Set',
			'video.listen_settings.disable' => 'Disable timer',
			'video.watching_count' => ({required Object count}) => '${count} watching',
			'video.detail_page' => 'Detail Page',
			'actions.like' => 'Like',
			'actions.unlike' => 'Dislike',
			'actions.follow' => 'Follow',
			'actions.followed' => 'Following',
			'actions.share' => 'Share',
			'actions.reply' => 'Reply',
			'actions.comment' => 'Comment',
			'actions.forward' => 'Forward',
			'common.no_content' => 'No content',
			'common.coming_soon' => ({required Object tab}) => 'Coming soon: ${tab}',
			'common.loading' => 'Loading...',
			'common.error' => 'Something went wrong',
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
			'common.refresh_completed' => 'Refresh successful',
			'common.refresh_failed' => 'Refresh failed',
			'common.pull_up_to_load_more' => 'Pull up to load more',
			'common.release_to_load_more' => 'Release to load more',
			'common.load_failed' => 'Failed to load',
			'common.load_completed' => 'Loaded',
			'common.no_more_content' => 'You\'ve reached the end.',
			'common.up' => 'UP',
			'common.save_image' => 'Save Image',
			'common.saving' => 'Saving...',
			'common.save_success' => 'Saved to gallery',
			'common.save_failed' => ({required Object message}) => 'Failed to save: ${message}',
			'common.slide_to_switch' => 'Swipe to switch',
			'common.no_data' => 'No data',
			'error.connection_timeout' => 'Connection Timed Out',
			'error.send_timeout' => 'Request Timed Out',
			'error.receive_timeout' => 'Response Timed Out',
			'error.bad_response' => ({required Object code}) => 'Server Error (${code})',
			'error.cancel' => 'Request Canceled',
			'error.network' => 'Network Error',
			'error.auth_failed' => 'Authentication failed',
			'error.server_error' => 'Server error',
			'error.details' => 'Error Details',
			'error.view_details' => 'View Details',
			'error.stack_trace' => 'Stack Trace',
			'format.hundred_million' => '100M',
			'format.ten_thousand' => '10K',
			'format.hours_ago' => ({required Object hours}) => '${hours} h ago',
			'format.minutes_ago' => ({required Object minutes}) => '${minutes} m ago',
			'format.just_now' => 'Just now',
			'watch_later.title' => 'Watch Later',
			'watch_later.clear_all' => 'Clear All',
			'watch_later.clear_all_confirm' => 'Are you sure you want to clear your Watch Later list?',
			'watch_later.watch_to' => ({required Object progress}) => 'Watch to ${progress}',
			'watch_later.add_success' => 'Added to Watch Later',
			'subscription.title' => 'Subscriptions',
			'subscription.tabs.video' => 'Videos',
			'subscription.tabs.anime' => 'Anime',
			'subscription.tabs.cinema' => 'Cinema',
			'subscription.empty' => ({required Object tab}) => 'No content in ${tab}',
			'notification.title' => 'Notifications',
			'notification.types.like' => 'Likes',
			'notification.types.at' => '@Me',
			'notification.types.reply' => 'Replies',
			'notification.types.system' => 'System',
			'notification.related_content' => 'Related Content',
			'notification.navigation_error' => ({required Object type, required Object id}) => 'Unable to open content: ${type} ${id}',
			'notification.chat.message_withdrawn' => 'Message unsent',
			'notification.chat.unsupported_type' => ({required Object type}) => '[Unsupported message: ${type}]',
			'notification.chat.no_message' => 'No messages',
			'notification.chat.input_hint' => 'Type a message...',
			'notification.chat.page_not_developed' => 'Profile page not developed yet',
			'notification.chat.send_failed' => ({required Object error}) => 'Failed to send: ${error}',
			'notification.chat.summary_text' => 'Text message',
			'notification.chat.summary_image' => 'Image',
			'notification.chat.summary_notice' => 'System notice',
			'notification.chat.summary_video' => 'Video',
			'notification.chat.summary_article' => 'Article',
			'notification.chat.summary_card' => 'Card',
			'notification.chat.summary_share' => 'Shared content',
			'notification.chat.summary_unknown' => 'Unknown message',
			'notification.empty' => 'No notifications',
			'live.header.online' => ({required Object count}) => '${count} viewers',
			'live.header.guard' => ({required Object count}) => 'Fleet: ${count}',
			'live.tags.hot' => 'Top',
			'live.tags.popularity' => 'Popular',
			'live.tags.more_play' => 'More',
			'live.danmaku.system_notice' => 'System Notice',
			'live.danmaku.system_notice_colon' => 'Notice: ',
			'live.danmaku.admin' => 'Admin',
			'live.danmaku.input_hint' => 'Say something...',
			'live.danmaku.support_hint' => 'Send a danmaku...',
			'live.danmaku.welcome' => 'Welcome! Tap follow to support the host.',
			'live.danmaku.enter_room' => 'entered the room',
			'live.danmaku.followed' => 'followed the host',
			'live.danmaku.shared' => 'shared the room',
			'live.danmaku.gift_feed' => ({required Object giftName, required Object num}) => 'fed ${giftName} x${num}',
			'history.empty' => 'No history found',
			_ => null,
		};
	}
}
