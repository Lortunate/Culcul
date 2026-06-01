# Culcul App Architecture Refactor Plan

Date: 2026-05-24
Tracking issue: `culcul-jix`

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
- Completed JSON object-list normalization cleanup: home feed and search result DTO
  converters now use `JsonUtils` string-key map helpers instead of duplicating
  `Map<String, dynamic>.from` list conversion loops.
- Completed relation service scalar-reader cleanup: relation user parsing now uses
  `JsonUtils.parseIntWithDefault`/`parseStringWithDefault`, and `JsonUtils.parseInt`
  handles numeric API values without keeping a duplicate relation-local `_readInt`.
- Completed relation service map-reader cleanup: relation user nested map parsing now
  calls `JsonUtils.asStringKeyedMap` directly instead of keeping a duplicate `_asMap`.
- Completed auth cached-user helper cleanup: `level_info` parsing now uses
  `JsonUtils.asStringKeyedMap` and `JsonUtils.parseInt`, so the auth cache boundary no
  longer keeps private `_asMapOrNull`/`_asIntOrNull` clones.
- Completed auth repository helper part cleanup: `getCachedUser`, `_cacheUser`,
  `clearCache`, `isLoggedIn`, `_loadCurrentUser`, and the user cache JSON helpers now
  live directly on/with `AuthRepositoryImpl`; `auth_repository_impl.helpers.dart` and
  `_AuthRepositoryHelpersMixin` are archived while `auth_repository_impl.flows.dart`
  remains as the behaviorful login-flow split.
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
  post-success `authProvider` user refresh.
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
- Completed profile relation-stats parser helper cleanup: `getProfile` now keeps the
  optional relation follower/following parse inline after the shared response data-map
  gate, so `_parseRelationStats` is archived and guarded.
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
- Completed video danmaku option Freezed shell cleanup: `DanmakuOption` now remains as a
  hand-written immutable value in `danmaku_option.dart`, preserving defaults, equality,
  hash, and diagnostics without `danmaku_option.freezed.dart`. The unused hand-written
  `copyWith` helper is archived too; the overlay builds a fresh option from
  `DanmakuSettings` instead of mutating the render value.
- Completed video danmaku Freezed shell cleanup: `DanmakuEntry` and `DanmakuSegment`
  now remain as hand-written immutable values in `danmaku.dart`, preserving read-only
  segment entries, equality, hash, and diagnostics without `danmaku.freezed.dart`.
  Their unused `copyWith` helpers are archived too.
- Completed playback snapshot Freezed shell cleanup: `PlaybackSnapshot` now remains as a
  hand-written immutable value in `playback_snapshot_view_model.dart`, preserving
  zero-duration defaults, `copyWith`, equality, hash, and diagnostics without
  `playback_snapshot_view_model.freezed.dart`.
- Completed audio playback snapshot Freezed shell cleanup: `AudioPlaybackSnapshot` now
  remains as a hand-written immutable value beside `AudioPlaybackStateGate`, preserving
  playback-state equality, hash, and diagnostics without
  `audio_playback_state_gate.freezed.dart`. The unused `copyWith` helper is archived too.
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
- Completed settings page helper cleanup: the language/theme selection flows and
  clear-cache action were folded into `SettingsPage.build`, preserving the shared
  bottom-sheet shell, locale/theme updates, cache invalidation, and refresh feedback
  without one-use helper methods.
- Completed settings cache-size provider cleanup: the settings page owns its private
  `_cacheSizeProvider` for the only cache-size read UI, and
  `settings_controller.dart` plus generated provider output are archived.
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
  archived.
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
  private helpers beside `LoadVideoDetailWorkflow`, preserving non-null request-user
  defaults and growable-false page mapping without public extension surface.
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
- Completed home video actions drag-handle helper cleanup: the fixed sheet handle was
  folded into `_HomeVideoActionsBottomSheet.build`, preserving its margin, width, height,
  surface-variant color opacity, and radius without a one-use `_buildDragHandle` helper.
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
- Completed dynamic feed query-bag cleanup: dynamic, user-space, and topic feed
  providers now call repository feed methods with explicit endpoint parameters, so
  `DynamicFeedQuery`, `SpaceDynamicFeedQuery`, `TopicDynamicFeedQuery`, and
  `dynamic_queries.dart` are archived.
- Completed dynamic post action-sheet wrapper cleanup: `DynamicPostHeader` now owns its
  share/copy/open action sheet privately, preserving Bilibili link construction, share
  text, clipboard feedback, external navigation, and drag-handle sheet UI without
  `showDynamicPostActions`, `DynamicPostAction`, or `dynamic_post_actions.dart`.
- Completed publish dynamic page-only widget cleanup: `publish_dynamic_page.dart` now
  owns its bottom toolbar, image grid, emoji picker, and topic picker privately,
  preserving toolbar actions, character count, safe-area padding, image remove/add
  controls, 3-column grid layout, emoji package loading/retry, tab controller
  disposal/rebuild, package icon tabs, emote insertion, debounced topic search,
  topic covers/fallback icons, HTML-stripped topic labels, and modal close behavior
  without `PublishDynamicBottomToolbar`, `PublishDynamicImageGrid`, `EmojiPicker`,
  `TopicPicker`, or their one-owner files.
- Completed article-detail public part-helper cleanup: the comment sliver builder is
  now `_buildArticleCommentSlivers` inside the article detail library, and the scaffold
  builder is now `_buildArticleDetailScaffold`, preserving loading/disabled/error/empty/
  list/load-more comment slivers plus the article scaffold/app-bar/refresh/bottom bar
  without exposing page-only helpers as public API.
- Completed profile nested-feed paging cleanup: user dynamic and user video tabs now
  share `profileNestedFeedExtentAfterThreshold`,
  `profileNestedFeedOnlyOnScrollEnd`, and `profileNestedFeedCacheExtent`; their differing
  viewport/max thresholds remain local.
- Completed profile home-tab wrapper cleanup: `UserProfilePage` now owns its home tab
  body as a private `_UserHomeTab`, preserving keep-alive, page storage, overlap
  injection, sticky/masterpiece/recent sections, and the recent-video tab switch callback.
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
  title/subtitle values into a scaffold that does not render them.
- Completed player theme dead-token cleanup: unused `PlayerTheme` constants/style helpers
  were removed, and the one-call public `sliderTheme` helper was folded into
  `progressSliderTheme`.
- Completed player progress-bar wrapper cleanup: the single-use video progress slider is
  now private to `PlayerControlsOverlay`, preserving position/buffer display, drag state,
  formatted labels, and seek-on-drag-end behavior without a public wrapper file.
- Completed gesture feedback wrapper cleanup: the double-tap seek ripple and
  brightness/volume indicator chrome now live privately with `InteractionLayer`,
  preserving animation completion, clipping, blur policy, text/value display, and progress
  indicator rendering without public controls-level wrapper files.
- Completed user dynamic skeleton wrapper cleanup: `UserDynamicFeed` now owns its loading
  shimmer card privately, preserving the header/content/footer shimmer layout without a
  public `DynamicSkeleton` file under shared UI. The private `_DynamicSkeleton` also
  keeps its header/content/footer shimmer rows inline in `build()` instead of one-call
  helper methods.
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
  `_buildUserMetaItem` helper are gone, and `SearchUserItem` owns its local label/value
  row construction directly.
- Completed video action-sheet entry cleanup: `showVideoActionsBottomSheet` now lives in
  the home owner file, so the thin `features/video/video_action_sheet_entry.dart`
  wrapper is gone.
- Completed image prefetch spec builder cleanup: home, profile, and video cover-prefetch
  paths now share `network_image_prefetch_specs.dart` for pixel-ratio cache-dimension
  construction.
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
  computed inline through `Object.hashAllUnordered`, so the file-local `_mapEquals`
  and `_mapHash` clones are archived with the room-detail read model.
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
- Completed publish dynamic route wrapper cleanup: `PublishDynamicRoute` now constructs
  `PublishDynamicPage` directly, removing the one-line
  `buildPublishDynamicRoutePage` facade from dynamic navigation.
- Completed dynamic route page wrapper cleanup: `DynamicRoute` and
  `DynamicDetailRoute` now compose `DynamicPage` / `DynamicDetailPage` with
  `buildDynamicNavigationScope` directly in the app router, removing the one-line
  `buildDynamicRoutePage` and `buildDynamicDetailRoutePage` facades from dynamic
  navigation.
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
- Completed ranking list-view cleanup: the one-page `RankingListView` tab body was
  folded into `RankingPage` as private UI while preserving provider watch, refresh, and
  keep-alive behavior.
- Completed to-view item cleanup: the one-page `ToViewItem` renderer was folded into
  `ToViewPage` as private `_ToViewItem`, preserving dismiss/delete behavior, compact
  `VideoListCard` dimensions, progress/owner metadata, stats, and open-video callback.
- Completed to-view page micro-wrapper cleanup: `_ToViewPageAppBar` and
  `_DismissibleToViewItem` were folded into `ToViewPage.build` and
  `_ToViewListView.build`, keeping clear-all visibility, confirm-dialog gating, swipe
  delete, and open-video wiring beside their only owners.
- Completed to-view list-shell cleanup: `_ToViewListView` was folded into
  `_ToViewBody.build`, so refresh, empty/error/loading state, swipe delete, and
  open-video wiring now live in one page body owner.
- Completed history item cleanup: the one-page `HistoryItemWidget` renderer was folded
  into `HistoryPage` as private `_HistoryItemWidget`, preserving keyed rows,
  archive-only open-video gating, wide `VideoListCard` dimensions, progress overlay,
  author, badge, and time stats.
- Completed history empty-state cleanup: `_HistoryEmptyState` was folded into
  `_HistoryContent.build` because it only rendered the single empty history branch.
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
- Completed search callback-helper cleanup: `_buildOnSearch` was folded into
  `SearchPage.build` because it only normalized the submitted term and dispatched to the
  page-owned search state.
- Completed search body-helper cleanup: `_buildSearchBody` was folded into
  `SearchPage.build`, keeping suggestion/result/landing mode ownership in the page that
  owns the search state.
- Completed search page state-wrapper cleanup: `SearchPage` now owns its page-local hook
  state privately, so `use_search_view_model.dart`, public `useSearchViewModel`, public
  `SearchPageMode`, and the public `SearchPageState` wrapper class are archived.
- Completed ranking page micro-wrapper cleanup: `_RankingAppBar`, `_RankingItemsList`,
  and `_RankingSkeletonList` were folded into `RankingPage.build` and
  `_RankingListViewState.build`, keeping tab chrome, loaded rows, and loading rows beside
  the only owner state that uses them.
- Completed settings selection-sheet cleanup: `_SettingsSelectionSheet` was folded into
  `_showSelectionSheet`, keeping the shared bottom-sheet chrome beside the only helper
  used by theme and language selectors.
- Completed profile page micro-wrapper cleanup: `_ProfileStatDivider` was folded into
  `_ProfileStats.build`, while `_ProfileStatItem` remains because it owns the repeated
  posts/following/followers stat row structure.
- Completed relation-list privacy error cleanup: `_RelationPrivacyError` was folded into
  `RelationUserList.errorBuilder`, preserving the `22115` privacy branch, lock icon,
  translated title/message, and theme colors without a one-use private widget.
- Completed user-profile tab-bar builder cleanup: `_buildUserProfileTabBar` was folded
  into `_UserProfileContent.build`, keeping the single tab renderer beside its
  `SliverPersistentHeader` owner.
- Completed live room state split cleanup: lifecycle and fetcher part files were folded
  into `LiveRoomController`, removing private mixin getter/override plumbing.
- Completed live room state shell cleanup: `LiveRoomState` was folded into
  `live_room_view_model.dart` as a controller-owned immutable class, preserving the
  room-id requirement, loading/error/room-info/anchor/gold-rank/guard/play-url fields,
  and `isPlaying`/`volume` UI state without a separate `live_room_state.dart` file or
  generated Freezed state wrapper.
- Completed live room error wrapper cleanup: `_LiveRoomError` was folded into
  `LiveRoomContent.build`, keeping the single error branch beside the room load state
  and retry controller read that own it.
- Completed live room content wrapper cleanup: `_LiveRoomTitle` and `_DanmakuTopGradient`
  were folded into their owning build branches, keeping the title render and danmaku
  top fade beside the only state/layout that consumes them.
- Completed live header private extension cleanup: `_LiveHeaderAnchorParts` and
  `_LiveHeaderTagParts` were folded back into `LiveHeader`, keeping header helper
  methods inside their only owning widget instead of splitting them into one-owner
  extensions.
- Completed live header number-format wrapper cleanup: `LiveHeader` now calls
  `FormatUtils.formatNumber` directly for online and gold-rank counts, so the one-line
  `_liveHeaderFormatNumber` delegate is archived.
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
- Completed favorites folder item cleanup: the one-use `FavFolderItem` file was folded
  into `FavFolderList` as a private row renderer.
- Completed favorites page wrapper cleanup: `_FavoritesTabView` and `_AddFolderAction`
  were folded into `FavoritesPage.build`, keeping the page-owned tab controller,
  logged-in tab body, current-tab add-folder visibility, dialog, invalidation, and error
  feedback in one place.
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
  was folded into `ProfileActionGrid.build`, keeping the page-owned action list beside
  the responsive row/wrap branches that consume it.
- Completed profile action-grid widget cleanup: `ProfileActionGrid` was folded into
  `ProfilePage.build`, preserving the desktop `LayoutBuilder`, six-column item width
  calculation, wrap spacing, mobile four-action row, disabled download item, and
  settings/history/favorites/watch-later/support callbacks without a separate public
  widget file.
- Completed profile action-button wrapper cleanup: `_ProfileActionButton` was folded into
  `UserProfileButtons`, preserving the chat `OutlinedButton` size, border, surface
  background, icon scale, and open-chat callback without a separate widget element.
- Completed profile privacy-error wrapper cleanup: `PrivacyErrorWidget` was folded into
  `RelationUserList`, keeping the private relation-list `AppError` code `22115` branch
  beside its only error builder and deleting the standalone feedback widget file.
- Completed feedback error-details helper cleanup: the one-use `_showErrorDetails`
  method was folded into `AppErrorWidget.build`, preserving `ErrorHandler` detail
  construction, selectable monospace content, translated title/confirm labels, and
  dialog close behavior without a separate helper method.
- Completed feedback button wrapper cleanup: `_ErrorDetailsButton` and `_RetryButton`
  were folded into `AppErrorWidget.build`, preserving the same icons, translated labels,
  compact density, retry border, padding, and error-details dialog behavior.
- Completed profile app-bar header cleanup: `_HeaderBackground` was folded into
  `ProfileAppBar.build`, keeping the profile/session header row inline with the only app
  bar that owns it.
- Completed profile action-grid helper cleanup: `ProfileActionGrid._buildActions` was
  folded into `ProfileActionGrid.build`, keeping the page-owned action list beside the
  only responsive branches that use it.
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
- Completed notification chat state part cleanup: `_ChatHelpersMixin` and
  `_ChatSendMixin` were folded into `Chat`, keeping local snapshot sync, older-page
  loading, min-seq tracking, image upload, send, refresh, and paging-error behavior on
  the single notifier owner without `chat_view_model.helpers.dart` or
  `chat_view_model.send.dart`.
- Completed auth/settings single-owner widget cleanup: `AuthBackground`,
  `SettingsSelectionSheet`, and `SettingsSelectionItem` were folded into their owning
  pages as private UI.
- Completed video controls utility cleanup: the side-panel/bottom-sheet orientation
  policy now lives with the player controls assembly as `showPlayerSidePanel`, so
  `controls_utils.dart` and the generic `showSidePanel` wrapper are archived.
- Completed settings/search page-owned UI cleanup: `SettingsTile`, `SettingsGroup`, and
  `SearchAppBar` were folded into their owning pages as private UI. `HotSearchSection`
  keeps provider-backed loading/error/empty/grid rendering inline with the section.
- Completed settings scaffold cleanup: `_SettingsPageScaffold` was folded into
  `SettingsPage` because it only delegated the page into a second private class.
- Completed home app-bar cleanup: `HomeAppBar` was folded into `HomePage` as private
  `_HomeAppBar`, keeping auth gating, search affordance, avatar/message actions, tab
  bar, and the message action button private to the page owner.
- Completed home card micro-wrapper cleanup: private live-room cover wrappers and the
  popular-card badge wrapper were folded into their owning cards, keeping card-specific
  media overlays and recommendation tags next to the only state that uses them.
- Completed shared overlay tag wrapper cleanup: video recommendation tags and live-area
  tags now live as card-private widgets, preserving semantic overlay colors and text
  styling without a public `AppOverlayTag` wrapper.
- Completed comment image wrapper cleanup: `CommentItemWidget` now owns its picture
  grid/preview helper privately, preserving single-image sizing, grid spacing, decode
  bounds, hero tags, load/error placeholders, and `AppImagePreview.open` behavior without
  a public `CommentImagesWidget` wrapper file.
- Completed home feed wrapper cleanup: `PopularView` and `RecommendView` now own their
  private list/grid rendering, prefetch, scroll-precache, and action-sheet wiring
  directly beside the feed state.
- Completed search history section cleanup: `SearchHistorySection` was folded into
  `SearchPage`, and the remaining private `_SearchHistorySection` was later folded into
  the landing branch as an inline `Consumer` because the history provider watch, clear
  action, and tag tap callback have one page owner.
- Completed search history provider cleanup: `SearchPage` now owns its private
  `_SearchHistory` notifier for the one page that reads and mutates search history,
  while `search_workflows.dart` remains the shared owner of normalization rules.
- Completed about page header cleanup: `_AboutHeader` was folded into `AboutPage.build`
  because it only rendered the single page's icon, product name, version tag, and summary
  copy.
- Completed search result item cleanup: the one-use `SearchVideoItem`, `SearchUserItem`,
  `SearchBangumiItem`, `SearchArticleItem`, and `SearchTopicItem` files were folded into
  `SearchResultList` as private result-entry renderers.
- Completed auth repository session cleanup: `auth_repository_impl.session.dart` and
  `_AuthRepositorySessionMixin` were removed, and `checkAndRefreshCookie()` / `logout()`
  now live directly on `AuthRepositoryImpl`, the single session-method owner.
- Completed auth repository helper part cleanup: `auth_repository_impl.helpers.dart` and
  `_AuthRepositoryHelpersMixin` were removed, keeping cached-user/current-user behavior
  directly with `AuthRepositoryImpl`.
- Completed auth repository crypto part cleanup: `auth_repository_impl.crypto.dart` was
  removed, keeping password-login encryption helpers beside the login flow that owns
  them.
- Completed notification chat message renderer cleanup: `ChatBubble`, `ChatTextMessage`,
  `ChatImageMessage`, and `ChatSystemMessage` were folded into `ChatMessageItem` as
  private renderers.
- Completed notification chat text renderer cleanup: `_ChatTextMessage` was inlined into
  `ChatMessageItem._buildContent` because it only forwarded `BilibiliEmojiText`
  configuration from the owner.
- Completed notification private-session item cleanup: the one-use `PrivateSessionItem`
  file was folded into `PrivateSessionListView` as a private row renderer.
- Completed notification private-session helper cleanup: the row summary, avatar, and
  unread-badge helpers were folded into the private-session item build method, keeping
  the row's profile lookup and visual chrome in one owner.
- Completed notification feed item cleanup: `_NotificationItemContent`,
  `_NotificationItemHeader`, and `_NotificationSourcePreview` were folded into
  `NotificationItemWidget` so one notification row has one owner for tap handling,
  header text, and source preview rendering.
- Completed notification feed text helper cleanup: `_getActionText` and `_getSourceText`
  were folded into `NotificationItemWidget.build`, preserving notification type labels
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
  `video_info_view.dart`.
- Completed video detail tag-chip cleanup: `_CompactTag` was folded into
  `_ExpandableDescriptionAndTags.build`, keeping expanded tag styling beside the only
  description/tag owner.
- Completed video player overlay chrome cleanup: `PlayerTopBar` and `PlayerBottomBar`
  were folded into `PlayerControlsOverlay`; the remaining one-use bottom-bar and lock
  button glue was then inlined directly into `PlayerControlsOverlay.build`.
- Completed vertical video right-action cleanup: `_RightActionItem` was folded into
  `_RightBar.build` so the action icon/count row stays beside the only action-list owner.
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
- Completed profile banner preview cleanup: `UserProfileHeader.build` now owns the only
  banner and avatar tap handlers inline, so `_showImagePreview` stays archived.
- Completed shared user-list title helper cleanup: `UserListTile.build` now owns the
  title typography, optional badge row, stats row, and optional subtitle text inline, so
  `_buildTitle`, `_buildTitleRow`, `_buildStatsRow`, and `_buildSubtitle` stay archived.
- Completed follow-button label helper cleanup: `FollowButton.build` now computes one
  local label for both accessibility and visible text, so `_resolveLabel` stays archived.
- Completed app-tag color helper cleanup: `AppTag.build` now owns background/foreground
  fallback colors inline, so `_backgroundColor` and `_foregroundColor` stay archived.
- Completed VIP tag shadow helper cleanup: `VipTag.build` now owns the `showShadow`
  null-or-single-`BoxShadow` branch inline, so its one-call `_buildShadow` stays
  archived.
- Completed app-card decoration helper cleanup: `AppCardContainer` now builds the
  `BoxDecoration` inline in the performance-policy builder while keeping `_buildShadow`
  as the policy boundary.
- Completed profile home-tab header cleanup: recent videos now uses shared
  `SectionHeader` with a trailing view-more link instead of a duplicate private header
  row.
- Completed single-consumer data mapper cleanup: history, profile, and favorites
  DTO-to-domain mapper extensions now live privately in their sole repository libraries,
  the to-view copy-only mapper was removed after `ToViewEntry` became the item JSON
  owner, and the public mapper files are archived.
- Completed notification system-notice mapper cleanup: system-notice JSON persistence
  mapping now lives with the canonical `SystemNotice` entity instead of a data mapper;
  the separate `system_notice_mapper.dart` file and mapper-level helper ownership are
  archived.
- Completed notification message-support helper cleanup: system notification talker/text
  parsing helpers now live privately on `NotificationFeedSync`, and the one-owner
  extension file `notification_repository_impl.message_support_helpers.dart` plus public
  helper method surface are archived.
- Completed notification message-support dead-helper cleanup:
  `NotificationMessagePersistence` remains the only owner for emoji key canonicalization,
  emoji variant insertion, and local-row-to-message conversion; duplicate
  `NotificationMessageSupport` helper copies were removed.
- Completed notification message-support owner cleanup: `NotificationFeedSync` now owns
  the feed remote fetch dispatch, like response normalization, system talker lookup, and
  system notice extraction directly. The one-owner `NotificationMessageSupport` delegate
  and `notification_repository_impl.message_support.dart` are archived.
- Completed notification landing category-grid cleanup: the one-page
  `NotificationCategoryGrid` widget now lives privately in `notification_page.dart`
  beside the callbacks and unread-count watch that own it.
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
  `last_msg`, `at_uids`, `e_infos`, list/map equality, and DTO-local `contentMap`
  parsing without `private_message_model.freezed.dart` or
  `private_message_model.g.dart`.
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
- Completed favorite detail resource-item cleanup: `_FavoriteResourceRow` now owns its
  `VideoListCard` composition, uploader line, more action, and play/danmaku stat chips
  directly, so `_FavResourceItem` no longer remains as a one-use row wrapper.
- Completed favorite detail loading-skeleton cleanup: `FavoriteDetailPage` now owns the
  fixed 10-row shimmer loading list directly in its loading branch, so the one-use
  `_FavoriteDetailSkeleton` wrapper no longer remains beside the page.
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
  `_fromDioException`, preserving 401/403 auth classification, response status/message
  propagation, and server fallback without a one-call private helper.
- Completed endpoint policy provider cleanup: `NetworkQualityInterceptor` now constructs
  `EndpointPolicyResolver` from `runtimePerformancePolicyProvider` directly, so the
  one-consumer generated `endpoint_policy_provider.dart` wrapper is archived.
- Completed WBI signer wrapper cleanup: `WbiHelper` now owns WBI mixin-key construction,
  sorted query normalization, and `w_rid` generation directly; the one-owner
  `wbi_signer.dart`/`WbiSigner` helper class is archived.
- Completed resource API provider wrapper cleanup: `ResourceApi` now owns the
  `basicResourceApiProvider` and `resourceApiProvider` factories beside the Retrofit
  interface, so `resource_api_provider.dart` and its generated output are archived.
- Do not replace the network stack until all repository call sites can move in one
  coherent phase.

## Phase 4: Feature Directory Simplification

Goal: remove template-shaped layers that do not carry behavior.

- Remove empty `domain`, `application`, `presentation/view_models`, `service`, `helper`,
  and `utils` folders after each feature pass.
- Rename `presentation` to `ui` only when all imports in that feature can move in the same
  batch.
- Keep `navigation.dart` only when it contains behaviorful navigation composition.
- Move business assemblies currently under `ui/assemblies` back to owning features unless
  they are truly shared.

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
  - video detail share wrapper already collapsed into the only video actions row caller;
    `shareVideo` stays archived while reusable share variants remain in `share_utils.dart`
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
  - live header viewer avatar helper already collapsed into `_buildViewerStack`;
    `_buildViewerAvatar` stays archived as a one-call decorative wrapper
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
  - hot search ranked item wrapper already collapsed into `HotSearchSection`
  - video comments handwritten list split already collapsed into its owning comments view
  - profile app bar handwritten exp bar split already collapsed into its owning widget
  - notification item handwritten content split already collapsed into its owning widget
  - notification list page helper file already collapsed into the owning page
  - notification navigation parser split already collapsed into
    `notification_navigation.dart`; parser behavior and public API remain unchanged
  - favorite detail pure row/skeleton UI splits already collapsed into the owning page
  - favorite detail list/action splits already collapsed into the owning page
  - profile page/header handwritten content/section splits already collapsed into their
    owning page/widget files
  - profile tab local stat/sort/render-state UI splits already collapsed into their
    owning section/tab widgets
  - profile video image prefetch tuning facade archived; recent-video grid ratio stays
    private to `RecentVideoSection`, and user-video list prefetch sizing stays private to
    `UserVideoTab`
  - video listen page private controls/widget splits already collapsed into the owning
    page file
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
    owning comment/info views; the constants-only `video_prefetch_tuning.dart` file is
    archived
  - unused video danmaku view metadata seam already removed; active video danmaku
    data ownership stays with segment loading and AI mask bytes, and
    `DanmakuViewConfig` / `fetchDanmakuView` remain archived
  - video danmaku AI-mask provider wrapper already moved out of presentation;
    `VideoExtraWorkflows` owns the async provider, and `danmaku_mask_view_model.dart`
    stays archived
  - video player wakelock test seam already removed; `usePlayerSystemSettings` calls
    `WakelockPlus` directly and no longer exposes `PlayerWakelock`,
    `PlatformPlayerWakelock`, or `syncPlayerWakelock`
  - video loader input selector seam already folded into `useVideoLoader`; player pages
    pass `bvid` directly and no longer call `watchVideoLoaderInput` or handle a public
    `VideoLoaderInput` record
  - vertical video author bar empty avatar click, fake follower count, and inactive
    follow chip already removed
  - `GuestView` private illustration/login/message part splits already collapsed into the
    owning shared widget file
  - `CulculTheme` private palette/component part splits already collapsed into the owning
    theme file
  - `VideoCard` private content/footer/thumbnail part splits already collapsed into the
    owning feed card file
  - `VideoListCard` private body/content/media part splits already collapsed into the
    owning feed card file
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
  - live gold-rank and guard-list page-size defaults already consolidated to
    `liveGoldRankPageSize` and `liveGuardListPageSize`
  - one-line publish dynamic route page wrapper already collapsed into
    `PublishDynamicRoute`
  - one-line dynamic route page wrappers already collapsed into `DynamicRoute` and
    `DynamicDetailRoute`
  - single-use article detail loading/error/empty scaffold helpers already collapsed
    into `ArticleDetailPage.build`
  - empty directories left by collapsed shared UI handwritten part splits already removed
  - repeated cover-image `NetworkImagePrefetchSpec` construction already consolidated to
    `ui/widgets/media/network_image_prefetch_specs.dart`
  - `AppImagePreview` private widget part split already collapsed into the owning shared
    preview file; the public constructor and `open(...)` API remain unchanged
  - unused `VideoCardContent` public wrapper already deleted; `VideoCard` owns the
    private content renderer without dead `extra` extension slots
  - `AppAvatar` one-use decorative fallback/shadow/border helpers already inlined into
    the avatar owner
  - comment image grid/preview wrapper already collapsed into `CommentItemWidget`;
    comment content owns picture sizing, decode bounds, hero tags, and preview opening
  - `SmartPagingView` content/load-more part splits already collapsed into the owning
    shared paging file
  - `SmartPagingView` one-use refresh result helper already inlined at the EasyRefresh
    boundary
  - scroll prefetch budget helper already collapsed into `useScrollPrecache`;
    `ScrollPrecacheBudget` and `resolveScrollPrecacheBudget` stay archived as hook-local
    policy plumbing
  - favorites folder dialog form-data wrapper already replaced with a typed record
    returned directly from `FavFolderDialog`
  - generic page skeleton wrappers already collapsed into the owning home popular and
    recommend feed loading branches
  - unused `SmartPagingContent` public content layer already made private to
    `SmartPagingView`
  - publish dynamic page private scaffold/app-bar widget split already collapsed into
    the owning page file
  - publish dynamic page private editor widget split already collapsed into the owning
    page file, and its no-op text-change callback already removed
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
  - comment item private footer split already collapsed into the owning shared comment
    item file, and its empty more-menu action already removed
  - comment item private header/replies splits already collapsed into the owning shared
    comment item file
  - dynamic comments no longer pass an empty dislike callback into shared comment item
    controls
  - dynamic comments empty-state widget already made private to the comments sliver owner
  - video comments empty-state widget already made private to the comments view owner
  - video detail info one-file tag/action render helpers already made private to their
    owning section widgets
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
  - player settings danmaku slider row split already collapsed into `PlayerSettingsSheet`
  - player settings speed/quality option section split already collapsed into
    `PlayerSettingsSheet`
  - vertical video top/right control split already collapsed into `VerticalVideoPage`
  - vertical video bottom-bar split already collapsed into `VerticalVideoPage`
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
    sheet implementation
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
    consolidated as private constants in `SearchResultList`
  - single-use search history tag wrapper already inlined into the owning section
  - search/to-view DTO fields already slimmed to current mapped app-facing concepts
  - home/search object-list DTO conversion already consolidated through `JsonUtils`
  - notification send-result one-call map reader already collapsed into
    `JsonUtils.asStringKeyedMap`
  - single-use widget wrappers already removed from dynamic detail rendering
  - dynamic vote additional card wrapper already collapsed into `DynamicContentWidget`
    inline beside the additional-type dispatcher; do not restore `_DynamicVoteCard`
  - dynamic common additional and link-card wrappers already collapsed into
    `DynamicContentWidget`; content card rendering stays beside the dispatcher instead
    of exporting one-owner wrapper files
  - dynamic UGC additional and video content wrappers already collapsed into
    `DynamicContentWidget`; fallback navigation IDs, jump URLs, cover sizing, and
    counter/chrome rendering stay with the content dispatcher
  - dynamic goods and reserve additional wrappers already collapsed into
    `DynamicContentWidget`; empty goods shrink behavior, list rows, reserve disabled
    state, translated labels, and navigation remain beside `_buildAdditional`
  - dynamic image wrapper already collapsed into `DynamicContentWidget`; trim/take-9,
    empty shrink, single-image constraints, grid sizing, tap targets, and preview open
    behavior stay with the content owner
  - dynamic forward wrapper already collapsed into `DynamicContentWidget`; author
    navigation, fallback forward text, and recursive original-post rendering stay with
    the content owner
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
    executor class owns the callback policy directly
  - listen audio mode hook input typedef already inlined into `useListenAudioMode`; the
    hook owns that single record parameter shape directly
  - request executor `runVoid` pass-through wrapper already deleted; void actions can use
    `run` or `runUnit` directly
  - to-view page app bar wrapper already collapsed into `to_view_page.dart`; the page
    owns its tiny title/actions surface directly
  - home tab bar wrapper already collapsed into `home_page.dart`; the page owns
    its single bottom tab surface directly
  - live bottom bar wrapper already collapsed into `live_room_page.dart`; the room page
    owns its single input affordance directly
  - live room page-local `_LivePlayerSection` and `_LiveBottomBar` wrappers already
    collapsed into `LiveRoomPage.build`; the page owns its player aspect-ratio shell and
    danmaku input affordance directly
  - live danmaku message factory and one-off gift/interact/system renderers already
    collapsed into `live_room_content.dart`
  - live danmaku guard/medal/admin badges already collapsed into `live_normal_message.dart`
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
  - request executor app-error and stale-cache aliases already inlined into
    `RequestExecutionOptions`; the network core owns the callback types directly
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
    feedback UI directly
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
  - shared dynamic/video comment list state no longer uses a Freezed-generated shell;
    `CommentListState` remains a small immutable value over `PagedListState<CommentItem>`
    and `CommentSort`
  - favorites folder-detail state no longer uses a Freezed-generated shell; the folder
    resources controller owner keeps `FavFolderDetailState` as a small immutable value
    while preserving nullable folder info and paging copy/equality semantics
  - notification chat state no longer uses a Freezed-generated shell; the chat notifier
    owner keeps `ChatState` as a small immutable value while preserving paging copy
    semantics and emoji-map equality/immutability; the emoji-map hash is inline
    unordered hashing, so the local `_mapHash` helper stays archived
  - network endpoint policy no longer uses a Freezed-generated shell; the network core
    keeps `EndpointPolicy` as a hand-written immutable value while preserving cache,
    retry, deduplication, prefetch, nullable TTL copy, and retryable status-set equality
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
    slice. The one-use `_parseInitialState` helper is also archived; initial-state JSON
    decode/type normalization now stays inline in `ArticleDetailParser.extractInitialState`.
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
  - article detail stats chip cleanup archived `_StatChip`; `_StatsRow.build` now owns
    the favorite/like icon-text cells inline while preserving centered rows, spacing,
    vertical padding, and typography.
  - settings about-page action tile cleanup archived `_ActionTile`; `AboutPage.build` now
    owns the GitHub and license `Material`/`InkWell` rows inline while preserving icon
    chrome, typography, chevron, and callbacks.
  - app search bar icon helper cleanup archived the trivial `_buildSearchIcon` method;
    editable and read-only branches now own their static search icon inline while
    decoration and text-style helpers remain as the shared branch styling boundary.
  - app search bar read-only helper cleanup archived `_buildReadonlySearchBar`;
    `AppSearchBar.build` now owns the `controller == null` clipped `AppClickable`
    prompt inline while preserving the editable `TextField` branch.
  - app search bar text-style helper cleanup archived `_buildTextStyle`;
    `_buildEditableSearchBar` now owns the editable `TextField` `bodyMedium` font-size
    and `onSurface` color inline.
  - ranking loading skeleton wrapper cleanup archived `_RankingSkeletonItem`; the
    loading `ListView` now owns the fixed 88px shimmer row inline.
  - ranking loading skeleton primitive cleanup archived `_RankingSkeletonThumbnail` and
    `_RankingSkeletonText`; the loading row now owns the thumbnail/text shimmer
    primitives directly.
  - app network image loading-placeholder helper cleanup archived
    `_buildLoadingPlaceholder`; `AppNetworkImage.build` now owns custom-placeholder
    priority, optional shimmer, and fallback geometry inline.
  - video list-card overlay getter cleanup archived `_overlayChildren`; the media stack
    now keeps the nullable overlay child branch inline instead of materializing a
    one-item list for a single spread site.
  - video card reason-tag wrapper cleanup archived `_VideoReasonTag`; the thumbnail
    branch now owns the recommendation label overlay styling inline while preserving
    semantic overlay colors, border, padding, and text style.
  - video card title/description/footer wrapper cleanup archived `_VideoCardTitle`,
    `_VideoCardDescription`, and `_VideoCardFooter`; `_VideoCardContent.build` now owns
    the text and author-row typography inline while preserving truncation, spacing, and
    the trailing more icon.
  - video thumbnail bottom-overlay cleanup archived `_ThumbnailBottomOverlay`;
    `VideoThumbnail.build` now owns the 48px bottom scrim gradient and radius inline,
    while stats/duration overlays remain unchanged.
  - article detail image/link-card block wrapper cleanup archived `_ImageBlockView`,
    `_LinkCardView`, and `article_detail_page_block_renderers.cards.dart`;
    `_buildArticleBlocks` now owns image preview/caption rendering and link-card
    navigation/chrome inline beside the paragraph, quote, and divider branches.
  - video thumbnail stats-row cleanup archived `_VideoThumbnailStats`;
    `VideoThumbnail.build` now owns the optional view/danmaku row and spacing inline,
    while `_ThumbnailStatItem` remains as the repeated counter primitive.
  - video thumbnail cache-size helper cleanup archived `_resolveCacheSize`;
    `VideoThumbnail.build` now keeps explicit cache overrides, finite constraint checks,
    pixel-ratio multiplication, and null fallbacks inline in the `LayoutBuilder`.
  - video detail play-url cache read wrapper cleanup archived `_readCachedPlayUrl`;
    `VideoDetailController` now reads `_playUrlSessionCache` inline through the shared
    cache-key builder while keeping the write path and cache semantics unchanged.
  - home video actions row wrapper cleanup archived `_ActionItem`; the home bottom
    sheet now owns both action rows as direct `InkWell` blocks with the same padding,
    icon, and `bodyLarge` typography.
- State placement is complete for this refactor phase: non-widget
  `presentation/view_models` has 0 active Dart files, and reusable feature state now lives
  under feature `state` directories.
- Continue merging:
  - duplicate DTO/entity/UI-state pairs into canonical feature models
  - business-specific `ui/assemblies` into owning features
  - remaining profile presentation actions only when they prove to be reusable feature
    state instead of page-local behavior

## Immediate Execution Steps

1. Run `bash tool/architecture/run_architecture_guards.sh` and fix guard failures.
2. Remove empty directories left by moved view models.
3. Run `dart format` on changed Dart files.
4. Run `flutter analyze --no-fatal-infos`.
5. Run `git diff --check`.
6. Run GitNexus `detect_changes` and inspect unexpected affected flows.
7. Update `culcul-jix` with evidence and next phase notes.
