# Culcul App Architecture Refactor Plan

Date: 2026-05-24
Tracking issue: `culcul-jix`
Continuation issue: `culcul-bea`

## Phase 1: Stabilize Boundaries

Goal: make the current broad refactor inspectable and prevent old route-entry patterns
from returning.

- [x] Write architecture specs and archive the initial audit.
- [x] Restore `tool/architecture/run_architecture_guards.sh`.
- [x] Archive `features/*/route_entry.dart` by inlining thin route builders or moving
  behaviorful navigation to `navigation.dart`.
- [x] Move reusable route-entry actions out of router-facing entrypoints.
- [x] Archive unused app-router transition wrappers that no active route constructs,
  and inline the one-use login fade transition beside `LoginRoute.buildPage`.
- [x] Delete empty directories left by moved view models.
- [x] Strengthen guards for archived route entries and empty presentation state folders.
- [x] Restore missing CI validation entrypoints and remove stale README validation paths.
- [x] Untrack generated Android/iOS build artifacts.
- [x] Run architecture guard, formatter, analyzer, `git diff --check`, and GitNexus
  change detection.
- [x] Archive legacy root-level architecture drafts so the active architecture specs and
  plan live only under `docs/architecture`.

## Phase 2: State Ownership Cleanup

Goal: make Riverpod state the feature state source of truth.

- Move active non-widget state from `presentation/view_models` to
  `features/<feature>/state` in feature-sized batches.
- Completed home state move: reusable `HomeFeedPagingMixin` lives in
  `lib/features/home/state`; single-widget popular/recommend feed state is owned
  privately by its matching feed widget.
- Completed home tab sync provider cleanup: `HomeTabSyncState`,
  `HomeTabSyncController`, and `homeTabSyncControllerProvider` were folded into
  `use_home_scroll_sync.dart` as a private hook-local event provider. `HomePage` now
  sends tab taps through `notifyHomeTabTapped`, preserving the current-tab retap
  scroll-to-top/refresh behavior and the `indexIsChanging` guard without keeping a
  public state file.
- Completed search result state move: result paging state was moved out of
  `presentation/view_models`; it is now private to `SearchResultView` because the result
  view is the only active consumer of the provider.
- Completed first profile state move: `myProfile`, `Followings`, `Followers`, and
  `UserSpaceNotifier` now live in `lib/features/profile/state`.
- Keep page-local hooks only for widget lifecycle, controllers, scroll coordination, and
  focus/input details.
- Merge state classes that only mirror repository results.
- Delete generated files for removed providers and regenerate with build_runner.
- Use `dart run build_runner build`; the old `--delete-conflicting-outputs` flag is
  ignored by the current build_runner version.
- Prioritize low-risk features first: `ranking`, `favorites`, `home`, `search`.
- Treat `video`, `live`, and `notification` as higher-risk and run GitNexus impact before
  each controller move.
- Completed notification state move: chat, feed, lifecycle sync, private-session, and
  chat-send state now live in `lib/features/notification/state`. System-notice and
  unread-count page-local stream state were later folded into `SystemNotificationPage`
  and `NotificationPage` after impact analysis confirmed they had no second active
  consumer.

## Phase 3: Data And Model Consolidation

Goal: keep one canonical representation for each business concept.

- Keep Retrofit API interfaces and API DTOs in `data`.
- Collapse one-call private repository wrappers that only forward to `RequestExecutor`.
- Remove nullable API/test constructor seams when no tests or production override use
  them.
- Compare DTO/entity/UI-state pairs feature by feature and keep only the layers that
  encode distinct semantics.
- Completed trivial video list response consolidation: ranking popular, home popular,
  and home weekly APIs now share `VideoModel` list parsing instead of separate
  per-feature response shells.
- Completed home/ranking port cleanup: removed one-line port providers and unused
  interfaces; state now reads repository providers directly.
- Completed next low-risk port cleanup: removed `ToViewPort`, `SearchPort`,
  `FavoritesPort`, `AuthQrLoginPort`, video ports, and profile read/cache/user-space
  ports plus their one-line providers; callers now read concrete repository providers
  directly while keeping behaviorful workflow providers.
- Completed notification chat/system-notice port cleanup: removed
  `NotificationChatPort`, `notificationChatPortProvider`, `NotificationSystemNoticePort`,
  and `notificationSystemNoticePortProvider`; chat and system-notice state now read
  `notificationRepositoryProvider` directly.
- Completed remaining notification port cleanup: removed `NotificationFeedPort`,
  `notificationFeedPortProvider`, `NotificationPrivateSessionPort`,
  `notificationPrivateSessionPortProvider`, `NotificationUnreadCountPort`, and
  `notificationUnreadCountPortProvider`. Feed, private-session, unread-count, and resume
  sync paths now share `notificationRepositoryProvider`.
- Completed notification resume-sync port cleanup: removed `NotificationResumeSyncPort`
  and renamed its provider to the concrete `notificationResumeSyncServiceProvider` while
  keeping the behaviorful concurrent resume sync service.
- Completed notification resume-sync service cleanup: `NotificationLifecycleSync` now
  owns the concurrent resume sync policy directly, reading
  `notificationRepositoryProvider` for unread, sessions, and feed-head sync; the
  one-caller `NotificationResumeSyncService` provider file and generated provider output
  are archived.
- Completed notification owner-uid provider cleanup: the notification state files now
  read `currentUserProvider` directly and parse the owner uid locally, so
  `notification_owner_uid_application_providers.dart` and its generated provider output
  do not remain as a thin session wrapper.
- Completed notification stream watcher wrapper cleanup: unread-count and system-notice
  local stream queries now live directly on `NotificationRepositoryImpl`, removing the
  one-owner `NotificationStreamWatchers` delegate and
  `notification_repository_impl.stream_watchers.dart`.
- Completed notification local read-store wrapper cleanup: local unread, session,
  message, emoji-map, and feed paging queries now live directly on
  `NotificationRepositoryImpl`, removing the one-owner `NotificationLocalReadStore`
  delegate and `notification_repository_impl.local_read_store.dart`.
- Completed notification local unread snapshot cleanup: removed the unused
  `getUnreadCountFromLocal` repository API after confirming active unread state uses the
  stream watcher plus sync path and no current caller reads a one-shot local summary.
- Completed notification local database connection helper cleanup:
  `NotificationLocalDatabase` owns the default `driftDatabase` name/options inline in its
  constructor, so the one-line `_openConnection` helper is archived.
- Completed notification message-send service cleanup: `NotificationRepositoryImpl` now
  owns image upload, local pending/outbox writes, send-result mapping, and message-head
  sync after successful sends directly. The one-owner `NotificationMessageSendService`
  delegate, `notification_repository_impl.message_send_service.dart`, and the old
  `SyncMessagesHeadFn` callback alias are archived.
- Completed notification send/upload mapper helper cleanup: `uploadImage` now maps
  directly through the canonical `UploadedImage.fromJson`, and `sendPrivateMessage`
  owns its small `SendMessageResult` JSON normalization locally. `SendMessageResult`
  itself is now a hand-written immutable value, so `send_message_result.freezed.dart`
  is archived and the unused `copyWith` helper stays removed. The mapper-level
  `sendMessageResultFromJson`, `uploadedImageFromJson`, and `_readNullableString`
  helpers are archived.
- Completed notification send-result nullable-string helper cleanup:
  `sendPrivateMessage` now keeps `msg_content` null/empty-string normalization inline
  with the local `SendMessageResult` projection, so the one-use `readNullableString`
  nested helper is archived.
- Completed notification send-result equality helper cleanup: `SendMessageResult` is now
  a lightweight send response holder with immutable `keyHitInfos`; the unused deep
  equality/hash helpers and value overrides are archived because current send flows read
  the parsed fields and do not compare result instances.
- Completed dynamic port cleanup: removed detail, comment, feed, user-dynamic,
  article-detail, emote, and publish-dynamic port/provider aliases. Behaviorful dynamic
  workflows remain; upload-image metadata now uses the shared `UploadedImage`
  contract.
- Completed dynamic publish workflow cleanup: publish orchestration for csrf
  resolution, image upload, publish submission, and feed invalidation was removed from
  the one-consumer `PublishDynamicWorkflow`; `PublishDynamicWorkflow`,
  `publishDynamicWorkflowProvider`, and `dynamic_workflows.dart` are archived.
- Completed dynamic publish page-state cleanup: `PublishDynamicUiState`,
  `PublishDynamicViewModel`, and `publishDynamicViewModelProvider` were folded into
  `PublishDynamicPage` as private `_PublishDynamicController` /
  `_publishDynamicControllerProvider`, replacing the one-field Freezed state shell with
  a private bool notifier while preserving the publish guard, csrf resolution, image
  upload, publish submission, dynamic feed invalidation, and page pop/feedback behavior.
- Completed dynamic detail page-state cleanup: `DynamicDetailUiState`,
  `DynamicDetailViewModel`, and `dynamicDetailViewModelProvider` were folded into
  `DynamicDetailPage` as private `_DynamicDetailController` / `_dynamicDetailProvider`,
  preserving initial microtask load, refresh, optimistic like update, and rollback.
- Completed dynamic detail response-shell cleanup: `DynamicApi.getDynamicDetail` now
  exposes raw response data and `DynamicRepositoryImpl.getDetail` parses `data.item`
  directly into the canonical `DynamicItem`; `DynamicDetailData` is archived.
- Completed dynamic detail parser helper cleanup: `getDetail` now keeps the `data.item`
  unwrap and `DynamicItem.fromJson` mapping inline, so `_parseDynamicDetailItem` is
  archived and guarded.
- Completed dynamic emote provider cleanup: removed `emotePackagesProvider`; the only
  publish emoji picker now loads through `emoteRepositoryProvider` locally and the retry
  UI reaches the real repository failure path.
- Completed profile user-space provider cleanup: removed `userStickyVideoProvider` and
  `userMasterpiecesProvider`; their only consumers now load through
  `profileRepositoryProvider` locally while preserving hidden-on-empty/error rendering.
- Completed search hot-ranking response-shell cleanup: `SearchRepositoryImpl` now parses
  the transport `list` envelope directly to the hand-written `SearchTrendingItem`,
  removing the `TrendingRankingResponse`/`TrendingRankingData` shell and duplicate
  `TrendingItem` DTO. Unused `SearchTrendingItem.copyWith` and `toJson` helpers are
  archived too.
- Completed search hot-ranking silent-refresh equality cleanup:
  `TrendingRanking._refreshSilently` now uses Flutter's `listEquals` over the
  canonical `SearchTrendingItem` value equality instead of the one-use
  `_sameTrendingItems` loop.
- Completed search default response-shell cleanup: `SearchRepositoryImpl` reads the
  default-search `show_name` field from the API data map directly, removing the one-value
  `DefaultSearchData` DTO.
- Completed search one-use mapper cleanup: default-search conversion and suggestion JSONP
  parsing now live at the only repository callsites; `_parseDefaultSearchName` and
  `_parseSuggestionText` stay archived while the non-trivial search-result mapper remains as
  the data-to-application normalization boundary. Hot-ranking `list` parsing now also
  stays inline with `getTrendingRanking` instead of a separate `_parseTrendingRankingItems`
  repository mapper, and the one-use `_parseSuggestionsResponse` helper is archived too.
- Completed search suggestion DTO cleanup: `SearchRepositoryImpl` now parses
  `result.tag[].value`/`term` directly into `List<String>`, removing the one-use
  `SearchSuggestionResponse`, `SearchSuggestionTag`, `SearchSuggestionTagsConverter`,
  and private `_parseSuggestionText` helper.
- Completed search result outer response-shell cleanup: search result API methods now
  return shared `ApiResponse<SearchResultData>`, removing the duplicate
  `SearchResultResponse` envelope while keeping the polymorphic result DTO parser.
- Completed search DTO field slimming: removed unused search result metadata, one-use
  suggestion result wrapper metadata, and unused hot-ranking metadata while keeping
  app-facing models unchanged.
- Completed to-view DTO consolidation: `ToViewEntry` now owns watch-later item JSON
  decoding, removing `ToViewListResponseDto`, `ToViewModelDto`, and the copy-only
  `_ToViewModelMapper` chain while preserving the API `No Data` empty-list fallback.
  `ToViewRepositoryImpl.getList` now owns the transport `list` envelope parse inline, so
  `_parseToViewEntries` is archived as a one-use repository helper.
- Completed shell navigation item cleanup: the four app-shell destinations now live as
  private records in `main_shell.dart`, removing the public `NavigationItem` and
  `NavigationItems` wrapper file while asserting label/item length alignment.
- Completed shell layout wrapper cleanup: `MainShell.build` now directly owns the desktop
  `NavigationRail` and mobile `BottomNavigationBar` branches, removing the one-owner
  public `AdaptiveShellScaffold` wrapper while preserving label/item length assertion and
  navigation behavior.
- Completed selectable text wrapper cleanup: deleted `AppSelectableText` and replaced
  its three call sites with direct `SelectableText.rich`, preserving the old
  `NeverScrollableScrollPhysics` behavior explicitly at each owner.
- Completed JSON object-list normalization cleanup: home feed and search result DTO
  converters now use `JsonUtils` string-key map helpers instead of duplicating
  `Map<String, dynamic>.from` list conversion loops.
- Completed relation service scalar-reader cleanup: relation user parsing now uses
  `JsonUtils.parseIntWithDefault`/`parseStringWithDefault`, and `JsonUtils.parseInt`
  handles numeric API values without keeping a duplicate relation-local `_readInt`.
- Completed relation service map-reader cleanup: relation user nested map parsing now
  calls `JsonUtils.asStringKeyedMap` directly instead of keeping a duplicate `_asMap`.
- Completed relation service item-parser helper cleanup: `_parseRelationUsers` now owns
  each `ProfileRelationUser` projection inline after item map normalization, so
  `_parseRelationUser` is archived and guarded.
- Completed relation service list-parser helper cleanup: `_getRelationUsers` now owns the
  `list` unwrap and relation-user projection inline at the request-executor transform
  boundary, so `_parseRelationUsers` is archived and guarded.
- Completed relation API response helper cleanup: `_getRelationUsers` now owns the
  follow-list GET response decode inline, and `modifyRelation` owns the follow/unfollow
  POST response decode inline, so `_getApiResponse` and `_postApiResponse` are archived
  as one-call transport wrappers.
- Completed auth cached-user helper cleanup: `level_info` parsing now uses
  `JsonUtils.asStringKeyedMap` and `JsonUtils.parseInt`, so the auth cache boundary no
  longer keeps private `_asMapOrNull`/`_asIntOrNull` clones.
- Completed auth repository helper part cleanup: `getCachedUser`, `clearCache`,
  `isLoggedIn`, `_loadCurrentUser`, and the user cache JSON helpers now live directly
  on/with `AuthRepositoryImpl`; `auth_repository_impl.helpers.dart` and
  `_AuthRepositoryHelpersMixin` are archived while `auth_repository_impl.flows.dart`
  remains as the behaviorful login-flow split.
- Completed auth current-user cache write helper cleanup: `_loadCurrentUser` now owns the
  only successful current-user cache write inline, so `_cacheUser` is archived as a
  one-call repository helper while preserving the existing cache key and JSON shape.
- Completed auth cached-user JSON write helper cleanup: `_loadCurrentUser` now owns the
  successful current-user cache JSON shape inline, so `_userEntityToJson` is archived as
  a one-call repository helper.
- Completed auth repository crypto part cleanup: password-login PEM/RSA helpers now live
  beside their only caller in `auth_repository_impl.flows.dart`; the one-owner
  `auth_repository_impl.crypto.dart` part file is archived.
- Completed auth session cookie refresher adapter cleanup: the runtime override factory
  in `auth_session_providers.dart` now owns the private `SessionCookieRefresher`
  implementation directly, so `auth_session_cookie_refresher.dart` and its public
  single-method adapter are archived.
- Completed auth QR login page-state cleanup: `AuthQrLoginStatus`,
  `AuthQrLoginState`, `AuthQrLoginController`, and `authQrLoginControllerProvider`
  were folded into `QrLoginView` as private `_AuthQrLoginStatus`,
  `_AuthQrLoginState`, `_AuthQrLoginController`, and
  `_authQrLoginControllerProvider`, preserving QR URL loading, three-second polling,
  status-code mapping, expired/success timer cancellation, retry refresh, and
  post-success `authProvider` user refresh. The private controller now keeps polling
  setup and status updates inline in `refresh`, so one-use `_startPolling` and
  `_updateStatus` methods stay archived.
- Completed auth Geetest hook result cleanup: `useGeetest` now returns a Dart record for
  the captcha start callback and loading flag, so `UseGeetestResult` no longer exists as
  a public two-field presentation wrapper shared by password and SMS login widgets.
- Completed auth QR poll result cleanup: `AuthQrPollResult` now stays as a hand-written
  immutable value beside the QR login repository flow, so `auth_qr_poll_result.freezed.dart`
  is archived and the unused `copyWith` helper stays removed.
- Completed auth QR code cleanup: `AuthQrCode` now stays as a hand-written
  immutable value for the QR URL/key returned by the login repository flow, so
  `auth_qr_code.freezed.dart` is archived and the unused `copyWith` helper stays
  removed.
- Completed auth country code cleanup: `CountryCode` now stays as a hand-written
  immutable value for country-list parsing, default SMS country selection, and
  country-picker navigation, so `country_code.freezed.dart` is archived and the
  unused `copyWith` helper stays removed.
- Completed auth cached-user cleanup: `UserEntity` now stays as a hand-written
  immutable value for current-user loading, cache serialization, and
  `AuthState.user`, so `user_entity.freezed.dart` is archived and the unused
  `copyWith` helper stays removed.
- Completed auth controller state Freezed shell cleanup: `AuthState` now stays as a
  hand-written immutable value beside `Auth` in `auth_controller.dart`, preserving
  login/loading/user/error defaults, nullable clearing, equality, hash, diagnostics, and
  controller `copyWith` behavior without `auth_controller.freezed.dart`.
- Completed auth captcha challenge Freezed shell cleanup: `AuthCaptchaChallenge` now
  stays as a hand-written immutable value in `auth_captcha_challenge.dart`, preserving
  token/gt/challenge transport, equality, hash, and diagnostics without
  `auth_captcha_challenge.freezed.dart`; the unused `copyWith` helper stays removed.
- Completed ranking category feed provider cleanup: `RankingPage` now owns the private
  `FutureProvider.autoDispose.family` for category ranking items, so
  `category_ranking_view_model.dart` and its generated provider wrapper are archived.
- Completed relation service port cleanup: cross-feature relation callers now read the
  concrete `relationServiceProvider`, removing the no-alternate-implementation
  `RelationPort` interface and generated `relationPortProvider` wrapper.
- Completed notification like response-wrapper cleanup: the like endpoint now exposes
  raw response data to `NotificationFeedSync`, which normalizes `total.cursor/items`
  directly into `ReplyResponse` without `LikeResponse`, `LikeLatest`, or `LikeTotal`
  wrappers; the unconsumed `latest.last_view_at` field is no longer mirrored.
- Completed notification like parser helper cleanup: `_fetchReplyLikeAtResponse` now
  keeps the like endpoint `total.cursor/items` normalization inline, so the one-use
  `_parseLikeResponse` helper is archived and guarded.
- Completed notification reply item metadata cleanup: `ReplyItem` no longer mirrors the
  unused `counts` and `is_multi` metadata fields because current feed/domain behavior only
  consumes actors, detail, and reply/like timestamps.
- Completed profile optional response parser cleanup: relation stats, like count, and
  video count now share one optional response data-map gate, and their scalar fields call
  `JsonUtils.parseIntWithDefault` directly while preserving the zero fallback for failed
  optional enrichment calls. The private `_readOptionalInt` helper is archived.
- Completed profile optional fallback helper cleanup: non-critical profile enrichment
  `ConcurrentTask` definitions now keep their `(_) => null` fallbacks inline, so the
  private `_ignoreOptionalProfileResponse` pass-through helper is archived.
- Completed profile relation-stats parser helper cleanup: `getProfile` now keeps the
  optional relation follower/following parse inline after the shared response data-map
  gate, so `_parseRelationStats` is archived and guarded.
- Completed profile official verification helper cleanup: `getProfile` now normalizes
  `official` with `JsonUtils.asStringKeyedMap` and parses `role` inline beside the
  other profile scalars, so `_isVerified` is archived and guarded.
- Completed profile banner helper cleanup: `getProfile` now owns `top_photo` fallback,
  optional card response map normalization, and `space.l_img`/`space.s_img` precedence
  inline beside the other profile payload projection, so `_resolveBanner` is archived
  and guarded.
- Completed profile repository flow part cleanup: profile video list, sticky video, and
  masterpiece fetch methods now live directly on `ProfileRepositoryImpl`, while
  user-space video parsing lives on the repository owner;
  `profile_repository_impl.flows.dart` and `_ProfileRepositoryImplFlowsMixin` are
  archived.
- Completed profile repository parser part cleanup: user card, profile enrichment,
  banner, and user-space video parsers now live directly on `ProfileRepositoryImpl`, so
  `profile_repository_impl.parsers.dart` and `_ProfileRepositoryParsers` are archived.
  The remaining one-use `_parseUserCard` helper is archived and guarded; `getUserCard`
  owns its card map normalization inline.
- Completed search page-size constants cleanup: `SearchApi` now owns its private result
  page-size default directly, and `search_paging_constants.dart` is archived.
- Completed search cache-presence helper cleanup: `DefaultSearch` and `TrendingRanking`
  share the file-private `_hasApiCacheValue` helper instead of keeping duplicate
  `_hasCachedValue` methods with the same `api_cache_` key rule.
- Completed video danmaku provider-wrapper cleanup: the overlay playback scheduler now
  reads `danmakuRepositoryProvider` directly and maps `DanmakuSegment.entries` at the
  only consumer, removing `DanmakuProvider` and its generated provider shell.
- Completed video danmaku mask-path helper cleanup: the playback scheduler now owns the
  AI-mask `AsyncValue`/`Result` unwrap inline beside the mask refresh bucket cache, so
  `_resolveMaskPath` does not remain as a one-call resolver.
- Completed video danmaku segment-entry mapper helper cleanup: the playback scheduler
  now owns `DanmakuEntry` color/type mapping inline beside `DanmakuItem` construction,
  so `_toOpaqueDanmakuColor` and `_toDanmakuItemType` do not remain as one-call helpers.
- Completed video danmaku option Freezed shell cleanup: `DanmakuOption` now remains as a
  hand-written immutable value in `danmaku_option.dart`, preserving defaults, equality,
  hash, and diagnostics without `danmaku_option.freezed.dart`. The unused hand-written
  `copyWith` helper is archived too; the overlay builds a fresh option from
  `DanmakuSettings` inline instead of mutating the render value or keeping
  `_buildDanmakuOption` as a one-call constructor wrapper.
- Completed video danmaku Freezed shell cleanup: `DanmakuEntry` and `DanmakuSegment`
  now remain as hand-written immutable values in `danmaku.dart`, preserving read-only
  segment entries, equality, hash, and diagnostics without `danmaku.freezed.dart`.
  Their unused `copyWith` helpers are archived too.
- Completed playback snapshot Freezed shell cleanup: `PlaybackSnapshot` now remains as a
  hand-written immutable value in `playback_snapshot_view_model.dart`, preserving
  zero-duration defaults, `copyWith`, equality, hash, and diagnostics without
  `playback_snapshot_view_model.freezed.dart`.
- Completed playback snapshot quantizer facade cleanup: `playbackSnapshot` now owns
  position `250ms` and buffer `500ms` floor quantization inline before snapshot equality
  suppression, so `_PlaybackSnapshotQuantizer` does not remain as a static-only facade.
- Completed audio playback snapshot Freezed shell cleanup: `AudioPlaybackSnapshot` now
  remains as a hand-written immutable value beside `AudioPlaybackStateGate`, preserving
  playback-state equality, hash, and diagnostics without
  `audio_playback_state_gate.freezed.dart`. The unused `copyWith` helper is archived too.
- Completed audio playback state-gate timing cleanup: `AudioPlaybackStateGate` keeps its
  single 250ms quantization/throttle policy private and no longer exposes unused
  `positionStep` or `minEmitInterval` constructor defaults.
- Completed dynamic content entity Freezed shell cleanup: `DynamicVideoContent`,
  `DynamicLinkCard`, `DynamicAdditional`, and `DynamicGoodsItem` now remain as
  hand-written immutable value objects in `dynamic_content_entities.dart`, preserving
  nullable clearing, value equality, diagnostics, and read-only `goodsItems` list
  semantics without `dynamic_content_entities.freezed.dart`. Their unused hand-written
  `copyWith` helpers are archived too.
- Completed dynamic content list-equality helper cleanup: `DynamicAdditional.goodsItems`
  now uses Flutter's canonical `listEquals`, so the file-local nullable `_listEquals`
  clone is archived with the dynamic content entity file.
- Completed profile user Freezed shell cleanup: `ProfileUser` now remains as a
  hand-written immutable value in `profile_user.dart`, preserving profile defaults,
  nullable clearing, equality, hash, diagnostics, and follow-toggle `copyWith` behavior
  without `profile_user.freezed.dart`.
- Completed video danmaku item transport cleanup: `DanmakuItem` and `DanmakuItemType`
  now live beside `DanmakuController`, the API that accepts item batches, preserving
  text/color/time/type transport, mode mapping, opaque RGB conversion, and default white
  scroll items without a separate `models/danmaku_item.dart` file.
- Completed video player-info mask DTO cleanup: `VideoApi.fetchPlayerInfo` now exposes
  raw response data to `VideoRepositoryImpl`, which parses only `dm_mask.mask_url` and
  `dm_mask.fps` for the single danmaku-mask workflow; `PlayerInfo` and `DmMask` are gone,
  and the one-use `_parseDanmakuMaskInfo` parser is archived and guarded.
- Completed notification mapper scalar-reader cleanup: summary, send-result, and image
  upload parsing now use `JsonUtils` scalar helpers instead of duplicate
  `_readInt`/`_readString` functions.
- Completed settings cache-maintenance wrapper cleanup: `SettingsPage` owns the one
  clear-cache pending flag locally and calls `settingsRepositoryProvider.clearCache`
  directly.
- Completed settings page helper cleanup: the language/theme selection flows,
  language/theme label switches, and clear-cache action were folded into
  `SettingsPage.build`, preserving the shared bottom-sheet shell, locale/theme updates,
  cache invalidation, translated labels, and refresh feedback without one-use helper
  methods.
- Completed settings tile nullable-branch cleanup: `_SettingsTile` now requires `icon`
  and `onTap` because every settings row is clickable and icon-led; the row always keeps
  its leading icon, 16px gap, trailing chevron, and `AppClickable` tap behavior while
  leaving `value` optional for the About row.
- Completed settings theme mapper cleanup: `AppThemeMode.build` now owns the
  `AppThemePreference` to `ThemeMode` switch inline, and `setTheme` owns the reverse
  switch inline after the optimistic `state = mode` update, so one-use private
  `toThemeMode`/`toPreference` extension getters stay archived.
- Completed settings cache-size provider cleanup: the settings page owns its cache-size
  loading and refresh state inline for the only cache-size read UI; `_cacheSizeProvider`,
  `settings_controller.dart`, and generated provider output are archived.
- Completed home recommend mapper cleanup: `FeedResponseDto.item` now decodes directly to
  `List<VideoModel>` using the existing `goto == av` filter and malformed-item skip
  policy, so `HomeRepositoryImpl.fetchRecommendPage` no longer keeps a one-use
  `_parseRecommendItems` mapper.
- Completed home recommend response-shell cleanup: `HomeApi.fetchRecommend` now exposes
  raw response data to `HomeRepositoryImpl`, which owns the only `data.item` unwrap,
  `goto == av` filter, and malformed-item skip policy; `FeedResponseDto` and generated
  output are archived.
- Completed home recommend list-parser helper cleanup: `fetchRecommendPage` now keeps
  the `data.item` unwrap, `goto == av` filter, and malformed-item skip policy inline,
  so the one-use `_parseRecommendVideos` repository helper is archived and guarded.
- Completed shared video-list response-shell cleanup: home popular, home weekly, and
  ranking APIs now expose raw response data, and repositories call
  `parseVideoModelListEnvelope` for the shared `data.list` unwrap; `VideoListResponseDto`
  and generated output are archived.
- Completed home weekly API wrapper cleanup: the weekly feed endpoint now lives on
  `HomeApi` beside recommend/popular feed calls, and `HomeRepositoryImpl.fetchWeeklyList`
  uses the shared home API plus `parseVideoModelListEnvelope`. The one-endpoint
  `WeeklyApi`, `weekly_api.dart`, and generated output are archived.
- Completed home weekly page provider cleanup: `WeeklyScreen` owns the private
  `FutureProvider.autoDispose` for the weekly list and retry behavior, so
  `weekly_view_model.dart` and its generated output are archived.
- Completed related-video DTO cleanup: `VideoApi.fetchRelatedVideos` now decodes
  directly to canonical `VideoModel`, so `RelatedVideo`, its generated files, and the
  copy-only `RelatedVideoViewDataMapper` are archived.
- Completed search result DTO/domain mirror cleanup: search result API methods now expose
  raw response data and `SearchRepositoryImpl` parses pagination plus polymorphic
  `result` items directly into app-facing `SearchResultPage`/`SearchResultEntry`,
  preserving unknown-type drop logging without `SearchResultData`, `SearchResultItem`,
  `_SearchResultConverter`, or the copy-only search mapper extensions.
- Completed search result page shell cleanup: `SearchResultPage` now remains as a
  hand-written immutable pagination value, so `search_result.freezed.dart` is archived.
- Completed search query shell cleanup: `SearchQuery` now remains as a hand-written
  immutable keyword/type/order/duration/page value, so `search_query.freezed.dart` is
  archived. Its `type` input is required too, so callers choose the search domain
  explicitly instead of inheriting an implicit `SearchType.all` default.
- Completed search pagination copy-helper cleanup: `SearchResultView` now builds the
  next `SearchQuery` and appended `SearchResultPage` explicitly at the pagination
  boundary, so one-use `SearchQuery.copyWith` and `SearchResultPage.copyWith` stay
  archived.
- Completed video tag view-data wrapper cleanup: video detail and auxiliary state now
  carry tag names as `List<String>`, so the one-field `VideoTagViewData` wrapper and
  `VideoTagViewDataMapper` are archived.
- Completed video dimension view-data wrapper cleanup: video detail and part state now
  carry the decoded `VideoDimension` payload directly, so the width/height/rotate
  `VideoDimensionViewData` copy and mapper are archived.
- Completed video detail single-use mapper cleanup: `VideoDetailViewDataMapper`,
  `VideoPartViewDataMapper`, and `VideoRequestUserStateMapper` were folded into
  `LoadVideoDetailWorkflow.loadCritical`, and the remaining private
  `_videoDetailToViewData`, `_videoPageToViewData`, and `_reqUserToState` helpers are
  archived while that workflow is the only consumer. The inline projection preserves
  non-null request-user defaults and growable-false page mapping without public extension
  surface.
- Completed video detail DTO Freezed/JSON shell cleanup: `VideoDetail`, `ReqUser`,
  `VideoPage`, `VideoDimension`, `VideoTag`, and `TagCount` now remain as hand-written
  immutable DTOs in `video_detail_dto.dart`, preserving Bilibili detail/page/tag wire
  keys, default values, list equality, nullable subtitle/request-user fields, and JSON
  parsing without `video_detail_dto.freezed.dart` or `video_detail_dto.g.dart`.
- Completed video detail DTO list-equality helper cleanup: `VideoDetail.pages` and
  `tag` now use Flutter's canonical `listEquals`, so the file-local `_listEquals`
  clone is archived with the detail DTO read model.
- Completed video detail DTO deep-equality helper cleanup: `VideoDetail.copyright`
  now uses `collection`'s shared `DeepCollectionEquality` helper, so the file-local
  `_deepEquals` / `_deepHash` clones are archived with the detail DTO read model.
- Completed video detail DTO dead-code cleanup: unused DTO-level `copyWith` helpers were
  removed from `VideoDetail`, `ReqUser`, `VideoPage`, `VideoDimension`, `VideoTag`, and
  `TagCount`. Active optimistic UI mutations remain on `VideoDetailViewData` and
  `VideoRequestUserState`, not on the response DTOs.
- Completed video detail DTO serialization dead-code cleanup: unused response DTO
  `toJson` helpers were removed from `VideoDetail`, `ReqUser`, `VideoPage`,
  `VideoDimension`, `VideoTag`, and `TagCount`; Retrofit deserialization remains
  `fromJson`-owned.
- Completed home video actions sheet cleanup: the home video-actions owner now owns the
  bottom-sheet widget privately, so the cross-feature `VideoActionsBottomSheet` wrapper
  file under video overlays is archived.
- Completed home video actions private sheet cleanup:
  `showHomeVideoActionsBottomSheet` now owns the modal sheet chrome, drag handle, action
  rows, and callbacks inline, so `_HomeVideoActionsBottomSheet` stays archived too.
- Completed home video actions drag-handle helper cleanup: the fixed sheet handle is
  owned by the `showHomeVideoActionsBottomSheet` modal builder, preserving its margin,
  width, height, surface-variant color opacity, and radius without a one-use
  `_buildDragHandle` helper.
- Completed notification send-result map normalization cleanup: `key_hit_infos` now uses
  `JsonUtils.asStringKeyedMap` directly, and the private one-call map reader is gone.
- Completed home feed prefetch cleanup: recommend, live, and popular feeds now share
  `buildHomeFeedImagePrefetchSpecs` for initial and scroll-ahead image prefetch specs.
- Completed home feed tuning cleanup: recommend/live grid feeds and popular list now use
  named cache tuning and initial prefetch presets from `home_feed_view_utils.dart`.
- Completed home feed grid-width cleanup: recommend and live grid prefetch paths now use
  `estimateHomeGridItemWidth` instead of duplicating the same responsive calculation.
- Completed home popular/recommend feed load cleanup: `HomeFeedPagingMixin` now owns
  shared `Result<List<VideoModel>, AppError>` unfolding, silent-refresh success logging,
  and load-error empty-list fallback. The feed-specific cache/query/repository
  descriptors now live privately beside `PopularView` and `RecommendView` instead of
  public one-widget state shells.
- Completed home feed silent-refresh equality cleanup:
  `HomeFeedPagingMixin.refreshFirstPageSilently` now uses Flutter `listEquals` over
  canonical `VideoModel` value equality instead of a private `_sameItems` loop.
- Completed home feed silent-refresh fetch cleanup:
  `HomeFeedPagingMixin` now owns the silent-refresh `Stopwatch`, force-refresh page 1
  load, and `silent_refresh_fetch` logging inline beside `refreshFirstPageSilently`
  instead of a private `_loadFreshFirstPage` wrapper.
- Completed dynamic feed query-bag cleanup: dynamic, user-space, and topic feed
  providers now call repository feed methods with explicit endpoint parameters, so
  `DynamicFeedQuery`, `SpaceDynamicFeedQuery`, `TopicDynamicFeedQuery`, and
  `dynamic_queries.dart` are archived.
- Completed dynamic feed like-item helper cleanup: `DynamicFeedController.toggleLike`
  now owns the stat-null guard and optimistic `copyWithLike(!isLiked)` update inline,
  so the one-use `_buildLikedItem` helper is archived.
- Completed dynamic post action-sheet wrapper cleanup: `DynamicPostHeader.build` now
  owns its share/copy/open action sheet privately, preserving Bilibili link
  construction, share text, clipboard feedback, external navigation, and
  drag-handle sheet UI without `showDynamicPostActions`,
  `_showDynamicPostActions`, or `dynamic_post_actions.dart`.
- Completed dynamic post header author-navigation helper cleanup: `DynamicPostHeader.build`
  now owns the shared avatar/name `onOpenUser(post.authorMid)` callback as a local
  closure without `_openUserProfile`.
- Completed dynamic post header author-color helper cleanup: `DynamicPostHeader.build`
  now owns the official-account primary-color switch beside the author `TextStyle`
  without `_authorColor`.
- Completed dynamic forward-card author-navigation helper cleanup: `DynamicContentWidget.build`
  now owns the forwarded-author `onOpenUser(post.authorMid)` callback as a local
  closure without `_openUserProfile`.
- Completed dynamic link-card private wrapper cleanup: `DynamicContentWidget.build`
  now owns the link-card surface, navigation tap target, cover sizing, title/description
  clamps, and optional description branch inline without `_DynamicLinkCard`.
- Completed dynamic common-card private wrapper cleanup: `_buildAdditional` now owns the
  common additional surface, navigation tap target, cover sizing, title/description
  clamps, and fallback strings inline without `_DynamicCommonCard`.
- Completed dynamic UGC/video private wrapper cleanup: `_buildAdditional` now owns the
  UGC additional surface and jump-url navigation inline without `_DynamicUgcCard`, and
  `DynamicContentWidget.build` owns the video card fallback BVID/AID navigation, media
  cover, duration badge, counters, clamps, and typography inline without
  `_DynamicVideoCard`.
- Completed dynamic goods/reserve private wrapper cleanup: `_buildAdditional` now owns
  empty goods shrink behavior, goods row navigation and price styling, reserve
  jump-url gating, translated labels, disabled button state, padding, and typography
  inline without `_DynamicGoodsCard` or `_DynamicReserveCard`.
- Completed dynamic image private wrapper cleanup: `DynamicContentWidget.build` now
  owns image trimming, take-9 limiting, single-image constraints, grid sizing, tap
  targets, and `AppImagePreview.open` calls inline without `_DynamicImages` or
  `_openImagePreview`.
- Completed dynamic forward private wrapper cleanup: `DynamicContentWidget.build` now
  owns forwarded-author navigation, fallback forward text, surface styling, and
  recursive original-post rendering inline without `_DynamicForwardCard`.
- Completed publish dynamic page-only widget cleanup: `publish_dynamic_page.dart` now
  owns its bottom toolbar, image grid, emoji picker, and topic picker privately,
  preserving toolbar actions, character count, safe-area padding, image remove/add
  controls, 3-column grid layout, emoji package loading/retry, tab controller
  disposal/rebuild, package icon tabs, inline emote grid item chrome, emote insertion,
  debounced topic search, topic covers/fallback icons, HTML-stripped topic labels, and
  modal close behavior, with emoji/topic `showModalBottomSheet` launch owned directly by
  the toolbar callbacks instead of private launcher helpers, and discard confirmation
  called directly from the back/close exit callbacks instead of `_onWillPop`, with the
  page `Scaffold` and `AppBar` owned inline by `PublishDynamicPage.build` instead of
  `_PublishDynamicScaffold` or `_PublishDynamicAppBar`, and the editor text/image-grid
  mount owned inline instead of `_PublishDynamicEditor`, with bottom toolbar chrome
  owned inline instead of `_PublishDynamicBottomToolbar` and selected-image grid chrome
  owned inline instead of `_PublishDynamicImageGrid`,
  without `PublishDynamicBottomToolbar`, `PublishDynamicImageGrid`,
  `_PublishToolbarAction`, `_PublishImageItem`, `_PublishAddImageButton`,
  `_buildEmojiGrid`, `_showEmojiPicker`, `_showTopicPicker`,
  `_showPublishDynamicEmojiPicker`, `_showPublishDynamicTopicPicker`, `_onWillPop`,
  `EmojiPicker`, `TopicPicker`, or their one-owner files.
- Completed article-detail public part-helper cleanup: the comment sliver builder is
  now `_buildArticleCommentSlivers` inside the article detail library, and the scaffold
  builder is now `_buildArticleDetailScaffold`, preserving loading/disabled/error/empty/
  list/load-more comment slivers plus the article scaffold/app-bar/refresh/bottom bar
  without exposing page-only helpers as public API.
- Completed profile nested-feed paging cleanup: user dynamic and user video tabs now
  share `profileNestedFeedExtentAfterThreshold`,
  `profileNestedFeedOnlyOnScrollEnd`, and `profileNestedFeedCacheExtent`; their differing
  viewport/max thresholds remain local.
- Completed user dynamic/profile space-feed silent-refresh equality cleanup:
  `UserDynamicNotifier._refreshFirstPageSilently` and
  `UserSpaceVideosNotifier._refreshFirstPageSilently` now use Flutter `listEquals`
  over canonical model value equality instead of private `_sameItems` loops.
- Completed profile home-tab wrapper cleanup: `UserProfilePage` now owns its home tab
  body as a private `_UserHomeTab`, preserving keep-alive, page storage, overlap
  injection, sticky/masterpiece/recent sections, and the recent-video tab switch callback.
- Completed profile recent-video tab-switch callback cleanup: `_UserHomeTab` and
  `RecentVideoSection` require the page-owned `tabController.animateTo` callback and the
  view-more affordance calls tab index `2` directly without a nullable fallback.
- Completed user-profile content wrapper cleanup: `UserProfilePage.build` now owns the
  loaded profile nested-scroll shell directly, preserving depth-0 scroll offset tracking,
  refresh edge offset, overlap absorber/pinned tab bar, and the home/moments/contribution
  tab order without a one-use `_UserProfileContent` widget.
- Completed compact video list-card dimension cleanup: ranking items and to-view items now
  share `video_list_card_dimensions.dart` for the `140x88` thumbnail preset instead of
  duplicating raw card layout literals.
- Completed live-room title min-lines wrapper cleanup: the one-use `AppMinLinesText`
  public widget was folded into `LiveRoomCard` as a local fixed two-line title slot,
  preserving the title style, two-line max, ellipsis, and bottom-row spacing.
- Completed live-room area-tag wrapper cleanup: the one-use `_LiveAreaTag` badge was
  folded into `LiveRoomCard` so cover image, gradient, area tag, and online counter stay
  owned by the card.
- Completed video entry vertical builder seam cleanup: the unused `verticalPageBuilder`
  constructor seam and one-line `_buildVerticalPage` helper were removed; the vertical
  layout branch now constructs `VerticalVideoPage(bvid: bvid)` directly.
- Completed video entry normal builder seam cleanup: the unused `normalPageBuilder`
  constructor seam and one-line `_buildNormalPage` helper were removed; the normal
  layout branch now constructs `VideoDetailPage` directly.
- Completed player panel dead-API cleanup: `PlayerPanelScaffold` no longer declares
  unused title/subtitle/trailing inputs, and `QuickSelectionSheet` no longer forwards
  title/subtitle values into a scaffold that does not render them. Its
  `isBottomSheet` input is required too, because all active panel owners derive and pass
  their layout mode explicitly.
- Completed player panel section surface-alpha cleanup: `PlayerPanelSection` no longer
  exposes an unused `surfaceAlpha` override; the default section surface alpha stays in
  `VideoOverlayStyles.panelSurface` while active `backgroundColor`,
  `outlineAlpha`, and `cornerRadius` inputs remain.
- Completed quick-selection option tile cleanup: `QuickSelectionSheet.build` now owns
  the selected/unselected menu row chrome, subtitle branch, select-and-pop callback, and
  check/chevron animated switch inline without `_PlayerMenuOptionTile`.
- Completed player settings filter chip cleanup: `PlayerSettingsSheet.build` now owns
  the danmaku filter row chip chrome, selected/unselected colors, animation, spacing, and
  callbacks inline without `_PlayerFilterChip`.
- Completed player settings option text-chip cleanup:
  `_InlineTextOptionSectionState.build` now owns the speed/quality option chip chrome,
  preserving measurement keys, semantics, selected text styling, and tap callbacks inline
  without `_OptionTextChip`.
- Completed player settings option item equality cleanup:
  `_InlineTextOptionSectionState.didUpdateWidget` now computes one `itemsChanged` local
  with Flutter's `listEquals`, so the private `_sameItems` loop is archived.
- Completed player theme dead-token cleanup: unused `PlayerTheme` constants/style helpers
  were removed, and the one-call public `sliderTheme` helper was folded into
  `progressSliderTheme`.
- Completed player progress-bar wrapper cleanup: the single-use video progress slider is
  now private to `PlayerControlsOverlay`, preserving position/buffer display, drag state,
  formatted labels, and seek-on-drag-end behavior without a public wrapper file.
- Completed gesture feedback wrapper cleanup: the double-tap seek ripple and
  brightness/volume indicator chrome now live privately with `InteractionLayer`,
  preserving animation completion, clipping, blur policy, text/value display, and progress
  indicator rendering without public controls-level wrapper files. The private
  `_GestureIndicator` leaf wrapper is also folded into `_GestureFeedbackOverlay.build`.
- Completed user dynamic skeleton wrapper cleanup: `UserDynamicFeed` now owns its loading
  shimmer card inline in `build`, preserving the header/content/footer shimmer layout
  without a public `DynamicSkeleton` file under shared UI or a private
  `_DynamicSkeleton` one-call class.
- Completed home feed page skeleton wrapper cleanup: `PopularView` and `RecommendView`
  now own their loading `CustomScrollView` slivers directly, preserving non-scrollable
  physics, padding, item padding, grid delegates, and skeleton counts without public
  `GridSkeletonView`/`ListSkeletonView` wrappers.
- Completed ranking category wrapper cleanup: ranking tab metadata now lives page-local
  in `ranking_page.dart`; the public `RankingCategory`/`rankingCategories` wrapper file
  is archived because `RankingPage` was its only consumer.
- Completed wide video list-card dimension cleanup: search video, favorite resource, and
  history list rows now share the `160x90` thumbnail preset from
  `video_list_card_dimensions.dart` instead of duplicating raw `16 / 9` and `90` layout
  literals.
- Completed live header follow cleanup: `LiveHeader` now requires a real follow handler
  and no longer falls back to a no-op when the user is already logged in.
- Completed profile sticky-video stat wrapper cleanup: the private `_StatIconText`
  duplicate is gone, and `StickyVideoSection` now uses the shared `IconText` primitive.
- Completed search article meta wrapper cleanup: `_ArticleMetaItem` is gone, and article
  result metadata now uses the shared `IconText` primitive.
- Completed search user meta wrapper cleanup: `_UserMetaItem` and the later
  `_buildUserMetaItem` helper are gone, and the user branch in `SearchResultList.build`
  owns its local label/value row construction directly.
- Completed video action-sheet entry cleanup: `showVideoActionsBottomSheet` now lives in
  the home owner file, so the thin `features/video/video_action_sheet_entry.dart`
  wrapper is gone.
- Completed image prefetch spec builder cleanup: home, profile, and video cover-prefetch
  paths now share `network_image_prefetch_specs.dart` for pixel-ratio cache-dimension
  construction.
- Completed video related prefetch estimate cleanup: `VideoInfoView.build` now owns the
  two-column width estimate, `16 / 10` aspect ratio, and four-image prefetch limit inline,
  so `_relatedGrid*` file-level constants do not remain as layout-looking tokens.
- Completed search result prefetch spec cleanup: mixed search result cover/avatar/topic
  prefetch paths now use `buildNetworkImagePrefetchSpecs` instead of rebuilding
  `NetworkImagePrefetchSpec` cache dimensions locally.
- Completed notification private-message page-size SSOT cleanup: notification API,
  repository, and state now read `notificationPrivateMessagePageSize` instead of
  duplicating the `20` literal or referencing `NotificationRepositoryImpl.pageSize`.
- Completed search result page-size SSOT cleanup: search API defaults now read a private
  `SearchApi` constant instead of duplicating the `20` literal across all/type search
  endpoints or using a one-line constants wrapper.
- Completed home feed page-size SSOT cleanup: API defaults and state cache queries now
  read `homeFeedPageSize`; `HomeRepositoryImpl.feedPageSize` and `HomeApi.feedPageSize`
  wrapper constants are gone.
- Completed live recommend page-size SSOT cleanup: provider has-more checks and API
  defaults now read `liveRecommendPageSize` instead of splitting `12` and `30` defaults.
- Completed live recommend provider cleanup: `LiveView` now owns the private
  auto-dispose paging notifier for live-room recommendations, so
  `live_recommend_provider.dart`, generated output, public `LiveRecommend`, and public
  `liveRecommendProvider` are archived as a one-consumer shell.
- Completed live recommend response-wrapper cleanup: `LiveRecommendResponse` and its
  generated files were deleted; `LiveApi.getRecommendList` now exposes raw response data
  to the repository boundary, where `recommend_room_list` is strictly parsed into the
  canonical `LiveRoomSummary` list.
- Completed live recommend list-parser helper cleanup: `getRecommendList` now keeps
  the strict `recommend_room_list` unwrap and `LiveRoomSummary.fromJson` mapping inline,
  so the one-use `_parseRecommendRooms` repository helper is archived and guarded.
- Completed live room summary Freezed shell cleanup: `LiveWatchedShow` and
  `LiveRoomSummary` now remain as hand-written immutable values in
  `live_room_summary_contract.dart`, preserving recommend-room wire keys, `watched_show`
  nesting, `keyframe`, `is_auto_play`, and JSON parsing without
  `live_room_summary_contract.freezed.dart` or `live_room_summary_contract.g.dart`.
  Their unused `copyWith` and `toJson` helpers are archived too.
- Completed live watched-count scalar helper cleanup: `LiveWatchedShow.fromJson` now
  calls shared `JsonUtils.parseInt` directly and preserves the previous invalid numeric
  `FormatException`; the private `_parseWatchedCount` helper is archived and guarded.
- Completed user card Freezed shell cleanup: `UserCardModel` now remains as a
  hand-written immutable value in `user_card_contract.dart`, preserving profile/live
  card handoff fields, default `isFollowed = false`, equality, and diagnostics without
  `user_card_contract.freezed.dart`. The `UserCardModel.copyWith` helper is archived;
  profile optimistic follow updates remain on `ProfileUser.copyWith`, and the live
  anchor follow toggle emits an explicit `UserCardModel` constructor.
- Completed shared paged-list Freezed shell cleanup: `PagedListState<T>` now remains as
  a hand-written immutable paging value in `paged_list_state.dart`, preserving default
  loading/page flags, list equality, and nullable `error` clearing through `copyWith`
  without `paged_list_state.freezed.dart`.
- Completed shared paged-list equality helper cleanup: `PagedListState.items` now uses
  Flutter's canonical `listEquals`, so the file-local `_listEquals` clone is archived
  with the shared paging value.
- Completed relation-user Freezed/JSON shell cleanup: `OfficialVerify`, `VipInfo`, and
  `ProfileRelationUser` now remain as hand-written immutable values in
  `relation_user_contract.dart`, preserving relation-list wire keys, defaults, equality,
  diagnostics, and JSON parsing without `relation_user_contract.freezed.dart` or
  `relation_user_contract.g.dart`. Their unused `copyWith` and `toJson` helpers are
  archived too.
- Completed dynamic/live API page-size SSOT cleanup: topic dynamic feed, live gold-rank,
  and live guard-list API defaults now read named feature constants instead of inline
  `20` literals.
- Completed topic dynamic feed provider cleanup: `TopicDetailPage` now owns the private
  cursor-paged topic feed notifier, so `topic_dynamic_feed_provider.dart`, generated
  output, public `TopicDynamicNotifier`, and public `topicDynamicProvider` are archived
  as a one-consumer state shell.
- Completed live gold-rank DTO consolidation: `LiveGoldRankModel` now owns JSON decoding
  for the online gold-rank response, and the duplicate `LiveGoldRankDto`,
  `LiveRankItemDto`, and `LiveRankMedalInfoDto` field mirrors are archived. The
  hand-written gold-rank models now keep only active read-side behavior; unused
  `copyWith` and `toJson` helpers are archived and guarded.
- Completed live gold-rank equality helper cleanup: `LiveGoldRankModel.list` now uses
  Flutter's canonical `listEquals`, so the file-local `_listEquals` clone is archived
  with the gold-rank read model.
- Completed live danmu-info DTO consolidation: `LiveDanmuInfoModel` now owns JSON
  decoding for danmaku connection info, preserving the empty `host_list` fallback while
  removing the duplicate DTO and copy-only repository mapper.
- Completed live danmu-info shell cleanup: `LiveDanmuInfoModel` and `LiveDanmuHost` now
  remain as hand-written immutable values in `live_danmu_info_model.dart`, preserving
  the `host_list` empty-list fallback and eliminating the generated Freezed/JSON shell.
  Unused `copyWith` and `toJson` helpers are archived too.
- Completed favorites resource-page equality cleanup: `FavoriteResourcePage.medias` now
  uses Flutter's canonical `listEquals`, so the file-local `_listEquals` clone is
  archived with the page-owned read-only list equality.
- Completed favorites folder-resource initial fetch helper cleanup: `FavFolderResources.build`
  now owns the first-page `getFolderResources` call, request stopwatch, telemetry, and
  `dataOrNull` unwrap inline, so `_fetchItems` does not remain as a one-call request
  wrapper beside the controller.
- Completed live danmu-info equality cleanup: `LiveDanmuInfoModel.hostList` now uses
  Flutter's canonical `listEquals`, so the file-local `_listEquals` clone is archived
  with the connection-info list equality.
- Completed live play-url shell cleanup: `LivePlayUrlModel`,
  `LiveQualityDescription`, and `LiveStreamUrl` now remain as hand-written immutable
  values in `live_play_url_model.dart`, preserving Bilibili play-url wire keys, list
  equality, and JSON parsing without generated Freezed/JSON shells. Unused `copyWith`
  and `toJson` helpers are archived too.
- Completed live play-url equality helper cleanup: `LivePlayUrlModel.acceptQuality`,
  `qualityDescription`, and `durl` now use Flutter's canonical `listEquals`, so the
  file-local `_listEquals` clone is archived with the play-url read model.
- Completed live guard-list equality helper cleanup: `LiveGuardListModel.top3` and
  `list` now use Flutter's canonical `listEquals`, so the file-local `_listEquals`
  clone is archived with the guard-list read model.
- Completed live room detail Freezed shell cleanup: `LiveRoomDetailModel` now remains
  as a hand-written immutable value in `live_room_detail_model.dart`, preserving live
  room detail wire keys, `hot_words` list equality, `new_pendants` / `studio_info` map
  equality, and JSON parsing without generated Freezed/JSON shell files. Unused
  `copyWith` and `toJson` helpers are archived too.
- Completed live room detail list-equality helper cleanup:
  `LiveRoomDetailModel.hotWords` now uses Flutter's canonical `listEquals`, so the
  file-local `_listEquals` clone is archived with the room-detail read model.
- Completed live room detail map helper cleanup: `LiveRoomDetailModel.newPendants`
  and `studioInfo` now use Flutter's canonical `mapEquals`, with map hash values
  delegated inline to `collection`'s shallow `MapEquality`, so the file-local
  `_mapEquals` / `_mapHash` clones and one-use `_liveRoomDetailMapEquality` token are
  archived with the room-detail read model.
- Completed live history danmaku shell cleanup: `LiveHistoryDanmakuModel`,
  `LiveDanmakuItem`, and nested medal/title/user-level values now remain hand-written
  in `live_history_danmaku_model.dart`, preserving array-encoded metadata converters,
  nullable metadata parsing, `checkInfo` map equality, and JSON parsing without
  generated Freezed/JSON shells. Unused `copyWith` and `toJson` helpers are archived
  too.
- Completed live history danmaku list-equality helper cleanup:
  `LiveHistoryDanmakuModel.admin` and `room` now use Flutter's canonical `listEquals`,
  so the file-local `_listEquals` clone is archived with the history danmaku read
  model.
- Completed live history danmaku map helper cleanup: `LiveDanmakuItem.checkInfo` now
  uses Flutter's canonical `mapEquals`, with hash values delegated to `collection`'s
  shallow `MapEquality` inline at the hash site, so the file-local `_mapEquals` /
  `_mapHash` clones and one-use `_liveDanmakuCheckInfoEquality` token are archived with
  the history danmaku read model.
- Completed live history danmaku metadata parser helper cleanup:
  `LiveDanmakuItem.fromJson` now owns the array-encoded medal/title/user-level
  coercion inline, so `_medalFromJson`, `_titleFromJson`, and `_userLevelFromJson`
  stay archived with the history danmaku read model.
- Completed live guard-list DTO consolidation: `LiveGuardListModel` now owns JSON
  decoding for guard rankings and nested guard-user data, preserving the `uinfo`,
  `guard_level`, and empty `top3` / `list` fallbacks while removing the duplicate DTO
  family and repository mapper chain.
- Completed live guard-list Freezed shell cleanup: `LiveGuardListModel`,
  `LiveGuardInfo`, `LiveGuardItem`, `LiveGuardUserInfo`, and `LiveGuardUserBase` now
  remain as hand-written immutable values in `live_guard_list_model.dart`, preserving
  list equality, and JSON parsing without generated Freezed/JSON shell files. Unused
  `copyWith` and `toJson` helpers are archived too.
- Completed live guard-list integer helper cleanup: required guard-list numeric fields
  now call `JsonUtils.parseInt` directly and preserve required-field failure through
  `FormatException`; the private `_jsonInt` scalar clone is archived and guarded.
- Completed video subtitle DTO consolidation: `VideoSubtitles`, `SubtitleInfo`,
  `SubtitleContent`, and `SubtitleItem` now own subtitle metadata/content JSON decoding,
  preserving Bilibili JSON key mappings and empty-list fallbacks while removing
  `subtitle_dto.dart` and the copy-only subtitle mapper chain.
- Completed video subtitle Freezed shell cleanup: `VideoSubtitles`, `SubtitleInfo`,
  `SubtitleContent`, and `SubtitleItem` now remain as hand-written immutable values in
  `subtitle.dart`, preserving nullable fields, list equality, JSON parsing, and
  Bilibili subtitle wire keys without generated Freezed/JSON shell files.
- Completed video subtitle equality helper cleanup: `VideoSubtitles.list` and
  `SubtitleContent.body` now use Flutter's canonical `listEquals`, so the file-local
  `_listEquals` clone is archived with the subtitle read models.
- Completed video subtitle read-model dead-code cleanup: unused `copyWith` and `toJson`
  helpers were removed from `VideoSubtitles`, `SubtitleInfo`, `SubtitleContent`, and
  `SubtitleItem` after external search found no active consumers; subtitle metadata and
  content stay read-only API values owned by `fromJson`.
- Completed video subtitle integer helper cleanup: `SubtitleInfo.id` and
  `SubtitleItem.location` now call `JsonUtils.parseInt` directly and preserve
  required-field failure through `FormatException`; the private `_jsonInt` clone is
  archived while `_jsonDouble` stays local because there is no shared double parser yet.
- Completed video play-url DTO consolidation: `PlayUrl`, `DashInfo`, `DashStream`,
  `Durl`, and `SupportFormat` now own play-url JSON decoding, preserving Bilibili wire
  keys and DASH `baseUrl`/`base_url` plus `backupUrl`/`backup_url` compatibility while
  removing `video_play_url_dto.dart` and the copy-only play-url mapper chain.
- Completed video play-url key-alias helper cleanup: `DashStream.fromJson` now keeps the
  DASH `baseUrl`/`base_url` and `backupUrl`/`backup_url` fallbacks inline, so the
  one-use `_readBaseUrl` and `_readBackupUrls` wrappers stay archived.
- Completed video play-url Freezed shell cleanup: `PlayUrl`, `DashInfo`, `DashStream`,
  `Durl`, and `SupportFormat` now remain as hand-written immutable values in
  `play_url.dart`, preserving list equality, nullable `dash`, empty-list defaults,
  JSON parsing, and Bilibili play-url wire keys without
  generated Freezed/JSON shell files.
- Completed video play-url list-equality helper cleanup: play-url read-model lists now
  use Flutter's canonical `listEquals`, so the file-local `_listEquals` clone is
  archived with the play-url model family.
- Completed video play-url read-model dead-code cleanup: unused `copyWith` and `toJson`
  helpers were removed from `PlayUrl`, `DashInfo`, `DashStream`, `Durl`, and
  `SupportFormat` after external search found no active consumers; playback code reads
  the canonical parsed values directly.
- Completed video detail uploader wrapper cleanup: the one-use `UploaderSection` file was
  folded into `VideoInfoView` as private header UI, preserving the avatar/name row,
  profile navigation, follow button sizing, and login gate before follow toggles.
- Completed dynamic API defaults cleanup: feed feature flags and web timezone offset now
  live in `dynamic_api.dart` and are shared by Retrofit defaults and user-space
  cache-key construction without a separate defaults wrapper.
- Completed live danmaku send-default cleanup: `LiveApi.sendDanmaku` now owns its named
  color, font-size, mode, and bubble defaults directly, and
  `live_danmaku_defaults.dart` is archived.
- Completed live danmaku config cleanup: removed the unused `GetDMConfigByGroup`
  endpoint, `LiveDanmakuConfigModel` mirror family, `LiveRoomState.danmakuConfig`, and
  `_fetchDanmakuConfig`; live-room init now treats play URL as the only critical
  startup request because no active UI/socket path consumes the config payload.
- Completed live danmaku event integer helper cleanup: `LiveDanmakuEventParser` now
  calls `JsonUtils.parseIntWithDefault` directly for user, medal, gift, and level
  numeric event fields while preserving malformed-value fallback to 0; the private
  `_asInt` clone is archived and guarded.
- Completed live danmaku event parser wrapper cleanup: `LiveSocketService` now owns its
  socket event parsing as private helpers beside the only message source, preserving
  DANMU_MSG, INTERACT_WORD, NOTICE_MSG, and SEND_GIFT parsing while archiving the
  one-use `LiveDanmakuEventParser` file/class and injection field.
- Completed live socket notification decode helper cleanup:
  `_decodeCompressedNotificationEvents` now owns zlib decode plus uncompressed packet
  iteration inline, preserving operation `5` filtering, nested compressed packet
  recursion, protocol `0` JSON decoding, and map-only event collection without a one-call
  `_decodeNotificationEventsFromMessage` helper.
- Completed publish dynamic route wrapper cleanup: `PublishDynamicRoute` now constructs
  `PublishDynamicPage` directly, removing the one-line
  `buildPublishDynamicRoutePage` facade from dynamic navigation.
- Completed dynamic route page wrapper cleanup: `DynamicRoute` and
  `DynamicDetailRoute` now compose `DynamicPage` / `DynamicDetailPage` with
  `buildDynamicNavigationScope` directly in the app router, removing the one-line
  `buildDynamicRoutePage` and `buildDynamicDetailRoutePage` facades from dynamic
  navigation.
- Completed dynamic article/topic route factory cleanup: article and topic modal pushes now
  construct `ArticleDetailPage` and `TopicDetailPage` directly in the typed app router,
  preserving root-navigator article pushes and dynamic navigation callback wiring without
  `buildArticleDetailRoutePage` or `buildTopicDetailRoutePage`.
- Completed article detail scaffold helper cleanup: the loading/error/empty page states
  now live inline in `ArticleDetailPage.build`, removing the one-use
  `buildArticleLoadingScaffold`, `buildArticleErrorScaffold`, and
  `buildArticleEmptyScaffold` wrappers.
- Completed empty shared UI split directory cleanup: removed leftover empty directories
  from collapsed `VideoCard`, `VideoListCard`, `SmartPagingView`, and `GuestView`
  handwritten part splits.
- Completed ranking skeleton cleanup: the one-use `RankingSkeletonItem` file was folded
  into the ranking tab list owner as a private skeleton widget.
- Completed ranking badge cleanup: the one-use `RankBadge` file was folded into
  `RankingItemCard` as a private thumbnail overlay helper.
- Completed ranking private badge helper cleanup: `RankingItemCard.build` now owns the
  rank 1/2/3 badge color mapping, top-rank gradient/shadow, and fallback scrim inline,
  so `_RankBadge` and `_RankBadgeStyle` stay archived too.
- Completed ranking badge font-size facade cleanup: `RankingItemCard.build` keeps the
  top-three `14.0` and fallback `12.0` font-size branch inline at the text style instead
  of a one-use `rankBadgeFontSize` local.
- Completed ranking list-view cleanup: the one-page `RankingListView` tab body was
  folded into `RankingPage` as private UI while preserving provider watch, refresh, and
  keep-alive behavior.
- Completed to-view item cleanup: the one-page `ToViewItem` renderer was first folded
  private, then `_ToViewItem` was folded into `ToViewPage.build`, preserving
  dismiss/delete behavior, compact `VideoListCard` dimensions, progress/owner metadata,
  stats, and open-video callback inline with the list item builder.
- Completed to-view page micro-wrapper cleanup: `_ToViewPageAppBar` and
  `_DismissibleToViewItem` were folded into `ToViewPage.build` and
  `_ToViewListView.build`, keeping clear-all visibility, confirm-dialog gating, swipe
  delete, and open-video wiring beside their only owners.
- Completed to-view list-shell cleanup: `_ToViewListView` was folded into
  the to-view page body path, so refresh, empty/error/loading state, swipe delete, and
  open-video wiring live in one page owner.
- Completed to-view body-wrapper cleanup: `_ToViewBody` was folded into
  `ToViewPage.build`, keeping login-gated provider watching, refresh result mapping,
  empty/error/loading states, swipe delete, compact row metadata, stats, and open-video
  dispatch beside the page owner.
- Completed history item cleanup: the one-page `HistoryItemWidget` renderer was first
  folded private, then `_HistoryItemWidget` was folded into `HistoryPage.build`,
  preserving keyed rows, archive-only open-video gating, wide `VideoListCard`
  dimensions, progress overlay, author, badge, and time stats inline with the list
  item builder.
- Completed history empty-state cleanup: `_HistoryEmptyState` was folded into
  `_HistoryContent.build` because it only rendered the single empty history branch.
- Completed history content-shell cleanup: `_HistoryContent` was folded into
  `HistoryPage.build`, keeping empty/list/error/loading branches, refresh, retry, keyed
  rows, and archive-only open-video gating beside the private page provider owner.
- Completed recent-video section micro-wrapper cleanup: `_EmptyState` and `_ViewMoreLink`
  were folded into `RecentVideoSection.build`, keeping the empty sliver and view-more
  affordance beside the only provider branch and section header that use them.
- Completed search section header wrapper cleanup: `SearchPage` and `HotSearchSection`
  now own their header rows inline, preserving title typography, bottom padding, and the
  history clear trailing action without a public `AppSectionHeader` wrapper.
- Completed recent-video section branch cleanup: `_ErrorState`, `_LoadingGrid`, and
  `_VideoGrid` were folded into `RecentVideoSection.build`; the data/error/loading
  branches now own their sliver padding, grid delegates, skeleton count, capped display
  count, and open-video wiring directly.
- Completed search landing/skeleton cleanup: `_SearchLandingContent` and
  `_SearchResultSkeleton` were folded into their owning build branches because they only
  wrapped one `ListView` each and did not own state.
- Completed search result filter-chip cleanup: `_FilterChip` was folded into
  `_SearchResultTab.build`, preserving the sort/duration option lists, right padding,
  compact `ChoiceChip` tap target, selected/unselected label color and weight, 12px font,
  transparent background, selected primary-container tint, no side, hidden checkmark, and
  owner callbacks. The one-use `SearchType.supportsDuration` getter is archived too;
  `_SearchResultTab.build` gates duration filters directly on `SearchType.video`.
- Completed search callback-helper cleanup: `_buildOnSearch` was folded into
  `SearchPage.build` because it only normalized the submitted term and dispatched to the
  page-owned search state.
- Completed search body-helper cleanup: `_buildSearchBody` was folded into
  `SearchPage.build`, keeping suggestion/result/landing mode ownership in the page that
  owns the search state.
- Completed search page state-wrapper cleanup: `SearchPage` now owns its page-local hook
  state privately, so `use_search_view_model.dart`, private `_useSearchViewModel`,
  public `useSearchViewModel`, public `SearchPageMode`, and the public
  `SearchPageState` wrapper class are archived.
- Completed ranking page micro-wrapper cleanup: `_RankingAppBar`, `_RankingItemsList`,
  and `_RankingSkeletonList` were folded into `RankingPage.build` and
  `_RankingListViewState.build`, keeping tab chrome, loaded rows, and loading rows beside
  the only owner state that uses them.
- Completed settings selection-sheet cleanup: `_SettingsSelectionSheet` was folded into
  `_showSelectionSheet`, keeping the shared bottom-sheet chrome beside the only helper
  used by theme and language selectors. The private `_SettingsSelectionItem` wrapper is
  archived too; theme and language selectors own their option row markup inline.
- Completed profile page micro-wrapper cleanup: `_ProfileStatDivider` was folded into
  `_ProfileStats.build`.
- Completed profile page stat-item cleanup: `_ProfileStatItem` was folded into
  `_ProfileStats.build`, preserving formatted posts/following/followers counts, posts
  coming-soon feedback, `vmid != 0` navigation gates, dividers, `AppClickable`
  radius/padding, and text styles while keeping `_ProfileStats` as the
  `myProfileProvider` rebuild boundary.
- Completed profile guest helper cleanup: `_emptyProfileUser` was folded into
  `myProfile`, preserving the guest `ProfileUser` shape inline when the user is logged
  out.
- Completed user-profile header stats cleanup: the `user_profile_info.dart`
  `_StatsRow`/`_ProfileStatItem` pair was folded into `UserProfileHeader.build` so the
  avatar offset, following/followers/likes row, navigation callbacks, likes no-op, stat
  text styles, and profile buttons stay with the only header owner.
- Completed relation user follow-control cleanup: `_buildFollowButton` and
  `_handleFollowPressed` were folded into `_RelationUserItemState.build`, preserving the
  attribute-to-label mapping, unauthenticated login gate, `FollowButton(height: 32)`,
  and authenticated `_handleFollow` call while leaving `_handleFollow` as the optimistic
  relation mutation boundary.
- Completed relation user row-tap override cleanup: `RelationUserItem` owns the only row
  tap behavior directly by opening `ProfileNavigationScope.of(context).onOpenUser(user.mid)`
  and no longer exposes an unused nullable `onTap` constructor override.
- Completed popular video card callback cleanup: `PopularVideoCard` requires `onTap` and
  `onLongPress` because all current popular, recommend, and weekly rows provide detail
  navigation and the home video action sheet directly.
- Completed relation-list privacy error cleanup: `_RelationPrivacyError` was folded into
  `RelationUserList.errorBuilder`, preserving the `22115` privacy branch, lock icon,
  translated title/message, and theme colors without a one-use private widget.
- Completed profile user-video sort-chip cleanup: `_SortChip` was folded into
  `UserVideoTab.build`, preserving the three localized sort labels, 12px spacing,
  200ms selected animation, 14x6 padding, 16px radius, selected primary tint, outline
  fallback border, text weights, no-op selected tap, and `_loadGate` reset before order
  changes.
- Completed profile one-use visual/prefetch token cleanup: user-video cover prefetch now
  owns first-8 and `160x100` sizing inline in `UserVideoTab.build`, recent-video prefetch
  owns `16 / 10` inline, and the profile header owns its top-card `20.0` radius inline
  without private constants.
- Completed profile user-video cover prefetch helper cleanup: `_scheduleCoverPrefetch`
  was folded into the single `UserVideoTab.build` data branch, preserving post-frame
  scheduling, the mounted/key guard, first-8 count, `160x100` sizing, and
  `limit: specs.length`.
- Completed user-profile tab-bar builder cleanup: `_buildUserProfileTabBar` was folded
  into the user-profile nested-scroll layout, keeping the single tab renderer beside its
  `SliverPersistentHeader` owner.
- Completed live room state split cleanup: lifecycle and fetcher part files were folded
  into `LiveRoomController`, removing private mixin getter/override plumbing.
- Completed live room state shell cleanup: `LiveRoomState` was folded into
  `live_room_view_model.dart` as a controller-owned immutable class, preserving the
  room-id requirement, loading/error/room-info/anchor/gold-rank/guard/play-url fields,
  and `isPlaying`/`volume` UI state without a separate `live_room_state.dart` file or
  generated Freezed state wrapper.
- Completed live room request-token cleanup: `LiveRoomController._init` now increments
  `_loadRequestToken` inline instead of routing through a one-use `_beginLiveRoomRequest`
  helper.
- Completed listen sleep timer dispose cleanup:
  `ListenSleepTimerController.build` now owns ticker teardown inline through
  `ref.onDispose` instead of a private `_dispose` helper.
- Completed listen sleep timer preset cleanup: preset buttons in
  `ListenSettingsSheet` now call `setCustomMinutes` directly instead of a one-use
  `setPresetMinutes` wrapper.
- Completed listen settings sheet layout-flag cleanup: `ListenSettingsSheet` no longer
  exposes `isBottomSheet` because its only caller opens it via `showModalBottomSheet`;
  the sheet keeps `PlayerPanelScaffold(isBottomSheet: true)` and `maxHeightFactor: 0.62`
  inline.
- Completed player settings layout-default cleanup: `PlayerSettingsSheet.isBottomSheet`
  remains a required live layout input because the overlay caller derives
  portrait/landscape placement; the unused constructor default `false` branch is archived.
- Completed player lifecycle dispose cleanup:
  `PlayerController.build` now owns the dispose registration inline instead of a
  one-use `_disposePlayerLifecycle` wrapper.
- Completed player load helper cleanup: `PlayerController.loadVideo` now owns the
  timeout/open path and first-frame readiness logging inline instead of one-use
  `_markReadyForRequest` and `_openMediaWithTimeout` wrappers.
- Completed live room error wrapper cleanup: `_LiveRoomError` was folded into
  `LiveRoomContent.build`, keeping the single error branch beside the room load state
  and retry controller read that own it.
- Completed live room content wrapper cleanup: `_LiveRoomTitle` and `_DanmakuTopGradient`
  were folded into their owning build branches, keeping the title render and danmaku
  top fade beside the only state/layout that consumes them.
- Completed live danmaku section wrapper cleanup: `LiveRoomContent.build` now owns the
  danmaku feed watch, enabled fallback, reverse list, item repaint boundaries,
  per-`dmType` message styling, and top scrim gradient inline without `_DanmakuSection`
  or `_LiveDanmakuView`.
- Completed live header private extension cleanup: `_LiveHeaderAnchorParts` and
  `_LiveHeaderTagParts` were folded back into `LiveHeader`, keeping header helper
  methods inside their only owning widget instead of splitting them into one-owner
  extensions.
- Completed live header number-format wrapper cleanup: `LiveHeader` now calls
  `FormatUtils.formatNumber` directly for online and gold-rank counts, so the one-line
  `_liveHeaderFormatNumber` delegate is archived.
- Completed live header anchor-row helper cleanup: `LiveHeader.build` owns the only back
  button, room-info branch, avatar, name/online block, follow button, viewer stack, and
  row spacing inline without `_buildAnchorRow`.
- Completed live header anchor-avatar helper cleanup: `LiveHeader.build` owns the circular
  primary border, 1.5px padding, 38px `AppAvatar`, and anchor-face/user-cover fallback
  inline without `_buildAvatar`.
- Completed live header follow-button helper cleanup: `LiveHeader.build` owns the nullable
  anchor/followed gate, lazy `currentUserProvider` watch, login/follow callback choice,
  8px right padding, 32px height, and `+ follow` label inline without `_buildFollowButton`.
- Completed live header name/online helper cleanup: `LiveHeader.build` owns the expanded
  anchor name, optional level badge, formatted online count, optional guard count,
  ellipsis, spacing, and text colors inline without `_buildNameAndOnline`.
- Completed live header tag-row cleanup: `LiveHeader.build` owns the hot/popularity tag
  row inline, preserving row padding, tag order, spacing, alpha tint, radius, font size,
  and weight without `_buildTagsRow` or `_buildTag`.
- Completed live watched-count scalar helper cleanup: `LiveWatchedShow.fromJson` now
  uses `JsonUtils.parseInt` directly instead of carrying a private `_parseWatchedCount`
  clone in the live room summary contract.
- Completed live anchor-info wrapper cleanup: the optional anchor-info endpoint now
  parses only `exp.master_level.level` into `LiveRoomState.anchorLevel` for the
  `LiveHeader` badge, and the unused nested `LiveAnchorInfoModel` tree is archived.
- Completed live anchor-info parser helper cleanup: `getAnchorInfo` now keeps
  `exp.master_level.level` parsing inline, so `_parseAnchorMasterLevel` is archived and
  guarded as a one-use repository helper.
- Completed favorites folder list response-shell cleanup: `FavApi` exposes raw folder
  list response data and `FavRepositoryImpl` parses the `list` envelope directly into
  `List<FavoriteFolder>`, so unused transport `count` no longer keeps
  `FavFolderListResponse` or `FavoriteFolderPage` alive.
- Completed favorites resource list response-shell cleanup: `FavApi` exposes raw
  resource list response data and `FavRepositoryImpl` parses the
  `info`/`medias`/`has_more` envelope directly into `FavoriteResourcePage`, so
  `FavResourceListResponse` and `_FavResourceListMapper` are archived.
- Completed favorites resource-list parser helper cleanup: `getFolderResources` now keeps
  the `info`/`medias`/`has_more` unwrap and `FavoriteResourcePage` validation inline, so
  `_parseFavoriteResourcePage` is archived and guarded.
- Completed favorites favorite-delta media ID helper cleanup: `dealVideoFavorite` now owns
  positive-ID filtering, de-duplication, sorting, comma joining, and null-on-empty
  behavior inline for add/delete media IDs, so `_joinMediaIds` is archived.
- Completed favorites folder item cleanup: the one-use `FavFolderItem` file was folded
  into `FavFolderList` as a private row renderer.
- Completed favorites folder-list loading-skeleton cleanup: `FavFolderList.build` now
  passes its only loading shimmer `ListView` directly to `SmartPagingView`, so the
  private `_Skeleton` wrapper no longer remains beside the folder row renderer.
- Completed favorites private folder-item wrapper cleanup: `_FavFolderItem` was folded
  into `FavFolderList.build`, preserving the keyed row, folder cover/fallback, private
  badge, media count, upper-name text, `AppClickable` open callback, and row
  spacing/sizing.
- Completed favorites page wrapper cleanup: `_FavoritesTabView` and `_AddFolderAction`
  were folded into `FavoritesPage.build`, keeping the page-owned tab controller,
  logged-in tab body, current-tab add-folder visibility, dialog, invalidation, and error
  feedback in one place.
- Completed favorites create-folder helper cleanup: `FavoritesPage.build` now owns the
  add-folder dialog, create repository call, success invalidation, mounted check, and
  error feedback inline, so the one-call `_handleCreateFolder` helper is archived.
- Completed favorites folder dialog DTO cleanup: `FavFolderDialog` now returns a typed
  record for title/intro/privacy, so create and edit flows no longer share a public
  three-field `FavFolderFormData` wrapper with no validation or behavior.
- Completed notification list page wrapper cleanup: `_NotificationListView` and
  `_EmptyNotificationView` were folded into `NotificationListPage`, keeping the page
  controller, load-more gate, separator layout, keyed rows, and empty-state text inline
  with the page-owned `state.when` branches.
- Completed profile menu row wrapper cleanup: `_MenuItem` was folded into `ProfileMenu`
  because it only rendered the single logout row. The menu now owns the `AppClickable`
  padding, icon/text/chevron row, logout dialog, and auth callback inline.
- Completed profile menu wrapper cleanup: `ProfileMenu` was folded into
  `ProfilePage.build`, so the authenticated page owns the logout row, dialog, and auth
  callback directly.
- Completed profile desktop action-grid wrapper cleanup: `_DesktopActionGrid` was folded
  into `ProfileActionGrid`, preserving the desktop `LayoutBuilder`, six-column item width
  calculation, wrap spacing, and shared `_GridItem` renderer used by desktop and mobile.
- Completed profile action-grid action helper cleanup: `ProfileActionGrid._buildActions`
  and the later page-local `_profileActions` wrapper were folded into `ProfilePage.build`,
  keeping the page-owned action list beside the responsive row/wrap branches that consume
  it.
- Completed profile action-grid widget cleanup: `ProfileActionGrid` was folded into
  `ProfilePage.build`, preserving the desktop `LayoutBuilder`, six-column item width
  calculation, wrap spacing, mobile four-action row, disabled download item, and
  settings/history/favorites/watch-later/support callbacks without a separate public
  widget file.
- Completed profile action-grid item wrapper cleanup: `_ProfileActionGridItem` was
  folded into `ProfilePage.build`, preserving the desktop/mobile item widths,
  rounded `AppClickable` chrome, primary icon color, label style, and disabled-action
  no-op callback inline with the authenticated action layout.
- Completed profile action-button wrapper cleanup: `_ProfileActionButton` was folded into
  `UserProfileButtons`, preserving the chat `OutlinedButton` size, border, surface
  background, icon scale, and open-chat callback without a separate widget element.
- Completed user-profile buttons sizing-prop cleanup: `UserProfileButtons` no longer
  exposes unused `height` or `borderRadius` defaults for its single header call site; the
  edit/follow/chat actions keep their 36px height, 8px radii, and chat icon scale inline.
- Completed profile privacy-error wrapper cleanup: `PrivacyErrorWidget` was folded into
  `RelationUserList`, keeping the private relation-list `AppError` code `22115` branch
  beside its only error builder and deleting the standalone feedback widget file.
- Completed profile relation-list empty-text fallback cleanup: `RelationUserList` now
  requires route-owned translated empty text and passes it directly to `SmartPagingView`
  without a default `t.common.no_data` fallback or `emptyText.isEmpty` branch.
- Completed profile relation-list `hasMore` default cleanup: `RelationUserList` now
  requires the route-owned pagination availability from each relation provider instead of
  carrying an unused `false` constructor default.
- Completed feedback error-details helper cleanup: the one-use `_showErrorDetails`
  method was folded into `AppErrorWidget.build`, preserving `ErrorHandler` detail
  construction, selectable monospace content, translated title/confirm labels, and
  dialog close behavior without a separate helper method.
- Completed feedback button wrapper cleanup: `_ErrorDetailsButton` and `_RetryButton`
  were folded into `AppErrorWidget.build`, preserving the same icons, translated labels,
  compact density, retry border, padding, and error-details dialog behavior.
- Completed feedback compactness API cleanup: the one `compact: true` call was converted
  to `AppErrorWidgetVariant.compact`, and the duplicate `compact` boolean API was removed
  so `AppErrorWidgetVariant` is the only compactness source.
- Completed profile app-bar header cleanup: `_HeaderBackground` was folded into
  `ProfileAppBar.build`, keeping the profile/session header row inline with the only app
  bar that owns it.
- Completed profile action-grid helper cleanup: `ProfileActionGrid._buildActions` and
  `ProfilePage._profileActions` are archived; `ProfilePage.build` owns the concrete
  action records beside the only responsive branches that use them.
- Completed player settings danmaku slider-row cleanup: `_DanmakuSliderRow` is archived;
  `PlayerSettingsSheet.build` owns the slider row records, labels, percent values,
  slider ranges/divisions, spacing, and notifier callbacks inline.
- Completed player settings item-key helper cleanup:
  `_InlineTextOptionSectionState.initState` and `didUpdateWidget` now allocate fresh
  option `GlobalKey`s directly beside the initial assignment and `listEquals`-guarded
  item-change branch, so the one-use `_buildItemKeys` helper is archived.
- Completed player settings section-background helper cleanup:
  `PlayerSettingsSheet.build` and `_InlineTextOptionSectionState.build` now own their
  `colorScheme.scrim.withValues(alpha: 0.82)` decoration color directly, so the one-line
  `_settingsSectionBackground` wrapper is archived.
- Completed single-owner list/filter widget cleanup: the one-use `FavResourceItem`,
  `ChatTimeDivider`, and `SearchFilterBar` files were folded into their owning consumer
  files as private widgets.
- Completed notification chat timestamp cleanup: the remaining `_ChatTimeDivider`
  wrapper was inlined into `ChatMessageList` so timestamp grouping, separator spacing,
  and message item rendering are owned by the same list builder.
- Completed notification chat send-result cleanup: `sendMessage`/`sendImage` now return
  a state-owned record for success, skip, or failure, and the public
  `ChatSendResult`/`ChatSendStatus` wrapper types are archived.
- Completed notification chat image input cleanup: `ChatInput` now passes image bytes and
  filename to `Chat.sendImage` as a named record, so the two-field `ChatImageAttachment`
  input wrapper and `chat_send_models.dart` file are archived.
- Completed notification chat input widget cleanup: `ChatPage.build` now owns the only
  text/image input surface inline, preserving image picker bytes/filename behavior,
  send-result handling, scroll-to-bottom behavior, and input chrome without `ChatInput`
  or `chat_input.dart`.
- Completed notification chat display-info helper cleanup: `ChatPage.build` now owns the
  route-provided name/avatar defaults, non-user-session bypass, and profile-card
  loading/null fallbacks inline without `_resolveDisplayInfo`.
- Completed notification chat state part cleanup: `_ChatHelpersMixin` and
  `_ChatSendMixin` were folded into `Chat`, keeping local snapshot sync, older-page
  loading, min-seq tracking, image upload, send, refresh, and paging-error behavior on
  the single notifier owner without `chat_view_model.helpers.dart` or
  `chat_view_model.send.dart`.
- Completed auth/settings single-owner widget cleanup: `AuthBackground`,
  `SettingsSelectionSheet`, and `SettingsSelectionItem` were folded into their owning
  pages as private UI.
- Completed auth presentation local-style cleanup: `AuthTextField.build` owns its single
  fill color inline and `LoginPanel.build` owns the transient feedback background color
  branch inline without local `isDark` or `feedbackBackgroundColor` facades.
- Completed auth login close-callback cleanup: `LoginPanel.onClose` is required because
  both dialog and route owners already supply concrete close behavior; the nullable
  fallback and one-use `closePanel` wrapper are archived.
- Completed history repository page-size token cleanup: `HistoryRepositoryImpl.getHistory`
  keeps the sole cursor page size inline at `getHistoryCursor(..., 20)` without a
  one-use `_historyPageSize` constant.
- Completed video controls utility cleanup: the side-panel/bottom-sheet orientation
  policy now lives with the player controls assembly as `showPlayerSidePanel`, so
  `controls_utils.dart` and the generic `showSidePanel` wrapper are archived.
- Completed player controls orientation helper cleanup: `VideoControlButtons` now
  checks `MediaQuery.orientationOf(context) == Orientation.portrait` inline at the two
  bottom-sheet call sites, so `isPlayerBottomSheetLayout` stays archived.
- Completed player controls progress-bar wrapper cleanup: `PlayerControlsOverlay.build`
  now owns the playback slider, drag state, and seek callback inline, so
  `_VideoProgressBar` stays archived.
- Completed video fullscreen-toggle wrapper cleanup: `_FullscreenToggleButton` was folded
  into `VideoControlButtons.build`, reusing the parent `isFullscreen` provider select and
  preserving `onToggleFullscreen ?? playerController.toggleFullscreen`, fullscreen/exit
  icons, and `_ControlButton` size 26. `_DanmakuToggleButton` is archived too:
  `VideoControlButtons.build` now keeps the danmaku `isEnabled` provider select inside a
  nested `Consumer`, preserving scoped rebuilds, icon/color policy, `setEnabled`, and
  `_ControlButton` size 20 inline. `_SubtitleToggleButton` is archived the same way: the
  subtitle enabled/availability select, no-subtitle `SizedBox.shrink()` branch,
  `toggleSubtitle`, caption icons, color policy, and trailing 4px spacer stay inline in a
  nested `Consumer`. `_PlayPauseControlButton` is archived too: the `isPlaying` select,
  `playOrPause` callback, play/pause icons, and `_ControlButton` size 28 stay inline in a
  nested `Consumer`. `_PlaybackSpeedButton` is archived too: the `playbackSpeed` select,
  formatted speed label, side-panel `QuickSelectionSheet`, playback-speed descriptions,
  and `setPlaybackSpeed` callback stay inline in a nested `Consumer`.
  `_PlaybackQualityButton` is archived too: the selected/available/play-url select tuple,
  quality-label map, side-panel `QuickSelectionSheet`, unavailable empty text, and
  `switchQuality` callback stay inline in a nested `Consumer`. `_TimeText` is archived
  too: the playback position/duration watches, formatted duration label, time style, and
  `RepaintBoundary` stay inline in a nested `Consumer`.
- Completed settings/search page-owned UI cleanup: `SettingsTile`, `SettingsGroup`, and
  `SearchAppBar` were folded into their owning pages as private UI. The remaining
  private `_SearchAppBar` wrapper was later folded into `SearchPage.build`, preserving
  the back button, search field, clear action, and submit button inline. `HotSearchSection`
  keeps provider-backed loading/error/empty/grid rendering inline with the section.
- Completed settings scaffold cleanup: `_SettingsPageScaffold` was folded into
  `SettingsPage` because it only delegated the page into a second private class.
- Completed home app-bar cleanup: `HomeAppBar` was folded into `HomePage` as private
  `_HomeAppBar`, keeping auth gating, search affordance, avatar/message actions, tab
  bar, and the message action button private to the page owner. The avatar/message login
  gates now live inline with their tap owners without a one-use `_handleProtectedTap`
  helper. The one-call `_loadHintText` startup helper is archived too; `HomePage.build`
  now owns default-search hint preloading inline in the post-frame callback beside the
  `home_ready` log.
- Completed home card micro-wrapper cleanup: private live-room cover wrappers and the
  popular-card badge wrapper were folded into their owning cards, keeping card-specific
  media overlays and recommendation tags next to the only state that uses them.
- Completed shared overlay tag wrapper cleanup: video recommendation tags and live-area
  tags now live as card-private widgets, preserving semantic overlay colors and text
  styling without a public `AppOverlayTag` wrapper.
- Completed comment image wrapper cleanup: `CommentItemWidget` now owns its picture
  grid/preview helper privately, preserving single-image sizing, grid spacing, decode
  bounds, hero tags, load/error placeholders, and `AppImagePreview.open` behavior without
  a public `CommentImagesWidget` wrapper file or one-call `_buildSingleImage` /
  `_buildImageGrid` branch helpers.
- Completed comment image load-state helper cleanup: `_CommentImages.build` owns the
  `ExtendedImage` loading/completed/failed switch inline for both single-image and grid
  image branches without `_buildLoadState`.
- Completed comment image single-size helper cleanup: `_CommentImages.build` owns the
  single-image display-size calculation inline beside the branch that uses it, without
  `_resolveSingleImageDisplaySize`.
- Completed home feed wrapper cleanup: `PopularView` and `RecommendView` now own their
  private list/grid rendering, prefetch, scroll-precache, and action-sheet wiring
  directly beside the feed state.
- Completed search history section cleanup: `SearchHistorySection` was folded into
  `SearchPage`, and the remaining private `_SearchHistorySection` was later folded into
  the landing branch as an inline `Consumer` because the history provider watch, clear
  action, and tag tap callback have one page owner.
- Completed search history provider cleanup: `SearchPage` now owns its private
  `_SearchHistory` notifier for the one page that reads and mutates search history.
  Because the current UI only supports add and clear-all, the unused single-entry
  `_SearchHistory.remove` method and `removeSearchHistoryEntry` helper are archived while
  `search_workflows.dart` remains the shared owner of normalization/deduplication rules.
- Completed about page header cleanup: `_AboutHeader` was folded into `AboutPage.build`
  because it only rendered the single page's icon, product name, version tag, and summary
  copy.
- Completed search result item cleanup: the one-use `SearchVideoItem`, `SearchUserItem`,
  `SearchBangumiItem`, `SearchArticleItem`, and `SearchTopicItem` files were folded into
  `SearchResultList`; the remaining private `_SearchVideoItem`, `_SearchUserItem`,
  `_SearchBangumiItem`, `_SearchArticleItem`, and `_SearchTopicItem` renderers are
  archived too. `SearchResultList.build` owns video/user/bangumi/article/topic row
  markup, tap gates, metadata labels, thumbnail policies, optional cover/image branches,
  and stats inline.
- Completed search result prefetch helper cleanup: `SearchResultList.build` now owns
  the image prefetch scan/spec construction inline, preserving the private scan limits,
  per-entry logical dimensions, and final prefetch limit without a one-use
  `_buildSearchResultImagePrefetchSpecs` facade.
- Completed search result pane cleanup: `_SearchResultTab.build` now owns the private
  result provider watch, data/loading/error branches, 10-row skeleton, load-more
  callback, and retry refresh inline, so `_SearchResultPane` stays archived.
- Completed auth repository session cleanup: `auth_repository_impl.session.dart` and
  `_AuthRepositorySessionMixin` were removed, and `checkAndRefreshCookie()` / `logout()`
  now live directly on `AuthRepositoryImpl`, the single session-method owner.
- Completed auth repository helper part cleanup: `auth_repository_impl.helpers.dart` and
  `_AuthRepositoryHelpersMixin` were removed, keeping cached-user/current-user behavior
  directly with `AuthRepositoryImpl`.
- Completed auth repository crypto part cleanup: `auth_repository_impl.crypto.dart` was
  removed, keeping password-login encryption helpers beside the login flow that owns
  them.
- Completed notification chat message renderer cleanup: `ChatMessageItem.build` owns the
  shared bubble padding/decoration and applies it inline for text and unsupported
  messages; one-branch text/image renderers, the system-message pill, and `_ChatBubble`
  are archived from the build-owned dispatch.
- Completed notification chat text/content dispatch cleanup: `ChatMessageItem.build`
  owns message-type content dispatch, including the inlined `_ChatTextMessage`
  `BilibiliEmojiText` configuration, without `_buildContent`.
- Completed `BilibiliEmojiText` emoji helper cleanup: `buildEmojiTextSpan` owns emoji URL
  resolution and `WidgetSpan` construction inline, preserving string/map URL inputs,
  image sizing, tap callback behavior, and fallback text without `_resolveEmojiUrl` or
  `_buildEmojiSpan`.
- Completed notification chat image renderer cleanup: `ChatMessageItem.build` owns the
  image preview branch inline, preserving preview tap, cache sizing, rounded image, and
  loading placeholder without `_ChatImageMessage`.
- Completed notification chat avatar helper cleanup: `ChatMessageItem.build` now owns the
  only left/right avatar widget inline, preserving preview cache sizing, fallback icon,
  and tap callback without `_buildAvatar`.
- Completed notification private-session item cleanup: the one-use `PrivateSessionItem`
  file was folded into `PrivateSessionListView` as a private row renderer.
- Completed notification private-session helper cleanup: the row summary, avatar, and
  unread-badge helpers were folded into the private-session item build method, keeping
  the row's profile lookup and visual chrome in one owner.
- Completed notification feed item cleanup: `_NotificationItemContent`,
  `_NotificationItemHeader`, and `_NotificationSourcePreview` were folded into
  the notification row owner so one notification row owns tap handling, header text,
  and source preview rendering.
- Completed notification feed text helper cleanup: `_getActionText` and `_getSourceText`
  were folded into the notification row build path, preserving notification type labels
  and source-content/title/related-content fallback.
- Completed notification system-notice card cleanup: `_SystemNotificationCard` was folded
  into `SystemNotificationPage` so system-notice row rendering and navigation feedback now
  live beside the only list owner that uses them.
- Completed notification skeleton cleanup: `PrivateSessionSkeletonList` and
  `ChatMessageSkeletonList` were folded into their single owners as private loading UI,
  and the shared `notification_skeletons.dart` file was removed.
- Completed notification private-session loading cleanup: the remaining one-owner
  private-session skeleton wrapper was inlined directly into `PrivateSessionListView`
  so the loading markup now lives beside the list state and item builder that own it.
- Completed notification private-session provider cleanup: `PrivateSessionList` and
  `privateSessionListProvider` were folded into `PrivateSessionListView` as private
  `_PrivateSessionList` / `_privateSessionListProvider`, preserving local paging, head
  sync, older-session loading, talker-id de-dupe, and logged-out empty fallback.
- Completed notification feed provider cleanup: `NotificationFeedList` and
  `notificationFeedListProvider` were folded into `NotificationListPage` as private
  `_NotificationFeedList` / `_notificationFeedListProvider`, preserving type-family
  cursor paging, reply/at/like head sync, older-feed loading, refresh/load-more wrappers,
  and the system-feed empty/no-load path.
- Completed notification list page item/retry helper cleanup:
  `_NotificationListPageState.build` owns the keyed item and retry invalidation
  callback inline, preserving row callbacks and the system-feed retry no-op without
  `_buildItem` or `_retry`.
- Completed notification list load-more helper cleanup: `EasyRefresh.onLoad` owns the
  system-feed no-load branch and `ScrollLoadTrigger.runWithNotifier` call inline, so the
  one-use `_loadMore` wrapper stays archived.
- Completed notification target-open helper cleanup: notification row taps own target
  parsing, `onOpenTarget`, and navigation failure feedback inline, so the one-use local
  `openNotificationTarget` wrapper stays archived.
- Completed notification feed item widget cleanup: `NotificationItemWidget` was folded
  into `NotificationListPage`; `_NotificationListPageState.build` now owns row tap
  parsing, navigation failure feedback, actor avatar taps, header/action/date text,
  message text, and source preview beside the keyed list item builder.
- Completed notification feed cursor cleanup: `NotificationFeedCursor` is now a
  hand-written immutable value beside the notification repository/list-page consumers,
  so `notification_feed_cursor.freezed.dart` is archived and the unused `copyWith`
  helper stays removed.
- Completed notification unread summary cleanup: `NotificationSummary` is now a
  hand-written immutable counter bundle beside the notification repository and
  unread-count page consumer, so `notification_summary.freezed.dart` is archived and the
  unused `copyWith` helper stays removed.
- Completed notification system notice cleanup: `SystemNotice` is now a
  hand-written immutable value beside the notification repository and
  system-notice page consumer, so `system_notice.freezed.dart` is archived and the unused
  `copyWith` helper stays removed.
- Completed notification chat loading cleanup: the remaining `_ChatMessageSkeletonList`
  and `_ChatMessageSkeletonItem` wrappers were inlined directly into `ChatPage` so chat
  loading markup now lives beside the only async chat state branch that owns it.
- Completed video detail info renderer cleanup: `VideoStatsRow`,
  `RecommendationItem`, `VideoPartsSection`, `ExpandableDescriptionAndTags`,
  `VideoActionsRow`, and `VideoCollectionSummary` were made private to
  `video_info_view.dart`; the one-use `_VideoCollectionSummary` row was then folded into
  `_VideoInfoEngagementSection.build` and the one-use `_VideoStatsRow` was folded into
  the header owner. The one-use `_VideoInfoHeaderSection` is now folded into
  `_VideoInfoLoadedContent.build`, preserving the owner tile, login-gated follow tap,
  title expansion, stats/BVID row, and description/tag placement. The one-use
  `_ExpandableDescriptionAndTags` helper is now folded into the same owner with a
  branch-local `HookBuilder`, preserving description expansion independently from title
  expansion. `_VideoActionsRow` was also folded into `_VideoInfoEngagementSection.build`
  while retaining `_ActionButton` as the repeated action primitive. The one-use
  `_RecommendationItem` row is folded into `_VideoInfoLoadedContent.build`, preserving
  related-video card rendering beside the sliver builder that owns it.
- Completed video detail parts-section cleanup: `_VideoPartsSection` was folded into
  `_VideoInfoEngagementSection.build`, preserving the multi-part gate, section label,
  horizontal part list, selected-state graphic-eq icon/coloring, part title fallback, and
  `onPartChanged` callback inline with the only engagement section owner.
- Completed video detail tag-chip cleanup: `_CompactTag` was folded into
  the description/tag `HookBuilder` in `_VideoInfoLoadedContent.build`, keeping expanded
  tag styling beside the only description/tag owner.
- Completed video player overlay chrome cleanup: `PlayerTopBar` and `PlayerBottomBar`
  were folded into `PlayerControlsOverlay`; the remaining one-use bottom-bar and lock
  button glue was then inlined directly into `PlayerControlsOverlay.build`, followed by
  the one-use settings launcher closure.
- Completed vertical video right-action cleanup: `_RightActionItem` was folded into
  `_RightBar.build` so the action icon/count row stays beside the only action-list owner.
- Completed vertical video top/right wrapper cleanup: `VerticalVideoPage.build` owns the
  SafeArea top controls and right action column inline, preserving back pop, watching
  count text, search/more icons, action counts, spacing, and formatted stats without
  `_TopBar` or `_RightBar`.
- Completed vertical video bottom-bar wrapper cleanup: `_BottomBar` was folded into
  `VerticalVideoPage.build`, preserving the author/title/play-count/progress/action
  chrome and keeping playback position/duration watches inside an inline `Consumer`
  rebuild boundary.
- Completed video player one-owner overlay wrapper cleanup: `ControlsLayer` was folded
  into `VideoPlayerView` and then fully inlined into `VideoPlayerView.build`; 
  `GestureFeedbackOverlay` was folded into interaction-layer gesture handling as private
  render glue.
- Completed video player seek-edge cleanup: `_SeekDoubleTapOverlay` was folded into
  `_InteractionGestureSurface` so edge seek dispatch stays beside the only gesture owner.
- Completed video comment reply bottom-bar cleanup: the one-use `BottomInputBar` file was
  deleted because its only live caller did not provide a real input handler.
- Completed video detail interaction helper cleanup: like, coin, and favorite optimistic
  state transitions now live privately with `VideoDetailController`; the one-consumer
  `video_detail_interactions.dart` application helper file is archived.
- Completed profile banner cleanup: the one-use `UserProfileBanner` file and its later
  private `_UserProfileBanner` wrapper were folded into `UserProfileHeader`, keeping the
  banner image/gradient stack beside the only owner of image preview behavior.
- Completed profile relation route page wrapper cleanup: `FollowersPage` and
  `FollowingsPage` were folded into a private profile navigation relation route page,
  preserving each provider, title, empty text, refresh/load-more, `hasMore`, scaffold, and
  app bar while keeping the public route builder functions.
- Completed profile relation private switch wrapper cleanup: `_RelationUsersRoutePage`
  and `_RelationUsersRouteKind` were folded into `buildFollowingsRoutePage` and
  `buildFollowersRoutePage`; each route builder now owns its `Consumer`, title, provider
  watch/read, refresh/load-more callbacks, `hasMore`, empty text, and relation scaffold
  inline.
- Completed profile header badge/tag cleanup: `_VerifiedBadge` and `_UidTag` were folded
  into `UserProfileHeader.build`, keeping the one-use verified badge and UID label beside
  the only header state that renders them.
- Completed profile stats cleanup: the one-page `ProfileStats` sliver now lives privately
  in `profile_page.dart` beside the authenticated page layout and profile navigation
  callbacks that own it.
- Completed profile guest-view cleanup: the logged-out `GuestProfileView` file and
  remaining `_GuestProfileView` wrapper were folded into `ProfilePage.build`, beside the
  session gate, login navigation callback, and settings action that own them.
- Completed profile app-bar action helper cleanup: `ProfileAppBar._buildActions` was
  folded into `ProfileAppBar.build`, keeping the single settings action beside the app
  bar that owns it.
- Completed profile app-bar header-background cleanup: `_HeaderBackground` was folded
  into `ProfileAppBar.build`, keeping the single header row beside the only app bar
  state that supplies profile/session data.
- Completed profile app-bar avatar cleanup: `_ProfileAvatar` was folded into
  `ProfileAppBar.build`, keeping the one-owner hero/avatar border chrome beside the
  profile header state that supplies the image URL.
- Completed profile app-bar detail cleanup: `_ProfileDetails` was folded into
  `ProfileAppBar.build`, keeping the username, VIP tag, level progress, and bio rows
  beside the same profile header owner.
- Completed profile app-bar experience-bar cleanup: `_ExpBar` was folded into
  `_ProfileDetails.build`, keeping the single level-progress row beside the profile
  header state that owns the current/min/next exp values.
- Completed user profile app-bar menu helper cleanup: `_showMoreMenu` was folded into
  `UserProfileAppBar.build`, preserving the share/blacklist/report bottom sheet actions
  beside the only more button that opens them.
- Completed app bottom-sheet helper cleanup: `showAppModalBottomSheet` was folded into
  the same `UserProfileAppBar.build` call site, preserving surface color, rounded top
  shape, clip behavior, and the share/blacklist/report actions without keeping a
  one-call shared overlay helper file.
- Completed user profile app-bar icon helper cleanup: `UserProfileAppBar.build` now owns
  the back/search/more circular icon button chrome directly, preserving margins,
  background, icon size, constraints, shrink-wrap tap target, and callbacks without
  keeping `_buildIconButton`.
- Completed profile banner preview cleanup: `UserProfileHeader.build` now owns the only
  banner and avatar tap handlers inline, so `_showImagePreview` stays archived.
- Completed shared user-list title helper cleanup: `UserListTile.build` now owns the
  title typography, optional badge row, stats row, and optional subtitle text inline, so
  `_buildTitle`, `_buildTitleRow`, `_buildStatsRow`, and `_buildSubtitle` stay archived.
- Completed follow-button label helper cleanup: `FollowButton.build` now computes one
  local label for both accessibility and visible text, so `_resolveLabel` stays archived.
- Completed app-tag wrapper cleanup: the remaining badge/pill owners now render their
  concrete `Container` and `Text` inline, so `AppTag`, `app_tag.dart`,
  `_backgroundColor`, and `_foregroundColor` stay archived.
- Completed VIP tag shadow helper cleanup: `VipTag.build` now owns the `showShadow`
  null-or-single-`BoxShadow` branch inline, so its one-call `_buildShadow` stays
  archived.
- Completed level tag color helper cleanup: `LevelTag.build` now owns the level-to-
  `ColorScheme` switch expression inline, so `_resolveLevelColor` stays archived.
- Completed app-card decoration helper cleanup: `AppCardContainer` now builds the
  `BoxDecoration` and performance-policy `BoxShadow` switch inline in the
  `ValueListenableBuilder`, so `_buildDecoration` and `_buildShadow` stay archived.
- Completed profile home-tab header cleanup: recent videos now uses shared
  `SectionHeader` with a trailing view-more link instead of a duplicate private header
  row.
- Completed single-consumer data mapper cleanup: history, profile, and favorites
  DTO-to-domain mapper extensions now live privately in their sole repository libraries,
  the to-view copy-only mapper was removed after `ToViewEntry` became the item JSON
  owner, favorites favorite-delta media ID joining stays in the owning repository method,
  and the public mapper files are archived.
- Completed notification system-notice mapper cleanup: system-notice JSON persistence
  mapping now lives with the canonical `SystemNotice` entity instead of a data mapper;
  the separate `system_notice_mapper.dart` file and mapper-level helper ownership are
  archived.
- Completed notification message-support helper cleanup: system notification talker lookup
  now lives inline in `_fetchSystemNotifications`, text/URI parsing helpers live privately
  on `NotificationFeedSync`, and the one-owner extension file
  `notification_repository_impl.message_support_helpers.dart` plus public helper method
  surface are archived.
- Completed notification message-support dead-helper cleanup:
  `NotificationMessagePersistence` remains the only owner for emoji key canonicalization,
  emoji variant insertion, and local-row-to-message conversion; duplicate
  `NotificationMessageSupport` helper copies were removed.
- Completed notification message-support owner cleanup: `NotificationFeedSync` now owns
  the feed remote fetch dispatch, like response normalization, system talker lookup, and
  system notice extraction directly. The one-use `_resolveSystemTalkerId` helper is
  archived so the dedicated system-notice fetch owns its talker selection beside the
  private-session read. The one-owner `NotificationMessageSupport` delegate and
  `notification_repository_impl.message_support.dart` are archived.
- Completed notification landing category-grid cleanup: the one-page
  `NotificationCategoryGrid` wrapper is archived; `NotificationPage.build` owns the
  unread-count watch and category row beside the callbacks that consume it.
- Completed notification landing category/manual-refresh helper cleanup:
  `NotificationPage.build` owns the four category item render branches inline,
  preserving unread badges and callbacks without `_NotificationCategoryGrid` or
  `_buildCategoryItem`; `_UnreadCount` keeps only active stream-watch and initial-sync
  behavior without an unwired manual `refresh()` method.
- Completed recently-followed item cleanup: the private `_UserItem` renderer was folded
  into `RecentlyFollowedWidget`, keeping the avatar/name row inline with the owning
  dynamic feed section.
- Completed recently-followed header wrapper cleanup: `DynamicListView` now owns the
  all-tab recently-followed header privately, preserving the provider watch,
  empty/loading/error shrink behavior, translated section title, 90px horizontal avatar
  list, primary outline ring, network avatar provider, and 64px ellipsized user names
  without a public `RecentlyFollowedWidget` file.
- Completed recently-followed provider cleanup: the one-consumer `RecentlyFollowed`
  provider shell now lives as a private `FutureProvider.autoDispose` in
  `dynamic_list_view.dart`; `recently_followed_provider.dart` and its generated output
  are archived.
- Completed upload-image model cleanup: `DynamicUploadImageResponseDto`,
  `UploadedPublishImage`, and notification `ImageUploadResult` were collapsed
  into the canonical `UploadedImage` contract so dynamic publish and chat image
  send share one upload-image shape.
- Completed dynamic publish response cleanup: `DynamicPublishResponseDto` and its
  generated files were deleted; `DynamicApi.createDynamic` now returns
  `ApiResponse<void>` because `publishDynamic` only validates server success and no
  current flow consumes `dyn_id_str`.
- Completed dynamic publish command shell cleanup: `PublishMediaAsset` now remains as a
  hand-written path value, while unused `PublishDynamicCommand` and
  `dynamic_publish_command.freezed.dart` are archived because publish text/images already
  flow through page-controller and repository parameters. The unused
  `PublishMediaAsset.copyWith` helper is archived too.
- Completed dynamic emote DTO consolidation: `EmoteCatalogPackage` and
  `EmoteCatalogItem` now own the user emote catalog JSON shape, while
  `EmoteApi.getUserEmotes` exposes raw response data to the repository boundary. The
  duplicate `EmoteResponse`, `EmotePackage`, and `Emote` DTO mirrors plus generated
  files are archived. The catalog also uses `JsonUtils.asStringKeyedMap` directly for
  JSON object coercion instead of keeping a private `_readStringKeyedMap` utility copy,
  and emote id parsing now calls `JsonUtils.parseInt` directly instead of keeping a
  private `_readRequiredInt` scalar helper. Required `text`/`url` fields now keep their
  strict string checks inline, so the private `_readRequiredString` helper is archived
  without widening behavior to string coercion. `EmoteRepositoryImpl.getUserEmotePackages`
  now parses the repository `packages` envelope inline, so `_parseEmotePackages` is
  archived as well.
- Completed nav endpoint constant cleanup: `ApiConstants.userInfo` now aliases
  `ApiConstants.nav`, leaving `/x/web-interface/nav` with one literal owner while
  preserving auth/profile call-site names.
- Completed favorites resource-stats cleanup: `FavCntInfoModel` was collapsed into
  `FavoriteResourceStats`, so favorites resource API decoding and app-facing resource
  state share one count-stats shape.
- Completed favorites folder-info cleanup: `FavoriteFolderInfo` was collapsed into
  `FavoriteFolder`, so favorite resource page `info` decoding and app-facing state
  share one folder metadata shape while preserving `media_count` decoding.
- Completed favorites folder/resource item DTO cleanup: `FavoriteFolder` and
  `FavoriteResource` now own JSON decoding for folder/resource items and add/edit
  responses, so `FavFolderModel`, `FavResourceModel`, `_FavFolderMapper`, and
  `_FavResourceMapper` are archived.
- Completed dynamic post card view-data cleanup: dynamic list/detail/topic/user-feed
  card widgets now take canonical `DynamicItem` and read presentation fields through
  `dynamic_item_extensions.dart`; `DynamicPostCardViewData` and
  `DynamicPostCardViewDataMapper` are archived.
- Completed dynamic item mapper part cleanup: private video/link-card/additional content
  mappers now live in `dynamic_item_extensions.dart` beside
  `DynamicItemContentExtension`, removing the one-owner
  `dynamic_item_extensions.mappers.dart` part split without changing mapped content
  behavior.
- Completed dynamic video-content mapper helper cleanup:
  `DynamicItemContentExtension.videoContent` now owns the archive/UGC-season projection
  inline, so `_dynamicMapVideoContent` is archived as a one-call helper while the larger
  link-card/additional mappers remain private beside the extension.
- Completed profile user-space video model/response cleanup: `ProfileVideo` owns
  user-space JSON decoding and normalization, while `ProfileRepositoryImpl` now parses
  the API-only `list.vlist` response shape directly. `UserSpaceVideoModel`,
  `UserSpaceVideoListResponse`, and copy-only repository mappers are archived.
- Completed profile user-space list-parser helper cleanup: `getSpaceVideos` now keeps
  the `list.vlist` unwrap and `ProfileVideo.fromJson` mapping inline, so
  `_parseUserSpaceVideos` is archived and guarded.
- Completed profile video pub-date helper cleanup: `ProfileVideo.fromJson` now keeps
  the `pubDate`/`pubdate` fallback inline, so the one-use `_readPubDate` scalar helper
  is archived and guarded.
- Completed profile video Freezed shell cleanup: `ProfileVideo` now remains as a
  hand-written immutable value in `profile_video.dart`, preserving user-space JSON
  normalization, `stat`/`inter_video` wire keys, defaults, equality, and diagnostics
  without generated Freezed/JSON shell files. The unused `copyWith` and `toJson` helpers
  are archived too.
- Completed favorites folder/resource Freezed shell cleanup: `FavoriteFolder`,
  `FavoriteResourceStats`, `FavoriteResource`, and `FavoriteResourcePage` now remain as
  hand-written immutable domain values, preserving `fav_state`, `media_count`,
  `cnt_info`, `fav_time`, `bv_id`, `preferredBvid`, `isPrivate`, nullable clearing,
  list equality, and JSON parsing without generated Freezed/JSON shell files.
- Completed favorites resource dead-code cleanup: the unused `copyWith` helpers on
  `FavoriteResourceStats`, `FavoriteResource`, and `FavoriteResourcePage` are archived.
  The resource models keep constructor/fromJson, `preferredBvid`, equality,
  list immutability, and folder-resource page parsing semantics; `FavoriteFolder.copyWith`
  remains live for folder-cover updates and is intentionally retained.
- Completed favorites resource serialization dead-code cleanup: the unused `toJson`
  helpers on `FavoriteResourceStats` and `FavoriteResource` are archived. The resource
  models keep constructor/fromJson, `preferredBvid`, equality, immutable page media
  lists, and folder-resource read semantics.
- Completed favorites folder serialization dead-code cleanup: the unused
  `FavoriteFolder.toJson` helper is archived. `FavoriteFolder` keeps constructor/fromJson,
  `fav_state`/`media_count` decoding, `isPrivate`, equality, diagnostics, and the live
  `copyWith` cover-normalization path used by collected-folders state.
- Completed notification private-message emoji cleanup: `PrivateMessageEmoji` now owns
  `gif_url` JSON decoding, `PrivateMessageListResponse.e_infos` decodes directly to the
  canonical emoji model, and `PrivateMessageEmojiInfo` plus its mapper are archived.
- Completed notification private-message account-info cleanup:
  `PrivateMessageSession.accountInfo` now decodes directly to the canonical
  `PrivateSessionAccountInfo`, preserving `account_info.pic_url` parsing while removing
  `PrivateMessageAccountInfo` and its copy-only mapper.
- Completed notification private-message account-info helper cleanup:
  `PrivateMessageSession.fromJson` and `PrivateMessageSession.toJson` now own the
  canonical account-info JSON shape inline, so `_privateSessionAccountInfoFromJson` and
  `_privateSessionAccountInfoToJson` are archived as one-use DTO helpers.
- Completed notification private-message Freezed shell cleanup: `PrivateMessage` and
  `PrivateMessageEmoji` now remain as hand-written immutable values in
  `private_message.dart` / `private_message.types.dart`, preserving message helper
  semantics, at-uid list equality, and `gif_url` JSON parsing without
  `private_message.freezed.dart` or `private_message.g.dart`. The unused
  `PrivateMessage.copyWith`, `PrivateMessageEmoji.copyWith`, and
  `PrivateMessageEmoji.toJson` helpers are archived too.
- Completed notification private-message DTO Freezed shell cleanup:
  `PrivateMessageSessionResponse`, `PrivateMessageSession`, `PrivateMessageDetail`, and
  `PrivateMessageListResponse` now remain as hand-written DTOs in
  `private_message_model.dart`, preserving session/list wire keys, `account_info.pic_url`,
  `last_msg`, `at_uids`, `e_infos`, list equality, shallow `system_msg` map
  equality/hash through Flutter `mapEquals` and `collection`'s `MapEquality`, `content`
  deep equality/hash through `collection`'s `DeepCollectionEquality`, and DTO-local
  `contentMap` parsing without `private_message_model.freezed.dart` or
  `private_message_model.g.dart`.
- Completed notification private-message DTO map-hash cleanup:
  `PrivateMessageSessionResponse.hashCode` now delegates `system_msg` hashing to
  `collection`'s shallow `MapEquality`, so the hand-written unordered entry hash stays
  archived beside the DTO.
- Completed notification private-message DTO copy-helper cleanup:
  `PrivateMessageSessionResponse`, `PrivateMessageSession`, `PrivateMessageDetail`, and
  `PrivateMessageListResponse` keep the hand-written DTO boundary in
  `private_message_model.dart`, but their unused DTO-local `copyWith` helpers are
  archived.
- Completed notification private-message response-shell serializer cleanup:
  `PrivateMessageSessionResponse.toJson` and `PrivateMessageListResponse.toJson` are
  archived because current repository/cache flows consume fields and nested serializers
  directly. `PrivateMessageSession.toJson` and `PrivateMessageDetail.toJson` remain for
  cache round-trips.
- Completed notification private-session Freezed shell cleanup: `PrivateSession` and
  `PrivateSessionAccountInfo` now remain as hand-written immutable values in
  `private_session.dart`, preserving nullable fields, equality/hash, and diagnostics
  without a generated Freezed shell. Their unused `copyWith` helpers are archived too.
- Completed notification summary mapper cleanup: unread-summary cache parsing now lives
  inline in `NotificationRepositoryImpl.watchUnreadCount`, so the one-use
  `notificationSummaryFromJson` mapper and unused `notificationSummaryToJson` write
  mapper are archived.
- Completed notification repository helper/service cleanup:
  `NotificationRepositoryImpl` now owns local read queries, unread and system-notice
  stream parsing, upload/send outbox behavior, and the repository-level bridge to feed
  sync. `NotificationFeedSync` owns the reply/at/like support fetches and system-notice
  API parsing it uses directly. `NotificationLocalReadStore`,
  `NotificationStreamWatchers`, `NotificationMessageSupport`,
  `NotificationMessageSendService`, and `SyncMessagesHeadFn` are archived so these
  one-owner helper splits do not coexist with the repository boundary.
- Completed notification private-message DTO convenience cleanup:
  `PrivateMessageDetail` keeps the active `contentMap` parser but no longer exposes
  unused DTO-local `isMe`, text/image/system-tip, withdrawn, or summary-kind helpers.
- Completed notification reply actor cleanup: `NotificationActor` now owns `mid_link`
  JSON decoding, `ReplyItem.user`, `ReplyItem.users`, and `ReplyItemDetail.atDetails`
  decode directly to the canonical actor model, and `ReplyUser` plus
  `ReplyUserMapper` are archived. `ReplyItemDetail` remains a data DTO because it owns
  reply wire/cache shape and the `subject_id`/`item_id` fallback.
- Completed notification reply DTO Freezed shell cleanup: `ReplyResponse`,
  `ReplyCursor`, `ReplyItem`, and `ReplyItemDetail` now remain as hand-written DTOs in
  `reply_model.dart`, preserving reply feed wire keys, `subject_id`/`item_id` fallback
  behavior, nullable actor/time fields, list equality, and local cache serialization
  without `reply_model.freezed.dart` or `reply_model.g.dart`.
- Completed notification reply DTO copy-helper cleanup: `ReplyResponse`,
  `ReplyCursor`, `ReplyItem`, and `ReplyItemDetail` keep the hand-written DTO boundary
  in `reply_model.dart`, but their unused DTO-local `copyWith` helpers are archived.
- Completed notification reply response-shell serializer cleanup:
  `ReplyResponse.toJson` and `ReplyCursor.toJson` are archived because current API/feed
  flows only deserialize the response shell. `ReplyItem.toJson` and
  `ReplyItemDetail.toJson` remain for local feed cache round-trips.
- Completed notification entry Freezed shell cleanup: `NotificationActor`,
  `NotificationEntryDetail`, and `NotificationEntry` now remain as hand-written
  immutable values in `notification_entry.dart`, preserving `mid_link` JSON parsing,
  `NotificationActor` JSON output, actor/detail list equality, and `primaryActor`/`eventTime`
  behavior without `notification_entry.freezed.dart` or `notification_entry.g.dart`. The
  unused `copyWith` helpers are archived too.
- Completed notification reply detail mapper cleanup: `ReplyItemMapper` now builds
  `NotificationEntryDetail` directly, removing the one-use `ReplyItemDetailMapper`
  extension while keeping `ReplyItemDetail` as the wire/cache DTO owner.
- Completed notification reply subject-id helper cleanup: `ReplyItemDetail.fromJson`
  now keeps the `subject_id`/`item_id` fallback inline, preserving the wire behavior
  while removing the private one-use `_readSubjectId` helper.
- Completed architecture guard coverage sync for archived DTO/mapper wrappers:
  favorites resource stats, notification emoji/reply actor, live gold-rank/danmu/guard,
  video subtitle/play-url, profile cache repository file, and class-modifier variants for
  dynamic emote and home tab sync wrappers now fail the guard if reintroduced.
- Completed architecture guard coverage sync for archived generated/file wrappers:
  generated DTO artifact filenames, application/core port files, shell navigation item
  files/classes, dynamic route wrapper functions, `RequestExecutor.runVoid`,
  `DynamicUploadImageResponseDto`, favorites mapper file, notification system-notice
  mapper file, notification message-support helper file, and notification message-send
  delegate file now fail the guard if reintroduced.
- Completed history DTO consolidation: `HistoryEntry` now owns history item JSON decoding
  for title, cover, nested `history.bvid` / `history.business`, author, viewed-at,
  progress, duration, and badge. `HistoryRepositoryImpl.getHistory` now parses the
  transport `list` envelope directly, and `HistoryResponseDataDto`, `HistoryCursorDto`,
  `HistoryTabDto`, `HistoryItemDto`, `HistoryDetailDto`, `_HistoryItemMapper`, plus the
  one-use `_parseHistoryEntries` repository helper are archived because no current
  repository or UI path needs separate DTO mirrors.
- Completed history entry Freezed shell cleanup: `HistoryEntry` now remains as a
  hand-written immutable value in `history_entry.dart`, preserving current JSON decoding,
  equality, hash, and string diagnostics without `history_entry.freezed.dart`. The unused
  `copyWith` helper is archived too.
- Completed history/to-view integer helper cleanup: `HistoryEntry.fromJson` and
  `ToViewEntry.fromJson` now use `JsonUtils.parseIntWithDefault` for their numeric item
  fields, and the duplicated private `_readInt` helpers are archived.
- Completed history/to-view strict string helper cleanup: `HistoryEntry.fromJson` and
  `ToViewEntry.fromJson` now keep string-only fallback checks inline and the duplicated
  private `_readString` helpers are archived without widening behavior to
  `JsonUtils.parseStringWithDefault`.
- Completed notification private-message content string helper cleanup:
  `PrivateMessageContent` getters now read nullable content strings inline from the raw
  map without the private `_readString` clone, preserving null fallback behavior without
  widening through `JsonUtils.parseStringWithDefault`.
- Completed to-view nested helper cleanup: `ToViewEntry.fromJson` now keeps the
  `owner` and `stat` map unwrap beside the only fields that consume them, so `_readOwner`
  and `_readStat` are archived without changing the existing null fallback or cast
  behavior.
- Completed history nested helper cleanup: `HistoryEntry.fromJson` now keeps the nested
  `history` map unwrap beside the `bvid` and `business` fields that consume it, so
  `_readHistory` is archived without changing the existing null fallback or cast
  behavior.
- Completed favorite detail list-section cleanup: `FavoriteDetailPage` now owns its
  resource sliver list, empty state, selection toggling, and pagination error renderer
  directly, so `_FavoriteDetailListSection` no longer remains as a one-page UI wrapper.
- Completed favorite detail resource-row wrapper cleanup: `_FavoriteResourceRow` was
  folded into `FavoriteDetailPage.build`, preserving selection checkbox behavior,
  `VideoListCard` dimensions, upper-name text, more-action feedback, play/danmaku stat
  chips, divider, and row tap selection toggling inline with the sliver item builder.
- Completed favorite detail loading-skeleton cleanup: `FavoriteDetailPage` now owns the
  fixed 10-row shimmer loading list directly in its loading branch, so the one-use
  `_FavoriteDetailSkeleton` wrapper no longer remains beside the page.
- Completed favorite detail app-bar actions cleanup: `FavoriteDetailPage.build` now owns
  its selection-mode delete/close actions, owner popup menu, and non-owner empty action
  state directly, so `_buildFavoriteDetailAppBarActions` no longer remains beside the
  page.
- Completed favorite detail batch resource delete helper cleanup:
  `FavoriteDetailPage.build` now owns the selection-mode delete repository call,
  selected-id join, success selection reset, resource-list invalidation, mounted check,
  and error feedback inline without `_handleDeleteResources`.
- Completed favorite detail edit-folder helper cleanup:
  `FavoriteDetailPage.build` now owns the owner-popup edit dialog, current-folder lookup,
  update repository call, success folder-list invalidation, mounted check, and error
  feedback inline without `_handleEditFolder`.
- Completed favorite detail delete-folder helper cleanup:
  `FavoriteDetailPage.build` now owns the owner-popup delete confirmation, delete
  repository call, success folder-list invalidation, mounted navigation pop, and error
  feedback inline without `_handleDeleteFolder`.
- Completed favorite detail folder-header cleanup: `FavoriteDetailPage.build` now owns
  the non-null folder cover/title/owner/count header inline, so `_FavoriteFolderHeader`
  no longer remains as a one-use page wrapper.
- Completed profile optional integer helper cleanup: `ProfileRepositoryImpl` now parses
  relation followers/following, likes, and video count with `JsonUtils.parseIntWithDefault`
  directly instead of keeping a private `_readOptionalInt` wrapper.
- Completed profile optional counter helper cleanup: `getProfile` now reads optional
  up-stat and nav-number response maps through the shared `_optionalResponseDataMap`
  gate and parses likes/video count inline, so `_parseLikes` and `_parseVideoCount`
  no longer exist as one-use wrappers.
- Completed profile VIP scalar helper cleanup: `ProfileRepositoryImpl.getProfile` now
  reads the optional `vip` map once and parses `type`/`status` with
  `JsonUtils.parseIntWithDefault`, so the private `_parseVipType` and `_parseVipStatus`
  one-use helpers are archived.
- Completed history page provider cleanup: `HistoryPage` owns its private
  `FutureProvider.autoDispose` for the history list state, so `history_controller.dart`
  and its generated output are archived.
- Completed to-view entry Freezed shell cleanup: `ToViewEntry` now remains as a
  hand-written immutable value in `to_view_entry.dart`, preserving current JSON decoding,
  progress getters, equality, hash, and string diagnostics without
  `to_view_entry.freezed.dart`. The unused `copyWith` helper is archived too.
- Review `notification_repository_impl.*`; it is split across many sibling helper files
  and should be merged or moved into a deliberate data subpackage after impact analysis.
- Keep `RequestExecutor`, `Result`, and `AppError` as the shared network/error boundary.
- Completed `AppError` bad-response helper cleanup: `_fromBadResponse` was folded into
  the Dio branch now owned by `AppError.fromObject`, preserving 401/403 auth
  classification, response status/message propagation, and server fallback without a
  one-call private helper.
- Completed `AppError` Dio helper cleanup: `_fromDioException` was folded into
  `AppError.fromObject`, preserving Dio type mapping, 401/403 auth classification,
  response status/message propagation, request cancellation, certificate, unknown, and
  original-cause handling without a second one-call private helper.
- Completed object API response decoder helper cleanup: `decodeObjectApiResponse` now owns
  JSON object validation and `Map<String, dynamic>.from` normalization inline, so
  `_requireJsonObject` is archived without changing the public decoder.
- Completed JSON compute callback wrapper cleanup: `jsonDecodeCompute` now passes
  `jsonDecode` directly to `compute`, preserving the isolate threshold without a one-line
  `_parseAndDecode` wrapper.
- Completed endpoint policy provider cleanup: `NetworkQualityInterceptor` now constructs
  `EndpointPolicyResolver` from `runtimePerformancePolicyProvider` directly, so the
  one-consumer generated `endpoint_policy_provider.dart` wrapper is archived.
- Completed network quality normalization helper cleanup:
  `_profileFromConnectivityResult` now owns single/list/iterable connectivity-result
  normalization inline, so `_normalizeResults` stays archived.
- Completed network quality stream helper cleanup: `networkQualityProfile` now owns the
  initial connectivity read, normal fallback on failure, changed-stream profile mapping,
  and `distinct()` filter inline, so `_watchConnectivityProfiles` stays archived.
- Completed WBI signer wrapper cleanup: `WbiHelper` now owns WBI mixin-key construction,
  sorted query normalization, and `w_rid` generation directly; the one-owner
  `wbi_signer.dart`/`WbiSigner` helper class is archived.
- Completed WBI mixin-key helper cleanup: `WbiHelper.sign` now owns its one-use
  key-material permutation inline, so `_getWbiMixinKey` stays archived.
- Completed resource API provider wrapper cleanup: `ResourceApi` now owns only the
  reusable `basicResourceApiProvider` factory beside the Retrofit interface. The full
  `dioClientProvider` construction is inline in `videoRepository`, its only current
  consumer, and `resourceApiProvider` plus the old generated provider file are archived.
- Completed WBI helper provider wrapper cleanup: `AuthInterceptor` now lazily owns its
  single `WbiHelper` from `basicResourceApiProvider`, so `wbiHelperProvider` and
  `wbi_helper_provider.g.dart` stay archived.
- Completed auth interceptor CSRF cache helper cleanup: `_ensureCookieRefreshed` now clears
  `_cachedCsrf` inline in the cookie-refresh `whenComplete` block beside
  `_refreshCookieFuture` reset, so the one-use `_invalidateCsrfCache` helper stays
  archived.
- Completed retry-delay helper cleanup: `_createRetryInterceptor` now owns the only
  exponential retry delay list inline beside retry evaluation, so `_retryDelays` stays
  archived.
- Completed retry-interceptor replacement helper cleanup: `dioClient` now owns its
  network-policy listener retry interceptor add/replace branch inline, so
  `_replaceRetryInterceptor` stays archived.
- Completed endpoint cache TTL helper cleanup: `_basePolicyFor` now owns the only cache
  TTL override/config lookup inline beside the endpoint-class policy matrix, so
  `_cacheTtlFor` stays archived.
- Completed request-policy cache-key delegate cleanup: `CacheOptions` now calls the
  canonical `RequestPolicyInterceptor.buildCacheKey` source of truth inline, so the
  one-use `_generateCacheKey` tear-off stays archived.
- Completed request-policy timeout policy accessor cleanup:
  `RequestPolicyInterceptor.onRequest` now owns the cached network-policy read/provider
  fallback inline beside timeout application, so `_getPolicy` stays archived.
- Completed request-policy cache-options helper cleanup:
  `RequestPolicyInterceptor.onRequest` now owns the only GET `force_refresh` removal,
  refresh cache policy, cache-TTL force-cache branch, and `buildCacheKey` wiring inline,
  so `_applyCacheOptions` stays archived.
- Completed in-flight dedup predicate cleanup: `InFlightDedupInterceptor.onRequest` owns
  the only GET, endpoint-policy, and disable-extra gate inline, so `_shouldDeduplicate`
  stays archived.
- Completed in-flight dedup key helper cleanup: `InFlightDedupInterceptor.onRequest` owns
  the host/path key, no-query fast path, single-query fast path, and sorted multi-query key
  construction inline, so `_buildDedupKey` stays archived.
- Completed in-flight dedup response-clone cleanup: the waiting-request `handler.resolve`
  branch owns the only response clone construction inline, so `_cloneResponseForRequest`
  stays archived.
- Completed in-flight dedup completion helper cleanup: `InFlightDedupInterceptor.onResponse`
  and `onError` own dedup-key lookup, in-flight map removal, completer completion, and
  error stack-trace propagation inline, so `_completePendingSuccess` and
  `_completePendingFailure` stay archived.
- Completed cache-store directory fallback cleanup: `cacheStore` owns the temp-directory
  fallback closure at the lazy store boundary, so `_resolveCacheDirectory` stays archived.
- Completed cookie-jar lazy creation cleanup: `_LazyPersistCookieJar._resolve` owns the
  only persistent jar directory lookup, `PersistCookieJar` construction, and `_jar`
  assignment inline, so `_create` stays archived.
- Completed audio-handler dispose helper cleanup: `CilixiliAudioHandler.dispose` owns
  subscription cancellation, player disposal, error logging, and shared-instance reset
  inline, so `_disposeResources` stays archived.
- Completed pagination load-gate getter cleanup: duplicate-load state is private to
  `PaginationLoadGate.run` and `reset`, so the unused public `isInFlight` getter stays
  archived.
- Completed scroll-notification trigger helper cleanup:
  `ScrollLoadTrigger.triggerOnScrollNotificationWithGate` owns the scroll-end default,
  vertical-axis gate, viewport-adjusted threshold clamp, inclusive
  `extentAfter <= threshold` check, and gated scheduling inline, so
  `resolveExtentAfterThreshold`, `shouldTriggerByExtentAfter`, and
  `shouldTriggerOnScrollNotification` stay archived.
- Do not replace the network stack until all repository call sites can move in one
  coherent phase.

## Phase 4: Feature Directory Simplification

Goal: remove template-shaped layers that do not carry behavior.

- Remove empty `domain`, `application`, `presentation/view_models`, `service`, `helper`,
  and `utils` folders after each feature pass.
- Rename `presentation` to `ui` only when all imports in that feature can move in the same
  batch.
- Keep `navigation.dart` only when it contains behaviorful navigation composition.
- Move business-specific widgets currently under shared `ui/widgets` back to owning
  features unless multiple feature owners are proven.

## Phase 5: Shared UI Migration

Goal: make cross-feature UI reusable without creating two homes for the same component.

- Create `shared/` only when the first component is moved from `ui/`.
- Move theme, responsive helpers, feedback widgets, media widgets, and generic controls
  in small batches.
- Update imports and delete the old `ui/` source file in the same batch.
- Leave feature-specific feed cards, comment assemblies, and user sections with their
  owning feature unless multiple feature owners are proven.

## Phase 6: Dependency And Platform Hygiene

Goal: keep tooling modern without adding unused complexity.

- Upgrade direct dependencies in focused batches; start with patch/minor upgrades that
  are resolvable by `flutter pub upgrade`.
- Handle major or constrained upgrades separately: `dio_cache_interceptor`,
  `drift`, `drift_flutter`, `json_annotation`, `json_serializable`,
  `sqlite3_flutter_libs`, and `pointycastle`.
- Keep generated/local platform outputs ignored: `.gradle`, `.idea`, `Pods`,
  `.symlinks`, Flutter `ephemeral`, `.dart_tool`, `android/build`, `ios/build`, and
  `.DS_Store`.
- Do not add a new package unless it removes active code in the same phase.

## Phase 7: Performance Pass

Goal: reduce startup work, rebuilds, duplicate caching, and resource lifetime issues.

- Audit `main.dart`, bootstrap, root overrides, runtime initializers, and media startup.
- Bootstrap overlay style cleanup archived `_systemUiOverlayStyle`; the initializer keeps
  the transparent status bar and dark icon brightness inline beside `SystemChrome`.
- Review large list/feed pages for broad provider watches and redundant transformations.
- Review live/video player ownership and disposal paths.
- Move heavy JSON or mapping work off the UI frame path when it appears in hot flows.
- Add focused tests or profiling notes for flows touched in this phase.

## Current Deletion / Merge / Archive Queue

- Delete empty folders: none currently detected under `lib/features` or `lib/ui`.
- Keep archived by deletion:
  - all `lib/features/*/route_entry.dart`
  - one-call repository wrappers already removed in the current worktree
  - command/action facades already removed in the current worktree
  - one-line port/provider wrappers already removed for home, ranking, to-view, search,
    favorites, auth QR login, video, profile, notification, and dynamic
  - to-view refresh-result helper already collapsed into the owning `EasyRefresh`
    callback path; `_refreshList` stays archived as a one-call provider reload wrapper
  - video detail share wrapper already collapsed into the engagement section's inline
    action row; `shareVideo` stays archived and `share_utils.dart` is removed
  - one-call article/user share helpers are collapsed into their owning menu actions;
    `shareUri` and `shareUser` stay archived while dynamic sharing is owned by the
    dynamic feature's shared `shareDynamicItem` payload rule
  - notification resume-sync port and one-caller service provider already removed;
    `NotificationLifecycleSync` owns resume sync directly
  - single-use visual token wrappers already removed from live danmaku rendering
  - single-use live danmaku view wrapper already collapsed into the owning content file
  - single-use live danmaku message factory and small message renderers already
    collapsed into the owning content file
  - home tab descriptor helper already collapsed into `HomePage.build`;
    `_buildTabs` stays archived as a one-call page-local tab list wrapper
  - live header handwritten part split already collapsed into its owning widget file
  - live header private extension split already collapsed into `LiveHeader`
  - live header viewer-stack helper already collapsed into `LiveHeader.build`;
    `_buildViewerStack` and `_buildViewerAvatar` stay archived as one-call decorative
    wrappers
  - live header tag-row helpers already collapsed into `LiveHeader.build`;
    `_buildTagsRow` and `_buildTag` stay archived
  - live room title/error/gradient wrappers already collapsed into their owning build
    branches
  - live room danmaku input sheet launcher already collapsed into the only tap handler;
    `_showInputSheet` stays archived as a one-call page modal helper
  - live header empty more-menu and more-play controls already removed
  - video control button handwritten part split already collapsed into its owning widget
    file
  - settings about page handwritten section split already collapsed into its owning page
    file
  - settings page scaffold split already collapsed into its owning page file
  - search suggestion handwritten list/state splits already collapsed into their owning
    widget file
  - search suggestion private list/item/loading/empty wrappers already collapsed into
    `SearchSuggestionView`
  - search suggestion highlight-span helper cleanup archived `_buildHighlightedSpans`;
    each suggestion row now owns case-insensitive match splitting, normal/highlight
    styles, substring boundaries, and the `RichText` span list inline.
  - hot search ranked item wrapper already collapsed into `HotSearchSection`
  - video comments handwritten list split already collapsed into its owning comments view
  - video comment list-item forwarding wrapper already collapsed into
    `VideoCommentsView.build`; the list item builder owns `CommentItemWidget`
    construction and comment callbacks without `_VideoCommentListItem`
  - profile app bar handwritten exp bar split already collapsed into its owning widget
  - user profile app-bar icon helper already collapsed into the owning widget
  - notification item handwritten content split already collapsed into its owning page
  - notification list page helper file already collapsed into the owning page
- notification navigation parser split already collapsed into
    `notification_navigation.dart`; parser behavior and public API remain unchanged,
    and the one-use URI/opus helpers were collapsed into `NotificationNavigationParser.parse`
  - favorite detail pure row/skeleton UI splits already collapsed into the owning page
  - favorites folder-list loading skeleton already collapsed into the owning list view
  - favorite detail list/action splits already collapsed into the owning page
  - favorite detail app-bar actions helper already collapsed into the owning page
  - favorite detail edit-folder helper already collapsed into the owning popup action
  - favorite detail delete-folder helper already collapsed into the owning popup action
  - favorite detail folder header wrapper already collapsed into the owning page
  - profile page/header handwritten content/section splits already collapsed into their
    owning page/widget files
  - profile tab local stat/sort/render-state UI splits already collapsed into their
    owning section/tab widgets
  - profile video image prefetch tuning facade archived; recent-video grid ratio stays
    inline with `RecentVideoSection`, and user-video list prefetch sizing stays inline
    with `UserVideoTab`
  - video listen page private controls/widget splits already collapsed into the owning
    page file
  - video listen page visual chrome wrappers already collapsed into `VideoListenPage.build`;
    `_Background`, `_CoverArt`, and `_TrackInfo` stay archived as one-use background,
    cover-art, and title/author chrome while progress and playback control rebuild
    boundaries remain private widgets
  - video listen page app-bar wrapper already collapsed into `video_listen_page.dart`;
    `_buildAppBar` stays archived as a one-call listen-page app bar helper
  - interaction layer private drag-session/seek-overlay splits already collapsed into
    the owning layer file
  - video listen page no-op repeat/playlist button callbacks already removed
  - video comment list cache extent already folded into the owning root-comment and
    reply scroll views; the single-constant `video_comment_layout.dart` file is archived
  - video comment reply navigation typedef already collapsed into the owning comments
    view file; the typedef-only callback wrapper file stays archived
  - video comment and related-video image prefetch tuning already folded into the
    owning comment/info views; related-video prefetch estimates stay inline in
    `VideoInfoView.build`, and the constants-only `video_prefetch_tuning.dart` file is
    archived
  - unused video danmaku view metadata seam already removed; active video danmaku
    data ownership stays with segment loading and AI mask bytes, and
    `DanmakuViewConfig` / `fetchDanmakuView` remain archived
  - video danmaku AI-mask provider wrapper already moved out of presentation;
    `VideoExtraWorkflows` owns the async provider, and `danmaku_mask_view_model.dart`
    stays archived
  - video danmaku mask-path resolver helper already collapsed into the playback
    scheduler; mask `AsyncValue`/`Result` unwrapping stays beside the refresh bucket cache
  - video danmaku segment-entry mapper helpers already collapsed into the playback
    scheduler; color/type mapping stays beside `DanmakuItem` construction
  - video danmaku render painter helpers already collapsed into
    `_DanmakuViewStateRender._createRenderItem`; text/stroke `TextPainter` construction
    stays beside width, height, and velocity derivation without `_buildStrokePainter` or
    `_buildTextPainter`; `DanmakuPainter.paint` owns item horizontal visibility,
    offset/stroke/fill painting inline without `_isVisible` or `_paintItem`
  - video player wakelock test seam already removed; `usePlayerSystemSettings` calls
    `WakelockPlus` directly and no longer exposes `PlayerWakelock`,
    `PlatformPlayerWakelock`, or `syncPlayerWakelock`
  - video loader input selector seam already folded into `useVideoLoader`; player pages
    pass `bvid` directly and no longer call `watchVideoLoaderInput` or handle a public
    `VideoLoaderInput` record
  - vertical video author bar empty avatar click, fake follower count, and inactive
    follow chip already removed
  - `GuestView` private illustration/login/message part splits already collapsed into the
    owning shared widget file, and its one-owner `_GuestIllustration`,
    `_GuestLoginButton`, and `_GuestMessage` wrappers are archived with the concrete
    illustration, login button, and title/message stack kept inline in `GuestView.build`
  - `CulculTheme` private palette/component part splits already collapsed into the owning
    theme file; the one-use `_appBarTheme`, `_tabBarTheme`,
    `_bottomNavigationBarTheme`, `_cardTheme`, `_filledButtonTheme`, `_textButtonTheme`,
    `_outlinedButtonTheme`, `_inputDecorationTheme`, and `_dividerTheme` factories are
    archived with `AppBarTheme`, `TabBarThemeData`, `BottomNavigationBarThemeData`,
    `CardThemeData`, `FilledButtonThemeData`, `TextButtonThemeData`,
    `OutlinedButtonThemeData`, `InputDecorationTheme`, and
    `DividerThemeData(color: outlineVariant, thickness: 1, space: 1)` kept inline in
    `_buildTheme`
  - `VideoCard` private content/footer/thumbnail part splits already collapsed into the
    owning feed card file
  - `VideoListCard` private body/content/media part splits already collapsed into the
    owning feed card file; the one-use media thumbnail/leading wrapper stays inline in
    `_VideoListCardBody.build`; the one-use content column stays inline in
    `_VideoListCardBody.build` without `_VideoListCardContent`
  - `VideoListCard` stats row wrapper already collapsed into `_VideoListCardBody.build`
  - video orientation dimension helper already collapsed into `useVideoOrientation`;
    the fullscreen branch owns current-part, detail-level, and player-state fallback
    dimensions inline before rotation normalization
  - compact `VideoListCard` thumbnail dimensions already consolidated to
    `video_list_card_dimensions.dart` for ranking and to-view list items
  - wide `VideoListCard` thumbnail dimensions already consolidated to
    `video_list_card_dimensions.dart` for search, favorites, and history list rows
  - `LiveHeader` optional no-op follow callback already removed; the live room caller
    supplies real behavior directly
  - profile sticky-video private stat icon/text wrapper already collapsed into the
    shared `IconText` primitive
  - search article private meta icon/text wrapper already collapsed into the shared
    `IconText` primitive
  - thin video action-sheet entry wrapper already collapsed into
    `home_video_actions.dart`
  - search result local `NetworkImagePrefetchSpec` reconstruction already consolidated
    through `network_image_prefetch_specs.dart`
  - notification private-message page-size literal already consolidated to
    `notificationPrivateMessagePageSize`
  - search result API page-size literal already consolidated as a private `SearchApi`
    default
  - live recommend page-size literal/default already consolidated to
    `liveRecommendPageSize`
  - live recommend provider shell already collapsed into `LiveView`
  - dynamic topic feed page-size default already consolidated to
    `dynamicTopicFeedPageSize`
  - topic dynamic feed provider shell already collapsed into `TopicDetailPage`
  - dynamic feed feature flags and timezone offset already consolidated to
    `dynamic_api.dart`
  - video listen sleep timer expire callback typedef already collapsed into the provider
    return type
  - video listen settings preset-minute button wrapper already collapsed into
    `ListenSettingsSheet`
  - video listen settings bottom-sheet layout flag already collapsed into
    `ListenSettingsSheet`
  - live gold-rank and guard-list page-size defaults already consolidated to
    `liveGoldRankPageSize` and `liveGuardListPageSize`
  - one-line publish dynamic route page wrapper already collapsed into
    `PublishDynamicRoute`
  - one-line dynamic route page wrappers already collapsed into `DynamicRoute` and
    `DynamicDetailRoute`
  - one-line article/topic dynamic route factories already collapsed into typed app-router
    modal push builders
  - single-use article detail loading/error/empty scaffold helpers already collapsed
    into `ArticleDetailPage.build`
  - empty directories left by collapsed shared UI handwritten part splits already removed
  - repeated cover-image `NetworkImagePrefetchSpec` construction already consolidated to
    `ui/widgets/media/network_image_prefetch_specs.dart`
  - `AppImagePreview` private widget part split already collapsed into the owning shared
    preview file; the public constructor and `open(...)` API remain unchanged, and the
    gesture pager plus top/save/hint overlay wrappers stay inline with
    `_AppImagePreviewState.build`
  - unused `VideoCardContent` public wrapper already deleted; `VideoCard` owns the
    private content renderer without dead `extra` extension slots
  - `AppAvatar` one-use decorative fallback/shadow/border helpers already inlined into
    the avatar owner
  - comment image grid/preview wrapper already collapsed into `CommentItemWidget`;
    comment content owns picture sizing, decode bounds, hero tags, preview opening, and
    the single/grid image branches inline without `_buildSingleImage` or
    `_buildImageGrid`, plus load-state chrome inline without `_buildLoadState`
  - `SmartPagingView` content wrapper cleanup archived `_SmartPagingContent`;
    `SmartPagingView.build` owns loading/error/empty/data content selection inline
    without `_PagingStatusView`
  - `SmartPagingView` load-more helper cleanup archived `_handleLoadMore`;
    `SmartPagingView.build` owns the `ScrollLoadTrigger.runWithGate` call,
    previous-count capture, `hasMoreAfterLoad` fallback, and `ui.smart_paging_view`
    source attribution inline
  - `SmartPagingView` one-use refresh result helper already inlined at the EasyRefresh
    boundary
  - scroll prefetch budget helper already collapsed into `useScrollPrecache`;
    `ScrollPrecacheBudget` and `resolveScrollPrecacheBudget` stay archived as hook-local
    policy plumbing
  - favorites folder dialog form-data wrapper already replaced with a typed record
    returned directly from `FavFolderDialog`
  - favorites create-folder helper already collapsed into `FavoritesPage.build`; do not
    restore `_handleCreateFolder`
  - generic page skeleton wrappers already collapsed into the owning home popular and
    recommend feed loading branches
  - unused `SmartPagingContent` public content layer already made private to
    `SmartPagingView`
  - publish dynamic page private scaffold/app-bar widgets already collapsed into
    `PublishDynamicPage.build`
  - publish dynamic page private editor widget split already collapsed into the owning
    page build, and its no-op text-change callback already removed
  - dynamic item app-facing content extension split already collapsed into the owning
    extension file
  - dynamic item app-facing identity extension split already collapsed into the owning
    extension file; mapper normalization remains in its part file
  - article detail private author/stat section split already collapsed into the owning
    scaffold file
  - article detail private loading/error/empty shell split already collapsed into the
    owning page file
  - article detail quote block render wrapper already collapsed into the owning scaffold
    renderer; the quote block now renders inline with the article-detail block switch
  - article detail action mixin split already collapsed into the owning view model file
  - comment item private content split already collapsed into the owning shared comment
    item file
  - comment item text-span helper cleanup archived `_buildTextSpans`; `_Content.build`
    now owns reply-to prefix span creation, base text styling, and emoji span creation
    inline beside `SelectableText.rich`
  - comment item private footer split already collapsed into the owning shared comment
    item file, and its empty more-menu action already removed
  - comment item private header/replies splits already collapsed into the owning shared
    comment item file; `_Replies.build` owns the reply row rendering without
    `_buildReplyItem`
  - dynamic comments no longer pass an empty dislike callback into shared comment item
    controls
  - dynamic comments empty-state widget already inlined into the comments sliver owner
  - dynamic comments list wrapper already collapsed into the comments sliver owner
  - dynamic comments reply sheet launcher already collapsed into the comment row
    callback; `CommentReplySheet` owns the sheet chrome and the row callback owns
    add-reply dispatch instead of restoring `_showReplySheet`, `_ReplySheetContent`, or
    `_ReplySheetContentState`
  - video comments empty-state widget already made private to the comments view owner
  - video detail info one-file tag/action render helpers already made private to their
    owning section widgets
  - quick-selection option tile wrapper already collapsed into `QuickSelectionSheet.build`;
    selected/unselected row chrome and the select-and-pop callback stay sheet-owned
  - video detail info loaded-content split already collapsed into `VideoInfoView`
  - video detail info private header/engagement section splits already collapsed into
    `VideoInfoView`
  - video detail controller helper split already collapsed into
    `VideoDetailController`; progress reporting and play-url cache behavior remain
    unchanged
  - video player one-file time/capsule/icon controls already made private to
    `VideoControlButtons`
  - player panel empty-state helper already collapsed into `QuickSelectionSheet`
  - player panel shared scaffold/section primitives already collapsed into
    `player_panel.dart`
  - player panel one-owner menu/filter helpers already made private to their owning
    sheets
  - unused player panel option-card part already deleted instead of kept as reserved UI
  - player settings danmaku slider row split already collapsed into
    `PlayerSettingsSheet`; do not restore `_DanmakuSliderRow`
  - player settings speed/quality option section split already collapsed into
    `PlayerSettingsSheet`, and option item equality now uses Flutter `listEquals`
    without private `_sameItems` or `_buildItemKeys` helpers
  - player settings section-background helper already collapsed into the owning sheet
    decorations; do not restore `_settingsSectionBackground`
  - vertical video top/right control split already collapsed into `VerticalVideoPage`;
    do not restore `_TopBar` or `_RightBar`
  - vertical video bottom-bar wrapper and leaf helpers already collapsed into
    `VerticalVideoPage.build`; do not restore `_BottomBar`
  - player controller private load-helper split already collapsed into
    `player_view_model.dart` without changing public controller behavior
  - profile session logout cleaner adapter already made private behind its runtime
    override factory
  - profile repository DTO-returning flow helpers already inlined into the
    app-model-returning profile video flows
  - profile repository one-owner flow part already collapsed into
    `profile_repository_impl.dart`
  - profile repository one-owner parser part already collapsed into
    `profile_repository_impl.dart`
  - profile user-dynamic tab wrapper already deleted; profile page now constructs the
    real `UserDynamicFeed`
  - profile stat/action leaf widget files already collapsed into their single owning
    profile widgets
  - search result prefetch tuning facade already collapsed into `SearchResultList`
  - live room action mixin split already collapsed into the owning live controller file
  - to-view page command facade already collapsed into the owning page file
  - to-view list wrapper already collapsed into the owning page file
  - favorites collected generic `loadMore` alias already replaced by the semantic
    `loadNextCollectedPage` public method over the protected pagination primitive
  - favorite picker sheet widget already made private; `showVideoFavoritePicker` is the
    only cross-feature entrypoint
  - favorite picker selection/delta helpers already collapsed into the private picker
    sheet implementation; the data branch owns the one-time initial selected-id scan and
    `_submit` owns the add/delete diff without `_initializeSelection` or a private
    folder-delta wrapper, while the
    checkbox row callback owns the per-folder selected-id mutation without `_toggleFolder`
  - favorite picker retry helper already collapsed into the private picker sheet error
    branch; the branch owns selection reset, submit-error clearing, and provider
    invalidation without `_retry`
  - home tab sync two-field state wrapper already replaced by a Dart record typedef; the
    controller owns the retap event token directly
  - profile cache repository and unused Drift cache database are archived; logout cleanup
    now uses the core default no-op `SessionLogoutCleaner` instead of a profile-specific
    empty adapter
  - dynamic emote DTO mirrors already collapsed into the canonical `EmoteCatalogPackage`
    / `EmoteCatalogItem` application models; the repository only parses the response
    shell
  - search result list dead error API already removed; parent result panes own error
    rendering
  - video comment like tree-update helper already collapsed into the owning comments
    view model
  - search result tab widget already made private to `SearchResultView`
  - search result article/bangumi/user empty click and follow affordances already removed
  - search result image prefetch scan limits, final limit, and logical image sizes already
    consolidated as private constants in `SearchResultList`; the spec scan loop is inline
    in `SearchResultList.build` without `_buildSearchResultImagePrefetchSpecs`
  - single-use search history tag wrapper already inlined into the owning section
  - search/to-view DTO fields already slimmed to current mapped app-facing concepts
  - home/search object-list DTO conversion already consolidated through `JsonUtils`
  - notification send-result one-call map reader already collapsed into
    `JsonUtils.asStringKeyedMap`
  - single-use widget wrappers already removed from dynamic detail rendering
  - dynamic detail bottom-bar action icon helper already collapsed into
    `DynamicDetailBottomBar.build`; `_buildActionIcon` stays archived while the like and
    share buttons keep their owner-specific count/color/share behavior inline
  - dynamic vote additional card wrapper already collapsed into `DynamicContentWidget`
    inline beside the additional-type dispatcher; do not restore `_DynamicVoteCard`
  - dynamic common additional and link-card wrappers already collapsed into
    `DynamicContentWidget`; content card rendering stays beside the dispatcher instead
    of exporting one-owner wrapper files
  - dynamic UGC additional and video content wrappers already collapsed into
    `DynamicContentWidget`; fallback navigation IDs, jump URLs, cover sizing, and
    counter/chrome rendering stay with the content dispatcher, and the private
    `_DynamicUgcCard` / `_DynamicVideoCard` wrappers stay archived
  - dynamic goods and reserve additional wrappers already collapsed into
    `DynamicContentWidget`; empty goods shrink behavior, list rows, reserve disabled
    state, translated labels, and navigation remain beside `_buildAdditional`, and the
    private `_DynamicGoodsCard` / `_DynamicReserveCard` wrappers stay archived
  - dynamic image wrapper already collapsed into `DynamicContentWidget`; trim/take-9,
    empty shrink, single-image constraints, grid sizing, tap targets, and preview open
    behavior stay with the content owner, with `_DynamicImages`, `_openImagePreview`,
    and one-call `_buildImageItem` kept archived so `AppNetworkImage` grid chrome stays
    inline in `DynamicContentWidget.build`
  - dynamic topic chip wrapper already collapsed into `DynamicContentWidget.build`;
    topic navigation, pill padding/radius, primary tint, fire icon, and label style stay
    inline with the topic branch instead of restoring `_TopicChip`
  - dynamic content visibility helper already collapsed into `DynamicContentWidget.build`;
    text/image/link-card/additional branch gates stay beside the content they guard
    instead of restoring `_resolveVisibility`
  - publish dynamic emoji retry helper already collapsed into
    `_PublishEmojiPickerState.build`; the error branch now resets `_emotePackagesFuture`
    inline beside `AppErrorWidget.onRetry`, initial/retry emote package future assignment
    stays at those owners without `_loadEmotePackages`, and `_retryLoadEmotes` stays
    archived with the existing `_buildEmojiGrid` picker helper
  - publish dynamic emoji grid already collapsed into `_PublishEmojiPickerState.build`;
    package tab views, 48px grid extents, 8px spacing, 96px emote cache sizing, and
    tap-to-insert behavior stay inline with the picker instead of restoring
    `_buildEmojiGrid`
  - publish dynamic CSRF resolution already collapsed into
    `_PublishDynamicController._publishDynamic`; `getPublishCsrf`, null/empty token
    validation, fallback `AppError.auth('Missing csrf token')`, image upload, and publish
    sequencing stay in the single publish flow instead of restoring `_resolveCsrf`
  - dynamic forward wrapper already collapsed into `DynamicContentWidget`; author
    navigation, fallback forward text, and recursive original-post rendering stay with
    the content owner, and `_DynamicForwardCard` stays archived
  - dynamic content surface helper already collapsed into `DynamicContentWidget`; the
    Material/InkWell/Ink surface policy stays private to the remaining dynamic content
    cards
  - unused optional widget action APIs already removed from live bottom bar
  - zero-value feature facades already removed from dynamic
  - zero-value auth feature facade already removed
  - auth login dialog widget wrapper already collapsed into the `showLoginDialog`
    entrypoint in `login_panel.dart`; barrier/fade/close wiring stays auth-owned without
    a public `LoginDialog` widget shell or separate `login_dialog.dart` wrapper file
  - auth handwritten component part split already collapsed into its owning widget file
  - duplicate notification private-message page-size literals and the old repository
    alias already consolidated to `notificationPrivateMessagePageSize`
  - notification chat one-owner `ChatState` type split already collapsed into
    `chat_view_model.dart`
  - notification private-session one-owner item renderer already collapsed into
    `private_session_list.dart`
  - notification one-owner skeleton lists already collapsed into `private_session_list.dart`
    and `chat_page.dart`
  - video detail info one-owner renderer files already collapsed into
    `video_info_view.dart`
  - video player overlay top/bottom chrome wrappers already collapsed into
    `player_controls_overlay.dart`
  - duplicate home feed cache tuning and initial prefetch literals already consolidated
    to `home_feed_view_utils.dart`
  - duplicate recommend/live grid item width estimation already consolidated to
    `estimateHomeGridItemWidth`
  - duplicate profile nested-feed base paging/cache defaults already consolidated to
    `nested_feed_paging_defaults.dart`
  - duplicate profile space video page-size literals already consolidated to
    `profileUserSpaceVideoPageSize`
  - duplicate favorites page-size and collected-folder has-more rules already split into
    endpoint-specific `favoriteFolderPageSize` and `favoriteResourcePageSize`
  - profile dynamic navigation wrapper typedef already inlined into
    `ProfileRouteNavigation`; the route navigation object owns that callback shape
  - profile chat navigation typedef already inlined into `ProfileRouteNavigation` and
    `ProfileNavigationScope`; the route/scope owner keeps the callback shape directly
  - profile action-grid widget already collapsed into `ProfilePage`; the authenticated
    profile page owns its menu actions and responsive row/wrap layout directly
  - video entry normal-page builder typedef already inlined into
    `VideoEntryDecisionPage`; the page owns that test seam and fallback behavior
  - same-file hook/page typedefs `GeetestSuccessCallback`, `_HomeTabItem`, and
    `_VideoAction` already inlined; they only named one local callback or record shape
  - network concurrency typedefs `AsyncMapper` and `AsyncTask` already inlined; the
    executor class owns the callback policy directly, and its concurrent execution
    methods no longer accept unread per-call `scope` labels
  - network concurrency profile limits are now enum-owned; `NetworkConcurrencyProfile`
    exposes `maxConcurrency` directly without a detached `NetworkConcurrencyProfileX`
    extension wrapper
  - listen audio mode hook input typedef already inlined into `useListenAudioMode`; the
    hook owns that single record parameter shape directly
  - request executor `runVoid`, unused `runResponse`, and the retired
    `RequestExecutionOptions` wrapper already deleted; callers can use `run`,
    `runApi`, `runApiDirect`, or `runUnit` directly while passing Dio cancellation to
    Retrofit APIs and relying on `AppError.fromObject` for executor error mapping
  - search repository request-class metadata is now inline at each API call; `SearchRepositoryImpl`
    owns `EndpointPolicy.requestClassExtra: EndpointRequestClass.search` directly instead of
    routing through a request-executor option wrapper
  - Dio provider lifecycle and network-policy listener setup already collapsed into
    `_attachDioLifecycle`; `basicDio` and `dioClient` still keep their distinct
    interceptor policies in their provider bodies
  - to-view page app bar wrapper already collapsed into `to_view_page.dart`; the page
    owns its tiny title/actions surface directly, including the clear-all confirmation
    dialog without a one-use `_handleClearAll` helper
  - home tab bar wrapper already collapsed into `home_page.dart`; the page owns
    its single bottom tab surface directly
  - live bottom bar wrapper already collapsed into `live_room_page.dart`; the room page
    owns its single input affordance directly
  - article detail comment bar wrapper already collapsed into the scaffold; the scaffold
    owns its bottom composer surface directly
  - live room page-local `_LivePlayerSection` and `_LiveBottomBar` wrappers already
    collapsed into `LiveRoomPage.build`; the page owns its player aspect-ratio shell and
    danmaku input affordance directly
  - live danmaku message factory and one-off gift/interact/system renderers already
    collapsed into `live_room_content.dart`; `LiveRoomContent.build` owns the
    system/interact/gift/normal dispatch and one-off renderer chrome directly,
    with `_LiveDanmakuView` archived as another removed one-owner wrapper
  - live danmaku admin, guard, and medal badges already inlined into
    `LiveNormalMessage.build`; the message owner keeps those chip branches directly
  - search result skeleton wrapper already collapsed into `search_result_view.dart`; the
    result view owns its private loading renderer
  - hot search skeleton wrapper already collapsed into `HotSearchSection`; the loading
    grid now renders inline beside the final grid
  - live card skeleton wrapper already collapsed into `LiveView`; the live feed owns
    its loading `CustomScrollView`, grid, and shimmer card inline
  - live grid wrapper already collapsed into `LiveView`; the live feed owns its data
    grid, image prefetch, scroll-precache, and open-room wiring inline
  - home breakpoint facade already collapsed into `home_layout_spec.dart`; the home feed
    layout owner now keeps max widths and responsive thresholds private
  - video detail tab bar wrapper already collapsed into `video_detail_page.dart`; the
    detail page owns its private tab/header renderer
  - sliver tab bar delegate wrapper already collapsed into `user_profile_page.dart`; the
    profile page owns its private sliver header delegate
  - request executor app-error and stale-cache aliases already deleted; the network core
    owns the callback types directly, and search now injects
    `EndpointPolicy.requestClassExtra: EndpointRequestClass.search` inline at each API call
  - publish dynamic modal helper part already collapsed into `publish_dynamic_page.dart`;
    its dialog/sheet helpers are page-local behavior, not a separate module
  - article detail block/menu helper part already collapsed into
    `article_detail_page_scaffold.dart`; the scaffold owns those private render/menu
    helpers directly
  - danmaku layer render bridge helper part already collapsed into `danmaku_layer.dart`;
    option conversion and mask clipping are private to that overlay layer
  - dynamic comment fallback page-size literal already consolidated to
    `CommentService.defaultPageSize`
  - home feed cache/API page-size literals already consolidated to `homeFeedPageSize`
  - live recommend provider/API page-size defaults already consolidated to
    `liveRecommendPageSize`
  - dynamic topic feed and live room gold/guard API page-size defaults already
    consolidated to named constants
  - dynamic feed cache/API feature flags and timezone offset already consolidated to
    `dynamic_api.dart`
  - unused direct dev dependency `path_provider_platform_interface`; it remains
    transitive through `path_provider`
  - auth login background, login dialog entrypoint, and login panel micro-wrappers
    already collapsed into `login_page.dart` and `login_panel.dart`; the page/panel own
    their dialog wiring, decorative background, header, method tabs, and transient
    feedback UI directly, including one-use feedback/fill color expressions
  - home app bar bottom tab renderer already collapsed into `home_page.dart`; the app
    bar owns its tab strip directly instead of delegating to a one-owner widget
  - profile header identity and bio leaf wrappers already collapsed into
    `user_profile_info.dart`; the header owns username/VIP/level and bio-toggle rows
    directly
  - video detail tab bar, video comments paging/list wrappers, and quick-selection empty
    state already collapsed into their owning page/sheet files; the owners keep those
    one-owner branches inline instead of delegating to separate leaf widgets
  - video detail controller state already collapsed into `video_detail_view_model.dart`;
    the controller owner keeps `VideoDetailState` and its Freezed copy semantics directly
    instead of a separate one-owner `video_detail_state.dart` file
  - video detail optimistic interaction helpers already collapsed into controller
    methods; `toggleVideoLike`, `addVideoCoin`, and `setVideoFavoriteState` own their
    local stat/request-user updates without `_applyVideoLikeState`,
    `_applyVideoCoinState`, or `_applyVideoFavoriteState`
  - comment reply controller state already collapsed into `comment_reply_view_model.dart`;
    the controller owner keeps `CommentReplyState` as a hand-written immutable value
    instead of a separate one-owner `comment_reply_state.dart` file
  - listen sleep timer state no longer uses a Freezed-generated shell; the controller
    owner keeps `ListenSleepTimerState` as a small immutable value with equality and
    direct-constructor update semantics in `listen_sleep_timer_view_model.dart`; the
    unused `copyWith` helper and nullable copy sentinel are archived
  - live danmaku feed state no longer uses a Freezed-generated shell; the controller
    owner keeps `LiveDanmakuFeedState` as a small immutable value while preserving
    list equality, revision, enabled, connected, and buffered flush semantics
  - subtitle overlay state no longer uses a Freezed-generated shell; the controller
    owner keeps `SubtitleState` as a small immutable value while preserving subtitle
    list/content equality, selected subtitle, loading/enabled flags, and nullable error
    clearing semantics through explicit constructor updates; the unused `copyWith`
    helper and nullable copy sentinel are archived
  - danmaku settings state no longer uses a Freezed-generated shell; the controller
    owner keeps `DanmakuSettings` as a small immutable value while preserving opacity,
    font size, area, speed, visibility flags, and ai-mask toggles
  - article detail comment actions now return a named record for page-side effects,
    so `ArticleDetailCommentActionResult` no longer exists as a class wrapper
  - article detail state no longer uses a Freezed-generated shell; the controller owner
    keeps `ArticleDetailUiState` as a small immutable value while preserving detail/error
    nullable clearing, comment list equality, paging cursor state, and send-comment flags
  - article detail comment paging merge helper cleanup archived `_appendUniqueComments`;
    `loadComments` now owns the non-refresh `rpid` duplicate-replacement merge inline
  - article detail comment has-more helper cleanup archived `_resolveHasMore`;
    `loadComments` now owns the cursor `isEnd` fallback directly in the success branch
  - dynamic comment has-more helper cleanup archived `_resolveHasMore`;
    `DynamicCommentController.refresh` and `loadMore` now own cursor, page metadata, and
    default-page-size fallback checks directly in their success branches
  - dynamic comment target referer helper cleanup archived `_getDynamicCommentReferer`;
    `_resolveDynamicCommentTarget` now owns article referer normalization, link-card
    fallback, and Bilibili default referer inline beside oid/type selection
  - user profile tab-bar delegate default cleanup archived `topPadding = 0`;
    `UserProfilePage` now always supplies the safe-area padding explicitly to
    `_UserProfileTabBarDelegate`
  - shared dynamic/video comment list state no longer uses a Freezed-generated shell;
    `CommentListState` remains a small immutable value over `PagedListState<CommentItem>`
    and `CommentSort`
  - favorites folder-detail state no longer uses a Freezed-generated shell; the folder
    resources controller owner keeps `FavFolderDetailState` as a small immutable value
    while preserving nullable folder info and paging copy/equality semantics without a
    one-use `copyWith` helper or nullable copy sentinel
  - favorites folder-resource initial request helper cleanup archived `_fetchItems`;
    `FavFolderResources.build` owns first-page request logging and `dataOrNull` unwrap
    inline beside initial state construction
  - notification chat state no longer uses a Freezed-generated shell; the chat notifier
    owner keeps `ChatState` as a small immutable value while preserving paging copy
    semantics and emoji-map equality/immutability; the emoji-map hash delegates to
    `collection`'s shallow `MapEquality`, so the local `_mapHash` helper stays archived
  - network endpoint policy no longer uses a Freezed-generated shell; the network core
    keeps `EndpointPolicy` as a hand-written immutable value while preserving cache,
    retry, deduplication, prefetch, nullable TTL copy, and retryable status-set equality
    through Flutter's canonical `setEquals` instead of a file-local `_setEquals` clone
  - app network image prefetch failed/disposed cache-key removal now stays inline in
    `AppNetworkImagePrefetcher._runTask`, so `_forget` remains archived as a one-line
    wrapper around `_prefetchedAtByKey.remove`
  - app network image prefetch successful-task LRU recording now stays inline in
    `AppNetworkImagePrefetcher._runTask`, so `_rememberPrefetched` remains archived as
    a one-use timestamp refresh and capacity-eviction helper
  - app network image prefetch listener cleanup now uses a late-final
    `ImageStreamListener` self-reference, so nullable listener state and `listener!`
    force-unwraps stay archived in `_precacheImage`
  - notification private-message DTO content equality no longer uses DTO-local
    recursive helpers; `PrivateMessageDetail` delegates `content` equality/hash to
    `collection`'s `DeepCollectionEquality`, so `_contentEquals` and `_contentHash`
    stay archived
  - live gold-rank models no longer use Freezed/JSON generated shells; the live model
    owner keeps `LiveGoldRankModel`, `LiveRankItem`, and `LiveRankMedalInfo` as
    hand-written immutable DTO values while preserving `onlineNum`, `OnlineRankItem`,
    medal info, guard/wealth level wire keys, list equality, copy semantics, and JSON
    serialization
  - dynamic feed core response models no longer use Freezed-generated shells; the
    dynamic model owner keeps `DynamicData`, `DynamicItem`, `DynamicBasic`,
    `DynamicModules`, `ModuleAuthor`, and `ModuleDynamic` as hand-written immutable
    values while preserving feed offsets, nested item/orig/basic/module parsing,
    nullable fields, author/module wire keys, list equality, diagnostics, and JSON
    parsing. Unused hand-written `copyWith` helpers are archived for
    `DynamicData`, `DynamicBasic`, `ModuleAuthor`, and `ModuleDynamic`; the live
    `DynamicItem.copyWith` and `DynamicModules.copyWith` dynamic like-update path
    remains
  - dynamic feed response equality helper cleanup archived the file-local `_listEquals`
    and `_nullableListEquals` clones; dynamic response list equality now uses Flutter's
    canonical `listEquals` across the part library
  - dynamic feed core response model serialization cleanup removed unused hand-written
    `toJson` helpers from `DynamicData`, `DynamicItem`, `DynamicBasic`,
    `DynamicModules`, `ModuleAuthor`, and `ModuleDynamic`; these read models remain
    inbound API parse owners only
  - dynamic feed additional response models no longer use Freezed-generated shells; the
    dynamic model owner keeps `ModuleAdditional`, `AdditionalCommon`,
    `AdditionalReserve`, `ReserveDesc`, `AdditionalGoods`, `GoodsItem`,
    `AdditionalVote`, and `AdditionalUgc` as hand-written immutable values while
    preserving additional-module wire keys, nullable fields, reserve/goods/vote/UGC
    parsing, and goods list equality
  - dynamic feed additional response model dead-code cleanup removed unused hand-written
    `copyWith` helpers from `ModuleAdditional`, `AdditionalCommon`,
    `AdditionalReserve`, `ReserveDesc`, `AdditionalGoods`, `GoodsItem`,
    `AdditionalVote`, and `AdditionalUgc`; live dynamic like updates remain on
    `DynamicItem`/`DynamicModules`/`ModuleStat`/`StatLike`
  - dynamic feed additional response model serialization cleanup removed unused
    hand-written `toJson` helpers from `ModuleAdditional`, `AdditionalCommon`,
    `AdditionalReserve`, `ReserveDesc`, `AdditionalGoods`, `GoodsItem`,
    `AdditionalVote`, and `AdditionalUgc`; these read models remain inbound API parse
    owners only
  - dynamic feed major secondary response models no longer use Freezed-generated shells;
    the dynamic model owner keeps `MajorPgc`, `MajorCourses`, `MajorMusic`,
    `MajorOpus`, `OpusSummary`, `OpusPic`, `MajorLive`, and `MajorLiveRcmd` as
    hand-written immutable values while preserving PGC/course/music/opus/live wire
    keys, nested stat/summary/pic parsing, nullable fields/lists, and list equality
  - dynamic feed major secondary response model dead-code cleanup removed unused
    hand-written `copyWith` helpers from `MajorPgc`, `MajorCourses`, `MajorMusic`,
    `MajorOpus`, `OpusSummary`, `OpusPic`, `MajorLive`, and `MajorLiveRcmd`; live
    dynamic like updates remain on `DynamicItem`/`DynamicModules`/`ModuleStat`/`StatLike`
  - dynamic feed major secondary response model serialization cleanup removed unused
    hand-written `toJson` helpers from `MajorPgc`, `MajorCourses`, `MajorMusic`,
    `MajorOpus`, `OpusSummary`, `OpusPic`, `MajorLive`, and `MajorLiveRcmd`; these
    read models remain inbound API parse owners only
  - dynamic feed major primary response models no longer use Freezed-generated shells;
    the dynamic model owner keeps `ModuleDesc`, `ModuleMajor`, `MajorArchive`,
    `MajorDraw`, `DrawItem`, `MajorArticle`, `MajorCommon`, `MajorStat`, `ModuleStat`,
    `StatLike`, `StatCommon`, and `ModuleTopic` as hand-written immutable values while
    preserving desc/major/stat/topic wire keys, nested branch parsing, nullable
    branch semantics, list equality, and active like-update copy semantics. Unused
    read-model `copyWith` helpers are archived for `ModuleDesc`,
    `ModuleMajor`, `MajorArchive`, `MajorDraw`, `DrawItem`, `MajorArticle`,
    `MajorCommon`, `MajorStat`, `StatCommon`, and `ModuleTopic`; `ModuleStat.copyWith`
    and `StatLike.copyWith` remain because dynamic like toggles call them. The whole
    `dynamic_response` model family no longer imports `freezed_annotation` or keeps
    `dynamic_response.freezed.dart` / `dynamic_response.g.dart`.
  - dynamic feed major primary response model serialization cleanup removed unused
    hand-written `toJson` helpers from `ModuleDesc`, `ModuleMajor`, `MajorArchive`,
    `MajorDraw`, `DrawItem`, `MajorArticle`, `MajorCommon`, `MajorStat`, `ModuleStat`,
    `StatLike`, `StatCommon`, and `ModuleTopic`; these read models remain inbound API
    parse owners only
  - low-risk nested comment content/media values no longer use Freezed-generated shells;
    `comment_contract.types.dart` keeps `CommentLabel`, `CommentContent`,
    `CommentPicture`, and `CommentEmote` as hand-written immutable values while
    preserving label/content/picture/emote wire keys, defaults, nullable `emote`
    parsing, list/map immutability and equality, and JSON parsing. Their unused
    hand-written `copyWith` and `toJson` helpers are archived, while
    `comment_contract.freezed.dart` / `comment_contract.g.dart` remain active for the
    higher-risk main comment contract and must not contain generated private
    implementations, copy-with helpers, pattern helpers, or JSON helpers for these four
    low-risk values.
  - article inline text nodes no longer use a Freezed-generated shell; the article detail
    entity owner keeps `ArticleInlineNode` as a hand-written immutable leaf value while
    preserving text/link/color/font-size/bold/italic fields, nullable clearing, value
    equality, copy semantics, and diagnostics. `article_detail_data.freezed.dart`
    remains active for the higher-risk article detail/block union but must not contain
    generated private implementations, copy-with helpers, or pattern helpers for
    `ArticleInlineNode`.
  - article block render units no longer use a Freezed-generated union shell; the article
    detail entity owner keeps `ArticleBlock`, `ArticleBlockParagraph`,
    `ArticleBlockImage`, `ArticleBlockLinkCard`, `ArticleBlockQuote`, and
    `ArticleBlockDivider` as hand-written values while preserving factory constructors,
    current Dart pattern-matching variant names, nullable fields, list immutability and
    equality, and diagnostics. Their unused hand-written `copyWith` helpers are archived;
    `ArticleInlineNode.copyWith` remains active for tokenizer inline-style layering.
    `article_detail_data.freezed.dart` remains active for the higher-risk article
    detail/stat shell but must not contain generated block variants, pattern helpers, or
    copy-with helpers.
  - article parser integer scalar parsing now uses the shared `JsonUtils.parseInt`
    helper directly. The local `_int` helper is archived so article detail parsing does
    not keep a one-off JSON scalar utility beside the shared core implementation. The
    remaining `_asMap` helper is intentionally left in place because GitNexus reports
    HIGH risk for that map-shape change; it needs a separate larger article parsing
    slice. The one-use `_double` helper is archived too; Opus inline `font_size`
    conversion stays beside `_parseOpusInlineNodes`. The one-use `_parseInitialState`
    helper is also archived; initial-state JSON decode/type normalization now stays
    inline in `ArticleDetailParser.extractInitialState`.
  - video list skeleton thumbnail/content helper cleanup archived the one-use
    `_buildThumbnail` and `_buildContent` helpers; `VideoListSkeleton.build` now owns
    thumbnail width, aspect ratio, shimmer radius, expanded content column, title/footer
    shimmer sizes, and `Spacer` inline.
  - video card skeleton content helper cleanup archived `_buildContent`;
    `VideoCardSkeleton.build` now owns the fixed Expanded/padded shimmer column inline.
  - app clickable handler helper cleanup archived `_buildTapHandler` and
    `_buildLongPressHandler`; `AppClickable.build` now owns null-handler preservation,
    tap light haptic, long-press medium haptic, and callback dispatch inline.
  - app tab bar decoration/indicator helper cleanup archived `_buildDecoration` and
    `_buildIndicator`; `AppTabBar.build` now owns the 44px surface/bottom-border chrome
    and primary underline indicator geometry inline.
  - article paragraph text-normalization helper cleanup archived `_normalizeBlockText`;
    `_ParagraphBlockViewState.build` now owns the `\n{3,}` to `\n\n` collapse inline
    beside linked/plain `TextSpan` creation.
  - article paragraph alignment helper cleanup archived `_alignToAlignment` and
    `_toTextAlign`; `_ParagraphBlockViewState.build` now owns the shared
    `ArticleTextAlign` mapping for `Align.alignment` and `Text.rich.textAlign` inline.
  - article paragraph visible-text helper cleanup archived `_hasVisibleText`;
    `_buildArticleBlocks` now owns paragraph whitespace stripping inline with one local
    whitespace regex before deciding whether to render `_ParagraphBlockView`.
  - comment item user-tap helper cleanup archived `_handleTapUser`;
    `CommentItemWidget.build` now owns MID parsing, invalid-ID short-circuiting, and
    callback dispatch inline while sharing the local callback across avatar/header taps.
  - comment image preview/cache helper cleanup archived `_openPreview`,
    `_toCacheDimension`, and `_resolveSingleImageDisplaySize`; `_CommentImages.build` now
    owns preview opening, decode-size clamping, and single-image display-size calculation
    beside the single/grid image branches.
  - article detail stats chip cleanup archived `_StatChip`; `_StatsRow.build` now owns
    the favorite/like icon-text cells inline while preserving centered rows, spacing,
    vertical padding, and typography.
  - article detail author/stats section cleanup archived `_AuthorHeader` and
    `_StatsRow`; `_buildArticleDetailScaffold` now owns the author avatar/name/time row
    and favorite/like stats surface inline.
  - settings about-page action tile cleanup archived `_ActionTile`; `AboutPage.build` now
    owns the GitHub and license `Material`/`InkWell` rows inline while preserving icon
    chrome, typography, chevron, and callbacks.
  - app search bar icon helper cleanup archived the trivial `_buildSearchIcon` method;
    editable and read-only branches now own their static search icon inline while
    shared decoration and hint-style values stay as build-local values rather than helper
    methods.
  - app search bar read-only helper cleanup archived `_buildReadonlySearchBar`;
    `AppSearchBar.build` now owns the `controller == null` clipped `AppClickable`
    prompt inline.
  - app search bar editable helper cleanup archived `_buildEditableSearchBar`;
    `AppSearchBar.build` now owns the `controller != null` `TextField` branch inline.
  - app search bar text-style helper cleanup archived `_buildTextStyle`;
    `AppSearchBar.build` now owns the editable `TextField` `bodyMedium` font-size and
    `onSurface` color inline.
  - app search bar decoration/hint-style helper cleanup archived `_buildDecoration` and
    `_buildHintStyle`; `AppSearchBar.build` now owns the shared fill/radius decoration
    and hint `bodyMedium` style locals used by both branches.
  - app search bar autofocus prop cleanup archived the unused public `autofocus` default;
    current home and country-code search bars remain passive by relying on `TextField`'s
    non-autofocusing default.
  - ranking loading skeleton wrapper cleanup archived `_RankingSkeletonItem`; the
    loading `ListView` now owns the fixed 88px shimmer row inline.
  - ranking loading skeleton primitive cleanup archived `_RankingSkeletonThumbnail` and
    `_RankingSkeletonText`; the loading row now owns the thumbnail/text shimmer
    primitives directly.
  - ranking private badge helper cleanup archived `_RankBadge` and `_RankBadgeStyle`;
    `RankingItemCard.build` now owns the badge size, radius, rank 1/2/3 colors,
    top-rank gradient/shadow, fallback scrim, and italic label directly.
  - app network image loading-placeholder helper cleanup archived
    `_buildLoadingPlaceholder`; `AppNetworkImage.build` now owns custom-placeholder
    priority, optional shimmer, and fallback geometry inline.
  - app network image error-fallback helper cleanup archived `_buildErrorWidget`;
    `AppNetworkImage.build` now owns custom `errorWidget` priority, empty-URL and
    failed-load fallback handling, broken-image icon sizing, and decoration inline.
  - app network image decoration helper cleanup archived `_buildDecoration`;
    `AppNetworkImage.build` now owns fallback surface color and border radius directly
    in both loading and error fallback containers.
  - app image preview decode helper cleanup archived `_previewDecodeDimension`;
    `_AppImagePreviewState.build` now owns preview cache width/height decode sizing,
    finite/positive checks, DPR scaling, and max-dimension clamping inline.
  - app image preview save helper cleanup archived `_saveImage`;
    the save button now owns the saving gate, feedback lifecycle, media save call,
    success/error messages, and `_isSaving` reset inline.
  - app shimmer animation-sync helper cleanup archived `_syncAnimation`;
    `_AppShimmerState.build` now owns the effective-policy `repeat`/`stop` branches
    inline.
  - media image-save filename helper cleanup archived `_buildFileName`;
    `MediaUtils.saveImage` now owns URL path basename extraction, safe-base
    normalization, extension fallback, and timestamp suffixing inline.
  - adaptive blur helper cleanup archived `_buildBlur`; `AdaptiveBlur.build` now owns the
    reduced-motion fast path, policy-degrade child return, and `ClipRect`/`BackdropFilter`
    blur branches inline.
  - video list-card overlay getter cleanup archived `_overlayChildren`; the media stack
    now keeps the nullable overlay child branch inline instead of materializing a
    one-item list for a single spread site.
  - video list-card stats-row cleanup archived `_VideoListCardStatsRow`;
    `_VideoListCardBody.build` now owns custom/default stat resolution, the non-empty
    stats row, and 12px inter-stat spacing inline. The one-use `_resolvedStats` getter is
    archived too.
  - video list-card content wrapper cleanup archived `_VideoListCardContent`;
    `_VideoListCardBody.build` now owns the title, optional badge/middle content,
    optional author, and resolved stats column inline.
  - settings selection item cleanup archived `_SettingsSelectionItem`;
    `SettingsPage.build` now owns theme and language option row markup inline beside the
    corresponding locale/theme mutations.
  - search filter bar cleanup archived `_SearchFilterBar`; `_SearchResultTab.build` now
    owns the video/article sort and duration filter rows inline beside the tab-local
    `SearchQuery` state, including the direct video-only duration-filter gate.
  - search result renderer cleanup archived `_SearchVideoItem`, `_SearchUserItem`,
    `_SearchBangumiItem`, `_SearchArticleItem`, and `_SearchTopicItem`;
    `SearchResultList.build` now owns the video and bangumi `VideoListCard` branches,
    user metadata labels, article image-count branches, and topic row inline.
  - video card thumbnail/content wrapper cleanup archived `_VideoCardThumbnail` and
    `_VideoCardContent`; `VideoCard.build` now owns thumbnail cache sizing,
    recommendation label overlay styling, title/description text, author-row typography,
    truncation, spacing, and the trailing more icon inline. The one-use `_reason` getter
    is archived too; the `video?.rcmdReason ?? reason` fallback stays beside the overlay
    guard.
  - video thumbnail bottom-overlay cleanup archived `_ThumbnailBottomOverlay`;
    `VideoThumbnail.build` now owns the 48px bottom scrim gradient and radius inline,
    while stats/duration overlays remain unchanged.
  - article detail image/link-card block wrapper cleanup archived `_ImageBlockView`,
    `_LinkCardView`, and `article_detail_page_block_renderers.cards.dart`;
    `_buildArticleBlocks` now owns image preview/caption rendering and link-card
    navigation/chrome inline beside the paragraph, quote, and divider branches.
  - video thumbnail stats-row cleanup archived `_VideoThumbnailStats`;
    `VideoThumbnail.build` now owns the optional view/danmaku row, spacing, and repeated
    icon/text stat items inline.
  - video thumbnail cache-size helper cleanup archived `_resolveCacheSize`;
    `VideoThumbnail.build` now keeps explicit cache overrides, finite constraint checks,
    pixel-ratio multiplication, and null fallbacks inline in the `LayoutBuilder`.
  - app network image cache-size helper cleanup archived `_resolveCacheSize`;
    `AppNetworkImage.build` now keeps explicit cache overrides, logical width/height
    fallback sizing, device-pixel-ratio multiplication, and `_normalizeCacheSize`
    calls inline beside the `ExtendedImage.network` construction.
  - video detail play-url cache read wrapper cleanup archived `_readCachedPlayUrl`;
    `VideoDetailController` now reads `_playUrlSessionCache` inline through the shared
    cache-key builder while keeping the write path and cache semantics unchanged.
  - video detail play-url request-token wrapper cleanup archived
    `_isCurrentPlayUrlRequest`; `_loadPlayUrl` now keeps the
    `_playUrlRequestToken` comparison inline after the repository fetch.
  - home video actions private sheet cleanup archived `_HomeVideoActionsBottomSheet`;
    `showHomeVideoActionsBottomSheet` now owns the blurred rounded sheet chrome, drag
    handle, action rows, and watch-later/download-cover callbacks inline.
  - home video actions row wrapper cleanup archived `_ActionItem`; the home bottom
    sheet now owns both action rows as direct `InkWell` blocks with the same padding,
    icon, and `bodyLarge` typography.
  - legacy root-level architecture drafts are archived. `docs/architecture-spec.md` and
    `docs/refactoring-plan.md` moved to `archive/architecture` with archive notes, and
    the architecture guard now fails if those stale root-level document sources reappear.
  - unused `FormatUtils` string case/truncation helpers are archived. `capitalize`,
    `truncate`, `camelCaseToTitle`, and the private camel-case regex had no active
    external callers, and `FormatStringExtension` is now archived too.
  - unused `FormatUtils` extension getters are archived. `.timeAgo`, nullable
    `.formatImageUrl`, nullable `.parseDuration`, non-null `.parseDuration`,
    one-call `formatTimestamp()`, and the one-call int `.formatFileSize` getter are
    archived; static
    `FormatUtils.formatTimeAgo`, `FormatUtils.formatImageUrl`,
    `FormatUtils.formatFileSize`, and `FormatUtils.parseDurationString` remain because
    current UI/media/search/settings owners call the explicit APIs directly. The one-call
    `FormatUtils.formatDateTime` helper is archived; `formatTimeAgo` owns lazy
    `timeago.setLocaleMessages` initialization, the `timeago.format` locale fallback,
    and app-locale switch directly, so `_ensureTimeagoInitialized` and `_getAppLocale`
    stay archived. The one-call DateTime extension methods `toSimpleDate`,
    `toIsoDate`, and `toChatTime` are archived; short
    notification/session dates use the explicit static `FormatUtils.formatSimpleDate`
    API because two current owners share that rule.
  - one-call share helpers are archived. Article detail now shares its URL inline through
    `SharePlus`, and `UserProfileAppBar` owns its only profile share payload inline.
    Dynamic sharing is owned by `lib/features/dynamic/presentation/dynamic_share.dart`,
    so `share_utils.dart` does not remain as a feature-specific core utility.
  - unused core helper facades are archived. `ErrorHandler` no longer exposes test-only
    logged-error reset/count hooks without a test suite, and `AudioPlaybackStateGate`
    keeps quantization and the 250ms emission step private to `nextSnapshotIfShouldEmit`.
  - audio service initializer helper cleanup archived `_initializeCulculAudioService`;
    `initializeCulculAudioService` now owns the in-flight future gate, `AudioService.init`
    config, success flag, failure log, retry-on-failure behavior, and future reset inline.
  - unused request executor response wrapper is archived. `RequestExecutor.runResponse`
    had no active callers, so the network boundary keeps only the live `run`, `runApi`,
    `runApiDirect`, and `runUnit` methods.
  - unused request executor cache TTL option is archived. `RequestExecutionOptions`
    no longer exposes `cacheTtlOverride` or maps it through `toDioExtras`; generic
    `EndpointPolicy.cacheTtlOverrideExtra` stays resolver-owned for lower-level Dio
    policy extras.
  - inert request executor cancel-token option is archived. Search repositories still pass
    `CancelToken` directly to Retrofit APIs, but `RequestExecutionOptions` no longer stores
    an unread cancellation copy.
  - unused request executor callback options are archived. No active repository supplied
    `errorMapper` or `staleCacheFallback`, so `RequestExecutor.run` now maps all active
    failures through `AppError.fromObject` directly without dead override/fallback hooks.
  - dynamic post content-section helper is archived. `DynamicPostCard.build` now owns the
    transparent `Material`, rounded `InkWell`, detail navigation callback, and vertical
    padding inline instead of keeping one-call `_buildContentSection`.
  - dynamic post footer/stat helpers are archived. `DynamicPostCard.build` now owns the
    forward/comment/like footer row, share/detail/like callbacks, formatted count labels,
    liked color, feedback fallback, and repeated stat button chrome inline instead of
    keeping one-call `_buildFooter` or `_buildStat` methods.
  - dynamic comments reply-sheet content cleanup archived `_ReplySheetContent` and
    `_ReplySheetContentState`; `DynamicCommentsSliver.build` now uses the shared
    `CommentReplySheet.show` entrypoint and keeps only the `addReply` dispatch inline in
    the row callback.
  - guest login button wrapper is archived. `GuestView.build` now owns the only login
    `FilledButton` size, rounded shape, typography, and callback inline instead of keeping
    `_GuestLoginButton` as a one-use private class, and the unused `showLoginButton`
    branch is archived so active guest pages pass a required login callback.
  - guest message wrapper is archived. `GuestView.build` now owns the title and optional
    message text stack, preserving headline/body styles, 12px message gap, and centered
    alignment inline instead of keeping `_GuestMessage`.
  - guest illustration wrapper is archived. `GuestView.build` now owns the radial glow,
    badge background, lock icon, and decorative dots inline instead of keeping
    `_GuestIllustration`, `_GuestGlow`, `_GuestBadgeBackground`, or `_DecorativeDot`.
  - architecture guard path coverage was modernized for moved model/widget homes:
    `core/models`, feature `models`, `ui/widgets/cards`, and `ui/widgets/users` now
    receive the checks that previously pointed at archived `core/contracts`,
    `domain/entities`, and `ui/assemblies` paths. The guard now runs without stale
    missing-path noise.
- State placement is complete for this refactor phase: non-widget
  `presentation/view_models` has 0 active Dart files, and reusable feature state now lives
  under feature `state` directories.
- Continue merging:
  - duplicate DTO/entity/UI-state pairs into canonical feature models
  - business-specific shared `ui/widgets` into owning features
  - remaining profile presentation actions only when they prove to be reusable feature
    state instead of page-local behavior

## Immediate Execution Steps

1. Run `bash tool/architecture/run_architecture_guards.sh` and fix guard failures.
2. Remove empty directories left by moved view models.
3. Run `dart format` on changed Dart files.
4. Run `flutter analyze --no-fatal-infos`.
5. Run `git diff --check`.
6. Run GitNexus `detect_changes` and inspect unexpected affected flows.
7. Update `culcul-bea` with evidence and next phase notes.
