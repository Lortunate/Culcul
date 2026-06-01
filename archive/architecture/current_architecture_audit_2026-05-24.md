# Current Architecture Audit - 2026-05-24

This archive tracks decisions retired by the architecture refactor. Active code should
not keep old and new implementations side by side.

## Archived Decisions

- Route entry files are retired. Typed app router files own route construction, while
  feature `navigation.dart` files may keep behaviorful navigation composition only.
- Unused app-router transition wrappers are retired. Active route construction still uses
  the route transitions it instantiates, but `SlideFromLeftTransitionPage` is archived
  because no typed route constructs it. `FadeTransitionPage` is archived too; the only
  login route now owns its fade/scale transition directly in `LoginRoute.buildPage`.
- `presentation/view_models` is retired as a reusable state location. Feature state lives
  in `lib/features/<feature>/state`; widget hooks stay page-local.
- One-line `*_port.dart` and `*_application_providers.dart` aliases are retired when they
  only forward to concrete repositories or services.
- One-consumer core provider wrappers are retired when the owning boundary can construct
  the policy directly. `NetworkQualityInterceptor` owns endpoint policy resolution, so
  `endpoint_policy_provider.dart` and `endpointPolicyResolverProvider` stay archived.
- Resource API provider wrappers are retired when they only construct `ResourceApi` with
  configured Dio clients. `ResourceApi` owns `basicResourceApiProvider` and
  `resourceApiProvider`, so `resource_api_provider.dart` and generated output stay
  archived.
- One-consumer core helper classes are retired when their only caller owns the policy and
  state. `WbiHelper` owns WBI key refresh plus request signing, so `wbi_signer.dart` and
  `WbiSigner` stay archived.
- DTO/entity mirror pairs are retired when they only copy fields. The canonical app model
  owns JSON decoding when it is the only current business shape, and API response shells
  keep only transport structure that has active behavior.
- Generated build output and machine-local platform artifacts are retired from versioned
  source. They may exist locally, but should stay ignored and untracked.

## 2026-05-26 Updates

- History list item mirrors are archived. `HistoryEntry.fromJson` now owns item decoding,
  `HistoryRepositoryImpl.getHistory` parses the response `list` envelope directly, and
  `HistoryResponseDataDto`, `HistoryItemDto`, `HistoryDetailDto`, `_HistoryItemMapper`,
  plus the one-use `_parseHistoryEntries` helper are removed from active code.
- History entry Freezed shell is archived. `HistoryEntry` remains as a hand-written
  immutable value in `history_entry.dart`, preserving JSON normalization and equality
  behavior without `history_entry.freezed.dart`. Its unused `copyWith` helper is archived
  too. Its numeric JSON fields now use
  `JsonUtils.parseIntWithDefault` directly instead of a private `_readInt` clone, and
  its string-only fallback checks are inline instead of delegated through a private
  `_readString` helper. Nested `history` map decoding is inline too, so `_readHistory`
  does not remain as a one-use helper.
- History page list provider wrapper is archived. `HistoryPage` owns the page-local
  `FutureProvider.autoDispose` for the list data, refresh, and retry behavior, so
  `history_controller.dart` and its generated file do not remain as a shared state shell.
- Home tab sync's two-field state/provider shell is archived. `use_home_scroll_sync.dart`
  owns the private sync-token/tab-index event provider, and `HomePage` emits tab taps
  through `notifyHomeTabTapped`, preserving the `indexIsChanging` guard and
  current-tab retap scroll-to-top/refresh behavior without `home_tab_sync_controller.dart`,
  `HomeTabSyncState`, `HomeTabSyncController`, or `homeTabSyncControllerProvider`.
- Profile cache repository and the unused Drift cache database are archived. No active
  profile flow reads or writes cached profile users, so logout cleanup uses the core
  default no-op `SessionLogoutCleaner` instead of a feature-specific empty adapter.
- Profile video prefetch tuning facade is archived. Recent-video grid cover ratio and
  user-video list prefetch size/limit constants now live beside their only widget owners.
- Dynamic emote DTO mirrors are archived. `EmoteCatalogPackage` and `EmoteCatalogItem`
  now parse the user emote catalog JSON directly, and the repository only extracts the
  transport `packages` list before returning the canonical catalog models. The catalog's
  private `_readStringKeyedMap` helper is also archived; map coercion now uses
  `JsonUtils.asStringKeyedMap` directly. Its private `_readRequiredInt` helper is
  archived as well; emote ids now parse through `JsonUtils.parseInt` at the canonical
  model boundary. The private `_readRequiredString` helper is archived too; required
  `text`/`url` fields keep strict inline string checks instead of widening to generic
  string coercion.
- Architecture guard coverage now includes previously archived DTO/mapper families that
  were documented but under-guarded: favorites resource stats, notification emoji/reply
  actor, live gold-rank/danmu/guard, video subtitle/play-url, profile cache repository
  file recreation, and class-modified emote/home-tab-sync wrapper declarations.
- Home popular/recommend feed load handling is centralized in `HomeFeedPagingMixin`.
  Feed-specific state controllers no longer duplicate `Result` unfolding,
  silent-refresh result logging, or load-error empty-list fallback.
- Home popular/recommend feed provider shells are archived. `PopularView` and
  `RecommendView` own their private feed notifiers because no second active consumer
  imports them, while `HomeFeedPagingMixin` remains the shared owner of paging result
  handling.
- To-view list response shell is archived. `ToViewRepositoryImpl.getList` parses the
  transport `list` envelope directly into `ToViewEntry` and preserves the API `No Data`
  empty-list fallback without a DTO wrapper. The one-use `_parseToViewEntries` helper is
  archived as well.
- To-view entry Freezed shell is archived. `ToViewEntry` remains as a hand-written
  immutable value in `to_view_entry.dart`, preserving JSON normalization, progress
  getters, and equality behavior without `to_view_entry.freezed.dart`. Its numeric JSON
  fields now use `JsonUtils.parseIntWithDefault` directly instead of a private `_readInt`
  clone, and its string-only fallback checks are inline instead of delegated through a
  private `_readString` helper. Nested `owner` and `stat` decoding is inline too, so
  `_readOwner` and `_readStat` do not remain as one-use helpers. The unused `copyWith`
  helper is archived too.
- Live header number-format wrapper is archived. `LiveHeader` calls
  `FormatUtils.formatNumber` directly for online and gold-rank counts instead of keeping
  a private `_liveHeaderFormatNumber` pass-through delegate.
- Live header viewer-avatar helper is archived. `_buildViewerStack` owns the stacked
  20px avatar container inline, so `_buildViewerAvatar` does not remain as a one-call
  decorative method.
- Home tab descriptor helper is archived. `HomePage.build` owns the live/recommend/hot
  title and view factory records inline, so `_buildTabs` does not remain as a one-call
  page-local list wrapper.
- Scroll prefetch budget wrapper is archived. `useScrollPrecache` owns runtime policy
  resolution, adjusted prefetch count, and concurrency clamping inline, so
  `ScrollPrecacheBudget` and `resolveScrollPrecacheBudget` do not remain as hook-local
  pass-through plumbing.
- Live watched-count scalar helper is archived. `LiveWatchedShow.fromJson` uses
  `JsonUtils.parseInt` directly instead of keeping a private `_parseWatchedCount`
  wrapper in the live room summary contract.
- Live anchor-info parser helper is archived. `LiveRepositoryImpl.getAnchorInfo` keeps
  the `exp.master_level.level` parse inline and no longer routes through one-use
  `_parseAnchorMasterLevel`.
- Live recommend list-parser helper is archived. `LiveRepositoryImpl.getRecommendList`
  keeps the strict `recommend_room_list` unwrap and `LiveRoomSummary.fromJson` mapping
  inline instead of routing through one-use `_parseRecommendRooms`.
- Video listen page app-bar helper is archived. `VideoListenPage.build` owns the
  transparent listen-mode app bar, close action, title styling, and settings-sheet action
  inline, so `_buildAppBar` does not remain as a one-call page helper.
- Profile optional integer helper is archived. `ProfileRepositoryImpl` keeps the
  optional response data-map gate, but relation followers/following, likes, and video
  count now call `JsonUtils.parseIntWithDefault` directly instead of a private
  `_readOptionalInt` clone. The one-use `_parseLikes` and `_parseVideoCount` wrappers
  are archived as well; `getProfile` parses those counters inline after the shared
  optional response gate. The one-use `_parseRelationStats` wrapper is archived too;
  `getProfile` keeps relation follower/following parsing beside the other optional
  enrichment scalars.
- Profile user-space list-parser helper is archived. `ProfileRepositoryImpl.getSpaceVideos`
  keeps the `list.vlist` unwrap and `ProfileVideo.fromJson` mapping inline instead of
  routing through one-use `_parseUserSpaceVideos`.
- Profile video pub-date helper is archived. `ProfileVideo.fromJson` owns the
  `pubDate`/`pubdate` fallback inline instead of routing through the one-use
  `_readPubDate` scalar helper.
- Profile VIP scalar helpers are archived. `ProfileRepositoryImpl.getProfile` reads the
  optional `vip` map once and parses `type`/`status` with
  `JsonUtils.parseIntWithDefault`, so `_parseVipType` and `_parseVipStatus` no longer
  exist as one-use wrappers.
- Notification reply detail copy mapper is archived. `ReplyItemMapper` owns the only
  DTO-to-domain conversion into `NotificationEntryDetail`; `ReplyItemDetail` remains only
  as the reply wire/cache DTO. The private `_readSubjectId` helper is also archived;
  `ReplyItemDetail.fromJson` keeps the `subject_id`/`item_id` fallback inline.
- Search default/hot-ranking response shells are archived. `SearchRepositoryImpl` now
  parses the default-search `show_name` field and the hot-ranking `list` envelope
  directly from the API data maps, while `SearchTrendingItem` remains the single
  hand-written hot-ranking item shape. The private `_parseDefaultSearchName` helper is
  archived too; `getDefaultSearch` keeps the `show_name as String?` read inline.
  `_parseTrendingRankingItems` is archived as well; `getTrendingRanking` owns the only
  hot-ranking `list` envelope parse inline. `SearchTrendingItem.copyWith` and `toJson`
  are archived too because current flows only decode and render hot-ranking items.
- Search suggestion response/tag DTOs are archived. The repository now owns the only
  JSONP `result.tag` parsing path and returns app-facing suggestion strings without a
  Freezed response shell or tag model. The private `_parseSuggestionText` helper is
  archived too, along with the one-use `_parseSuggestionsResponse` wrapper;
  `SearchRepositoryImpl.getSuggestions` keeps the JSONP unwrap and `value`/`term`
  fallback inline.
- Search result outer response shell is archived. Search result API methods expose raw
  response data at the repository boundary instead of keeping an intermediate response
  wrapper.
- Search result DTO/domain mirror is archived. Search result API methods now expose raw
  response data and `SearchRepositoryImpl` parses pagination plus polymorphic result
  items directly into `SearchResultPage`/`SearchResultEntry`, preserving unknown-type
  drop logging without `SearchResultData`, `SearchResultItem`, `_SearchResultConverter`,
  or copy-only search mapper extensions.
- Search result page Freezed shell is archived. `SearchResultPage` remains as a
  hand-written immutable pagination value in `search_result.dart`, preserving list
  immutability without `search_result.freezed.dart` or a one-use pagination
  `copyWith`.
- Search query Freezed shell is archived. `SearchQuery` remains as a hand-written
  immutable keyword/type/order/duration/page value in `search_query.dart`, preserving
  default query semantics without `search_query.freezed.dart` or a one-use pagination
  `copyWith`.
- Search history provider shells are archived. `SearchPage` owns the private
  `NotifierProvider` that reads and writes `StorageKeys.searchHistory`, while
  `search_workflows.dart` remains the shared normalization/deduplication helper owner.
- Search result paging provider shells are archived. `SearchResultView` owns the private
  family `AsyncNotifierProvider` for result-page loading, cancel-token lifecycle, and
  load-more page merging because no second active consumer imports that provider.
- `SmartPagingView` one-use refresh result helper is archived. The shared paging widget
  maps refresh success/failure to `IndicatorResult` inline at the EasyRefresh boundary,
  keeping only the reusable load-more gate helper separate.
- `AppAvatar` decorative fallback/shadow/border helper methods are archived. The shared
  avatar widget keeps those visuals inline in `build`, while the public constructor,
  URL loading, fallback icon, semantics, tap handling, border override, and sizing stay
  unchanged.
- Home recommend feed response shell is archived. `HomeRepositoryImpl` owns the only
  `data.item` unwrap plus the existing `goto == av` filter and malformed-item skip
  policy, so `FeedResponseDto` and `_FeedItemListConverter` no longer wrap app-facing
  `VideoModel` lists. The one-use `_parseRecommendVideos` repository helper is also
  archived; `fetchRecommendPage` keeps that boundary parse inline.
- Shared video-list response shell is archived. Home popular, home weekly, and ranking
  repositories now call `parseVideoModelListEnvelope` for the common `data.list` unwrap,
  so `VideoListResponseDto` no longer exists as a second owner of `VideoModel` lists.
- Home weekly API wrapper is archived. The weekly endpoint lives on `HomeApi` beside
  recommend/popular feed calls, and `HomeRepositoryImpl.fetchWeeklyList` shares the
  canonical `parseVideoModelListEnvelope` path, so `WeeklyApi`, `weekly_api.dart`, and
  generated output do not remain as a one-endpoint Retrofit wrapper.
- Home weekly page provider wrapper is archived. `WeeklyScreen` owns the private
  `FutureProvider.autoDispose` for the weekly list and retry behavior, so
  `weekly_view_model.dart`, `weeklyListProvider`, and generated output do not remain as
  one-page state shells.
- Related-video DTO mirror is archived. Related-video API decoding now returns canonical
  `VideoModel` directly, so `RelatedVideo`, `related_video_dto.dart`, and the copy-only
  `RelatedVideoViewDataMapper` no longer duplicate the video card shape.
- Video tag view-data wrapper is archived. Video detail view state and auxiliary load
  results now carry tag names as `List<String>`, so `VideoTagViewData` no longer wraps a
  single `tagName` field.
- Video dimension view-data wrapper is archived. Video detail and part state now reuse
  the decoded `VideoDimension` payload as the single owner of width, height, and rotate,
  so `VideoDimensionViewData` and its copy-only mapper are no longer active.
- Video detail single-use mapper extensions are archived. Detail/page-to-view-data and
  request-user-state conversion now live as private helpers next to the only workflow
  caller, so `VideoDetailViewDataMapper`, `VideoPartViewDataMapper`, and
  `VideoRequestUserStateMapper` do not expose public copy-only extension APIs.
- Video detail DTO Freezed/JSON shell is archived. `VideoDetail`, `ReqUser`,
  `VideoPage`, `VideoDimension`, `VideoTag`, and `TagCount` remain in
  `video_detail_dto.dart` as hand-written immutable DTOs, preserving Bilibili
  detail/page/tag wire keys, default values, list equality, nullable
  subtitle/request-user fields, and JSON parsing without `video_detail_dto.freezed.dart`
  or `video_detail_dto.g.dart`. Their unused DTO-level `copyWith` and `toJson` helpers
  are archived too; active optimistic mutations belong to `VideoDetailViewData` and
  `VideoRequestUserState`.
- Video detail DTO list equality helper is archived. `VideoDetail` now uses Flutter's
  canonical `listEquals` for `pages` and `tag`, so a file-local `_listEquals` clone no
  longer sits beside the canonical detail DTO.
- Video detail DTO deep equality helper is archived. `VideoDetail.copyright` now uses
  `collection`'s shared `DeepCollectionEquality` helper for deep equality and hashing,
  so the file-local `_deepEquals` / `_deepHash` clones no longer sit beside the canonical
  detail DTO.
- Home video actions bottom-sheet wrapper is archived. The only entrypoint is
  `showHomeVideoActionsBottomSheet`, so the bottom-sheet widget now lives privately with
  the home owner instead of a cross-feature video overlay file.
  The sheet's fixed drag handle is owned inline by `_HomeVideoActionsBottomSheet.build`;
  `_buildDragHandle` is archived as a one-use visual helper.
- Home video actions row wrapper is archived. `_HomeVideoActionsBottomSheet.build` now
  owns the watch-later and download-cover `InkWell` rows inline, so `_ActionItem` does
  not remain as a duplicated one-use row wrapper.
- Shared overlay tag wrapper is archived. Video recommendation and live-area labels own
  their overlay styling privately in their card files, so `AppOverlayTag` and
  `app_overlay_tag.dart` no longer expose a two-call visual wrapper.
- Comment image wrapper is archived. `CommentItemWidget` is the only owner of comment
  picture layout, decode sizing, hero tags, and preview opening, so `CommentImagesWidget`
  and `comment_images.dart` no longer expose a single-owner UI wrapper.
- Favorites folder-list response shell is archived. `FavRepositoryImpl` parses the
  transport `list` envelope directly into `List<FavoriteFolder>`; the unused transport
  `count` no longer keeps `FavFolderListResponse` or `FavoriteFolderPage` alive.
- Favorites resource-list response shell is archived. `FavRepositoryImpl` parses the
  transport `info`/`medias`/`has_more` envelope directly into `FavoriteResourcePage`;
  `FavResourceListResponse` and `_FavResourceListMapper` no longer own that shape. The
  one-use `_parseFavoriteResourcePage` helper is archived too; `getFolderResources`
  keeps the resource page validation and mapping inline.
- Favorites resource-page list equality helper is archived. `FavoriteResourcePage`
  now uses Flutter's canonical `listEquals` for `medias`, so a file-local
  `_listEquals` clone no longer sits beside the canonical favorite resource entity.
- Favorites folder dialog form-data wrapper is archived. `FavFolderDialog` returns a
  typed record for title, intro, and privacy, so `FavFolderFormData` no longer exposes a
  behaviorless presentation DTO for the create/edit flows.
- Favorites folder/resource item DTO mirrors are archived. `FavoriteFolder` now decodes
  folder item and add/edit response JSON directly, and `FavoriteResource` now decodes
  resource item JSON directly, so `FavFolderModel`, `FavResourceModel`, and their
  copy-only repository mappers no longer coexist with the canonical entities.
- Ranking category presentation wrapper is archived. `RankingPage` is the only consumer
  of the tab name/rid metadata, so the category list and label resolver are page-private
  instead of a public `presentation/models/ranking_category.dart` file.
- Search page state wrapper is archived. `SearchPage` owns page-local controller, focus,
  suggestion, confirmed-keyword, debounce, default-search fallback, history insertion,
  and callback state privately, so `use_search_view_model.dart`, public
  `useSearchViewModel`, public `SearchPageMode`, and the public `SearchPageState` class
  must not return.
- Search section header wrapper is archived. Search landing history and hot-search
  headers own their title typography, padding, and clear action inline, so
  `AppSectionHeader` and `app_section_header.dart` no longer expose a search-only shared
  widget.
- Notification chat image/send wrappers are archived. The image picker passes bytes and
  filename as a named record into `Chat.sendImage`, and send methods return a record for
  sent/skipped/error outcomes instead of public `ChatImageAttachment`, `ChatSendResult`,
  or `ChatSendStatus` types.
- Notification chat state helper/send part splits are archived. `Chat` owns its local
  snapshot sync, min-seq tracking, older-page loading, upload/send, refresh, and
  paging-error behavior directly, so `_ChatHelpersMixin`, `_ChatSendMixin`,
  `chat_view_model.helpers.dart`, and `chat_view_model.send.dart` do not remain as
  one-owner state splits.
- Feature-local upload image result wrappers are archived. Dynamic publish upload and
  notification chat image upload now share the core `UploadedImage` contract for the
  `image_url`/`image_width`/`image_height` payload.
- Dynamic publish command Freezed shell is archived. `PublishMediaAsset` remains as a
  hand-written path value, while unused `PublishDynamicCommand` and
  `dynamic_publish_command.freezed.dart` do not remain in active code. The unused
  `PublishMediaAsset.copyWith` helper is archived too.
- Notification send/upload mapper helpers are archived. `NotificationRepositoryImpl`
  owns the only chat image upload and private-message send response parsing paths:
  upload mapping uses `UploadedImage.fromJson` directly, and private-message send keeps
  `msg_key`, nullable `msg_content`, and `key_hit_infos` normalization beside the outbox
  status updates that consume the result. Do not restore `sendMessageResultFromJson`,
  `uploadedImageFromJson`, or `_readNullableString` in `notification_mapper.dart`.
- Notification system-notice mapper helpers are archived at the data-mapper layer.
  `SystemNotice` now owns its persistence JSON helpers directly; do not restore
  `system_notice_mapper.dart` or move `systemNoticeFromJson`/`systemNoticeToJson` back
  into `notification_mapper.dart`.
- Notification system-notice page state shell is archived. `SystemNotificationPage` owns
  the private stream-backed notifier for local notice watches, initial sync, logged-out
  empty fallback, and refresh behavior because no second active consumer imports that
  provider.
- Notification unread-count page state shell is archived. `NotificationPage` owns the
  private stream-backed notifier for local unread summary watches, initial sync,
  logged-out empty summary fallback, and forced refresh because no second active
  consumer imports that provider.
- Auth login dialog widget wrapper is archived. The auth dialog entrypoint is
  `showLoginDialog` in `login_panel.dart`, preserving the modal barrier, fade transition,
  transparent material, `LoginPanel`, and close callback without exporting a public
  `LoginDialog` widget shell or separate `login_dialog.dart` wrapper file.
- Search provider cache-presence helper duplication is archived. `DefaultSearch` and
  `TrendingRanking` share `_hasApiCacheValue` for the `api_cache_` key rule instead of
  keeping identical per-provider `_hasCachedValue` methods.
- Auth repository helper part split is archived. `AuthRepositoryImpl` owns cached-user
  JSON read/write, cache clearing, login-state probing, and current-user loading
  directly, so `_AuthRepositoryHelpersMixin` and `auth_repository_impl.helpers.dart` do
  not remain as one-owner part-file abstractions.
- Auth repository crypto part split is archived. Password-login PEM parsing and RSA
  encryption helpers live beside the login flow that owns them, so
  `auth_repository_impl.crypto.dart` does not remain as a one-owner helper part.
- Auth session cookie refresher adapter is archived. `auth_session_providers.dart` owns
  the private `SessionCookieRefresher` implementation behind the runtime override
  factory, so `auth_session_cookie_refresher.dart` and public
  `AuthSessionCookieRefresher` no longer wrap the single cookie-refresh call.
- Auth QR login page-state wrapper is archived. `QrLoginView` owns its private
  `_AuthQrLoginController` and `_authQrLoginControllerProvider`, preserving QR URL
  loading, three-second polling, status-code mapping, expired/success timer
  cancellation, retry refresh, and post-success user refresh without
  `auth_qr_login_view_model.dart`, `AuthQrLoginState`, `AuthQrLoginController`, or
  `authQrLoginControllerProvider`.
- Auth Geetest hook result wrapper is archived. `useGeetest` returns a Dart record for
  the captcha start callback and loading flag used by password/SMS login, so
  `UseGeetestResult` does not remain as a public two-field presentation wrapper.
- Auth QR poll result shell is archived. `AuthQrPollResult` now remains as a
  hand-written immutable value beside the QR login repository flow, preserving simple
  code/message equality semantics without `auth_qr_poll_result.freezed.dart`. The
  unused `copyWith` helper is archived too.
- Auth QR code shell is archived. `AuthQrCode` now remains as a hand-written
  immutable value for the QR URL/key returned by the login repository flow,
  preserving equality semantics without `auth_qr_code.freezed.dart`. The unused
  `copyWith` helper is archived too.
- Auth country code shell is archived. `CountryCode` now remains as a
  hand-written immutable value for country-list parsing, default SMS country
  selection, and country-picker navigation, preserving equality semantics without
  `country_code.freezed.dart`. The unused `copyWith` helper is archived too.
- Auth cached-user shell is archived. `UserEntity` now remains as a hand-written
  immutable value for current-user loading, cache serialization, and
  `AuthState.user`, preserving nullable equality semantics without
  `user_entity.freezed.dart`. The unused `copyWith` helper is archived too.
- Auth controller state Freezed shell is archived. `AuthState` remains beside `Auth` in
  `auth_controller.dart` as a hand-written immutable authentication state value,
  preserving login/loading/user/error defaults, nullable clearing, value equality,
  diagnostics, and controller copy semantics without `auth_controller.freezed.dart`.
- Auth captcha challenge Freezed shell is archived. `AuthCaptchaChallenge` remains in
  `auth_captcha_challenge.dart` as a hand-written immutable login challenge value,
  preserving token/gt/challenge transport, equality, hash, and diagnostics without
  `auth_captcha_challenge.freezed.dart`. The unused `copyWith` helper is archived too.
- Ranking category provider wrapper is archived. `RankingPage` owns the private
  category-ranking provider and retry behavior, so `category_ranking_view_model.dart`
  and its generated provider wrapper do not remain as a shared state shell.
- Notification like response wrapper stack is archived. `NotificationFeedSync` parses
  the like endpoint's latest/total envelope directly into `ReplyResponse`, so
  `LikeResponse`, `LikeLatest`, and `LikeTotal` are removed from active code. The
  unconsumed `last_view_at` field is not mirrored in active DTO state. The one-use
  `_parseLikeResponse` helper is archived too; `_fetchReplyLikeAtResponse` keeps
  `total.cursor/items` normalization inline for the like feed branch.
- Notification reply item metadata fields are archived. `ReplyItem` still owns the
  active actor/detail/timestamp transport shape, but unused `counts` and `is_multi`
  metadata are no longer mirrored while no feed/domain path reads them.
- Notification resume-sync service wrapper is archived. `NotificationLifecycleSync`
  owns the resume throttle and concurrent unread/session/feed-head sync policy directly,
  so `NotificationResumeSyncService`,
  `notification_resume_sync_application_providers.dart`, and its generated provider
  output do not remain as one-caller application wrappers.
- Notification owner-uid provider wrapper is archived. The notification state files read
  `currentUserProvider` directly and parse the uid locally, so
  `notification_owner_uid_application_providers.dart` and its generated provider output
  do not remain as a thin session wrapper.
- Notification private-session provider shell is archived. `PrivateSessionListView`
  owns `_PrivateSessionList` and `_privateSessionListProvider` privately, so
  `private_session_view_model.dart`, its generated provider output,
  `PrivateSessionList`, and `privateSessionListProvider` do not remain as one-widget
  state wrappers. The row's message summary, avatar, and unread badge helpers are
  owned inline by `_PrivateSessionItem.build`.
- Notification feed item text helpers are archived. `NotificationItemWidget.build` owns
  action label selection and source-content/title fallback inline, so `_getActionText`
  and `_getSourceText` do not remain as one-use row helpers.
- Notification feed provider shell is archived. `NotificationListPage` owns
  `_NotificationFeedList` and `_notificationFeedListProvider` privately, so
  `notification_feed_view_model.dart`, its generated provider output,
  `NotificationFeedList`, and `notificationFeedListProvider` do not remain as one-page
  state wrappers.
- Notification feed cursor Freezed shell is archived. `NotificationFeedCursor` remains
  as a hand-written immutable two-field value in `notification_feed_cursor.dart`,
  preserving pagination cursor behavior without `notification_feed_cursor.freezed.dart`.
  The unused `copyWith` helper is archived too, leaving only active cursor fields and
  value semantics.
- Notification unread summary Freezed shell is archived. `NotificationSummary` remains
  as a hand-written immutable counter bundle in `notification_summary.dart`, preserving
  zero-default unread count behavior without `notification_summary.freezed.dart`. The
  unused `copyWith` helper is archived too.
- Notification system notice Freezed shell is archived. `SystemNotice` remains as a
  hand-written immutable value in `system_notice.dart`, preserving JSON helper behavior
  without `system_notice.freezed.dart`. The unused `copyWith` helper is archived too.
- Notification send-result Freezed shell is archived. `SendMessageResult` now stays as a
  lightweight hand-written send response holder in `send_message_result.dart`,
  preserving immutable `keyHitInfos` without `send_message_result.freezed.dart`. The
  unused `copyWith`, deep equality, and deep hash helpers are archived too.
- Notification stream watcher wrapper is archived. `NotificationRepositoryImpl` owns the
  unread-count and system-notice local database watch queries directly, so
  `NotificationStreamWatchers` and
  `notification_repository_impl.stream_watchers.dart` do not remain as one-owner
  repository delegate wrappers.
- Notification local read-store wrapper is archived. `NotificationRepositoryImpl` owns
  the unread, session, message, emoji-map, and feed local database read queries directly,
  so `NotificationLocalReadStore` and
  `notification_repository_impl.local_read_store.dart` do not remain as one-owner
  repository delegate wrappers.
- Notification local unread snapshot API is archived. Active unread state uses
  `watchUnreadCount` plus `syncUnreadCount`, so the unused
  `getUnreadCountFromLocal` one-shot repository method does not remain.
- Notification message-send wrapper is archived. `NotificationRepositoryImpl` owns image
  upload, local pending/outbox writes, send-result mapping, and post-send message-head
  sync directly, so `NotificationMessageSendService`, `SyncMessagesHeadFn`, and
  `notification_repository_impl.message_send_service.dart` do not remain as one-owner
  repository delegate wrappers.
- Notification message-support wrapper is archived. `NotificationFeedSync` owns feed
  remote fetch dispatch, like response normalization, system talker lookup, and system
  notice extraction directly, so `NotificationMessageSupport` and
  `notification_repository_impl.message_support.dart` do not remain as one-owner
  repository/feed delegate wrappers.
- Profile optional response parser duplication is archived. Relation stats, like count,
  and video count now share one optional enrichment data-map gate while preserving zero
  fallbacks when non-critical profile enrichment calls fail.
- Profile repository flow part split is archived. `ProfileRepositoryImpl` now owns the
  profile video list, sticky video, masterpiece fetch methods, and user-space video
  parsing directly, so `profile_repository_impl.flows.dart` does not remain as a
  one-owner abstraction.
- Profile repository parser part split is archived. User card, optional enrichment,
  banner, VIP, verification, and user-space video parsing now stay private to
  `ProfileRepositoryImpl`, so `profile_repository_impl.parsers.dart` and
  `_ProfileRepositoryParsers` do not remain as one-owner abstractions.
- Search page-size constants wrapper is archived. `SearchApi` owns the private default
  for search result page size directly because no other component consumes it.
- Live danmaku send defaults wrapper is archived. `LiveApi` owns its private send
  defaults directly, so `live_danmaku_defaults.dart` does not remain as a facade.
- Profile relation route page wrappers are archived. Profile navigation owns the
  followers/followings relation route body privately, so `followers_page.dart`,
  `followings_page.dart`, `FollowersPage`, and `FollowingsPage` no longer duplicate the
  same scaffold/list wrapper.
- Favorite detail list-section wrapper is archived. `FavoriteDetailPage` owns the
  resource sliver list, empty state, selection toggling, and pagination error renderer
  directly, so `_FavoriteDetailListSection` does not remain as a one-page private UI
  wrapper.
- Favorite detail resource-item wrapper is archived. `_FavoriteResourceRow` owns the
  `VideoListCard` composition, uploader line, more action feedback, and play/danmaku stat
  chips directly, so `_FavResourceItem` does not remain as a one-use private row wrapper.
- Favorite detail loading-skeleton wrapper is archived. `FavoriteDetailPage` owns the
  fixed 10-row shimmer loading list directly in its loading branch, so
  `_FavoriteDetailSkeleton` does not remain as a one-use private page wrapper.
- Profile home-tab wrapper is archived. `UserProfilePage` is the only owner of the home
  tab body, so `user_home_tab.dart` and public `UserHomeTab` are removed while keep-alive,
  page storage, overlap injection, and section composition stay private to the page.
- Video danmaku presentation provider wrapper is archived. The playback scheduler now
  reads `danmakuRepositoryProvider` directly and maps repository `DanmakuSegment`
  entries into overlay items at the only call site, so `DanmakuProvider` and its
  generated provider shell are removed from active code.
- Video danmaku Freezed shell is archived. `DanmakuEntry` and `DanmakuSegment` remain
  as hand-written immutable values in `danmaku.dart`, preserving read-only segment
  entries, equality, hash, and diagnostics without `danmaku.freezed.dart`. Their
  unused `copyWith` helpers are archived too.
- Video danmaku item transport wrapper file is archived. `DanmakuController` owns
  `DanmakuItem` and `DanmakuItemType` as its batch-add contract, preserving text,
  color, time, type, mode mapping, opaque RGB conversion, and default white scrolling
  items without a separate `models/danmaku_item.dart` file.
- Live anchor-info wrapper stack is archived. The optional live room fetch parses only
  `exp.master_level.level` into `LiveRoomState.anchorLevel`, so the nested
  `LiveAnchorInfoModel`/`LiveAnchorExp`/`LiveMasterLevel` tree is no longer active.
- Video player-info danmaku-mask DTO wrappers are archived. The video repository now
  parses the raw `dm_mask` object into the `mask_url` and `fps` record needed by the
  only danmaku-mask workflow, so `PlayerInfo`, `DmMask`, and their generated files are
  removed from active code. The one-use `_parseDanmakuMaskInfo` repository helper is
  archived too; `fetchDanmakuMaskInfo` owns the unwrap inline.
- Video detail uploader wrapper is archived. The uploader avatar/name row and follow
  login gate are owned privately by `VideoInfoView`, so `UploaderSection` and
  `uploader_section.dart` no longer expose a public one-consumer widget.
- Live-room title min-lines wrapper is archived. `LiveRoomCard` owns its fixed two-line
  title slot directly, so the public `AppMinLinesText` helper and
  `app_min_lines_text.dart` are removed while no second text layout consumer exists.
- Live-room area-tag wrapper is archived. `LiveRoomCard` owns its cover badge inline,
  preserving overlay colors, border, radius, padding, and text style without a one-use
  `_LiveAreaTag` class.
- Video entry vertical builder seam is archived. `VideoEntryDecisionPage` now constructs
  the vertical player branch directly, so the unused `verticalPageBuilder` constructor
  parameter and one-line `_buildVerticalPage` helper no longer expose a fake override seam.
- Video entry normal builder seam is archived. `VideoEntryDecisionPage` now constructs
  the normal detail branch directly, so the unused `normalPageBuilder` constructor
  parameter and one-line `_buildNormalPage` helper no longer expose a fake override seam.
- Player panel dead API is archived. `PlayerPanelScaffold` never rendered its
  title/subtitle/trailing inputs, so those constructor parameters and the
  `QuickSelectionSheet` title/subtitle forwarding path are removed from active code.
- Player theme dead tokens are archived. `PlayerTheme` keeps the active progress bar,
  subtitle, gradient, time, and sizing entries only; unused public constants/style helpers
  and the one-call `sliderTheme` helper are removed.
- Player progress-bar wrapper is archived. `PlayerControlsOverlay` is the only owner of
  the playback slider, so `video_progress_bar.dart` and public `VideoProgressBar` are
  removed while position, buffer, drag preview, label formatting, and seek behavior stay
  private to the overlay.
- Gesture feedback wrappers are archived. `InteractionLayer` is the only owner of the
  seek ripple and brightness/volume indicator, so `seek_ripple_overlay.dart`,
  `gesture_indicator.dart`, `SeekRippleOverlay`, and `GestureIndicator` are removed while
  animation, clipping, blur fallback, text value, and progress rendering stay private to
  the gesture layer.
- Video controls utility wrapper is archived. The controls assembly owns the side-panel
  versus bottom-sheet orientation policy directly, so `controls_utils.dart` and the
  generic `showSidePanel` helper no longer sit beside the controls callers.
- Dynamic API defaults wrapper is archived. `dynamic_api.dart` owns the shared feed
  feature flags, topic page size, and web timezone offset directly, so
  `dynamic_api_defaults.dart` no longer sits beside the API owner.
- User dynamic skeleton wrapper is archived. `UserDynamicFeed` is the only owner of the
  dynamic loading shimmer card, so `dynamic_skeleton.dart` and public `DynamicSkeleton`
  are removed. The remaining private `_DynamicSkeleton` owns its header/content/footer
  shimmer structure inline in `build()` without one-call `_buildHeader`, `_buildContent`,
  or `_buildFooter` helpers.
- Home feed page skeleton wrappers are archived. `PopularView` and `RecommendView` own
  their loading `CustomScrollView` slivers directly, so `page_skeletons.dart`,
  `GridSkeletonView`, and `ListSkeletonView` no longer expose generic wrappers with one
  active owner each.
- Live danmaku config fetch/state is archived. The `GetDMConfigByGroup` payload was only
  fetched during room initialization, stored in `LiveRoomState`, and logged as a boolean;
  no active UI or socket policy consumed the model. Live room initialization now keeps
  play URL as the only critical startup request and no longer fails because the unused
  config endpoint fails.
- Live room state wrapper file is archived. `LiveRoomController` now owns
  `LiveRoomState` directly in `live_room_view_model.dart`, preserving the room-id
  requirement, loading/error tri-state, room/anchor/rank/guard/play-url fields, and
  playback UI flags without a separate `live_room_state.dart` or generated Freezed
  state wrapper.
- Architecture guard gaps for archived generated/file wrappers are archived. The guard
  now checks generated DTO artifact filenames, application/core port files, shell
  navigation item wrappers, dynamic route wrapper functions, `RequestExecutor.runVoid`,
  dynamic upload-image response DTOs, favorites mapper files, and notification
  system-notice/message-support helper files.
- `AppError._fromBadResponse` is archived. Dio bad-response classification now lives in
  `_fromDioException`, preserving 401/403 auth mapping, response status/message
  propagation, and server fallback without a one-call private helper.
- Notification message-support dead helper copies are archived.
  `NotificationMessagePersistence` is the single owner for emoji key canonicalization,
  emoji variant insertion, and local-row-to-message conversion; the support service keeps
  only private system-notice parsing helpers and feed-response parsing behavior.
- Dynamic publish workflow and page-state wrappers are archived. `PublishDynamicPage`
  is the only consumer of csrf resolution, publish image upload, publish submission,
  and the one-bit publishing state, so `_PublishDynamicController` lives privately in
  `publish_dynamic_page.dart` instead of routing through `PublishDynamicWorkflow`,
  `PublishDynamicViewModel`, `PublishDynamicUiState`, or their generated providers.
- Dynamic detail page-state wrapper is archived. `DynamicDetailPage` owns
  `_DynamicDetailController` and `_dynamicDetailProvider` privately, so
  `dynamic_detail_view_model.dart`, `DynamicDetailUiState`, `DynamicDetailViewModel`,
  and `dynamicDetailViewModelProvider` do not remain as a one-page state wrapper.
- Publish dynamic page-only widget wrappers are archived. `publish_dynamic_page.dart`
  owns its bottom toolbar, selected-image grid, emoji picker, and topic picker privately,
  preserving toolbar actions, character count, safe-area padding, add/remove image
  controls, local file previews, 3-column grid layout, emoji package loading/retry, tab
  controller disposal/rebuild, package icon tabs, emote insertion, debounced topic
  search, topic covers/fallback icons, HTML-stripped topic labels, and modal close
  behavior without `PublishDynamicBottomToolbar`, `PublishDynamicImageGrid`,
  `EmojiPicker`, `TopicPicker`, or their one-owner files.
- Dynamic detail response shell is archived. The repository now owns the only
  `data.item` unwrap into `DynamicItem`, so `DynamicDetailData` does not coexist with the
  canonical dynamic item model. The one-use `_parseDynamicDetailItem` helper is archived
  too; `getDetail` keeps that unwrap and `DynamicItem.fromJson` mapping inline.
- Article-detail public part helpers are archived. The comment sliver builder is
  private to the article detail library, and the scaffold builder is private as well,
  preserving all article scaffold/app-bar/refresh/bottom-bar behavior and comment
  loading, disabled, error, empty, list, reply, divider, and load-more states without
  public `buildArticleDetailScaffold` or `buildArticleCommentSlivers` APIs.
- Dynamic post card view-data wrapper is archived. Dynamic card widgets now render
  canonical `DynamicItem` through the existing extension surface, so
  `DynamicPostCardViewData` no longer duplicates author, stats, content, topic, and
  original-post fields.
- Dynamic item mapper part split is archived. The private video/link-card/additional
  content mappers only serve `DynamicItemContentExtension`, so they now live in
  `dynamic_item_extensions.dart` instead of a one-owner
  `dynamic_item_extensions.mappers.dart` part file.
- Dynamic vote additional wrapper is archived. `DynamicContentWidget` is the only owner
  of the vote additional branch, so the vote surface now lives privately beside
  `_buildAdditional`; `_DynamicVoteCard` and
  `DynamicVoteWidget`/`dynamic_vote_widget.dart` are removed.
- Dynamic common/link-card wrappers are archived. `DynamicContentWidget` owns the common
  additional card and link-card branches directly, preserving their surface radius,
  navigation tap targets, cover sizing, text clamps, and fallback strings without
  `DynamicCommonWidget`, `DynamicLinkCardWidget`, or their one-owner files.
- Dynamic UGC/video wrappers are archived. `DynamicContentWidget` owns the UGC
  additional and video content branches directly, preserving UGC jump-url navigation,
  video fallback BVID/AID navigation, 140x88 media covers, duration chrome, play/danmaku
  counters, text clamps, and empty-string fallbacks without `DynamicUgcWidget`,
  `DynamicVideoWidget`, or their one-owner files.
- Dynamic goods/reserve wrappers are archived. `DynamicContentWidget` owns the goods and
  reserve additional branches directly, preserving empty goods shrink behavior, goods
  list row tap targets, price styling, reserve jump-url gating, translated reserve labels,
  button disabled state, and surface padding without `DynamicGoodsWidget`,
  `DynamicReserveWidget`, or their one-owner files.
- Dynamic image wrapper is archived. `DynamicContentWidget` owns dynamic post image
  rendering directly, preserving trim/take-9 filtering, empty shrink behavior,
  single-image 240px constraints, 3-column wrap sizing, tap targets, and
  `AppImagePreview.open` initial-index behavior without `DynamicImagesWidget` or
  `dynamic_images_widget.dart`.
- Dynamic forward wrapper is archived. `DynamicContentWidget` owns recursive original
  post rendering directly, preserving the forward surface, clickable author name, profile
  navigation, fallback forward text, and nested `DynamicContentWidget(post: post)`
  behavior without `DynamicForwardWidget` or `dynamic_forward_widget.dart`.
- Dynamic post action-sheet wrapper is archived. `DynamicPostHeader` owns its single
  share/copy/open sheet privately, preserving dynamic link construction, share text,
  clipboard feedback, external navigation, translated labels, and drag-handle UI without
  `showDynamicPostActions`, `DynamicPostAction`, or `dynamic_post_actions.dart`.
- Dynamic content surface helper is archived as a public file. `DynamicContentWidget`
  owns the remaining content-card surface policy privately, preserving transparent
  `Material`, `InkWell`, default surface color, padding, border radius, tap handling, and
  `Ink` decoration without `DynamicContentSurface` or `dynamic_content_surface.dart`.
- Dynamic feed query bags are archived. Dynamic feed providers pass endpoint parameters
  directly into repository feed methods, so `DynamicFeedQuery`, `SpaceDynamicFeedQuery`,
  `TopicDynamicFeedQuery`, and `dynamic_queries.dart` no longer mirror method arguments.
- Dynamic recently-followed header wrapper is archived. `DynamicListView` owns the
  all-tab recently-followed provider branch and horizontal avatar/name header privately,
  preserving empty/loading/error shrink behavior, translated title, network avatars,
  primary outline ring, and ellipsized names without `RecentlyFollowedWidget` or
  `recently_followed_widget.dart`. The one-consumer `RecentlyFollowed` provider shell is
  also archived; `DynamicListView` owns the private `FutureProvider.autoDispose` and
  `recently_followed_provider.dart` plus generated output must not return.
- Relation service scalar reader helpers are archived. Relation user parsing now uses
  shared `JsonUtils` scalar helpers, with numeric API values handled in
  `JsonUtils.parseInt` instead of a local `_readInt` clone.
- Relation service map reader helpers are archived. Nested relation user maps now call
  `JsonUtils.asStringKeyedMap` directly instead of keeping a local `_asMap` clone.
- Auth cached-user map/scalar helpers are archived. `_userEntityFromJson` now uses
  `JsonUtils.asStringKeyedMap` for `level_info` and `JsonUtils.parseInt` for level
  values, so `_asMapOrNull` and `_asIntOrNull` no longer duplicate core JSON utilities.
- Live danmaku event integer helper is archived. `LiveDanmakuEventParser` now calls
  `JsonUtils.parseIntWithDefault` directly for optional numeric event fields while
  preserving malformed-value fallback to 0 instead of keeping a private `_asInt` clone.
- Live danmaku event parser wrapper is archived. `LiveSocketService` now keeps the
  DANMU_MSG, INTERACT_WORD, NOTICE_MSG, and SEND_GIFT parsing private beside the socket
  message source instead of carrying a one-use `LiveDanmakuEventParser` wrapper file.
- Notification mapper scalar reader helpers are archived. Notification summary,
  send-result, and image-upload parsing now use shared `JsonUtils` scalar helpers
  instead of local `_readInt`/`_readString` clones.
- Notification summary mapper helpers are archived. Local cache and stream watcher
  paths parse stored unread summaries inline in
  `NotificationRepositoryImpl.watchUnreadCount`, so `notificationSummaryFromJson` and
  the unused `notificationSummaryToJson` write helper stay out of active code.
- Notification repository helper/service splits are archived. Local read-store queries
  and stream watchers now live on `NotificationRepositoryImpl`, feed support fetches and
  system-notice parsing live on the single `NotificationFeedSync` consumer, and
  upload/send outbox behavior lives on `NotificationRepositoryImpl`; do not restore
  `NotificationLocalReadStore`, `NotificationStreamWatchers`,
  `NotificationMessageSupport`, `NotificationMessageSendService`, or
  `SyncMessagesHeadFn`.
- Notification private-message DTO convenience members are archived.
  `PrivateMessageDetail` still owns small `contentMap` JSON decoding for active
  system-notice parsing, but unused DTO-local `isMe`, text/image/system-tip, withdrawn,
  and summary-kind helpers no longer coexist with canonical `PrivateMessage` domain
  behavior.
- Notification private-message account-info DTO mirror is archived.
  `PrivateMessageSession.accountInfo` now decodes `account_info` directly to the
  canonical `PrivateSessionAccountInfo`, so the copy-only `PrivateMessageAccountInfo`
  and mapper do not coexist with the app-facing session model.
- Notification private-session Freezed shell is archived. `PrivateSession` and
  `PrivateSessionAccountInfo` remain in `private_session.dart` as hand-written immutable
  values, preserving nullable fields, equality/hash, and diagnostics without
  `private_session.freezed.dart`. Their unused `copyWith` helpers are archived too.
- Settings cache-maintenance command wrapper is archived. The settings page now owns the
  only clear-cache pending state and calls the concrete settings repository directly.
- Settings cache-size provider wrapper is archived. The cache-size read model has one
  consumer, so `SettingsPage` owns a private `_cacheSizeProvider` beside the cache UI
  instead of keeping `settings_controller.dart` and a generated app-layer provider.
  The page also owns the language/theme selection builders and clear-cache action inline
  in `build`; `_showLanguageSelector`, `_showThemeSelector`, and `_handleClearCache`
  are archived.
- Profile action-grid widget wrapper is archived. The authenticated `ProfilePage` now
  owns its action list, desktop `LayoutBuilder`/six-column width calculation, mobile
  four-action row, disabled download item, and settings/history/favorites/watch-later/
  support callbacks directly instead of importing `profile_action_grid.dart`.
- Relation service port wrapper is archived. Cross-feature relation reads now use the
  concrete `relationServiceProvider`; `RelationPort`, `relation_port.dart`, and
  `relationPortProvider` are removed because no alternate implementation owns behavior.
- Video comment navigation callback wrapper is archived. `OpenVideoCommentReplies` now
  lives beside `VideoCommentsView`, the owner that invokes reply navigation from root
  comments, so `video_navigation_callbacks.dart` no longer exists as a typedef-only
  presentation file.
- Video prefetch tuning wrapper is archived. Comment-list prefetch scan/limit constants
  now live beside `VideoCommentsView`, and related-video prefetch constants now live
  beside `VideoInfoView`, so `video_prefetch_tuning.dart` no longer exists as a shared
  constants facade.
- Video comment layout constants wrapper is archived. The root comment list and reply
  page now own their scroll cache extent constants privately, so
  `video_comment_layout.dart` no longer exists as a one-line presentation layout facade.
- Home breakpoint facade is archived. Home feed max widths and grid-column threshold
  logic now live in `home_layout_spec.dart`, the existing owner for home feed layout
  sizing, so `home_breakpoints.dart` and `HomeBreakpoints` no longer exist as a separate
  presentation micro-facade.
- Video danmaku view metadata is archived. No current UI or workflow consumes the
  `/x/v2/dm/web/view` payload, while active danmaku behavior only needs segment loading
  and AI mask bytes, so `DanmakuViewConfig` and repository/API `fetchDanmakuView` seams
  must not return without a consuming feature.
- Video danmaku mask provider wrapper is archived. `VideoExtraWorkflows` now owns the
  AI-mask async provider directly, so `danmaku_mask_view_model.dart` no longer exists as
  a presentation-layer facade that only forwards `loadDanmakuMask`.
- Video player wakelock seam is archived. `usePlayerSystemSettings` now calls
  `WakelockPlus` directly for play/error/dispose handling, so the single-implementation
  `PlayerWakelock`, `PlatformPlayerWakelock`, and `syncPlayerWakelock` helper no longer
  exist without a real alternate implementation.
- Video loader input selector seam is archived. `useVideoLoader` now watches the video
  detail controller state it consumes, so player pages no longer prepare a
  `VideoLoaderInput` record through `watchVideoLoaderInput` before immediately passing
  it back into the same hook.
- Live recommend provider shell is archived. `LiveView` owns the private auto-dispose
  paging notifier for live-room recommendations, preserving `liveRecommendPageSize`,
  duplicate merge by `roomId`, load-error logging, refresh, and load-more behavior
  without `live_recommend_provider.dart`, generated output, public `LiveRecommend`, or
  public `liveRecommendProvider`.
- Live room summary Freezed shell is archived. `LiveWatchedShow` and `LiveRoomSummary`
  remain in `live_room_summary_contract.dart` as hand-written immutable values,
  preserving recommend-room wire keys, `watched_show` nesting, `keyframe`,
  `is_auto_play`, and JSON parsing without
  `live_room_summary_contract.freezed.dart` or `live_room_summary_contract.g.dart`.
  Their unused `copyWith` and `toJson` helpers are archived too.
  The previous private `_parseWatchedCount` scalar helper is also archived; watched-count
  parsing now uses `JsonUtils.parseInt` directly while keeping the invalid numeric
  `FormatException`.
- User card Freezed shell is archived. `UserCardModel` remains in
  `user_card_contract.dart` as a hand-written immutable value, preserving profile/live
  card handoff fields, default `isFollowed = false`, equality, and diagnostics without
  `user_card_contract.freezed.dart`. The `UserCardModel.copyWith` helper is archived
  too; profile optimistic follow updates remain on `ProfileUser.copyWith`, and the live
  anchor follow toggle emits an explicit `UserCardModel` constructor. The one-use profile
  repository `_parseUserCard` helper is archived too; `getUserCard` keeps that response
  unwrap inline.
- User profile app-bar menu helper is archived. `UserProfileAppBar.build` owns the
  share/blacklist/report bottom sheet actions inline with the only more button that
  opens them; `_showMoreMenu` does not remain as a one-use method.
- Profile banner/avatar preview helper is archived. `UserProfileHeader.build` owns the
  banner and avatar tap handlers, null/empty URL guards, and `AppImagePreview.open`
  calls inline, so `_showImagePreview` does not remain as a one-call method.
- Shared user-list text/stats helpers are archived. `UserListTile.build` now owns title
  typography, optional badge layout, stats spacing, and optional subtitle text inline, so
  `_buildTitle`, `_buildTitleRow`, `_buildStatsRow`, and `_buildSubtitle` do not remain
  as nested one-call methods.
- Follow-button label helper is archived. `FollowButton.build` owns the single label
  fallback once and reuses it for `Semantics.label` and visible text, so `_resolveLabel`
  does not remain as a one-call method.
- App-tag color fallback helpers are archived. `AppTag.build` owns the constructor
  color overrides and `ColorScheme` defaults inline, so `_backgroundColor` and
  `_foregroundColor` do not remain as one-call methods.
- VIP tag shadow helper is archived. `VipTag.build` owns the `showShadow` branch that
  either emits `null` or the single primary-color `BoxShadow`, preserving alpha 0.3,
  blur radius 4, and offset `(0, 2)` without a one-call `_buildShadow` method.
- App-card decoration helper is archived. `AppCardContainer` builds its
  `BoxDecoration` inline inside the performance-policy builder, while `_buildShadow`
  remains as the minimal/reduced/full effects policy boundary.
- Live room danmaku input sheet helper is archived. `LiveRoomPage.build` owns the
  single tap handler that opens `LiveInputSheet`, so `_showInputSheet` does not remain
  as a one-call page modal method.
- To-view refresh helper is archived. `ToViewPage.build` owns the only refresh callback
  that invalidates `toViewListProvider`, awaits reload, and maps the result to
  `IndicatorResult`, so `_refreshList` does not remain as a one-call provider wrapper.
- Video share wrapper is archived. `_VideoActionsRow.build` owns the only Bilibili video
  share payload construction, including the title, URL, and subject; `shareVideo` does
  not remain in `share_utils.dart` as a one-call wrapper with an unused cover argument.
- Shared paged-list Freezed shell is archived. `PagedListState<T>` remains in
  `paged_list_state.dart` as a hand-written immutable paging value, preserving default
  loading/page flags, list equality, and nullable `error` clearing through `copyWith`
  without `paged_list_state.freezed.dart`.
- Shared paged-list equality helper is archived. `PagedListState.items` now uses
  Flutter's canonical `listEquals`, so a file-local `_listEquals` clone no longer sits
  beside the shared paging value.
- Relation-user Freezed/JSON shell is archived. `OfficialVerify`, `VipInfo`, and
  `ProfileRelationUser` remain in `relation_user_contract.dart` as hand-written
  immutable values, preserving relation-list wire keys, defaults, equality, diagnostics,
  and JSON parsing without `relation_user_contract.freezed.dart` or
  `relation_user_contract.g.dart`. Their unused `copyWith` and `toJson` helpers are
  archived too.
- Topic dynamic feed provider shell is archived. `TopicDetailPage` owns the private
  auto-dispose cursor-paged topic feed notifier, preserving topic offset paging,
  empty-on-failure behavior, `item.idStr` merge identity, refresh, load-more, and
  `DynamicFeedController` like toggling without `topic_dynamic_feed_provider.dart`,
  generated output, public `TopicDynamicNotifier`, or public `topicDynamicProvider`.
- Favorites folder-resource page info mirror is archived. `FavoriteResourcePage.info`
  now uses canonical `FavoriteFolder`, preserving detail-response `media_count` decoding
  and repository validation that detail headers still receive non-null `cover` and
  `upper` without a parallel `FavoriteFolderInfo` model.
- Video detail state shell is archived. `VideoDetailState` now lives beside
  `VideoDetailController` in `video_detail_view_model.dart`, preserving generated
  Freezed copy/null semantics without a separate `video_detail_state.dart` owner file.
- Video detail play-url cache read wrapper is archived. `VideoDetailController` reads
  `_playUrlSessionCache` inline through the shared cache-key builder, so
  `_readCachedPlayUrl` does not remain as a one-use read helper beside the controller.
- Comment reply state shell is archived. `CommentReplyState` now lives beside
  `CommentReplyController` in `comment_reply_view_model.dart`, preserving hand-written
  copy/null semantics without touching the controller's refresh, cancellation,
  stale-request, pagination, like rollback, or root-comment behavior.
- Listen sleep timer Freezed shell is archived. `ListenSleepTimerState` remains beside
  `ListenSleepTimerController` in `listen_sleep_timer_view_model.dart` as a hand-written
  immutable two-field value, preserving equality/isActive semantics without a generated
  Freezed file for nullable `remaining` and `total` timer state. The unused
  `copyWith` helper and nullable copy sentinel are archived; the controller emits direct
  constructor updates. `ListenSettingsSheet` also owns the one-use preset-minute button
  rendering inline; `_PresetMinuteTextButton` is archived.
- Feedback error-details helper is archived. `AppErrorWidget` now owns its single
  error-details dialog entrypoint inline in `build`, preserving `ErrorHandler`
  detail text construction, selectable monospace content, translated labels, and dialog
  close behavior without the one-use `_showErrorDetails` method.
- Feedback button wrappers are archived. `AppErrorWidget.build` owns the details and
  retry `OutlinedButton.icon` controls inline, preserving compact density, retry border,
  padding, icons, and translated labels without `_ErrorDetailsButton` or `_RetryButton`.
- Playback snapshot Freezed shell is archived. `PlaybackSnapshot` remains beside the
  playback snapshot providers in `playback_snapshot_view_model.dart` as a hand-written
  immutable three-field value, preserving zero-duration defaults and copy/equality
  behavior without `playback_snapshot_view_model.freezed.dart`.
- Audio playback snapshot Freezed shell is archived. `AudioPlaybackSnapshot` remains
  beside `AudioPlaybackStateGate` in `audio_playback_state_gate.dart` as a hand-written
  immutable state-gate value, preserving playback-state equality, hash, and diagnostics
  without `audio_playback_state_gate.freezed.dart`. The unused `copyWith` helper is
  archived too.
- Live danmaku feed Freezed shell is archived. `LiveDanmakuFeedState` remains beside
  `LiveDanmakuFeedController` in `live_danmaku_feed_view_model.dart` as a hand-written
  immutable feed status value, preserving list equality, revision bumps, enabled/
  connected flags, and buffered history publishing without a generated Freezed file.
- Live danmu info Freezed shell is archived. `LiveDanmuInfoModel` and `LiveDanmuHost`
  remain in `live_danmu_info_model.dart` as hand-written immutable values, preserving
  the `host_list` empty-list fallback and connection metadata without generated
  Freezed/JSON shell files. Unused `copyWith` and `toJson` helpers are archived too.
- Live danmu info list equality helper is archived. `LiveDanmuInfoModel` now uses
  Flutter's canonical `listEquals` for `hostList`, so a file-local `_listEquals` clone
  no longer sits beside the canonical connection-info model.
- Live gold-rank list equality helper is archived. `LiveGoldRankModel` now uses
  Flutter's canonical `listEquals` for `list`, so a file-local `_listEquals` clone no
  longer sits beside the canonical gold-rank model.
- Live play-url Freezed shell is archived. `LivePlayUrlModel`,
  `LiveQualityDescription`, and `LiveStreamUrl` remain in `live_play_url_model.dart` as
  hand-written immutable values, preserving play-url wire keys, list equality, and JSON
  parsing without generated Freezed/JSON shell files. Unused `copyWith` and `toJson`
  helpers are archived too.
- Live play-url list equality helper is archived. `LivePlayUrlModel` now uses Flutter's
  canonical `listEquals` for `acceptQuality`, `qualityDescription`, and `durl`, so a
  file-local `_listEquals` clone no longer sits beside the canonical play-url model.
- Live guard-list list equality helper is archived. `LiveGuardListModel` now uses
  Flutter's canonical `listEquals` for `top3` and `list`, so a file-local `_listEquals`
  clone no longer sits beside the canonical guard-list model.
- Live room detail Freezed shell is archived. `LiveRoomDetailModel` remains in
  `live_room_detail_model.dart` as a hand-written immutable value, preserving live room
  detail wire keys, `hot_words` list equality, `new_pendants` / `studio_info` map
  equality, and JSON parsing without `live_room_detail_model.freezed.dart` or
  `live_room_detail_model.g.dart`. Unused `copyWith` and `toJson` helpers are archived
  too.
- Live room detail list equality helper is archived. `LiveRoomDetailModel` now uses
  Flutter's canonical `listEquals` for `hotWords`, so a file-local `_listEquals` clone
  no longer sits beside the room-detail read model.
- Live room detail map helper clones are archived. `LiveRoomDetailModel` now uses
  Flutter's canonical `mapEquals` for `newPendants` and `studioInfo`, with inline
  unordered map hashing, so file-local `_mapEquals` / `_mapHash` clones no longer sit
  beside the room-detail read model.
- Live history danmaku Freezed shell is archived. `LiveHistoryDanmakuModel`,
  `LiveDanmakuItem`, `LiveDanmakuMedal`, `LiveDanmakuTitle`, and
  `LiveDanmakuUserLevel` remain in `live_history_danmaku_model.dart` as hand-written
  immutable values, preserving array-encoded metadata converters, nullable metadata
  parsing, `checkInfo` map equality, and JSON parsing without generated Freezed/JSON
  shell files. Unused `copyWith` and `toJson` helpers are archived too.
- Live history danmaku list equality helper is archived. `LiveHistoryDanmakuModel`
  now uses Flutter's canonical `listEquals` for `admin` and `room`, so a file-local
  `_listEquals` clone no longer sits beside the history danmaku read model.
- Live guard-list Freezed shell is archived. `LiveGuardListModel`, `LiveGuardInfo`,
  `LiveGuardItem`, `LiveGuardUserInfo`, and `LiveGuardUserBase` remain in
  `live_guard_list_model.dart` as hand-written immutable values, preserving `uinfo`,
  `guard_level`, empty `top3` / `list` fallbacks, list equality, and JSON parsing
  without generated Freezed/JSON shell files. Unused `copyWith` and `toJson` helpers
  are archived too.
- Live guard-list integer scalar helper is archived. Required numeric guard-list fields
  now call `JsonUtils.parseInt` directly and throw `FormatException` for missing or
  invalid required values instead of keeping a private `_jsonInt` clone.
- Video subtitle Freezed shell is archived. `VideoSubtitles`, `SubtitleInfo`,
  `SubtitleContent`, and `SubtitleItem` remain in `subtitle.dart` as hand-written
  immutable values, preserving subtitle wire keys, nullable fields, empty list
  fallbacks, list equality, and JSON parsing without generated Freezed/JSON shell
  files. Unused subtitle read-model `copyWith` and `toJson` helpers are archived too.
- Video subtitle list equality helper is archived. `VideoSubtitles.list` and
  `SubtitleContent.body` now use Flutter's canonical `listEquals`, so a file-local
  `_listEquals` clone no longer sits beside the subtitle read models.
- Video subtitle integer scalar helper is archived. `SubtitleInfo.id` and
  `SubtitleItem.location` now use `JsonUtils.parseInt` directly and throw
  `FormatException` for invalid required integer values. `_jsonDouble` remains local
  until a shared double parser exists.
- Video play-url Freezed shell is archived. `PlayUrl`, `DashInfo`, `DashStream`, `Durl`,
  and `SupportFormat` remain in `play_url.dart` as hand-written immutable values,
  preserving Bilibili play-url wire keys, DASH `baseUrl`/`base_url` and
  `backupUrl`/`backup_url` compatibility, empty-list fallbacks, list equality, nullable
  `dash`, and JSON parsing without `play_url.freezed.dart` or `play_url.g.dart`.
  Unused play-url read-model `copyWith` and `toJson` helpers are archived too.
- Video play-url list equality helper is archived. The play-url model family now uses
  Flutter's canonical `listEquals` for read-only list fields, so a file-local
  `_listEquals` clone no longer sits beside the canonical play-url read models.
- Subtitle overlay Freezed shell is archived. `SubtitleState` remains beside
  `SubtitleController` in `subtitle_view_model.dart` as a hand-written immutable
  subtitle UI value, preserving list equality, selected subtitle, loading/enabled flags,
  and nullable error clearing without a generated Freezed file. The unused `copyWith`
  helper and nullable copy sentinel are archived; the controller emits explicit
  constructor updates for each state transition.
- Danmaku settings Freezed shell is archived. `DanmakuSettings` remains beside
  `DanmakuSettingsController` in `danmaku_settings_view_model.dart` as a hand-written
  immutable settings value, preserving opacity, font size, area, speed, visibility
  flags, and ai-mask enablement without `danmaku_settings_view_model.freezed.dart`.
- Danmaku option Freezed shell is archived. `DanmakuOption` remains in
  `danmaku_option.dart` as a hand-written immutable danmaku render value, preserving
  defaults, value equality, hash, and diagnostics without `danmaku_option.freezed.dart`.
  Its unused hand-written `copyWith` helper is archived as well; the overlay constructs
  the render option from `DanmakuSettings` rather than mutating an existing option.
- Article detail comment action wrapper is archived. `ArticleDetailCommentWorkflow` and
  `ArticleDetailViewModel` now return a named record for submitted/clear/unfocus/
  comments-disabled/error fields, so `ArticleDetailCommentActionResult` does not remain
  as a class wrapper.
- Article detail Freezed shell is archived. `ArticleDetailUiState` remains beside
  `ArticleDetailViewModel` in `article_detail_view_model.dart` as a hand-written
  immutable article/comment UI value, preserving nullable detail/error/comment cursor
  clearing, comment list equality, comment-enabled derivation, and send-comment state
  without `article_detail_view_model.freezed.dart`.
- Shared comment list Freezed shell is archived. `CommentListState` remains in
  `comment_list_state.dart` as a hand-written immutable value over
  `PagedListState<CommentItem>` and `CommentSort`, preserving the shared dynamic/video
  comment paging contract without `comment_list_state.freezed.dart`.
- Favorites folder-detail Freezed shell is archived. `FavFolderDetailState` remains
  beside `FavFolderResources` in `favorites_view_model.folder_resources.dart` as a
  hand-written immutable folder detail value, preserving nullable folder info and
  paged resource state copy/equality semantics without `favorites_view_model.freezed.dart`.
- Favorites folder/resource Freezed shells are archived. `FavoriteFolder`,
  `FavoriteResourceStats`, `FavoriteResource`, and `FavoriteResourcePage` remain as
  hand-written immutable domain values, preserving `fav_state`, `media_count`,
  `cnt_info`, `fav_time`, `bv_id`, `preferredBvid`, `isPrivate`, nullable clearing, list
  equality, and JSON parsing without `favorite_folder.freezed.dart`,
  `favorite_folder.g.dart`, `favorite_resource.freezed.dart`, or
  `favorite_resource.g.dart`.
- Favorites resource read-model copy helpers are archived. `FavoriteResourceStats`,
  `FavoriteResource`, and `FavoriteResourcePage` keep JSON parsing, `preferredBvid`,
  immutable media lists, equality, and diagnostics, but no longer carry unused `copyWith`
  methods. `FavoriteResourceStats` and `FavoriteResource` no longer carry unused `toJson`
  methods either. `FavoriteFolder.copyWith` remains active because folder cover
  normalization still mutates folder values in state.
- Favorites folder serialization helper is archived. `FavoriteFolder` still owns
  folder metadata parsing, `isPrivate`, equality, diagnostics, and the live cover
  normalization `copyWith` path used by collected-folders state, but its unused
  `toJson` helper is removed so the domain read model stays read-only on the write side.
- Notification chat Freezed shell is archived. `ChatState` remains beside `Chat` in
  `chat_view_model.dart` as a hand-written immutable chat value, preserving paging
  copy/equality and immutable emoji-map equality semantics without
  `chat_view_model.freezed.dart`. The local chat `_mapHash` helper is archived too;
  `emojiMap` uses `mapEquals` plus inline unordered hashing.
- Notification private-message Freezed/JSON shell is archived. `PrivateMessage` and
  `PrivateMessageEmoji` remain in `private_message.dart` / `private_message.types.dart`
  as hand-written immutable values, preserving message helper semantics, at-uid list
  equality, and `gif_url` JSON parsing without `private_message.freezed.dart` or
  `private_message.g.dart`. The unused `PrivateMessage.copyWith` and
  `PrivateMessageEmoji.copyWith` / `PrivateMessageEmoji.toJson` helpers are archived too.
- Notification private-message DTO Freezed/JSON shell is archived.
  `PrivateMessageSessionResponse`, `PrivateMessageSession`, `PrivateMessageDetail`, and
  `PrivateMessageListResponse` remain in `private_message_model.dart` as hand-written
  DTOs, preserving session/list wire keys, `account_info.pic_url`, `last_msg`,
  `at_uids`, `e_infos`, list/map equality, and DTO-local `contentMap` parsing without
  `private_message_model.freezed.dart` or `private_message_model.g.dart`. DTO-local
  `copyWith` helpers and unused response-shell `toJson` helpers are archived; nested
  session/detail serializers remain for cache round-trips.
- Notification reply DTO Freezed/JSON shell is archived. `ReplyResponse`,
  `ReplyCursor`, `ReplyItem`, and `ReplyItemDetail` remain in `reply_model.dart` as
  hand-written DTOs, preserving reply feed wire keys, inline `subject_id`/`item_id`
  fallback, nullable actor/time fields, list equality, and local cache serialization
  without `reply_model.freezed.dart` or `reply_model.g.dart`. DTO-local `copyWith`
  helpers and unused response-shell `toJson` helpers are archived; item/detail serializers
  remain for local feed cache round-trips.
- Notification entry Freezed/JSON shell is archived. `NotificationActor`,
  `NotificationEntryDetail`, and `NotificationEntry` remain in `notification_entry.dart`
  as hand-written immutable domain values, preserving `mid_link` JSON parsing,
  `NotificationActor` JSON output, actor/detail list equality, and `primaryActor`/`eventTime`
  behavior without `notification_entry.freezed.dart` or `notification_entry.g.dart`.
  Their unused `copyWith` helpers are archived too.
- Dynamic content entity Freezed shell is archived. `DynamicVideoContent`,
  `DynamicLinkCard`, `DynamicAdditional`, and `DynamicGoodsItem` remain in
  `dynamic_content_entities.dart` as hand-written immutable value objects, preserving
  nullable clearing, value equality, diagnostics, and read-only `goodsItems` list
  semantics without `dynamic_content_entities.freezed.dart`. Their unused hand-written
  `copyWith` helpers and nullable copy sentinel are archived too. `DynamicAdditional`
  goods-list equality now uses Flutter's canonical `listEquals`, so the file-local
  nullable `_listEquals` clone is archived too.
- Profile user Freezed shell is archived. `ProfileUser` remains in `profile_user.dart`
  as a hand-written immutable profile domain value, preserving defaults, nullable
  clearing, value equality, diagnostics, and follow-toggle copy semantics without
  `profile_user.freezed.dart`.
- Profile video Freezed shell is archived. `ProfileVideo` remains in `profile_video.dart`
  as a hand-written immutable user-space video value, preserving user-space JSON
  normalization, `stat`/`inter_video` wire keys, defaults, equality, and diagnostics
  without `profile_video.freezed.dart` or `profile_video.g.dart`.
  The unused `copyWith` and `toJson` helpers are archived too.
- Network endpoint policy Freezed shell is archived. `EndpointPolicy` remains in
  `endpoint_policy.dart` as a hand-written immutable network value, preserving request
  class, cache TTL, stale-cache behavior, retry attempts/status set, deduplication,
  unsafe-method retry, prefetch flags, nullable TTL clearing, and status-set equality
  without `endpoint_policy.freezed.dart`.
- Live gold-rank Freezed/JSON shell is archived. `LiveGoldRankModel`, `LiveRankItem`,
  and `LiveRankMedalInfo` remain in `live_gold_rank_model.dart` as hand-written
  immutable DTO values, preserving `onlineNum`, `OnlineRankItem`, medal info,
  `guard_level`, `wealth_level`, list equality, JSON parsing, and debug strings without
  `live_gold_rank_model.freezed.dart` or `live_gold_rank_model.g.dart`. Unused
  `copyWith` and `toJson` methods are archived too because no active flow mutates or
  serializes this read-only API value.
- Dynamic response core Freezed/JSON shell is partially archived for the low-risk feed
  root models. `DynamicData`, `DynamicItem`, `DynamicBasic`, `DynamicModules`,
  `ModuleAuthor`, and `ModuleDynamic` remain in `dynamic_response.core.dart` as
  hand-written immutable values, preserving feed offset/update fields, nested
  item/orig/basic/module parsing, nullable fields, author/module wire keys, list
  equality, diagnostics, and JSON parsing. Unused hand-written `copyWith` helpers
  are archived for `DynamicData`, `DynamicBasic`, `ModuleAuthor`, and
  `ModuleDynamic`, and unused hand-written `toJson` helpers are archived for all
  core dynamic response read models. The file-local `_listEquals` and
  `_nullableListEquals` clones are archived too; dynamic response list equality now uses
  Flutter's canonical `listEquals` across the part library. `DynamicItem.copyWith` and
  `DynamicModules.copyWith` remain because dynamic like updates still call them.
  `dynamic_response.freezed.dart` and `dynamic_response.g.dart` remain active for the
  major dynamic response parts, but no longer contain generated implementations or
  copy-with helpers for these core models.
- Dynamic response additional Freezed/JSON shell is archived for the low-risk additional
  module models. `ModuleAdditional`, `AdditionalCommon`, `AdditionalReserve`,
  `ReserveDesc`, `AdditionalGoods`, `GoodsItem`, `AdditionalVote`, and `AdditionalUgc`
  remain in `dynamic_response.additional.dart` as hand-written immutable values,
  preserving additional-module wire keys, nullable fields, reserve/goods/vote/UGC
  parsing, and goods list equality. Unused hand-written `copyWith` and `toJson`
  helpers for these additional read models are archived too.
  `dynamic_response.freezed.dart` and `dynamic_response.g.dart` no longer contain
  generated implementations or copy-with helpers for these additional models.
- Dynamic response major secondary Freezed/JSON shell is archived for the low-risk
  PGC/course/music/opus/live branch models. `MajorPgc`, `MajorCourses`, `MajorMusic`,
  `MajorOpus`, `OpusSummary`, `OpusPic`, `MajorLive`, and `MajorLiveRcmd` remain in
  `dynamic_response.major_secondary.dart` as hand-written immutable values, preserving
  PGC/course/music/opus/live wire keys, nested stat/summary/pic parsing, nullable list
  fields/lists, and list equality. Unused hand-written `copyWith` and `toJson` helpers
  for these major secondary read models are archived too.
  `dynamic_response.freezed.dart` and `dynamic_response.g.dart` no longer contain
  generated implementations or copy-with helpers for these major secondary models.
- Dynamic response major primary Freezed/JSON shell is archived for the low-risk
  desc/major/stat/topic models. `ModuleDesc`, `ModuleMajor`, `MajorArchive`,
  `MajorDraw`, `DrawItem`, `MajorArticle`, `MajorCommon`, `MajorStat`, `ModuleStat`,
  `StatLike`, `StatCommon`, and `ModuleTopic` remain in
  `dynamic_response.major_primary.dart` as hand-written immutable values, preserving
  desc/major/stat/topic wire keys, nested branch parsing, nullable branch semantics,
  and list equality. Unused hand-written `copyWith` helpers for the primary read models
  are archived except for the live `ModuleStat.copyWith` and `StatLike.copyWith`
  dynamic like-update path, and unused hand-written `toJson` helpers are archived for
  all primary read models. The full
  `dynamic_response` family no longer imports `freezed_annotation` or keeps
  `dynamic_response.freezed.dart` / `dynamic_response.g.dart`.
- Comment contract nested content/media Freezed/JSON shell is archived for the low-risk
  leaf values. `CommentLabel`, `CommentContent`, `CommentPicture`, and `CommentEmote`
  remain in `comment_contract.types.dart` as hand-written immutable values, preserving
  label/content/picture/emote wire keys, default values, nullable `emote` parsing,
  list/map immutability and equality, and JSON parsing. Their unused hand-written
  `copyWith` and `toJson` helpers are archived; `comment_contract.freezed.dart` and
  `comment_contract.g.dart` remain active for the
  higher-risk main comment response/member contract, but no longer contain generated
  implementations, pattern helpers, copy-with helpers, or JSON helpers for these four
  leaf values.
- Article inline node Freezed shell is archived for the low/medium-risk article text
  leaf. `ArticleInlineNode` remains in `article_detail_data.dart` as a hand-written
  immutable value, preserving text/link/color/font-size/bold/italic fields, nullable
  clearing, value equality, copy semantics, and diagnostics. `article_detail_data.freezed.dart`
  remains active for the higher-risk article detail and block union, but no longer
  contains generated implementation, pattern helper, or copy-with helper shells for
  `ArticleInlineNode`.
- Article block Freezed union shell is archived for the medium-risk article render
  units. `ArticleBlock`, `ArticleBlockParagraph`, `ArticleBlockImage`,
  `ArticleBlockLinkCard`, `ArticleBlockQuote`, and `ArticleBlockDivider` remain in
  `article_detail_data.dart` as hand-written immutable values, preserving the existing
  factory constructors, Dart pattern matching subtype names, nullable fields,
  list immutability/equality, and diagnostics. Their unused hand-written `copyWith`
  helpers are archived; `ArticleInlineNode.copyWith` remains active for tokenizer
  inline-style layering. `article_detail_data.freezed.dart` remains active for the
  higher-risk article detail/stat shells, but no longer contains generated block
  variants.
- Article detail quote block wrapper is archived. `ArticleDetailPageScaffold` now renders
  `ArticleBlockQuote` inline in the block switch, so `_QuoteBlockView` does not remain
  as a one-use private wrapper beside the article-detail renderer.
- Article detail image/link-card block wrappers are archived. `ArticleDetailPageScaffold`
  now renders `ArticleBlockImage` and `ArticleBlockLinkCard` inline in the same block
  switch, preserving preview taps, captions, link navigation, icon/chevron chrome,
  spacing, and surfaces without keeping `article_detail_page_block_renderers.cards.dart`,
  `_ImageBlockView`, or `_LinkCardView` as one-use private wrappers.
- Article parser integer scalar helper is archived. `ArticleDetailParser` and its parser
  part now call `JsonUtils.parseInt` directly for article/opuses ids, timestamps, stats,
  paragraph types, link types, and inline node types instead of carrying a private
  `_int` helper in `article_detail_parser.mapper.dart`. The private `_asMap` helper is
  deliberately not folded into `JsonUtils` in this slice because GitNexus reports HIGH
  upstream risk across article parsing, perf, and data modules. The one-use
  `_parseInitialState` JSON decode helper is archived; `extractInitialState` owns the
  decode and map-shape normalization inline.
- Video list skeleton thumbnail/content helpers are archived. `VideoListSkeleton.build`
  owns the thumbnail shimmer wrapper and fixed content column directly, preserving
  `thumbnailWidth`, `aspectRatio`, `AppShimmerBox` border radius, `Expanded`, title
  shimmer sizes, `Spacer`, and footer shimmer without one-call `_buildThumbnail` or
  `_buildContent` methods.
- Video card skeleton content helper is archived. `VideoCardSkeleton.build` owns the
  fixed `Expanded` content column directly, preserving padding, title shimmer sizes,
  `Spacer`, and footer shimmer without `_buildContent`.
- App clickable handler helpers are archived. `AppClickable.build` owns the nullable
  tap and long-press callbacks directly, preserving disabled null handlers, tap
  `lightImpact`, long-press `mediumImpact`, callback dispatch, and `Semantics.enabled`
  without `_buildTapHandler` or `_buildLongPressHandler`.
- App tab bar decoration and indicator helpers are archived. `AppTabBar.build` owns the
  44px surface container, bottom outline border, scroll alignment, label styling, and
  primary underline indicator directly without `_buildDecoration` or `_buildIndicator`.
- Article paragraph text-normalization helper is archived. `_ParagraphBlockViewState.build`
  owns the three-or-more-newline collapse directly beside linked/plain `TextSpan`
  creation, preserving the exact `\n{3,}` to `\n\n` behavior without
  `_normalizeBlockText`.
- Article detail stat chip wrapper is archived. `_StatsRow.build` owns both favorite and
  like icon-text cells directly, preserving expanded cells, vertical padding, centered
  rows, icon size/color, 6px spacing, and `titleSmall`/`w600` text styling without
  `_StatChip`.
- Settings about-page action tile wrapper is archived. `AboutPage.build` owns the GitHub
  and license `Material`/`InkWell` rows directly, preserving radius, padding, icon
  container chrome, title/subtitle typography, chevron, external GitHub launch, and
  license-page callback without `_ActionTile`.
- App search bar icon helper is archived. `AppSearchBar` now keeps the static
  `Icons.search_rounded` construction inline in the editable and read-only branches,
  preserving size and color without a private `_buildSearchIcon` wrapper. Decoration and
  text-style helpers remain because both branches share that styling policy.
- App search bar read-only helper is archived. `AppSearchBar.build` owns the
  `controller == null` branch directly as a clipped `AppClickable` prompt, preserving
  height, shared decoration, hint ellipsis, and disabled `onTap == null` behavior
  without `_buildReadonlySearchBar`.
- App search bar text-style helper is archived. `_buildEditableSearchBar` owns the
  editable `TextField` style inline, preserving `bodyMedium`, font size 15, and
  `ColorScheme.onSurface` without a one-call `_buildTextStyle` method.
- Ranking loading skeleton wrapper is archived. The loading `ListView` owns the fixed
  88px shimmer row directly, preserving the thumbnail/text skeleton primitives while
  removing the one-use `_RankingSkeletonItem`, `_RankingSkeletonThumbnail`, and
  `_RankingSkeletonText` wrappers.
- App network image loading-placeholder helper is archived. `AppNetworkImage.build`
  owns the loading fallback after custom `placeholder` priority, preserving
  `width`/`height`, `_buildDecoration(colorScheme)`, border radius, and optional
  `AppShimmer` without `_buildLoadingPlaceholder`.
- Relation privacy error wrapper is archived. `RelationUserList.errorBuilder` owns the
  only `AppError.code == 22115` branch directly, preserving the centered lock icon,
  translated privacy title/message, bold title, and surface/on-surface-variant colors
  without a one-use `_RelationPrivacyError` widget.
- Video list-card overlay getter is archived. `_VideoListCardMedia.build` now keeps the
  nullable `overlay` branch inline inside the media stack, preserving the optional
  overlay position while removing the one-use `_overlayChildren` list getter.
- Video card reason-tag wrapper is archived. `_VideoCardThumbnail.build` now owns the
  only recommendation reason overlay directly, preserving the `reason` non-empty guard,
  top-right position, semantic overlay background/border/foreground colors, padding,
  radius, and 10px medium text without `_VideoReasonTag`.
- Video card title/description/footer wrappers are archived. `_VideoCardContent.build`
  now owns the title text, optional description text, and optional author row directly,
  preserving max-lines, ellipsis overflow, typography, surface colors, spacing, and the
  trailing more icon without `_VideoCardTitle`, `_VideoCardDescription`, or
  `_VideoCardFooter`.
- Video thumbnail bottom-overlay wrapper is archived. `VideoThumbnail.build` now owns
  the single bottom scrim layer directly, preserving left/right/bottom positioning,
  48px height, bottom border radius, top-to-bottom transparent-to-scrim gradient, and
  stats/duration overlay order without `_ThumbnailBottomOverlay`.
- Video thumbnail stats-row wrapper is archived. `VideoThumbnail.build` now owns the
  optional view/danmaku counter row directly, preserving bottom-left positioning,
  row min sizing, view/danmaku null branches, 8px inter-counter spacing, formatted
  numbers, and overlay text style without `_VideoThumbnailStats`.
- Video thumbnail cache-size helper is archived. `VideoThumbnail.build` now owns
  explicit `memCacheWidth`/`memCacheHeight` priority, finite layout constraint checks,
  pixel-ratio multiplication, `toInt()` conversion, and null fallbacks inline without
  `_resolveCacheSize`.
