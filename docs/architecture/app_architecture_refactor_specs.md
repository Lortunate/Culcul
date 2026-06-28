# Culcul App Architecture Refactor Specs

Date: 2026-05-24

## Purpose

This refactor makes Culcul easier to understand, safer to change, and cheaper to run. It
does not preserve old internal APIs or old directory conventions when they conflict with
clarity. Compatibility work is out of scope unless it protects a current user-facing flow.

## Current Evidence

- `lib/` has 713 Dart files in the current worktree.
- `lib/features/` owns 547 Dart files; the largest areas are `video`, `dynamic`,
  `notification`, `profile`, and `live`.
- `presentation/view_models` has 0 active Dart files, while the new `state` directories
  have 61 Dart files. Feature state ownership has moved out of presentation; remaining
  handwritten parts are treated as UI/data split candidates rather than state placement.
- `test/` and `integration_test/` currently contain no files, so analyzer and architecture
  guards are the main verification gates until focused tests are added.
- CI must not reference missing local scripts or stale test paths. Validation entrypoints
  must be present in `tool/` or `scripts/`.
- `flutter pub outdated` shows upgrade candidates including `drift`, `drift_flutter`,
  `dio_cache_interceptor`, `json_annotation`, `json_serializable`, and
  `sqlite3_flutter_libs`.
- GitNexus is available for impact analysis, but query FTS reported degraded search after
  re-index. Symbol-specific `impact`, `context`, and `detect_changes` remain mandatory.

## Target Directory Shape

```text
lib/
  main.dart
  app/
    app.dart
    bootstrap/
    router/
      routes/
    runtime/
    shell/
  core/
    bootstrap/
    constants/
    data/
      network/
      pagination/
    errors/
    feedback/
    hooks/
    models/
    perf/
    result/
    runtime/
    services/
    session/
    storage/
    theme/
    utils/
  features/
    <feature>/
      application/  # only when real orchestration policy exists
      data/
      models/
      presentation/
      state/
      navigation.dart
  ui/
    responsive/
    widgets/
```

Migration note: `lib/ui/` is the current shared widget home. Do not create a parallel
`shared/` component for an existing `ui/` component unless the old component is moved or
deleted in the same phase. Rename feature `presentation` directories to `ui` only in a
single feature-sized batch that updates imports and deletes the old path.

## Architecture Rules

- `main.dart` only prepares bindings, root overrides, localization, performance probes,
  and `runApp`.
- `app/router` is the single source of truth for route declarations and thin page
  construction. Feature-level `navigation.dart` files may contain behaviorful navigation
  composition only.
- Route transition wrappers must correspond to active route behavior. Do not keep
  speculative transition classes such as `SlideFromLeftTransitionPage`, and do not keep
  one-use wrappers such as `FadeTransitionPage` when the only route can own the
  transition directly.
- App shell layout is owned by `MainShell`. Do not restore `AdaptiveShellScaffold` as a
  one-owner wrapper around the desktop `NavigationRail` and mobile `BottomNavigationBar`
  branches.
- Text selection uses Flutter `SelectableText.rich` directly at the owning widget. Do
  not restore `AppSelectableText` as a pass-through wrapper; call sites that need the old
  behavior must set `NeverScrollableScrollPhysics` explicitly.
- `features/*/route_entry.dart` is archived. No new route entry files or imports are
  allowed.
- Feature folders use only layers that carry real behavior. Empty `domain`, `application`,
  `service`, `helper`, `manager`, and `utils` folders are deleted.
- Dynamic `*_port.dart` and one-line `*_application_providers.dart` boundaries are
  archived. Dynamic UI/state reads concrete repository providers directly unless a
  behaviorful workflow/controller/provider owns real policy.
- Dynamic feed repository inputs use explicit method parameters for each endpoint's real
  API semantics. Do not reintroduce copy-only feed query bag classes such as
  `DynamicFeedQuery`, `SpaceDynamicFeedQuery`, or `TopicDynamicFeedQuery`.
- Dynamic detail state is page-owned because `DynamicDetailPage` is the only consumer;
  keep its initial load, refresh, optimistic like update, and rollback behavior private
  to `dynamic_detail_page.dart`. Do not restore `dynamic_detail_view_model.dart`,
  `DynamicDetailUiState`, `DynamicDetailViewModel`, or
  `dynamicDetailViewModelProvider`.
- Article-detail state belongs in `lib/features/dynamic/state`; its workflows may stay
  under `application` only when they own real orchestration policy.
- Article-detail comment actions should return a named record for page-side effects such
  as clear/unfocus/error/disabled flags. Do not restore an
  `ArticleDetailCommentActionResult` class that only wraps those fields.
- Publish state is page-owned because `PublishDynamicPage` is the only consumer; keep
  its publish guard, csrf resolution, image upload, publish submission, and feed
  invalidation private to `publish_dynamic_page.dart`. Do not restore
  `publish_dynamic_view_model.dart`, `PublishDynamicUiState`,
  `PublishDynamicViewModel`, or `publishDynamicViewModelProvider`.
- Article-detail `part` helpers stay private unless they are true feature APIs. Do not
  expose page-only scaffold/sliver/comment helpers such as `buildArticleDetailScaffold`
  or `buildArticleCommentSlivers` from active part files.
- Dynamic publish orchestration is owned by `PublishDynamicPage` because it is the only
  consumer. Do not restore `PublishDynamicWorkflow`, `publishDynamicWorkflowProvider`,
  or `dynamic_workflows.dart` as a one-consumer wrapper around `DynamicRepositoryImpl`.
- Publish-dynamic page-only chrome and picker UI stay private to
  `publish_dynamic_page.dart`. Do not restore `PublishDynamicBottomToolbar`,
  `PublishDynamicImageGrid`, `_PublishToolbarAction`, `_PublishImageItem`,
  `_PublishAddImageButton`, `EmojiPicker`, `TopicPicker`, or their one-owner widget
  files unless a second real publish surface shares the behavior.
- Feature-level facades are archived when they only construct one widget and hide the
  real owner without adding navigation, policy, or composition.
- Route-level page factories are archived when their only behavior is returning a single
  page constructor or duplicating router-owned callback wiring that the app router can
  own directly.
- Dynamic route page factories are archived when they only duplicate router-owned
  callbacks around `buildDynamicNavigationScope`; the typed app router owns
  `DynamicPage` and `DynamicDetailPage` composition directly.
- Dynamic post action sheets stay with their owning header/card when they have a single
  consumer. Do not restore `showDynamicPostActions`, `_showDynamicPostActions`, or
  `dynamic_post_actions.dart` as a one-entry wrapper around `DynamicPostHeader`;
  keep any typed modal action result private to the header file.
- Dynamic post header author navigation stays inline with `DynamicPostHeader.build`;
  keep the shared avatar/name callback as a build-local closure and do not restore a
  private `_openUserProfile` method.
- Dynamic post header author-name color mapping stays inline with
  `DynamicPostHeader.build`; keep the official-account primary-color switch beside the
  author `TextStyle` owner and do not restore `_authorColor`.
- Dynamic forward-card author navigation stays inline with `DynamicContentWidget.build`;
  keep the forwarded-author callback as a build-local closure and do not restore a
  private `_openUserProfile` method in `dynamic_content_widget.dart`.
- Thin one-owner action-sheet entry files are archived when they only forward to the
  home feature's video actions owner; the home wrapper owns the bottom-sheet policy.
- Share helpers are kept only when multiple current owners share the same payload rule.
  One-call helpers such as article URL sharing and user-profile sharing stay inline with
  the menu/action owner; do not restore `shareUri` or `shareUser`. Dynamic sharing is
  feature-owned through `shareDynamicItem`; do not restore `core/utils/share_utils.dart`
  as a feature-specific core utility.
- Video action bottom-sheet widgets are home-owned when their only entrypoint is
  `showHomeVideoActionsBottomSheet`; do not keep a cross-feature
  `VideoActionsBottomSheet` wrapper under the video feature for home-only actions.
  Keep the home sheet chrome, drag handle, and rows inline with the
  `showHomeVideoActionsBottomSheet` modal builder; do not restore
  `_HomeVideoActionsBottomSheet` or a one-use `_buildDragHandle` method for fixed visual
  elements.
- Auth feature facades are archived when they only expose one-line UI providers. Widgets
  call the concrete login UI/state owner directly.
- Auth QR login polling state is view-owned while it has a single consumer. Keep QR URL
  loading, three-second polling, status-code mapping, expired/success timer cancellation,
  refresh retry, and post-success auth refresh private to `QrLoginView` and inline with
  `_AuthQrLoginController.refresh`; do not restore `auth_qr_login_view_model.dart`,
  public QR-login provider/state shells, or one-use `_startPolling`/`_updateStatus`
  controller helpers.
- Auth Geetest hook result state is hook-owned. Keep the captcha start callback and
  loading flag as the `useGeetest` record return shape; do not restore a public
  `UseGeetestResult` wrapper class for the password/SMS login widgets.
- Auth QR poll result is repository-owned and hand-written. Keep `AuthQrPollResult`
  as a small immutable value beside the QR login repository flow; do not restore
  `auth_qr_poll_result.freezed.dart` or the unused `copyWith` helper.
- Auth QR code is repository-owned and hand-written. Keep `AuthQrCode` as a
  small immutable value for the QR URL/key returned by `AuthRepositoryImpl`;
  do not restore `auth_qr_code.freezed.dart` or the unused `copyWith` helper.
- Auth country code is repository/UI-owned and hand-written. Keep `CountryCode`
  as a small immutable value for country-list parsing, default SMS country
  selection, and country-picker navigation; do not restore
  `country_code.freezed.dart` or the unused `copyWith` helper.
- Auth cached user is repository-owned and hand-written. Keep `UserEntity` as a
  small immutable value for current-user loading, cache serialization, and
  `AuthState.user`; do not restore `user_entity.freezed.dart` or the unused
  `copyWith` helper.
- Auth controller state is controller-owned and hand-written. Keep `AuthState` beside
  `Auth` in `auth_controller.dart`, preserving login/loading/user/error defaults,
  nullable clearing, value equality, and diagnostics without
  `auth_controller.freezed.dart`.
- Auth captcha challenge is login-flow-owned and hand-written. Keep
  `AuthCaptchaChallenge` as a small immutable value in `auth_captcha_challenge.dart`,
  preserving token/gt/challenge transport, equality, and diagnostics without
  `auth_captcha_challenge.freezed.dart`; do not restore the unused `copyWith` helper.
- Auth repository private part-file mixins are archived when they only split session
  or cache/current-user helper methods for the single `AuthRepositoryImpl` owner; cookie
  refresh, logout, cached-user, and current-user loading behavior stay on the repository
  class.
- Auth current-user cache writes are owned inline by `_loadCurrentUser`. Do not restore a
  one-call `_cacheUser` helper when the cache key, JSON encoding, and current-user success
  branch share the same repository owner. Keep the successful current-user cache JSON
  shape inline there too; do not restore `_userEntityToJson` while it has no second
  active caller.
- Auth session cookie refresh adapters are owned by `auth_session_providers.dart`, the
  runtime override factory owner. Do not keep a separate
  `auth_session_cookie_refresher.dart` file or public `AuthSessionCookieRefresher` class
  when it only calls `AuthRepositoryImpl.checkAndRefreshCookie()`.
- Ranking category feed state is owned by `RankingPage`. Do not keep a separate
  `category_ranking_view_model.dart` file or generated provider wrapper when only the
  ranking page consumes the list and error-retry behavior.
- Auth repository password crypto helpers are owned by the login-flow part, not a
  separate one-owner `auth_repository_impl.crypto.dart` part file.
- Notification port/provider boundaries are archived. `NotificationLifecycleSync` owns
  the concurrent lifecycle resume sync policy directly; unread, session, feed, chat,
  and system-notice state read the concrete notification repository provider directly.
- Notification reusable state belongs in `lib/features/notification/state`; the old
  `presentation/view_models` directory is archived.
- Notification feed cursor is owned by `notification_feed_cursor.dart`. Do not restore
  `notification_feed_cursor.freezed.dart` for the tiny two-field paging cursor; keep
  `NotificationFeedCursor` as a hand-written immutable value beside the repository and
  list-page consumers. The file keeps only the active cursor fields and value semantics;
  unused `copyWith` helpers stay archived.
- Notification unread summary is owned by `notification_summary.dart`. Do not restore
  `notification_summary.freezed.dart`; keep `NotificationSummary` as a hand-written
  immutable counter bundle beside the repository and unread-count page consumer. Do not
  restore the unused `copyWith` helper.
- Notification system notice is owned by `system_notice.dart`. Do not restore
  `system_notice.freezed.dart`; keep `SystemNotice` as a hand-written immutable
  value beside the repository and system-notice page consumer. Keep active JSON helpers,
  but do not restore the unused `copyWith` helper.
- Notification send-result value is owned by `send_message_result.dart`. Do not restore
  `send_message_result.freezed.dart`; keep the small immutable result object
  hand-written beside `NotificationRepositoryImpl.sendPrivateMessage`. Do not restore the
  unused `copyWith` helper.
- Notification page-only stream state is page-owned when one page consumes it. Keep
  system-notice local watch, initial sync, logged-out empty fallback, and refresh
  behavior private to `SystemNotificationPage`; keep unread-count watch/sync behavior
  private to `NotificationPage`; keep private-session local paging, head sync, older
  session loading, talker-id de-dupe, and logged-out empty fallback private to
  `PrivateSessionListView`; keep reply/at/like feed cursor paging, head sync, load-more,
  and system-feed empty fallback private to `NotificationListPage`. The feed list's
  `EasyRefresh.onLoad` owns the system no-load branch and `ScrollLoadTrigger` call
  inline; do not restore a one-use `_loadMore` wrapper. Do not restore
  `openNotificationTarget`; notification rows keep target parsing, `onOpenTarget`, and
  navigation failure feedback inline beside the row tap owner. Do not restore
  `system_notification_view_model.dart`, `unread_count_view_model.dart`,
  `private_session_view_model.dart`, `notification_feed_view_model.dart`, or their
  public provider shells.
- Notification one-owner state type part splits are archived when the type only serves
  its owning notifier file. Keep Freezed state definitions with their owning notifier
  unless the type has independent cross-file ownership.
- Notification page-local list helpers are archived when they only branch on the current
  page type and forward to one page's feed provider.
- Notification owner-uid wrapper providers are archived when they only parse
  `currentUserProvider.uid`; keep the logged-out null behavior and `int.tryParse`
  semantics inline with the owning notification state files.
- Notification navigation parser part splits are archived when the parser only serves
  the single notification navigation owner file. Keep the parser behavior, but do not
  keep a handwritten part file for it.
- Notification navigation parser helpers are archived when they only normalize a raw
  candidate URI for external launching or extract the opus ID from an article path.
  Keep the allowed-scheme check and opus path-segment guard inline with
  `NotificationNavigationParser.parse`; do not restore `_tryExternalUri` or
  `_extractOpusId`.
- Notification repository one-owner stream watcher wrappers are archived when they only
  delegate local database watch queries back to `NotificationRepositoryImpl`. Keep unread
  and system-notice stream query ownership on the repository boundary.
- Notification repository one-owner local read-store wrappers are archived when they only
  delegate local unread/session/message/feed paging queries back to
  `NotificationRepositoryImpl`. Keep read-side query semantics at the repository boundary
  unless a second concrete owner appears; do not keep unused local snapshot APIs when
  stream-based state already owns the active read path.
- Notification repository one-owner message-send wrappers are archived when they only
  delegate upload/send side effects back to `NotificationRepositoryImpl`. Keep image
  upload, local pending/outbox writes, send-result mapping, and head-sync behavior on the
  repository boundary unless a second concrete owner appears.
- Dynamic reusable and page-orchestration state belongs in `lib/features/dynamic/state`;
  the old `presentation/view_models` directory is archived.
- Live reusable and lifecycle state belongs in `lib/features/live/state`; the old
  `presentation/view_models` directory is archived. One-controller live state bags stay
  with their owning controller file; do not keep a separate `live_room_state.dart` or
  generated Freezed state file when only `LiveRoomController` constructs and mutates it.
- Profile user-space one-off providers are archived when they serve exactly one widget
  and only unwrap a repository `Result`; the owning widget may localize the request and
  preserve its visible empty/error behavior.
- Profile menu wrappers are archived when they only render one `ProfilePage` action.
  Keep logout row layout, dialog, and auth callback inline with `ProfilePage`.
- Profile desktop action-grid wrappers are archived when they only choose row widths for
  the profile page action grid; keep the desktop `LayoutBuilder` branch inline with
  `ProfilePage` while preserving shared row items.
- Profile action-grid action builders are archived when they only assemble one page's
  icon-label callback list; keep the concrete action list inline with `ProfilePage` and
  do not restore `ProfileActionGrid._buildActions`, `ProfilePage._profileActions`, or
  `_ProfileActionGridItem`.
- Profile page stat-item wrappers are archived when only `_ProfileStats.build` renders
  the posts/following/followers row. Keep `_ProfileStats` itself as the
  `myProfileProvider` rebuild boundary, but keep formatted counts, vmid-gated
  navigation, posts feedback, dividers, `AppClickable` chrome, and text styles inline
  without `_ProfileStatItem`.
- Profile guest helper is archived when only `myProfile` needs the logged-out
  `ProfileUser` shell. Keep the guest `ProfileUser` construction inline with the
  provider branch, preserving id `0`, empty username, zero counts, and false follow
  flags without `_emptyProfileUser`.
- Profile relation follow-button helpers are archived when only
  `_RelationUserItemState.build` renders the trailing follow control. Keep the attribute
  label mapping, unauthenticated login gate, and `FollowButton(height: 32)` inline with
  `RelationUserItem`, while keeping `_handleFollow` as the optimistic mutation and
  rollback boundary. Relation row navigation is owned by `RelationUserItem`; do not
  restore the unused nullable `onTap` override when every current row opens
  `ProfileNavigationScope.of(context).onOpenUser(user.mid)`.
- Profile app-bar background wrappers are archived when they only wrap one header row
  and forward the current session/profile into a single layout shell; keep the header
  background inline with `ProfileAppBar`.
- Profile app-bar avatar wrappers are archived when they only wrap one hero/avatar border
  shell around a single owned image; keep the avatar chrome inline with
  `ProfileAppBar`.
- Profile app-bar detail wrappers are archived when they only render the username,
  level, experience, and bio rows for the same header owner; keep that profile detail
  stack inline with `ProfileAppBar`.
- Profile app-bar experience bar wrappers are archived when they only render the single
  level-progress row inside `ProfileAppBar`; keep the progress calculation and bar
  layout inline with the only profile header that owns it.
- User profile app-bar menu helpers are archived when the menu is opened only by
  `UserProfileAppBar`; keep share/blacklist/report bottom-sheet actions inline with the
  more button owner and do not restore `_showMoreMenu` or a one-call
  `showAppModalBottomSheet` wrapper.
- User profile app-bar icon button helpers are archived when they only wrap the three
  top-row app-bar actions; keep the circular background, constraints, tap target, icon
  size, and callbacks inline with `UserProfileAppBar.build`.
- Guest login button wrappers are archived when they only wrap the one `GuestView` login
  action. Keep the concrete `FilledButton` size, shape, typography, and callback inline
  with `GuestView` instead of restoring `_GuestLoginButton`; do not restore the unused
  `showLoginButton` API switch when all active guest pages require login.
- Guest message wrappers are archived when they only render the one `GuestView` title and
  optional message stack. Keep the headline/body text styles, spacing, and centered layout
  inline with `GuestView` instead of restoring `_GuestMessage`.
- Guest illustration wrappers are archived when they only draw the one `GuestView`
  login/empty-state illustration. Keep the fixed radial glow, badge background, lock
  icon, and decorative dot `Container`s inline with `GuestView.build` instead of
  restoring `_GuestIllustration`, `_GuestGlow`, `_GuestBadgeBackground`, or
  `_DecorativeDot`.
- Profile single-use action buttons are archived when they only wrap one owning widget's
  `OutlinedButton` style and callback; keep the concrete button inline with its owner.
- User-profile button sizing is owned by `UserProfileButtons`. Do not expose public
  `height` or `borderRadius` constructor knobs while the only call site uses the fixed
  header actions; keep the 36px buttons, 8px radii, and chat icon scale inline.
- Profile privacy-error wrappers are archived when they only render the `AppError`
  code `22115` branch for one relation list. Keep the privacy icon/title/message layout
  inside `RelationUserList` and do not keep a separate widget file for that branch.
- Profile repository DTO-returning flow helpers are archived when their only caller is
  the app-model-returning flow in the same repository. Keep API DTOs internal to the
  repository flow unless another current behavior consumes them directly.
- Profile repository one-owner flow part splits are archived when they only hold methods
  for `ProfileRepositoryImpl`; keep profile video fetch flows on the repository and
  parsing helpers in the repository parser part.
- Profile runtime cleanup adapters stay private behind behaviorful factory functions.
- Profile tab wrappers are archived when they only return a single concrete feed widget
  and add no navigation, state, layout, or policy.
- Profile relation route page wrappers are archived when they only select one relation
  provider/title/empty text for router-owned followers/followings pages. Keep the route
  builders public, but keep the concrete relation scaffold, provider watch, refresh, and
  load-more wiring inline with those builders instead of restoring
  `_RelationUsersRoutePage` or `_RelationUsersRouteKind`. `RelationUserList` must receive
  the route-owned translated empty text explicitly; do not restore a default empty-text
  fallback or `emptyText.isEmpty` branch inside the shared list widget. The route builders
  also own pagination availability, so `RelationUserList.hasMore` must stay required
  instead of falling back to `false`.
- Profile page-owned tab bodies are private to their page when they only compose sections
  for one `TabBarView`; keep keep-alive, storage keys, and overlap injectors beside the
  page owner instead of exposing a public wrapper file.
- Profile home-tab tab switching is page-owned. `_UserHomeTab` and `RecentVideoSection`
  must receive the concrete `tabController.animateTo` callback from `UserProfilePage`
  instead of carrying nullable `onSwitchToTab` callbacks or null-aware view-more calls.
- User profile page content wrappers are archived when they only forward the loaded
  profile into one nested-scroll layout. Keep the depth-0 scroll offset tracking,
  refresh edge offset, overlap absorber, pinned tab bar, and home/moments/contribution
  tab order inline with `UserProfilePage.build` instead of restoring
  `_UserProfileContent`.
- Profile page stats wrappers are archived when they are only consumed by `ProfilePage`;
  keep the profile-count sliver private to the page that owns the session gate and
  follow/follower navigation callbacks.
- Single-use visual token wrappers are archived when their constants are only consumed by
  one widget and carry no design-system ownership.
- Profile one-use visual/prefetch constants are archived when a single owner reads them.
  Keep the user-video prefetch count `8`, cover size `160x100`, recent-video prefetch
  aspect ratio `16 / 10`, and profile header top radius `20.0` inline with their
  owning build/prefetch methods instead of restoring private token constants.
- Bootstrap-only visual tokens are archived when they are used exactly once during app
  startup. Keep the transparent status bar and dark status-bar icon brightness inline
  with `AppBootstrap.initialize` instead of restoring `_systemUiOverlayStyle`.
- Single-use formatting wrappers are archived when they only delegate to a shared utility
  in one widget. `LiveHeader` should call `FormatUtils.formatNumber` directly for online
  and rank counts instead of restoring `_liveHeaderFormatNumber`.
- Shared overlay tag widgets are archived when they only style two card-local labels.
  Keep card-specific recommendation and live-area tags private to the owning card until
  a behaviorful design-system component exists.
- Single-use widget wrappers are archived when they only add local padding or call one
  concrete child and have exactly one owner.
- Auth dialog widget wrappers are archived when they only wrap `LoginPanel` inside one
  `showGeneralDialog` call. Keep the barrier, fade transition, and close callback in a
  function-level dialog entrypoint instead of exporting a public widget wrapper.
- `LoginPanel` close behavior is route/dialog-owned. Keep `onClose` required and do not
  restore a nullable callback, `Navigator.pop` fallback, or one-use `closePanel` wrapper.
- Auth presentation local style facades are archived when they only forward a single
  color expression. Keep `AuthTextField` fill color and `LoginPanel` feedback-chip
  success/error background colors inline with their owning build methods instead of
  restoring local `isDark` or `feedbackBackgroundColor` variables.
- Single-use text layout wrappers are archived when only one widget needs the sizing
  behavior. Keep fixed-title-height policy local to that card instead of keeping a public
  generic text wrapper.
- Dynamic feed item/header wrappers are archived when they only render one private
  row/card/header for an owning section. Keep the recently-followed provider branch and
  avatar/name row private beside `DynamicListView` unless a second real consumer appears;
  do not restore `RecentlyFollowedWidget` as a public one-owner wrapper, and do not split
  the one-consumer `recently_followed_provider.dart` state shell back out of the list view.
- Dynamic forward wrappers are archived when only `DynamicContentWidget` recurses into
  an original post. Keep author tap navigation, fallback forward text, surface styling,
  and recursive content rendering inline beside the owning content widget; do not
  restore `_DynamicForwardCard`.
- Dynamic content surface helpers are archived as public files/classes when only
  `DynamicContentWidget` uses them. Keep Material/InkWell/Ink, default surface color,
  padding, border radius, and tap behavior private beside the content cards.
- Dynamic additional/content card wrappers are archived when only `DynamicContentWidget`
  can dispatch to them. Keep image grids, vote, goods, reserve, common, link-card, UGC,
  and video surfaces, tap targets, preview open behavior, cover sizing, fallback strings,
  stats text, playback counters, button disabled state, padding, and typography private
  beside the content dispatcher unless another real owner appears. The vote branch is
  owned inline by `_buildAdditional`; do not restore `_DynamicVoteCard`. Dynamic image
  grid chrome stays inline with `DynamicContentWidget.build`; do not restore
  `_DynamicImages`, `_openImagePreview`, or a one-call `_buildImageItem` helper around
  `AppNetworkImage`. Dynamic link-card chrome stays inline with
  `DynamicContentWidget.build`; do not restore `_DynamicLinkCard`. Dynamic common-card
  chrome stays inline with `_buildAdditional`; do not restore
  `_DynamicCommonCard`. Dynamic UGC additional chrome stays inline with
  `_buildAdditional`; do not restore `_DynamicUgcCard`. Dynamic video-card chrome stays
  inline with `DynamicContentWidget.build`; do not restore `_DynamicVideoCard`. Dynamic
  goods and reserve chrome stays inline with `_buildAdditional`; do not restore
  `_DynamicGoodsCard` or `_DynamicReserveCard`.
- Dynamic topic chip chrome is owned by `DynamicContentWidget.build`. Keep topic
  navigation, 10x4 padding, 16px pill radius, primary tint, fire icon, and 12px label
  inline with the topic branch; do not restore `_TopicChip`.
- Dynamic content visibility gates are owned by `DynamicContentWidget.build`. Keep the
  text/image/link-card/additional booleans beside the content branches they guard; do
  not restore `_resolveVisibility` as a one-call record helper.
- Publish dynamic emoji grid item chrome is picker-owned. Keep package tab views, 48px
  grid extents, 8px spacing, 96px emote cache sizing, and tap-to-insert behavior inline
  in `_PublishEmojiPickerState.build`; keep retry future reset owned by the error branch
  callback, keep the emote package future assignment at its `initState`/retry owners, and
  do not restore one-call `_buildEmojiGrid`, `_retryLoadEmotes`, or `_loadEmotePackages`
  helpers.
  Publish dynamic emoji/topic modal launch is toolbar-callback-owned; keep
  `showModalBottomSheet`, text insertion, topic wrapping, and sheet close behavior
  inline with `onPickEmoji` / `onPickTopic`, and do not restore `_showEmojiPicker`,
  `_showTopicPicker`, `_showPublishDynamicEmojiPicker`, or
  `_showPublishDynamicTopicPicker`.
  Publish dynamic discard confirmation is exit-callback-owned: `PopScope` back handling
  and app-bar close both call `_confirmDiscardDynamicDraft` directly with `_hasDraft`;
  do not restore a one-line `_onWillPop` wrapper.
  Publish dynamic scaffold ownership is page-owned: `PublishDynamicPage.build` keeps the
  `Scaffold`, `appBar`, and body wiring inline so private state/callbacks are not routed
  through pass-through `_PublishDynamicScaffold` or `_PublishDynamicAppBar` wrappers.
  Publish dynamic editor ownership is page-owned: keep the text field, selected-image
  grid mount, and image remove/add callbacks inline with `PublishDynamicPage.build`
  instead of restoring `_PublishDynamicEditor`.
  Publish dynamic bottom toolbar ownership is page-owned: keep the safe-area padding,
  toolbar icon order, character count, and picker launch callbacks inline with
  `PublishDynamicPage.build` instead of restoring `_PublishDynamicBottomToolbar`.
  Publish dynamic selected-image grid ownership is page-owned: keep empty-state
  suppression, max-image add tile, 3-column layout, local file previews, and remove
  mutation inline with `PublishDynamicPage.build` instead of restoring
  `_PublishDynamicImageGrid`.
  Publish dynamic CSRF resolution is publish-flow-owned: `_PublishDynamicController`
  keeps `getPublishCsrf`, null/empty token validation, fallback `AppError.auth`, and
  upload/publish sequencing inline with `_publishDynamic`; do not restore `_resolveCsrf`.
- Dynamic loading skeleton wrappers are archived when they only serve one feed owner.
  Keep user dynamic feed loading shimmer markup inline with `UserDynamicFeed.build`
  instead of exporting a shared `DynamicSkeleton` widget or retaining private
  `_DynamicSkeleton`/header/content/footer helpers without a second consumer.
- Dynamic feed like toggling keeps the stat-null guard and optimistic `copyWithLike`
  update inline in `DynamicFeedController.toggleLike`; do not restore a one-use
  `_buildLikedItem` helper beside the only caller.
- Single-use page/section empty states and one-off trailing links are archived when they
  only construct a tiny branch for one owning build method. Keep the visible text,
  gesture, and icon inline with the provider branch or section header that owns it.
- Single-use provider-branch wrappers are archived when each wrapper only renders one
  data/loading/error branch for a single section. Keep branch-specific sliver/grid/error
  layout beside the `when`/`switch` that owns the state.
- Home popular and recommend feed providers are view-owned when their only active
  consumer is their matching feed widget. Keep shared result unfolding and logging in
  `HomeFeedPagingMixin`, but do not restore `home_popular_view_model.dart`,
  `home_recommend_view_model.dart`, or public `HomePopular`/`HomeRecommend` state shells.
  Silent-refresh item equality uses Flutter's shallow `listEquals` over canonical
  `VideoModel` value equality; do not restore a private `_sameItems` loop.
  Silent-refresh fetch logging stays inline with `refreshFirstPageSilently`; do not
  restore a private `_loadFreshFirstPage` wrapper.
- Search history persistence state is page-owned while only `SearchPage` reads and
  mutates it. Preserve `StorageKeys.searchHistory` and the `search_workflows.dart`
  normalization/deduplication add helper, but do not restore
  `search_history_application_providers.dart`, public `SearchHistory` provider shells,
  or single-entry history removal helpers without an active per-item delete flow.
- Single-use landing and skeleton list wrappers are archived when they only return a
  constant `ListView` for one owning state branch.
- Favorites folder-list loading skeleton chrome is owned by `FavFolderList.build`.
  Keep the 10-row shimmer `ListView`, 16px padding, 12px separators, 88px thumbnail
  placeholder, and title/subtitle bars inline with the `SmartPagingView` loading branch;
  do not restore the private `_Skeleton` wrapper in `fav_folder_list.dart`.
- Single-use page action and row-wiring wrappers are archived when they only forward a
  page-owned callback or bind one list item's ID to a concrete child. Keep the action
  button or `Dismissible` wiring inline with the owning page/list build branch.
- Single-use modal/sheet chrome wrappers are archived when they only wrap one page-owned
  helper's title and children. Keep the modal layout beside the helper that owns the
  entrypoint.
- Single-use profile stat icon/text wrappers are archived when they only pair an icon and
  a label in one home-tab widget; reuse `ui/widgets/text/icon_text.dart` instead of
  keeping a private duplicate.
- Shared user-list tiles should keep title typography, optional badge layout, stats row,
  and optional subtitle text inline with `UserListTile.build`; do not restore one-call
  `_buildTitle`, `_buildTitleRow`, `_buildStatsRow`, or `_buildSubtitle` helpers in
  `ui/widgets/users/user_list_tile.dart`.
- `FollowButton` should keep the label fallback inline with `build` so the same local
  label feeds both `Semantics.label` and the visible `Text`; do not restore a one-call
  `_resolveLabel` method in `ui/widgets/buttons/follow_button.dart`.
- App tag wrappers are archived when they only render one owner-specific badge/pill.
  Keep badge padding, radius, colors, and text style inline with the owning card/search
  UI instead of restoring `AppTag`, `app_tag.dart`, or its old one-call color helpers.
- `VipTag` shadow fallback should stay inline with `VipTag.build`; do not restore a
  one-call `_buildShadow` method that only maps `showShadow` to a single `BoxShadow`
  list or `null`.
- `LevelTag` level-to-color mapping should stay inline with `LevelTag.build`; do not
  restore a one-call `_resolveLevelColor` method that only maps `level` to
  `ColorScheme` entries.
- `AppCardContainer` decoration construction should stay inline with the
  `ValueListenableBuilder` branch that owns the current `PerformancePolicy`; do not
  restore one-call `_buildDecoration` or `_buildShadow` helpers around `BoxDecoration`
  or the shadow policy switch.
- `AppClickable` tap and long-press handlers should stay inline with
  `AppClickable.build`; do not restore one-call `_buildTapHandler` or
  `_buildLongPressHandler` methods that only wrap null checks, haptic feedback, and the
  provided callbacks.
- `AppTabBar` decoration and indicator construction should stay inline with
  `AppTabBar.build`; do not restore one-call `_buildDecoration` or `_buildIndicator`
  methods that only wrap the 44px surface border and primary underline geometry.
- Article paragraph block text normalization should stay inline with
  `_ParagraphBlockViewState.build`; do not restore a one-call `_normalizeBlockText`
  helper that only collapses three or more newlines to exactly two.
- Article paragraph alignment mapping should stay inline with
  `_ParagraphBlockViewState.build`; do not restore one-call `_alignToAlignment` or
  `_toTextAlign` helpers that only map `ArticleTextAlign` to Flutter alignment enums.
- Article paragraph visible-text filtering should stay inline with `_buildArticleBlocks`;
  do not restore a one-call `_hasVisibleText` helper that only strips whitespace before
  checking whether a paragraph has renderable text.
- Comment item user tap handling should stay inline with `CommentItemWidget.build`; do
  not restore `_handleTapUser` when it only parses the current member MID, ignores
  invalid IDs, and forwards the existing `onTapUser` callback for avatar/header taps.
- Article detail author and stats chrome should stay inline with
  `_buildArticleDetailScaffold`; do not restore one-call `_AuthorHeader`, `_StatsRow`,
  or `_StatChip` widgets that only render the scaffold-owned author row and
  favorite/like counts.
- About-page action rows should stay inline with `AboutPage.build`; do not restore a
  private `_ActionTile` wrapper that only renders the GitHub and license actions.
- Settings page tiles are clickable icon rows in the current settings surface. Keep
  `_SettingsTile.icon` and `_SettingsTile.onTap` required, preserve the leading icon,
  16px gap, trailing chevron, and `AppClickable` wrapper for every row, and do not
  restore no-icon or disabled-tile branches unless a real current row needs them.
- Relation-list privacy error chrome is page/list-owned when it only serves the
  `AppError.code == 22115` branch. Keep the lock icon, translated title/message, and
  text colors inline with `RelationUserList.errorBuilder`.
- User-video sort chips are owned by `UserVideoTab.build` when they only switch the
  page-owned sort order. Keep spacing, selected/unselected colors and borders,
  animation timing, text weight, and load-gate reset inline with the sort row; do not
  restore `_SortChip`.
- Shared search-bar icon helpers are archived when they only wrap the same static search
  icon in the editable and read-only branches. Keep the `Icon` inline with each branch
  while shared decoration and hint style remain as build-local values instead of private
  helper methods.
- The read-only `AppSearchBar` branch should stay inline with `AppSearchBar.build` so
  the `controller == null` path remains a clipped `AppClickable` prompt instead of a
  helper wrapper. Preserve height, shared decoration, hint overflow, and disabled
  `onTap == null` behavior.
- The editable `AppSearchBar` branch should stay inline with `AppSearchBar.build` so
  the `controller != null` path keeps the `TextField` decoration, prefix/suffix icon
  constraints, controller/onChanged wiring, cursor color, and text style beside the branch
  gate; do not restore `_buildEditableSearchBar`. Do not expose an `autofocus` constructor
  knob while every current search bar remains passive and non-focus-stealing.
- The editable `AppSearchBar` text style should stay inline with the `TextField` owner;
  do not restore a one-call `_buildTextStyle` helper that only applies the `bodyMedium`
  font size 15 and `onSurface` color.
- `AppSearchBar.build` owns the shared container decoration and hint style values for
  both editable and read-only branches; do not restore `_buildDecoration` or
  `_buildHintStyle` helper methods that only construct those values.
- Home video actions rows are owned inline by `showHomeVideoActionsBottomSheet`'s modal
  builder. Do not restore `_HomeVideoActionsBottomSheet` or `_ActionItem`; the sheet may
  keep the two action rows as direct `InkWell` blocks with the same padding, icon, and
  bodyLarge typography.
- Single-use profile banner wrappers are archived when they only render one
  `UserProfileHeader` image/gradient stack; keep the banner stack inline with the header
  that owns image preview behavior.
- Ranking loading skeleton wrappers are archived when the list branch only needs one
  fixed shimmer row layout. Keep the thumbnail/text skeleton primitives inline in the
  loading `ListView` branch; do not restore one-use `_RankingSkeletonItem`,
  `_RankingSkeletonThumbnail`, or `_RankingSkeletonText` wrappers.
- Ranking item badge wrappers are archived when only `RankingItemCard` renders the
  thumbnail rank overlay. Keep the rank 1/2/3 color mapping, top-rank gradient/shadow,
  fallback scrim, radius, size, and italic label inline with `RankingItemCard.build`;
  do not restore `_RankBadge`, `_RankBadgeStyle`, or one-use badge style locals such as
  `rankBadgeFontSize`.
- Profile banner and avatar preview helpers are archived when the only tap handlers can
  own the null/empty guard and `AppImagePreview.open` call inline.
- Single-use profile header badge/tag wrappers are archived when they only render
  `UserProfileHeader`'s verified badge or UID label; keep those tiny local rows inline
  with the header state and typography that own them.
- Single-use profile identity and bio wrappers are archived when they only forward
  username/VIP/level or expandable bio state for one `UserProfileHeader`.
- Single-use profile header stats wrappers in `user_profile_info.dart` are archived when
  only `UserProfileHeader` renders the following/followers/likes row. Keep the avatar
  offset, stat count formatting, navigation callbacks, likes no-op, `InkWell` chrome,
  text styles, and profile buttons inline with the header; do not restore that file's
  `_StatsRow` or `_ProfileStatItem`.
- Single-use home app bar tab renderers are archived when they only render one app bar's
  bottom tab surface; keep the `PreferredSize`/`TabBar` beside the owning app bar.
- Single-use video detail tab bars are archived when they only render the page's tab
  strip and subtitle affordance. Keep the renderer inline in `VideoDetailPage.build`.
- Single-use player overlay controls are archived when they only serve one overlay owner.
  Keep progress sliders and similar control fragments private beside
  `PlayerControlsOverlay` until a second real owner exists.
- Single-use gesture feedback widgets are archived when they only serve
  `InteractionLayer`. Keep double-tap seek ripple and brightness/volume indicator chrome
  private beside the gesture owner instead of exporting player-control wrappers. Do not
  restore a one-use `_GestureIndicator` wrapper when `_GestureFeedbackOverlay.build` can
  own the indicator chrome inline.
- Single-use video comments paging/list wrappers are archived when they only wrap one
  comments branch's refresh/load/list layout. Keep `EasyRefresh` and `ListView` in the
  owning page build method. One-use video comment item forwarding wrappers are also
  archived; keep `CommentItemWidget` construction, like/dislike/reply callbacks, and
  replies navigation inline in the list item builder instead of restoring
  `_VideoCommentListItem`.
- Single-owner comment image wrappers are archived when only `CommentItemWidget` uses
  the image grid/preview behavior. Keep single-image sizing, grid decode bounds, hero
  tags, and preview opening private beside the comment content owner. Do not restore
  one-call `_buildSingleImage`, `_buildImageGrid`, `_buildLoadState`, `_openPreview`,
  `_toCacheDimension`, or `_resolveSingleImageDisplaySize` helpers around the two image
  branches and their loading/error/preview/cache chrome.
- Comment content text-span assembly should stay inline with `_Content.build`; do not
  restore `_buildTextSpans` when it only prepends the optional reply-to label and then
  appends the current comment `BilibiliEmojiText` span.
- Single-use quick-selection empty-state wrappers are archived when they only render one
  sheet's empty branch; keep that branch inline beside the sheet's `ListView`.
- Single-use search article meta icon/text wrappers are archived under the same rule:
  article result metadata should use `IconText` rather than private row duplicates.
- Single-use search user meta label/value wrappers and helpers are archived when they
  only serve the owning search user result widget. Keep label/value styling local until a
  second real consumer proves a shared component is needed.
- Search result filter chips are owned by `_SearchResultTab.build` when they only render
  local sort/duration options. Keep the `ChoiceChip` padding, compact tap target,
  selected/unselected label style, transparent background, selected primary-container
  tint, no side, and hidden checkmark inline; do not restore `_FilterChip`. Keep the
  duration-filter visibility check inline as `searchType == SearchType.video` instead of
  restoring a one-use `SearchType.supportsDuration` getter.
- Search result async-state rendering is owned by `_SearchResultTab.build` when only the
  tab consumes the private result provider. Keep the data `SearchResultList`, 10-row
  skeleton loading list, and retrying `AppErrorWidget` branches inline; do not restore
  `_SearchResultPane`.
- Single-use page state scaffold helpers are archived when they only construct
  loading/error/empty branches for one page build method. The owning page keeps those
  early-return states inline unless a second owner appears.
- Widget APIs expose only active behavior. Optional callbacks and controller parameters
  are deleted when every caller passes empties or leaves them unused.
- Player overlay panel APIs expose only rendered behavior. Do not keep
  `PlayerPanelScaffold` title/subtitle/trailing inputs or `QuickSelectionSheet`
  title/subtitle forwarding when the scaffold does not render them. Do not expose a
  `PlayerPanelSection.surfaceAlpha` override unless an active caller needs a different
  section surface alpha; keep the default section alpha in `VideoOverlayStyles`.
  `PlayerPanelScaffold.isBottomSheet` must stay required because all active panel owners
  derive their layout mode explicitly.
- Feature-local player sheets should not expose layout-mode constructor flags when they
  have one real placement. `ListenSettingsSheet` is only opened as a modal bottom sheet,
  so it owns `PlayerPanelScaffold(isBottomSheet: true)` inline instead of exposing an
  `isBottomSheet` prop.
- Dynamic player sheets keep layout-mode inputs only when both panel modes are active.
  `PlayerSettingsSheet.isBottomSheet` remains required because the sole overlay caller
  derives portrait/landscape placement; do not restore a default `false` branch.
- Player control wrappers are archived when their provider boundary duplicates state
  already selected by `VideoControlButtons.build`. Keep the fullscreen toggle inline with
  the parent `isFullscreen` watch and player controller read; do not restore
  `_FullscreenToggleButton`. Keep the play/pause control inline only with a nested
  `Consumer` that preserves the `isPlaying` select boundary and `playOrPause` callback; do
  not restore `_PlayPauseControlButton`. Keep the danmaku toggle inline only with a nested
  `Consumer` that preserves the `isEnabled` select boundary; do not restore
  `_DanmakuToggleButton`. Keep the subtitle toggle inline only with a nested `Consumer`
  that preserves the enabled/availability select boundary and empty-state branch; do not
  restore `_SubtitleToggleButton`. Keep the playback speed selector inline only with a
  nested `Consumer` that preserves the `playbackSpeed` select boundary and side-panel
  sheet behavior; do not restore `_PlaybackSpeedButton`. Keep the playback quality
  selector inline only with a nested `Consumer` that preserves the selected/available
  quality and play-url select tuple plus side-panel sheet behavior; do not restore
  `_PlaybackQualityButton`. Keep the playback time label inline only with a nested
  `Consumer` that preserves `playbackPositionProvider`, `playbackDurationProvider`, and
  `RepaintBoundary`; do not restore `_TimeText`.
- Player theme APIs expose only active style tokens. Remove dead static members instead
  of leaving public constants or helper styles with no call sites.
- DTOs are API-bound. Feature app models are canonical app-facing data. UI state is not a
  duplicate domain model.
- Dynamic and notification upload-image responses use the canonical
  `UploadedImage` contract; do not reintroduce feature-local upload-image DTOs
  with the same `image_url`/`image_width`/`image_height` fields.
- Dynamic publish-create responses are `ApiResponse<void>` while the app only checks
  success. Do not reintroduce `DynamicPublishResponseDto` or generated files for the
  unused `dyn_id_str` field unless a current user-facing flow consumes the published ID.
- Dynamic publish upload inputs keep only `PublishMediaAsset` as a hand-written
  file-path value. Do not restore `PublishDynamicCommand` or
  `dynamic_publish_command.freezed.dart` while publish text and uploaded images already
  flow through the page controller and repository method parameters. Do not restore the
  unused `PublishMediaAsset.copyWith` helper.
- Dynamic detail responses parse `data.item` directly into the canonical `DynamicItem`
  at the repository boundary. Do not keep a `DynamicDetailData` response shell whose only
  purpose is exposing the nested `item` field. Keep the one app-facing `data.item` parser
  inline in `DynamicRepositoryImpl.getDetail`; do not restore `_parseDynamicDetailItem`
  as a one-use repository helper.
- Dynamic post card UI renders the canonical `DynamicItem` through
  `dynamic_item_extensions.dart`. Do not restore `DynamicPostCardViewData` or its
  copy-only mapper as a second flattened source for author, stats, content, topic, or
  original-post fields. Keep the tappable content section and footer action row inside
  `DynamicPostCard.build` instead of restoring one-call `_buildContentSection`,
  `_buildFooter`, or `_buildStat` methods.
- Live anchor-info responses expose only the consumed anchor master level. Do not
  reintroduce the nested `LiveAnchorInfoModel`/`LiveAnchorExp` wrapper tree unless
  another current UI consumes those fields. Keep `exp.master_level.level` parsing inline
  in `LiveRepositoryImpl.getAnchorInfo`; do not restore `_parseAnchorMasterLevel` as a
  one-use repository helper.
- Dynamic emote catalog data has one app-facing owner: `EmoteCatalogPackage` and
  `EmoteCatalogItem`. The transport response shell may expose raw data at the repository
  boundary, but do not restore `EmoteResponse`, `EmotePackage`, or `Emote` DTO mirrors
  that only copy `id`, `text`, `url`, and nested emote lists. Emote catalog map parsing
  uses `JsonUtils.asStringKeyedMap`; do not restore a private `_readStringKeyedMap`
  helper for the same JSON object coercion. Emote id parsing uses `JsonUtils.parseInt`
  directly at the canonical model boundary; do not restore a private `_readRequiredInt`
  scalar helper. Required `text`/`url` fields stay strict string checks inline at that
  same boundary; do not restore `_readRequiredString`, and do not replace it with the
  wider `JsonUtils.parseStringWithDefault` coercion. Keep the repository `packages`
  envelope parse inline in `EmoteRepositoryImpl.getUserEmotePackages`; do not restore
  `_parseEmotePackages` as a one-use mapper.
- Favorites resource count stats use the canonical `FavoriteResourceStats` shape; do not
  reintroduce `FavCntInfoModel` for the same `collect`/`play`/`danmaku` fields.
- Favorites folder-resource page info uses the canonical `FavoriteFolder` shape.
  Preserve `media_count` JSON decoding on the canonical model, and do not reintroduce
  `FavFolderInfoModel`, `FavoriteFolderInfo`, or its copy-only mapper.
- Favorites folder and resource items use `FavoriteFolder` and `FavoriteResource` as the
  canonical API/app-facing shapes. Preserve `fav_state`, `media_count`, `cnt_info`,
  `fav_time`, and `bv_id` JSON decoding on those canonical models; do not reintroduce
  `FavFolderModel`, `FavResourceModel`, `_FavFolderMapper`, or `_FavResourceMapper`.
  Keep `FavoriteFolder`, `FavoriteResourceStats`, `FavoriteResource`, and
  `FavoriteResourcePage` hand-written in their domain entity files; do not restore their
  `*.freezed.dart`/`*.g.dart` shell files or generated `_Favorite*` symbols. The
  favorites read models are API values; do not restore unused `copyWith` helpers on
  `FavoriteResourceStats`, `FavoriteResource`, or `FavoriteResourcePage`, and do not
  restore unused `toJson` helpers on `FavoriteFolder`, `FavoriteResourceStats`, or
  `FavoriteResource` while no active state or UI flow serializes them.
  `FavoriteResourcePage.medias` uses Flutter's canonical shallow `listEquals`; do not
  restore a file-local `_listEquals` clone for this read-only list equality.
  `FavoriteFolder.copyWith` remains live because the collected-folders state still
  normalizes missing folder covers from the first media item.
- Favorites folder-list responses return `List<FavoriteFolder>` directly. Do not
  reintroduce `FavoriteFolderPage` as a list-only response shell.
- Favorites folder dialog form data is a typed record owned by the dialog/create/edit
  call sites. Do not reintroduce a public `FavFolderFormData` class unless it gains real
  validation or business behavior.
- Profile user-space videos use `ProfileVideo` as the single API/app-facing shape.
  Preserve user-space JSON normalization on `ProfileVideo.fromJson`, parse the unique
  `list.vlist` response shape at the repository boundary, and do not reintroduce
  `UserSpaceVideoModel`, `UserSpaceVideoListResponse`, or copy-only repository mappers.
  Keep `pubDate`/`pubdate` normalization inline in `ProfileVideo.fromJson`; do not
  restore a private `_readPubDate` helper.
  Keep `ProfileVideo` hand-written in `profile_video.dart`; do not restore
  `profile_video.freezed.dart`, `profile_video.g.dart`, or `_ProfileVideo`/`_$ProfileVideo`
  generated shell symbols. The unused `copyWith` and `toJson` helpers are archived too.
- Profile optional enrichment responses share one repository-local success/data-map gate.
  Keep relation stats, like count, and video count fallbacks at zero without duplicating
  the same `response == null || code != 0 || data is! Map` branch per scalar. Keep the
  relation follower/following parse and `list.vlist` profile-video parse inline in
  `ProfileRepositoryImpl`; do not restore `_parseRelationStats` or `_parseUserSpaceVideos`
  as one-use repository helpers. Keep non-critical enrichment `ConcurrentTask` null
  fallbacks inline at each optional call site; do not restore a private
  `_ignoreOptionalProfileResponse` pass-through helper.
- Notification private-message emoji metadata use `PrivateMessageEmoji` as the single
  app/storage shape. Keep `gif_url` decoding on the canonical emoji model, and do not
  reintroduce `PrivateMessageEmojiInfo` or its copy-only mapper.
- Notification private-message session account metadata use `PrivateSessionAccountInfo`
  as the single app/API shape. Keep `account_info.pic_url` decoding at the DTO boundary,
  and do not reintroduce `PrivateMessageAccountInfo` or its copy-only mapper. Keep the
  account-info JSON read/write shape inline with `PrivateMessageSession.fromJson` and
  `PrivateMessageSession.toJson`; do not restore private
  `_privateSessionAccountInfoFromJson` or `_privateSessionAccountInfoToJson` helpers.
  Keep `PrivateSession` and `PrivateSessionAccountInfo` hand-written in
  `private_session.dart`; do not restore `private_session.freezed.dart` for the
  notification session shell. Their unused `copyWith` helpers are archived.
- Notification private-message entities are owned by `private_message.dart` and
  `private_message.types.dart`. Do not restore `private_message.freezed.dart` or
  `private_message.g.dart`; keep `PrivateMessage` and `PrivateMessageEmoji` as
  hand-written immutable values preserving message helper semantics, at-uid list
  equality, and `gif_url` JSON parsing. The unused `PrivateMessage.copyWith` and
  `PrivateMessageEmoji.copyWith` helpers are archived. Nullable content string reads
  stay inline with `PrivateMessageContent` getters; do not restore a private
  `_readString` helper or widen nullable values through `JsonUtils.parseStringWithDefault`.
  The unused
  `PrivateMessageEmoji.toJson` helper.
- Notification private-message API DTOs are owned by `private_message_model.dart`. Do
  not restore `private_message_model.freezed.dart` or `private_message_model.g.dart`;
  keep session/list/detail response DTOs hand-written while preserving `session_list`,
  `has_more`, `system_msg`, `account_info.pic_url`, `last_msg`, `at_uids`, `e_infos`,
  list equality, shallow `system_msg` map equality/hash through Flutter `mapEquals` and
  `collection`'s `MapEquality`, `content` deep equality/hash through `collection`'s
  `DeepCollectionEquality`, and DTO-local `contentMap` parsing. DTO-local `copyWith`
  helpers, hand-written unordered map-hash clones, and unused response-shell `toJson`
  helpers are archived; keep nested session/detail serializers because cache round-trips
  still use them.
- Notification reply actors use `NotificationActor` as the single app/API actor shape.
  Keep `mid_link` JSON decoding on the canonical actor model, and do not reintroduce
  `ReplyUser` or `ReplyUserMapper`. Keep `ReplyItemDetail` as a data DTO because it
  owns snake_case reply JSON keys, `subject_id`/`item_id` fallback behavior, and local
  cache round-trip shape, but keep that fallback inline in `ReplyItemDetail.fromJson`;
  do not restore a private `_readSubjectId` one-use helper or a separate
  `ReplyItemDetailMapper` when `ReplyItemMapper` is the only owner that builds
  `NotificationEntryDetail`.
- Notification reply feed DTOs are owned by `reply_model.dart`. Do not restore
  `reply_model.freezed.dart` or `reply_model.g.dart`; keep `ReplyResponse`,
  `ReplyCursor`, `ReplyItem`, and `ReplyItemDetail` as hand-written DTOs preserving
  reply feed wire keys, inline `subject_id`/`item_id` fallback behavior, nullable
  actor/time fields, list equality, and local cache serialization. DTO-local `copyWith`
  helpers and unused response-shell `toJson` helpers are archived; keep `ReplyItem` and
  `ReplyItemDetail` serializers for cache round-trips.
- Notification like feeds normalize to `ReplyResponse` at the repository support
  boundary. Parse the like endpoint's `total.cursor` and `total.items` envelope directly
  there, and do not restore `LikeResponse`, `LikeLatest`, or `LikeTotal` wrappers for the
  one endpoint. Keep the like envelope parse inline in `_fetchReplyLikeAtResponse`; do
  not restore `_parseLikeResponse` as a one-use helper. Do not mirror the unused
  `last_view_at` / `lastViewAt` field while no current feed state consumes it.
- Notification reply feed items keep only transport fields mapped into current feed/domain
  behavior. Do not mirror unused `counts` or `is_multi`/`isMulti` metadata while no active
  repository, state, or UI flow consumes it.
- Notification chat send state keeps only behaviorful inputs. Preserve
  image-picker bytes and filename as a named record flowing from the `ChatPage` input
  branch into `Chat.sendImage`; do not reintroduce `ChatInput`,
  `ChatImageAttachment`, `ChatSendResult`, or `ChatSendStatus` wrapper types.
- Notification chat state helper/send part splits are archived when they only serve
  `Chat`; keep local sync, pagination, and send helpers private on `chat_view_model.dart`.
- History history-list items use `HistoryEntry` as the single app/API item shape. Keep
  it as a hand-written immutable value with history JSON normalization on
  `HistoryEntry.fromJson`; parse the transport `list` envelope in
  `HistoryRepositoryImpl.getHistory`, and do not reintroduce `history_entry.freezed.dart`,
  `HistoryResponseDataDto`, `HistoryCursorDto`, `HistoryTabDto`, `HistoryItemDto`,
  `HistoryDetailDto`, `_HistoryItemMapper`, or the one-use `_parseHistoryEntries`
  repository helper just because the remote API sends additional history metadata.
  Do not restore the unused `HistoryEntry.copyWith` helper while no active state or UI
  flow mutates history list values.
  History integer fields use `JsonUtils.parseIntWithDefault`;
  do not restore a private `_readInt` helper for viewed-at, progress, or duration.
  History and to-view string fields keep strict string-only fallback inline at the
  entity boundary; do not restore private `_readString` helpers or widen these fields to
  `JsonUtils.parseStringWithDefault`, which coerces non-strings to text.
  To-view nested `owner` and `stat` decoding also stays inline on `ToViewEntry.fromJson`;
  do not restore one-use `_readOwner` or `_readStat` helpers.
  History nested `history` map decoding stays inline on `HistoryEntry.fromJson`; do not
  restore a private `_readHistory` helper.
- History page list state stays page-owned. `HistoryPage` keeps its private
  `FutureProvider.autoDispose` for the current list, refresh, and retry behavior; do not
  restore a shared `history_controller.dart` provider wrapper for one page. Keep the
  one-page `AsyncValue` body inline with `HistoryPage.build`; do not restore a private
  `_HistoryContent` shell that only forwards the same provider value and callbacks.
  History item row renderers stay page-inline when only the history list builds them.
  Keep keyed rows, archive-only open-video gating, wide `VideoListCard` dimensions,
  progress overlay, author line, badge, and viewed-at stat inline with
  `HistoryPage.build`; do not restore `_HistoryItemWidget`.
  History repository request constants stay inline when only one API call uses them;
  keep the cursor page size `20` beside `getHistoryCursor` instead of restoring a
  private `_historyPageSize` token.
- Live online gold-rank responses use `LiveGoldRankModel`, `LiveRankItem`, and
  `LiveRankMedalInfo` as the single app/API shape. Do not reintroduce
  `LiveGoldRankDto`, `LiveRankItemDto`, or `LiveRankMedalInfoDto` unless the API layer
  needs behavior that the canonical model must not own. These models are read-only API
  values; do not restore unused `copyWith` or `toJson` helpers for gold-rank data.
  `LiveGoldRankModel.list` uses Flutter's canonical shallow `listEquals`; do not
  restore a file-local `_listEquals` clone for this read-only list equality.
- Live danmaku connection info responses use `LiveDanmuInfoModel` and `LiveDanmuHost` as
  the single app/API shape. Preserve the `host_list` empty-list fallback on the canonical
  model, and do not reintroduce `LiveDanmuInfoDto` or `LiveDanmuHostDto` for pure field
  mirroring.
- Live danmaku connection info state stays hand-written in `live_danmu_info_model.dart`.
  Do not restore `live_danmu_info_model.freezed.dart` or `live_danmu_info_model.g.dart`
  for the canonical connection-info shell; keep `LiveDanmuInfoModel` and
  `LiveDanmuHost` as owner-owned values beside the live socket service. Do not restore
  unused `copyWith` or `toJson` helpers for these read-only connection-info values.
  `LiveDanmuInfoModel.hostList` uses Flutter's canonical shallow `listEquals`; do not
  restore a file-local `_listEquals` clone for this read-only list equality.
- Live play-url responses stay hand-written in `live_play_url_model.dart`. Do not
  restore `live_play_url_model.freezed.dart` or `live_play_url_model.g.dart`; keep
  `LivePlayUrlModel`, `LiveQualityDescription`, and `LiveStreamUrl` as the owner-owned
  play-url values consumed by the live room state and repository. Unused `copyWith` and
  `toJson` helpers are archived too. `acceptQuality`, `qualityDescription`, and `durl`
  equality uses Flutter's canonical shallow `listEquals`; do not restore a file-local
  `_listEquals` clone for those read-only lists.
- Live room detail responses stay hand-written in `live_room_detail_model.dart`. Do not
  restore `live_room_detail_model.freezed.dart` or `live_room_detail_model.g.dart`;
  preserve the live room detail wire keys, `hot_words` list equality, and
  `new_pendants` / `studio_info` map equality on the canonical `LiveRoomDetailModel`.
  Do not restore unused `copyWith` or `toJson` helpers for this read-only API value.
  `hotWords` equality uses Flutter's canonical shallow `listEquals`; do not restore a
  file-local `_listEquals` clone for the room-detail hot-words list.
  `newPendants` and `studioInfo` equality uses Flutter's canonical shallow
  `mapEquals`, and hashCode uses `collection`'s shallow `MapEquality` inline at the
  hash sites; do not restore file-local `_mapEquals` / `_mapHash` clones or a one-use
  `_liveRoomDetailMapEquality` token for the room-detail metadata maps.
- Live history danmaku responses stay hand-written in
  `live_history_danmaku_model.dart`. Do not restore
  `live_history_danmaku_model.freezed.dart` or `live_history_danmaku_model.g.dart`;
  keep `LiveHistoryDanmakuModel`, `LiveDanmakuItem`, and nested medal/title/user-level
  values as owner-owned live danmaku models consumed by live state, socket parsing, and
  render widgets. Do not restore unused `copyWith` or `toJson` helpers for these
  read-only danmaku values. `LiveHistoryDanmakuModel.admin` and `room` equality uses
  Flutter's canonical shallow `listEquals`; do not restore a file-local `_listEquals`
  clone for those read-only lists. `LiveDanmakuItem.checkInfo` equality uses Flutter's
  canonical shallow `mapEquals`, and hashCode uses `collection`'s shallow
  `MapEquality` inline at the hash site; do not restore file-local `_mapEquals` /
  `_mapHash` clones or a one-use `_liveDanmakuCheckInfoEquality` token for the
  danmaku metadata map. Array-encoded medal/title/user-level metadata parsing stays
  inline in `LiveDanmakuItem.fromJson`; do not restore one-use `_medalFromJson`,
  `_titleFromJson`, or `_userLevelFromJson` helpers. Keep the one-off live admin,
  guard, and medal badges inline in `LiveNormalMessage.build`; do not restore `_LiveAdminBadge`,
  `_LiveGuardBadge`, or `_LiveMedalBadge` as classes that only render one message owner.
- Live guard-list responses use `LiveGuardListModel`, `LiveGuardInfo`, `LiveGuardItem`,
  `LiveGuardUserInfo`, and `LiveGuardUserBase` as the single app/API shape. Preserve the
  `uinfo`, `guard_level`, and empty `top3` / `list` fallbacks on the canonical model,
  and do not reintroduce `LiveGuardListDto` or its nested DTO mirror types for pure field
  mirroring. Keep the canonical guard-list values hand-written in
  `live_guard_list_model.dart`; do not restore `live_guard_list_model.freezed.dart` or
  `live_guard_list_model.g.dart`. Required guard-list integer fields should use
  `JsonUtils.parseInt` directly instead of a private `_jsonInt` scalar helper. Unused
  `copyWith` and `toJson` helpers are archived too. `top3` and `list` equality uses
  Flutter's canonical shallow `listEquals`; do not restore a file-local `_listEquals`
  clone for those read-only lists.
- Live recommend lists use `LiveRoomSummary` as the canonical room shape. Do not
  reintroduce a one-field `LiveRecommendResponse` Freezed wrapper for
  `recommend_room_list`; keep that unique response-key parsing inside the repository
  boundary that returns `Result<List<LiveRoomSummary>, AppError>`. Keep that parser
  inline in `LiveRepositoryImpl.getRecommendList`; do not restore
  `_parseRecommendRooms` as a one-use repository helper.
- Live room summary API contracts are owned by `live_room_summary_contract.dart`. Do
  not restore `live_room_summary_contract.freezed.dart` or
  `live_room_summary_contract.g.dart`; keep `LiveWatchedShow` and `LiveRoomSummary` as
  hand-written immutable values preserving recommend-room wire keys, `watched_show`
  nesting, `keyframe`, and `is_auto_play`. Watched-count scalar parsing uses the shared
  `JsonUtils.parseInt` helper directly; do not restore unused `copyWith` or `toJson`
  helpers, or a private `_parseWatchedCount` JSON utility beside the canonical core
  parser.
- User profile card transport uses `UserCardModel` as the single app-facing shape for
  profile card and live anchor-card handoff. Do not restore
  `user_card_contract.freezed.dart`; keep `UserCardModel` as a hand-written immutable
  value preserving `mid`, `name`, `face`, and default `isFollowed = false` semantics.
  Do not restore the `UserCardModel.copyWith` helper; profile optimistic follow updates
  live on `ProfileUser.copyWith`, and the live anchor follow toggle emits an explicit
  `UserCardModel` constructor instead of keeping a read-only handoff copy helper.
  Keep profile-card response parsing inline in `ProfileRepositoryImpl.getUserCard`; do
  not restore a one-use `_parseUserCard` helper.
- Shared paging state is owned by `PagedListState<T>` and
  `PagedListStateTransitions`. Do not restore `paged_list_state.freezed.dart`; keep
  nullable `error` clearing, default first-page/loading flags, and list equality on the
  hand-written paging value. `PagedListState.items` uses Flutter's canonical shallow
  `listEquals`; do not restore a file-local `_listEquals` clone for the shared paging
  list equality.
- Relation-user contracts are owned by `relation_user_contract.dart`. Do not restore
  `relation_user_contract.freezed.dart` or `relation_user_contract.g.dart`; keep
  `OfficialVerify`, `VipInfo`, and `ProfileRelationUser` as hand-written immutable
  values preserving relation-list wire keys, defaults, equality, diagnostics, and JSON
  parsing. Do not restore unused `copyWith` or `toJson` helpers.
- Video subtitle metadata and subtitle content use `VideoSubtitles`, `SubtitleInfo`,
  `SubtitleContent`, and `SubtitleItem` as the single app/API shape. Preserve the
  Bilibili JSON keys and empty-list fallbacks on the canonical subtitle models, and do
  not reintroduce `VideoSubtitlesDto`, `SubtitleInfoDto`, `SubtitleContentDto`,
  `SubtitleItemDto`, or copy-only subtitle mapper functions. Keep these subtitle values
  hand-written in `subtitle.dart`; do not restore `subtitle.freezed.dart` or
  `subtitle.g.dart`, and do not restore unused read-model `copyWith` or `toJson`
  helpers. Subtitle list equality uses Flutter's canonical shallow `listEquals`; do not
  restore a file-local `_listEquals` clone for subtitle metadata or content lists.
  Subtitle integer fields should call `JsonUtils.parseInt` directly instead
  of a private `_jsonInt` helper; keep double parsing local until a shared `JsonUtils`
  double parser exists.
- Video play-url responses use `PlayUrl`, `DashInfo`, `DashStream`, `Durl`, and
  `SupportFormat` as the single app/API shape. Preserve Bilibili JSON keys such as
  `timelength`, `accept_format`, `video_codecid`, `support_formats`, `backup_url`, and
  DASH `baseUrl`/`base_url` plus `backupUrl`/`backup_url` compatibility on the
  canonical models, and do not reintroduce `VideoPlayUrlDto` or copy-only play-url
  mapper functions. Keep these play-url values hand-written in `play_url.dart`; do not
  restore `play_url.freezed.dart`, `play_url.g.dart`, or generated `_PlayUrl`/`_Dash*`
  / `_Durl` / `_SupportFormat` shell symbols, and do not restore unused read-model
  `copyWith` or `toJson` helpers. Play-url list equality uses Flutter's canonical
  shallow `listEquals`; do not restore a file-local `_listEquals` clone for
  `acceptDescription`, `acceptQuality`, `durl`, `supportFormats`, DASH audio,
  backup-url, or codec lists. Keep DASH `baseUrl`/`base_url` and
  `backupUrl`/`backup_url` fallback reads inline in `DashStream.fromJson`; do not
  restore private `_readBaseUrl` or `_readBackupUrls` key-alias helpers.
- Video danmaku segment loading is owned by `DanmakuRepositoryImpl` and the overlay
  playback scheduler. Do not reintroduce a presentation provider wrapper whose only
  behavior is an empty `build()` plus forwarding `fetchDanmakuSegment` and unwrapping
  `DanmakuSegment.entries`.
- Video danmaku segment values stay hand-written in `danmaku.dart`. Keep
  `DanmakuEntry` and `DanmakuSegment` as immutable app-facing values with read-only
  segment entries, and do not restore `danmaku.freezed.dart` or unused `copyWith`
  helpers.
- Video danmaku AI-mask loading is owned by `VideoExtraWorkflows` and its application
  provider. Do not restore a presentation-layer `danmaku_mask_view_model.dart` wrapper
  whose only behavior is forwarding `loadDanmakuMask`.
- Video danmaku item transport belongs to the NS danmaku controller contract. Keep
  `DanmakuItem` and `DanmakuItemType` beside `DanmakuController`; do not restore a
  separate `models/danmaku_item.dart` file that only copies text/color/time/type through
  to the renderer.
- Video danmaku view metadata is archived until a current UI or workflow consumes it.
  Keep the active danmaku path limited to segment loading and AI mask bytes; do not
  restore `DanmakuViewConfig` or a repository/API `fetchDanmakuView` seam.
- Video player-info danmaku-mask metadata is parsed at the video repository boundary
  from the raw `dm_mask` object. Do not reintroduce `PlayerInfo` or `DmMask` DTO wrappers
  while the app only consumes `mask_url` and `fps` for the danmaku mask workflow. Keep
  that unwrap inline in `VideoRepositoryImpl.fetchDanmakuMaskInfo`; do not restore a
  one-use `_parseDanmakuMaskInfo` helper.
- Danmaku mask path refresh is owned by `useDanmakuPlaybackScheduler`; keep the
  `AsyncValue`/`Result` unwrap beside the refresh bucket cache and do not restore
  `_resolveMaskPath` as a one-call resolver.
- Danmaku segment-entry mapping is owned by `useDanmakuPlaybackScheduler`; keep opaque
  color construction and mode-to-`DanmakuItemType` mapping inline beside `DanmakuItem`
  creation, and do not restore `_toOpaqueDanmakuColor` or `_toDanmakuItemType`.
- NS danmaku render painter construction is owned by `_createRenderItem`; keep stroke and
  fill `TextPainter` setup inline beside width/height/velocity derivation, and do not
  restore `_buildStrokePainter` or `_buildTextPainter` one-call factories. Danmaku item
  visibility and painting stay inline in `DanmakuPainter.paint`; do not restore one-use
  `_isVisible` or `_paintItem` wrappers around horizontal culling, offset creation,
  optional stroke paint, and fill text paint.
- JSON converters that normalize API object lists should use `JsonUtils` string-key map
  helpers instead of repeating ad hoc `Map<String, dynamic>.from` loops. Feature-specific
  filtering, logging, and drop-count policies stay with the owning converter.
- Single-value API map normalization should call `JsonUtils.asStringKeyedMap` directly
  instead of keeping private one-call map readers.
- Relation service nested relation-user maps follow the shared map normalization rule;
  do not keep a private `_asMap` clone for official-verify or VIP payloads.
- Relation service list and item parsing stays inline in the `_getRelationUsers`
  request-executor transform; do not restore `_parseRelationUsers` or a one-use
  `_parseRelationUser` mapper beside the only relation-list transform.
- Relation API response decoding stays owned by each endpoint boundary. Keep the
  follow-list GET decode inline in `_getRelationUsers` and the follow/unfollow POST
  decode inline in `modifyRelation`; do not restore one-call `_getApiResponse` or
  `_postApiResponse` transport wrappers.
- Profile official verification parsing stays inline in `ProfileRepositoryImpl.getProfile`;
  do not restore a one-use `_isVerified` wrapper around `official.role`.
- Profile banner fallback parsing stays inline in `ProfileRepositoryImpl.getProfile`;
  do not restore a one-use `_resolveBanner` wrapper around `top_photo` and card
  `space` images.
- Scalar API parsing should use `JsonUtils.parseIntWithDefault` and
  `JsonUtils.parseStringWithDefault` instead of local `_readInt`/`_readString` helpers
  when there is no feature-specific policy. `JsonUtils.parseInt` accepts numeric API
  values, including non-int `num`, before falling back to string parsing.
- Live danmaku event integer parsing follows the same scalar rule: the socket event
  parser is private to `LiveSocketService` and should call `JsonUtils.parseIntWithDefault`
  directly for optional numeric fields instead of carrying a private `_asInt` clone,
  preserving the event parser's malformed-value fallback to 0. Do not restore the
  one-use `LiveDanmakuEventParser` wrapper file/class.
- Live socket compressed notification decoding keeps uncompressed packet iteration inside
  `_decodeCompressedNotificationEvents`, the top-level compute callback. Do not restore
  a one-call `_decodeNotificationEventsFromMessage` helper; preserve operation `5`
  filtering, nested compressed packet recursion, protocol `0` JSON decoding, and
  map-only event collection inline.
- Profile optional enrichment counters follow the shared scalar rule: relation
  followers/following, likes, and video counts should call `JsonUtils.parseIntWithDefault`
  at the repository boundary instead of restoring a private `_readOptionalInt` clone.
  Keep the optional response data-map gate centralized, but keep one-use relation,
  likes/video count parsing inline in `getProfile`; do not restore `_parseRelationStats`,
  `_parseLikes`, or `_parseVideoCount` wrappers. Optional profile enrichment fallbacks
  stay as inline `(_) => null` callbacks beside their `ConcurrentTask` definitions, not
  as a named helper that only returns null.
- Profile VIP scalar fields follow the same repository-boundary rule: `getProfile`
  reads the optional `vip` map once and parses `type`/`status` with
  `JsonUtils.parseIntWithDefault`; do not restore private `_parseVipType` or
  `_parseVipStatus` helpers.
- Auth cached-user parsing follows the same shared map/scalar normalization rule: keep
  `_userEntityFromJson` as the cache boundary, but do not reintroduce private
  `_asMapOrNull` or `_asIntOrNull` helpers for `level_info`.
- Notification mapper scalar fields follow the shared scalar parsing rule; keep only
  behaviorful notification-specific normalization helpers such as nullable empty-string
  handling. Keep unread summary cache parsing inline in
  `NotificationRepositoryImpl.watchUnreadCount`; do not reintroduce
  `notificationSummaryFromJson` or `notificationSummaryToJson` mapper helpers.
- Notification chat send/upload response parsing is repository-owned. Do not reintroduce
  `sendMessageResultFromJson`, `uploadedImageFromJson`, or `_readNullableString` as
  public notification mapper helpers when the only active callers are
  `NotificationRepositoryImpl.sendPrivateMessage` and `uploadImage`. Keep private-message
  send `msg_content` null/empty-string normalization inline with the local
  `SendMessageResult` projection; do not restore a one-use `readNullableString` nested
  helper. Keep
  `SendMessageResult` as a lightweight send response holder; do not restore generated
  shells, `copyWith`, or deep equality/hash helpers for its `keyHitInfos` map while no
  active flow compares send results.
- Notification repository helper/service splits stay archived when they only proxy one
  repository owner. Keep local read queries, unread/system streams, reply/at/like
  support fetches, system-notice fetch parsing, image upload, and private-message send
  outbox behavior on `NotificationRepositoryImpl` or its sync collaborators; do not
  restore `NotificationLocalReadStore`, `NotificationStreamWatchers`,
  `NotificationMessageSupport`, `NotificationMessageSendService`, or
  `SyncMessagesHeadFn`.
- Notification local database connection policy stays constructor-owned when no second
  active database entrypoint shares it. Keep the default `driftDatabase` name/options
  inline with `NotificationLocalDatabase`; do not restore `_openConnection` as a one-line
  connection helper.
- Private-message transport DTOs keep only JSON decoding and wire-shape helpers required
  by active data paths. Do not reintroduce unused `PrivateMessageDetail` convenience
  members such as DTO-local text/image/withdrawn/summary getters; the UI uses canonical
  `PrivateMessage` domain behavior instead.
- Search DTOs keep only the response fields currently mapped into canonical app-facing
  models or repository behavior. Unknown API fields remain ignored by JSON decoding
  instead of being mirrored into unused Freezed properties.
- Search default and hot-ranking endpoints do not keep dedicated response-shell DTOs
  when the repository only needs one `show_name` value or the transport `list` envelope.
  Parse those envelopes in `SearchRepositoryImpl`, keep `SearchTrendingItem` as the
  canonical hand-written hot-ranking item shape, and do not reintroduce
  `DefaultSearchData`, `TrendingRankingResponse`, or `TrendingRankingData`. Keep the
  default-search `show_name as String?` read inline with `getDefaultSearch`; do not
  restore a private `_parseDefaultSearchName` wrapper for that one field. Keep the
  hot-ranking `list` envelope parse inline with `getTrendingRanking`; do not restore
  `_parseTrendingRankingItems` as a one-use repository mapper. `SearchTrendingItem` is
  read-only in current flows; do not restore unused `copyWith` or `toJson` helpers.
  Hot-ranking silent refresh equality uses Flutter's shallow `listEquals` over
  `SearchTrendingItem.operator ==`; do not restore `_sameTrendingItems`.
- Search suggestion JSONP parsing stays private to `SearchRepositoryImpl` while the
  app-facing behavior only needs `List<String>`. Parse `result.tag[].value`/`term`
  directly inline and do not reintroduce `SearchSuggestionResponse`,
  `SearchSuggestionTag`, `SearchSuggestionTagsConverter`, or a private
  `_parseSuggestionText` wrapper. Keep the JSONP response unwrap at the only
  `getSuggestions` callsite; do not restore a one-use `_parseSuggestionsResponse`
  helper.
- Search result endpoints use the shared `ApiResponse<SearchResultData>` envelope. Keep
  `SearchResultData` and `SearchResultItem` for polymorphic result parsing, but do not
  restore the duplicate outer `SearchResultResponse` shell.
- To-view watch-later items use `ToViewEntry` as the single app/API item shape. Keep it
  as a hand-written immutable value preserving `aid`, `pic`, `title`, `duration`,
  `owner.name`, `stat.view`, `stat.danmaku`, `progress`, `bvid`, progress getters, and
  the repository empty-list fallback for the API `No Data` response; parse the transport
  `list` envelope in `ToViewRepositoryImpl.getList`, and do not reintroduce
  `to_view_entry.freezed.dart`, `ToViewListResponseDto`, `ToViewModelDto`,
  `ToViewModelMapper`, `_ToViewModelMapper`, or the one-use `_parseToViewEntries`
  repository helper. To-view integer fields use
  `JsonUtils.parseIntWithDefault`; do not restore a private `_readInt` helper for `aid`,
  `duration`, or `progress`. Current watch-later flows read the entry directly; do not
  restore an unused `copyWith` helper.
- `RequestExecutor`, `Result`, and `AppError` stay the network and error boundary until a
  full replacement is planned and applied everywhere. Do not restore dead executor
  wrappers such as `runVoid`, `runResponse`, or any `RequestExecutionOptions` fields;
  the wrapper is retired. Active repositories should use `run`, `runApi`,
  `runApiDirect`, or `runUnit` directly, pass Dio cancellation to Retrofit APIs
  directly, and rely on `AppError.fromObject` for shared executor error mapping.
  Search now owns request-class extras inline at each API call via
  `EndpointPolicy.requestClassExtra: EndpointRequestClass.search`. Keep generic
  `EndpointPolicy.cacheTtlOverrideExtra` support resolver-owned unless an active caller
  proves a higher-level request-executor API is needed again.
  Keep Dio exception classification in `AppError.fromObject`; do not restore one-use
  `_fromDioException` or `_fromBadResponse` helpers for the shared error mapper.
  Keep object-response map normalization inline with `decodeObjectApiResponse`; do not
  restore a one-use `_requireJsonObject` helper beside the public decoder.
- Network cache policy, retries, concurrency, WBI signing, CSRF, cookies, and auth token
  handling stay centralized under `core`.
- `NetworkConcurrencyProfile` owns its `maxConcurrency` policy directly; do not restore
  a detached `NetworkConcurrencyProfileX` extension for the same enum-owned rule.
- Dio provider lifecycle and network-policy listener setup is shared by
  `_attachDioLifecycle`; keep `basicDio` and `dioClient` policy differences explicit in
  their provider bodies instead of merging the basic and full clients.
- Retry delay scheduling is owned by `_createRetryInterceptor` beside the retry evaluator;
  do not restore a one-use `_retryDelays` helper for the exponential clamp list.
- Full-client retry-interceptor replacement is owned by the `dioClient` network-policy
  listener beside `RequestPolicyInterceptor.invalidatePolicyCache`; do not restore a
  one-use `_replaceRetryInterceptor` helper.
- Endpoint cache TTL lookup is owned by `EndpointPolicyResolver._basePolicyFor` beside
  the endpoint-class matrix; do not restore a one-use `_cacheTtlFor` helper. Preserve
  `EndpointPolicy.cacheTtlOverrideExtra` precedence over `ApiConstants.cacheConfig`.
- Request cache keys have one canonical implementation:
  `RequestPolicyInterceptor.buildCacheKey`. Cache options pass that function inline at
  the `CacheOptions` construction boundary; do not restore a private `_generateCacheKey`
  delegate.
- Request timeout policy lookup is owned by `RequestPolicyInterceptor.onRequest` at the
  timeout application boundary; do not restore a one-use `_getPolicy` helper beside the
  `_cachedPolicy` field and `invalidatePolicyCache`.
- Request cache option application is owned by `RequestPolicyInterceptor.onRequest` at
  the GET request boundary; do not restore a one-use `_applyCacheOptions` helper beside
  the only refresh/cache-TTL branch.
- Cache-store directory fallback is owned by `cacheStore` at the lazy store construction
  boundary; do not restore a one-use `_resolveCacheDirectory` helper.
- Lazy cookie-jar creation is owned by `_LazyPersistCookieJar._resolve`; do not restore
  a one-use `_create` helper beside the cache field it initializes.
- In-flight request deduplication owns its simple GET/policy/extra predicate directly in
  `InFlightDedupInterceptor.onRequest`; do not restore `_shouldDeduplicate`. Dedup key
  construction for host/path, no-query, single-query, and sorted multi-query cases also
  stays on the request path; do not restore `_buildDedupKey`. The waiting request response
  clone stays inline at the `handler.resolve` boundary; do not restore
  `_cloneResponseForRequest`. Dedup success/failure completion stays inline in `onResponse`
  and `onError`; do not restore `_completePendingSuccess` or `_completePendingFailure`.
- Audio handler teardown is owned by `CilixiliAudioHandler.dispose`; do not restore a
  one-use `_disposeResources` helper for subscription/player cleanup.
- Pagination duplicate-load state is private to `PaginationLoadGate.run` and `reset`;
  do not restore a public `isInFlight` getter without a caller that needs read-only
  observation.
- Scroll-notification load-more eligibility is owned by
  `ScrollLoadTrigger.triggerOnScrollNotificationWithGate`; keep the scroll-end default,
  vertical-axis gate, effective threshold calculation, inclusive threshold comparison,
  and scheduled gate run together instead of restoring `resolveExtentAfterThreshold`,
  `shouldTriggerByExtentAfter`, or `shouldTriggerOnScrollNotification`.
- Endpoint policy resolver construction is owned by `NetworkQualityInterceptor`; do not
  keep a generated `endpointPolicyResolverProvider` wrapper when the interceptor is the
  only consumer.
- Connectivity result normalization is owned by `_profileFromConnectivityResult`; do not
  restore `_normalizeResults` as a one-call helper around single-result, typed-list,
  generic-iterable, or empty fallback handling. `networkQualityProfile` owns the
  initial connectivity read, normal fallback on `checkConnectivity` failure, changed
  connectivity stream mapping, and `distinct()` filter inline; do not restore
  `_watchConnectivityProfiles` as a one-call stream wrapper.
- Resource API basic-client construction is owned by `ResourceApi`; keep
  `basicResourceApiProvider` beside the Retrofit interface for WBI, danmaku bytes, and
  media-save paths. Full-client one-use construction stays inline with the only video
  repository consumer; do not restore `resourceApiProvider` or
  `resource_api_provider.dart`.
- WBI signing is owned by `WbiHelper`; do not keep a separate public `WbiSigner` class
  or `wbi_signer.dart` file when no caller consumes that boundary independently. The
  mixin-key derivation stays inline in `WbiHelper.sign`; do not restore a one-use
  `_getWbiMixinKey` helper.
- `AuthInterceptor` owns its single `WbiHelper` instance directly from
  `basicResourceApiProvider`; do not restore the generated `wbiHelperProvider`
  wrapper or `wbi_helper_provider.g.dart`. Cookie refresh completion owns CSRF cache
  invalidation inline beside `_refreshCookieFuture` reset; do not restore a one-use
  `_invalidateCsrfCache` helper.
- Feature pagination page sizes have one owner. UI/state may compare page lengths against
  the owning feature constant, but must not duplicate raw page-size literals or route
  shared defaults through repository/API wrapper constants.
- API endpoint constants must not duplicate the same path string under multiple names.
  `/x/web-interface/nav` is owned by `ApiConstants.nav`; auth-facing `userInfo` aliases
  that owner instead of retyping the literal.
- Notification private-message pagination page size is owned by
  `notificationPrivateMessagePageSize`; API defaults, repository wiring, and page-state
  has-more checks must use it instead of retyping `20`.
- Search result pagination page size is owned privately by `SearchApi`; search API
  defaults must not duplicate the raw `20` literal or restore a one-line constants wrapper.
- Shared comment pagination defaults are owned by `CommentService.defaultPageSize`; dynamic
  and video comment flows must not duplicate the raw fallback size.
- Video comment list cache extent is owner-private to the comment list and reply pages;
  keep the tuned value beside each owning scroll view instead of preserving a shared
  `video_comment_layout.dart` constants file or repeating a raw cache extent literal.
- Video comment reply navigation callback shape is owned beside `VideoCommentsView`.
  Do not restore the typedef-only `features/video/presentation/video_navigation_callbacks.dart`
  file.
- Video detail info section renderers are archived when they are only consumed by
  `VideoInfoView`; keep uploader/follow row, description/tags, parts row, and
  recommendation item chrome inline with their only owners in `video_info_view.dart`;
  keep one-use header/stats chrome inline with `_VideoInfoLoadedContent.build`, keep one-use
  action row, parts selector, and collection summary chrome inline with
  `_VideoInfoEngagementSection.build`,
  keep one-use recommendation cards inline with `_VideoInfoLoadedContent.build`, keep
  description/tag expansion branch-local with the loaded-content owner, and keep
  `_ActionButton` only as the repeated action primitive.
- Video player overlay chrome wrappers are archived when they are only consumed by
  `PlayerControlsOverlay`; keep only behaviorful repeated chrome split, and keep
  one-use bottom-bar, lock-button, and settings-launch glue inline in the overlay owner
  while leaving behaviorful progress/control widgets standalone.
- Video player wakelock management is owned directly by `usePlayerSystemSettings`.
  Do not reintroduce a single-implementation `PlayerWakelock` /
  `PlatformPlayerWakelock` seam or a public `syncPlayerWakelock` helper unless a real
  alternate platform implementation or test harness consumes it.
- Video player load-input selection is owned by `useVideoLoader`; player pages pass the
  `bvid` and session only. Do not restore a public `VideoLoaderInput` record typedef or
  `watchVideoLoaderInput` helper that merely prepares arguments for the same hook.
- Video player one-owner overlay layer wrappers are archived when they only position or
  bridge state for a single owning layer; keep controls positioning inline in
  `VideoPlayerView.build`, keep gesture feedback private to
  `interaction_layer.gestures.dart`, and keep one-use seek double-tap edge dispatch
  inline with `_InteractionGestureSurface`.
- Video controls side-panel layout policy is owned by the controls assembly. Do not keep
  a separate `controls_utils.dart` wrapper for `showSidePanel`/bottom-sheet orientation
  routing when only player controls use it.
  The player-controls assembly now checks bottom-sheet orientation inline at the two
  sheet call sites, so `isPlayerBottomSheetLayout` stays archived too.
  The playback progress slider stays inline in `PlayerControlsOverlay.build`; do not
  restore `_VideoProgressBar`.
- Video detail single-consumer interaction helpers are archived when they only apply
  optimistic like, coin, or favorite state for `VideoDetailController`; keep the delta
  logic inline in `toggleVideoLike`, `addVideoCoin`, and `setVideoFavoriteState`
  instead of in `_applyVideoLikeState`, `_applyVideoCoinState`,
  `_applyVideoFavoriteState`, or a separate application file.
- Video entry layout builder seams are archived when no route or test overrides them.
  Keep the vertical-video branch direct in `VideoEntryDecisionPage` instead of routing
  through a one-line `verticalPageBuilder` / `_buildVerticalPage` indirection, and keep
  the normal detail branch direct instead of routing through `normalPageBuilder` /
  `_buildNormalPage`.
- Home feed page size is owned by `homeFeedPageSize`; state cache queries and Retrofit
  defaults must use it instead of repeating the raw `20` literal or routing through
  `HomeRepositoryImpl.feedPageSize` / `HomeApi.feedPageSize` wrapper constants.
- Home recommend feed response parsing is owned by `HomeRepositoryImpl`: unwrap
  `data.item` at the repository boundary, preserve the `goto == av` filter and
  malformed-item skip policy, and do not reintroduce `FeedResponseDto` or its generated
  response shell. Keep that one app-facing `data.item` parser inline in
  `HomeRepositoryImpl.fetchRecommendPage`; do not restore `_parseRecommendVideos`
  as a one-use repository helper.
- Home popular, weekly, and ranking video-list response parsing share the canonical
  `parseVideoModelListEnvelope` helper beside `VideoModel`; do not reintroduce the
  `VideoListResponseDto` transport shell for a `data.list` unwrap.
- Home weekly feed transport is owned by `HomeApi`; do not keep a separate one-endpoint
  `WeeklyApi` Retrofit wrapper when the repository already owns the shared home feed API
  boundary and `parseVideoModelListEnvelope` parsing path.
- Home weekly page list state is owned by `WeeklyScreen`. Do not keep
  `weekly_view_model.dart` or a generated `weeklyListProvider` wrapper when only the
  weekly page consumes the list and retry behavior.
- Related-video API responses decode directly to canonical `VideoModel`. Do not
  reintroduce `RelatedVideo`, `related_video_dto.dart`, or a copy-only
  `RelatedVideoViewDataMapper`.
- Video detail tag view state stores tag names as `List<String>`. Do not reintroduce the
  one-field `VideoTagViewData` wrapper or `VideoTagViewDataMapper`.
- Video detail dimension state uses the canonical decoded `VideoDimension` payload for
  width, height, and rotate. Do not reintroduce `VideoDimensionViewData` or a copy-only
  `VideoDimensionViewDataMapper`.
- Video detail conversion keeps single-use detail/page/request-user mapping inline with
  `LoadVideoDetailWorkflow.loadCritical`, the only owner that turns the API detail
  payload into `VideoDetailViewData`. Do not reintroduce public
  `VideoDetailViewDataMapper`, `VideoPartViewDataMapper`, `VideoRequestUserStateMapper`,
  `toVideoDetailViewData`, `toVideoPartViewData`, or `toVideoRequestUserState`
  extension APIs, and do not restore private `_videoDetailToViewData`,
  `_videoPageToViewData`, or `_reqUserToState` helpers while the workflow remains their
  only consumer.
- Video detail API DTOs are owned by `video_detail_dto.dart`. Do not restore
  `video_detail_dto.freezed.dart` or `video_detail_dto.g.dart`; keep `VideoDetail`,
  `ReqUser`, `VideoPage`, `VideoDimension`, `VideoTag`, and `TagCount` as hand-written
  immutable DTOs preserving Bilibili wire keys, default values, list equality, and JSON
  parsing. `VideoDetail.copyright` keeps deep equality/hash via the shared
  `collection` package helper instead of file-local recursive clones. These DTOs are
  response read models; do not restore unused DTO-level `copyWith` or `toJson` helpers while optimistic state mutations live on
  `VideoDetailViewData` and `VideoRequestUserState`. `VideoDetail.pages` and `tag`
  equality uses Flutter's canonical shallow `listEquals`; do not restore a file-local
  `_listEquals` clone for these read-only detail lists, and do not restore file-local
  `_deepEquals` / `_deepHash` clones beside the detail DTO.
- Live recommend page size is owned by `liveRecommendPageSize`; the live recommend
  provider and Retrofit default must use it instead of keeping separate `12` / `30`
  values.
- Live recommend list state is owned by `LiveView`. Do not keep
  `live_recommend_provider.dart`, generated output, public `LiveRecommend`, or public
  `liveRecommendProvider` when the home live tab is the only consumer of paging,
  refresh, and load-more behavior.
- Dynamic topic feed page size is owned by `dynamicTopicFeedPageSize`; the topic-feed
  Retrofit default must not keep an inline raw `20`.
- Dynamic topic feed state is owned by `TopicDetailPage`. Do not keep
  `topic_dynamic_feed_provider.dart`, generated output, public `TopicDynamicNotifier`,
  or public `topicDynamicProvider` when the topic detail page is the only consumer of
  cursor paging, refresh/load-more, and like toggling.
- Dynamic feed API feature flags and web timezone offset are owned by `dynamic_api.dart`;
  Retrofit defaults and cache-key construction must not duplicate the long feature
  string or raw `-480` in a separate defaults wrapper.
- Live danmaku send defaults are owned by `LiveApi` directly; the Retrofit send endpoint
  must not repeat raw color, font-size, mode, or bubble defaults in a separate wrapper.
- Live room initialization must not fetch or store unused danmaku config payloads. The
  `GetDMConfigByGroup` response is archived until a current UI or socket policy consumes
  it; do not restore `LiveDanmakuConfigModel`, its nested mode/color/group mirrors,
  `getDanmakuConfig`, `_fetchDanmakuConfig`, or `LiveRoomState.danmakuConfig` as a
  startup health gate.
- Live room gold-rank and guard-list page sizes are owned separately by
  `liveGoldRankPageSize` and `liveGuardListPageSize`; do not merge them into a generic
  live `20` just because the current values match.
- Live room page-local player section and bottom input-bar wrappers are archived when
  they only wrap the single `LiveRoomPage` player aspect ratio or danmaku input
  affordance; keep those page-owned layout branches inline with `LiveRoomPage.build`.
- Favorites collected-folder and folder-resource page sizes are owned separately by
  `favoriteFolderPageSize` and `favoriteResourcePageSize`; do not merge them into a
  generic favorites `20` just because the current values match.
- Favorite folder row renderers are archived when they are only consumed by
  `FavFolderList`; keep folder-list visual rows inline with the list item builder,
  including `KeyedSubtree`, `AppClickable`, cover/fallback, private badge, media count,
  upper-name text, and spacing/sizing.
- Favorite resource row renderers are archived when they are only consumed by
  `FavoriteDetailPage`; keep selection checkbox behavior, `VideoListCard` dimensions,
  upper-name text, more-action feedback, play/danmaku stats, and divider inline with the
  page-owned sliver item builder. Keep batch resource delete repository calls, success
  selection reset, resource-list invalidation, mounted check, and error feedback inline
  with the selection-mode app-bar action instead of restoring `_handleDeleteResources`.
  Keep owner edit-folder dialog, current-folder lookup, update repository call, success
  invalidation, mounted check, and error feedback inline with the owner popup menu
  instead of restoring `_handleEditFolder`.
  Keep owner delete-folder confirmation, delete repository call, success invalidation,
  mounted navigation pop, and error feedback inline with the owner popup menu instead of
  restoring `_handleDeleteFolder`.
- Favorite detail loading skeleton wrappers are archived when they only serve
  `FavoriteDetailPage`; keep the fixed shimmer loading list inline with the page's
  loading branch.
- Favorites page-local tab/body and action wrappers are archived when they only serve
  `FavoritesPage`; keep the logged-in tab body and current-tab add-folder action inline
  with the page-owned tab controller, create-folder dialog, repository call,
  invalidation, mounted check, and error feedback instead of restoring
  `_handleCreateFolder`.
- Favorites dialog presentation DTOs are archived when the dialog only returns title,
  intro, and privacy to create/edit flows. Use a typed record return value instead of a
  public form-data class with no validation or behavior.
- Notification chat time dividers are archived when they are only consumed by
  `ChatMessageList`; keep chat-list local timestamp grouping inline with the list owner.
- Notification chat message subwidgets are archived when they are only consumed by
  `ChatMessageItem`; keep message-type dispatch in one owner file, inline text renderers
  that only forward `BilibiliEmojiText` parameters, keep image preview branches,
  one-use avatar/system-message helpers, and bubble wrappers that only apply padding,
  color, and asymmetric radius inline with the normal message row or early return
  branch.
- `BilibiliEmojiText` keeps emoji URL resolution and `WidgetSpan` construction inline in
  `buildEmojiTextSpan`; do not restore private one-use `_resolveEmojiUrl` or
  `_buildEmojiSpan` helpers around the shared text primitive.
- Notification message-support helper files are archived when they are only consumed by
  `NotificationFeedSync`; keep reply/at/like feed fetch dispatch, like-envelope parsing,
  system notification talker lookup inline with `_fetchSystemNotifications`, and
  system-notice text/URI parsing private to the feed-sync owner unless another repository
  owner consumes them.
- Notification message persistence owns emoji-key canonicalization, emoji variant
  insertion, and local-row-to-message conversion. Do not duplicate
  `canonicalEmojiKey`, `putEmojiVariants`, or `rowToPrivateMessage` inside
  feed-sync or repository support helpers.
- Notification system-notice card wrappers are archived when they only serve
  `SystemNotificationPage`; keep system notice row rendering, target parsing, and
  navigation failure feedback inline with the page-owned list builder.
- Notification landing-page category grids are archived as standalone widgets when they
  are only consumed by `NotificationPage`; keep the unread-count category surface private
  to the page that owns the navigation callbacks.
- Notification private-session item renderers are archived when they are only consumed by
  `PrivateSessionListView`; keep row profile lookup, message summary, avatar loading, and
  unread badge rendering private to the list owner. Do not restore one-use
  `_buildMessageSummary`, `_buildAvatar`, or `_buildUnreadBadge` helpers for the
  private-session row.
- Notification feed item chrome is archived when it only serves
  `NotificationListPage`; keep the avatar tap target, header row, source preview, and
  failure feedback inline in the page-owned row instead of splitting them into
  `NotificationItemWidget` or one-use helper widgets. Do not restore
  `NotificationItemWidget`, `_getActionText`, or `_getSourceText` when those strings
  only feed the same row build.
- Notification loading skeleton lists are archived when each skeleton has a single owner;
  keep chat and private-session loading UI inline with `ChatPage` and
  `PrivateSessionListView`, and inline one-owner skeleton item markup into the owner when
  the row has no independent behavior.
- Notification chat display fallback belongs in `ChatPage.build`; keep the name/avatar
  route defaults, non-user-session bypass, and profile-card loading/null fallbacks inline
  instead of restoring a one-call `_resolveDisplayInfo` method.
- Notification list page wrappers are archived when they only serve
  `NotificationListPage`; keep the empty state and refresh/list adapter inline with the
  page-owned load gate, item builder callbacks, and retry invalidation callback.
- Notification landing category wrappers/helpers are archived when they only serve
  `NotificationPage`; keep category button rendering, unread badges, loading/error
  branches, and callbacks with the page build owner instead of restoring
  `_NotificationCategoryGrid` or `_buildCategoryItem`. `_UnreadCount` keeps active
  stream-watch and initial-sync behavior only; manual refresh helpers must be wired to a
  visible refresh affordance or archived.
- Search filter bars are archived when they are only consumed by `SearchResultView`; keep
  tab-local search filter UI private to the result view owner and do not restore
  `_SearchFilterBar`.
- Search result paging state is result-view-owned while only `SearchResultView` consumes
  it. Preserve cancel-token disposal/rebuild/load-more replacement, empty-keyword null
  results, and page merge behavior privately beside the result view; do not restore
  `search_view_model.dart`, public `SearchResult`, or `searchResultProvider`.
- Auth page-only background widgets are archived when they are only consumed by
  `LoginPage`; keep login-only decorative layout private to the page owner.
- Settings bottom-sheet selection widgets are archived when they are only consumed by
  `SettingsPage`; keep selection sheet/item UI private to the page owner and do not
  restore `_SettingsSelectionItem`.
  Keep the language/theme selection builders and clear-cache action inline in
  `SettingsPage.build`; do not restore one-use `_showLanguageSelector`,
  `_showThemeSelector`, or `_handleClearCache` helpers.
- Settings row/group widgets are archived when they are only consumed by `SettingsPage`;
  keep page-local rows and grouping private to the page owner.
- Settings page scaffold wrappers are archived when they only forward `SettingsPage`
  into another private class; keep provider reads, app bar, grouped rows, and selection
  actions on the owning page.
- Settings cache-size loading is page-owned while only `SettingsPage` displays and
  refreshes it. Keep the formatted size state, loading placeholder, error fallback, and
  post-clear refresh inline with `_SettingsPageState`; do not restore a file-local
  `_cacheSizeProvider`.
- Ranking tab list views are archived as standalone widgets when they are only consumed by
  `RankingPage`; keep provider watch, refresh behavior, keep-alive lifecycle, and list
  rendering private to the tab page owner.
- Search app bars are archived when they are only consumed by `SearchPage`; keep
  page-local app-bar composition private to the page owner. Do not restore the private
  `_SearchAppBar` wrapper once the only owner can keep the `AppBar` inline.
- Search history sections are archived when they are only consumed by `SearchPage`; keep
  the history provider watch, clear action, and tag tap callback private to the landing
  page owner. Do not keep a single-entry removal method/helper while the UI only supports
  tap-to-search and clear-all.
- Search-only section header wrappers are archived when they only style the search
  history and hot-search headers. Keep the title text, padding, and trailing action
  chrome inline with the owning search branch or section.
- Search result item renderers are archived when they are only consumed by
  `SearchResultList`; keep result-entry switch dispatch and its concrete entry renderers
  in one owner file so result handling and prefetch policy do not drift. Thin
  no-callback result renderers should stay inline with `SearchResultList.build`; do not
  restore `_SearchVideoItem`, `_SearchUserItem`, `_SearchBangumiItem`,
  `_SearchArticleItem`, or `_SearchTopicItem`.
- Provider-backed search landing sections may remain standalone even with one consumer
  when they own loading/error/empty/data rendering and private subcomponents.
- Search result parsing is owned by `SearchRepositoryImpl`: decode the `page`,
  `numPages`, and polymorphic `result` payload directly into `SearchResultPage` and
  `SearchResultEntry` variants, preserving malformed/unknown-type drop logging. Do not
  restore `SearchResultData`, `SearchResultItem`, `_SearchResultConverter`,
  `search_result.freezed.dart`, or the copy-only search mapper extensions.
- Search query parameters are application-owned and hand-written. Keep `SearchQuery`
  as a small immutable value for keyword/type/order/duration/page routing between
  `SearchResultView`, providers, and the repository; do not restore
  `search_query.freezed.dart` or a single-call `copyWith` helper. Search pagination
  should build the next query explicitly at the owning result view boundary. Keep
  `SearchQuery.type` required so every entry point chooses its search domain explicitly.
  Do not add one-use `SearchType` capability getters when the only active owner can
  compare the concrete enum case directly.
- Home feed image prefetch specs are built through `buildHomeFeedImagePrefetchSpecs`;
  feed widgets may choose aspect ratio and image URL, but must not duplicate cache-size
  arithmetic or `NetworkImagePrefetchSpec` mapping locally.
- Generic network image prefetch spec construction is owned by
  `ui/widgets/media/network_image_prefetch_specs.dart`; search, profile, and video
  cover-prefetch paths must use it instead of rebuilding pixel-ratio cache dimensions
  locally.
- Video related-image prefetch estimates stay inline in `VideoInfoView.build` while
  the related UI remains a vertical list; do not restore `_relatedGrid*`,
  `_relatedCoverAspectRatio`, or `_relatedImagePrefetchLimit` file-level constants that
  imply a grid layout.
- `AppNetworkImagePrefetcher._runTask` owns failed/disposed cache-key removal inline
  beside task lifecycle cleanup; do not restore a one-line `_forget` wrapper around
  `_prefetchedAtByKey.remove`.
- `AppNetworkImagePrefetcher._runTask` owns successful-prefetch timestamp refresh and
  LRU capacity eviction inline beside task completion; do not restore a one-use
  `_rememberPrefetched` helper around `_prefetchedAtByKey` updates.
- `AppNetworkImagePrefetcher._precacheImage` uses a `late final ImageStreamListener`
  self-reference for stream cleanup; do not restore nullable listener state or
  `listener!` force-unwraps.
- `AppNetworkImage` loading fallback geometry is owned by the loading branch in
  `AppNetworkImage.build`. Keep custom `placeholder` priority, optional shimmer,
  `width`/`height`, fallback surface color, and border radius inline there; do not
  restore one-call `_buildLoadingPlaceholder` or `_buildDecoration` helpers.
- `AppNetworkImage` error fallback geometry is owned by `AppNetworkImage.build`. Keep
  custom `errorWidget` priority, empty-URL handling, failed-load handling, broken-image
  icon sizing, fallback surface color, and border radius inline there; do not restore
  separate `_buildErrorWidget` or `_buildDecoration` helpers.
- `AppShimmer` animation synchronization is owned by `_AppShimmerState.build` where the
  effective `PerformancePolicy` and reduced-motion gate are known; do not restore a
  one-call `_syncAnimation` helper around the `repeat`/`stop` branches.
- `AdaptiveBlur` owns its reduced-motion and `PerformancePolicy` blur branches directly
  in `AdaptiveBlur.build`; keep the `ClipRect`/`BackdropFilter` construction inline
  instead of restoring a private `_buildBlur` wrapper.
- Home feed cache tuning and initial prefetch limits are owned by
  `home_feed_view_utils.dart`; feed widgets select the named preset instead of repeating
  tuning literals. Home feed image aspect ratios are also named in the same utility file
  so cache dimensions do not drift between initial and scroll-ahead prefetch paths.
  Home grid item width estimation is owned by the same utility file so recommend and live
  prefetch dimensions cannot diverge.
- Home popular/recommend feed state controllers share page-result handling through
  `HomeFeedPagingMixin`. Individual controllers own only their cache key, query, perf
  chain, and repository method; load-error fallback and silent-refresh result logging stay
  in the mixin. Silent-refresh replacement checks use Flutter `listEquals`; do not keep a
  file-local `_sameItems` helper for `VideoModel` lists.
  Silent-refresh fetch timing and logging remain inline beside
  `refreshFirstPageSilently`; do not keep a file-local `_loadFreshFirstPage` helper.
- Ranking tab category metadata is page-local because only `RankingPage` renders those
  tabs and reads the selected `rid`. Do not restore a public
  `presentation/models/ranking_category.dart`, `RankingCategory`, or `rankingCategories`
  wrapper.
- Home page app bars are archived as standalone widgets when they are only consumed by
  `HomePage`; keep auth gating, login dialog fallback, avatar/message actions, search
  affordance, and tab bar private to the page owner. The login dialog entrypoint is owned
  by `login_panel.dart`; do not restore a separate `login_dialog.dart` wrapper.
- Nested profile feed paging defaults are owned by
  `core/data/pagination/nested_feed_paging_defaults.dart`; user dynamic and user video
  tabs must not repeat the base extent-after threshold, cache extent, or scroll-end
  trigger mode. Per-feed viewport factors and max thresholds stay local when they differ.
- User video cover prefetch stays in `UserVideoTab.build`; do not restore
  `_scheduleCoverPrefetch` for the single data branch. Preserve the post-frame scheduling,
  mounted/key guard, first-8 count, `160x100` sizing, and `limit: specs.length`.
- User dynamic and profile space-video silent-refresh replacement checks use Flutter
  `listEquals` over canonical model value equality; do not keep provider-local
  `_sameItems` loops beside those refresh methods.
- Favorites folder list responses parse the transport `list` envelope directly at the
  repository boundary. Do not restore `FavFolderListResponse` or expose the unused
  transport `count` unless current product code consumes it.
- Favorites resource list responses parse the transport `info`/`medias`/`has_more`
  envelope directly at the repository boundary. Do not restore
  `FavResourceListResponse` or the copy-only `_FavResourceListMapper`. Keep the
  one app-facing `FavoriteResourcePage` parser inline in
  `FavRepositoryImpl.getFolderResources`; do not restore `_parseFavoriteResourcePage`
  as a one-use repository helper.
- Favorites folder/resource item JSON decoding belongs to `FavoriteFolder.fromJson` and
  `FavoriteResource.fromJson`; repository list parsers and add/edit APIs must not decode
  through duplicate DTO mirrors.
- Riverpod 3 generated providers are the default state mechanism. Mutable feature state
  uses `@riverpod` `Notifier` or `AsyncNotifier`; page-local hooks remain only for widget
  lifecycle concerns.
- Search page hook state is page-local widget lifecycle state owned by `SearchPage`.
  Do not reintroduce `use_search_view_model.dart`, private `_useSearchViewModel`,
  public `useSearchViewModel`, public `SearchPageMode`, or a one-consumer
  `SearchPageState` wrapper class.
- Cross-feature app models live in `core/models`. Shared visual components live in
  `ui/widgets` until a future shared migration moves a component and deletes its old
  source in the same batch. Feature-specific assemblies belong to their owning feature.
- `FormatUtils` owns only currently used app formatting behavior. Do not restore unused
  string case/truncation helpers such as `capitalize`, `truncate`, `camelCaseToTitle`,
  their private regex, or unused extension getters such as `timeAgo`,
  `formatImageUrl`, and `formatFileSize` when no active call site needs them. Do not restore
  `FormatOptionalStringExtension.parseDuration` or the one-call non-null
  `String.parseDuration` extension; duration text parsing remains the static
  `FormatUtils.parseDurationString` API. Do not restore one-call timestamp extensions
  such as `formatTimestamp`; call `FormatUtils.formatTimeAgo` directly where a Unix-second
  timestamp is rendered. Keep lazy `timeago.setLocaleMessages` initialization,
  the locale-aware `timeago.format` call, and app-locale switch owned inline by
  `FormatUtils.formatTimeAgo`; do not restore `_ensureTimeagoInitialized`,
  `_getAppLocale`, or one-call date-time wrappers such as `formatDateTime`,
  `toSimpleDate`, `toIsoDate`, or `toChatTime`. Call
  `FormatUtils.formatSimpleDate` directly for short notification/session dates and
  `FormatUtils.formatFileSize` directly for byte counts.
  Keep active static methods such as `FormatUtils.formatTimeAgo`,
  `FormatUtils.formatSimpleDate`, `FormatUtils.formatFileSize`, and
  `FormatUtils.formatImageUrl` while they have real callers.
- Error handling helpers expose only production behavior. Do not keep test-only
  `ErrorHandler` hooks such as `resetLoggedErrorsForTest` or
  `loggedErrorCountForTest` when there is no active test suite or production caller.
- Audio playback throttling is owned by `AudioPlaybackStateGate.nextSnapshotIfShouldEmit`.
  Do not keep a public `quantizePosition` facade when the only active quantization path
  is the internal snapshot normalization. Do not expose `positionStep` or
  `minEmitInterval` constructor knobs while the only production state gate uses the fixed
  250ms quantization/throttle policy.
- `part` files are acceptable for generated code. Hand-written `part` splits must be
  collapsed or converted to normal private widgets/classes when they hide dependencies.
  Shared-widget private UI part splits are archived when they only contain private render
  helpers for one owning component.
  Auth handwritten component part splits are archived.
  Live header handwritten part splits and one-owner private extension splits are archived
  when they only contain private helpers for a single widget.
  Live room content wrappers are archived when they only wrap one title, error, danmaku
  feed, or decorative gradient branch for `LiveRoomContent`.
  Live header controls must not expose menu or more-play affordances without real
  behavior.
  Video control button handwritten part splits are archived when they only contain
  private helper controls for one widget.
  Settings handwritten page splits are archived when they only contain private widgets or
  local page behavior for one page.
  Search suggestion and video comment handwritten list/state splits are archived when
  they only contain private UI for one owning widget.
  Search suggestion private list/item/loading/empty wrappers are archived when they only
  serve `SearchSuggestionView`; keep provider state branches and row rendering with that
  owner.
  Search suggestion highlight spans are row-local behavior in `SearchSuggestionView`;
  do not restore `_buildHighlightedSpans`. Keep case-insensitive match splitting,
  normal/highlight styles, substring boundaries, and ellipsis rendering beside the
  `RichText` owner.
  Hot search item wrappers are archived when they only render a single ranked keyword
  row for `HotSearchSection`; keep the grid item inline with the section owner.
  Hot search loading skeleton wrappers are archived when they only serve the owning
  `HotSearchSection.loading` branch; keep the shimmer grid inline with the section.
  Search-only section header wrappers are archived when they only render the landing
  history and hot-search titles; keep the header row inline with the search owner.
  Home app-bar action button wrappers are archived when they only render the single
  message icon for `_HomeAppBar`; keep the button style inline with the app bar owner.
  Popular video badge wrappers are archived when they only render a single rcmdReason
  tag for `PopularVideoCard`; keep the badge inline with the card owner.
  Popular video card actions are caller-owned; keep `onTap` and `onLongPress` required
  because all current popular, recommend, and weekly rows open video detail and expose
  the home video action sheet.
  Live room cover wrappers are archived when they only render the cover stack for
  `LiveRoomCard`; keep the image, gradient, area tag, and online counter inline with
  the card owner. Do not restore a private `_LiveAreaTag` wrapper unless another live
  card consumer needs the exact tag as a reusable component.
  Popular feed list wrappers are archived when they only own the single-owner
  `PopularView` list, prefetch, and action-sheet wiring; keep the list builder inline
  with the view owner.
  Recommendation grid wrappers are archived when they only own the single-owner
  `RecommendView` grid, prefetch, and action-sheet wiring; keep the grid builder inline
  with the view owner.
  Live feed grid wrappers are archived when they only own the single-owner `LiveView`
  grid and image prefetch wiring; keep the grid builder and scroll-precache wiring
  inline with the view owner.
  Home feed breakpoint facades are archived when they only provide max widths and grid
  column thresholds to home feed views; keep those constants and responsive helpers with
  the existing home layout-spec owner.
  Live feed skeleton wrappers are archived when they only serve `LiveView`'s loading
  branch; keep the `CustomScrollView`, grid, and shimmer card inline with `LiveView`.
  Generic page skeleton wrappers are archived when each variant has only one home-feed
  owner. Keep popular list and recommend grid skeleton slivers beside their feed layout
  specs so padding, item count, and scroll physics do not drift.
  Feed-card skeleton media/content helpers are archived when they only wrap one fixed
  shimmer layout for the owning skeleton; keep width/aspect-ratio, shimmer radius,
  `Expanded`, title/footer shimmer sizes, and `Spacer` inline with
  `VideoListSkeleton.build` or `VideoCardSkeleton.build`.
  Feed-card skeleton content helpers are archived when the content column is a single
  fixed shimmer layout; keep `Expanded`, padding, title/footer shimmer sizes, and
  `Spacer` inline with `VideoCardSkeleton.build`.
  Feed-list card overlay list getters are archived when they only convert one nullable
  overlay into a spreadable list. Keep the nullable child branch inline in
  `_VideoListCardBody.build` so overlay policy stays beside the stack it modifies.
  Feed-card reason tag, thumbnail, text, and footer wrappers are archived when they only
  render one `VideoCard` branch. Keep thumbnail cache-width calculation, recommendation
  overlay guard, semantic overlay colors, border, padding, text style, title/description
  max-lines, overflow, typography, colors, author row, and more-action icon inline with
  `VideoCard.build`. Keep the one-use recommendation reason fallback expression inline
  with the overlay guard; do not restore a private `_reason` getter.
  Video orientation toggling owns current-part, detail-level, and player-state
  dimension fallback inline in `useVideoOrientation` before normalizing rotation; do not
  restore a one-use `_getVideoDimensions` helper beside the fullscreen branch.
  Video thumbnail bottom-overlay wrappers are archived when they only render the single
  gradient layer for `VideoThumbnail`; keep the positioned 48px scrim gradient and
  bottom border radius inline with `VideoThumbnail.build`.
  Video thumbnail stats-row wrappers are archived when they only group the optional
  view/danmaku counters for `VideoThumbnail`; keep the row and null-aware counter
  branches inline with `VideoThumbnail.build`, including the repeated icon/text stat
  items.
  Video thumbnail cache-size helpers are archived when they only combine explicit
  overrides, finite layout constraints, and pixel ratio; keep those fallback expressions
  inline with the `LayoutBuilder` branch that owns the constraints.
  Video comment tree-update helpers are archived when only the owning comments view
  model mutates comment like state; keep the immutable tree update private to
  `video_comments_view_model.dart`.
  Profile app bar, notification list item, and favorite detail pure UI handwritten
  splits are archived when they only contain private UI for one owning widget/page.
  Favorite detail page handwritten list/action splits are archived when they only
  contain private list/render and toolbar helpers for the single page owner.
  `_FavoriteDetailListSection` must stay page-inline with `FavoriteDetailPage`.
  `_FavResourceItem` and `_FavoriteResourceRow` must stay page-inline with
  `FavoriteDetailPage`.
  `_FavoriteFolderHeader` must stay page-inline with `FavoriteDetailPage`.
  `_buildFavoriteDetailAppBarActions` must stay inline with `FavoriteDetailPage.build`.
  Favorite picker selection/delta helpers are archived when only the picker sheet uses
  them; keep the selected-id scan inline in the picker sheet data branch and the
  add/delete diff in `_submit` without restoring a private folder-delta wrapper or
  `_initializeSelection`. Keep the per-folder
  checkbox mutation inline with the `CheckboxListTile.onChanged` callback; do not
  restore `_toggleFolder`. Keep the error retry reset and provider invalidation inline
  with the picker sheet error branch; do not restore a one-use `_retry` method.
  Profile page/header handwritten content/section splits are archived when they only
  contain private UI for one owning page/widget. `_UserProfileContent` must stay inline
  with `UserProfilePage.build`, which owns the nested-scroll profile layout directly.
  Profile leaf widget files are archived when they only contain a private stat/action
  renderer for one owning profile widget.
  Profile guest views are archived as standalone widgets when they are only consumed by
  `ProfilePage`; keep the logged-out shell inline with the page that owns the session
  gate, login callback, and settings action.
  To-view item renderers are archived as standalone widgets when they are only consumed
  by `ToViewPage`; keep dismiss, delete, open-video, compact thumbnail policy, progress,
  owner, and stats rendering inline with `ToViewPage.build`; do not restore
  `_ToViewBody` or `_ToViewItem`. One-use list shells stay inline with `ToViewPage`.
  Keep the app-bar clear-all confirmation dialog inline in `ToViewPage.build`; do not
  restore a one-use `_handleClearAll` page-action helper.
  History item renderers are archived as standalone widgets when they are only consumed
  by `HistoryPage`; keep keyed list boundaries, archive-only open-video gating, wide
  thumbnail policy, progress overlay, author, badge, and time stats private to the page
  list owner. One-use history content shells stay inline with `HistoryPage.build`.
  Profile banner renderers are archived when they only serve `UserProfileHeader`; keep
  the banner private to `user_profile_info.dart` unless another current profile surface
  consumes it directly.
  Profile tab local UI part splits are archived when they only contain private render
  helpers for one owning tab or section widget.
  Profile home-tab section title styling is owned by `SectionHeader`; tab sections must
  not duplicate private title/header rows when `SectionHeader` plus a trailing action can
  express the same layout.
  Video listen page handwritten controls/widget splits are archived when they only
  contain private UI for that page. Keep one-use blurred background, cover art, and
  title/author chrome inline with `VideoListenPage.build`, while preserving provider or
  hook boundaries that own playback progress, dragging state, or playback controls.
  Video listen page app-bar wrappers are archived when they only route a title plus
  settings sheet actions for the owning listen page.
  Interaction layer handwritten drag-session and seek-overlay splits are archived when
  they only contain private gesture state or overlay helpers for the owning layer.
  `CulculTheme` handwritten palette/component part splits are archived when they only
  contain private theme construction helpers for that single owner. One-use component
  factories stay inline with `ThemeData`; do not restore `_appBarTheme` around the app
  bar color/typography/system-overlay constants, `_tabBarTheme` around tab label and
  indicator styling, `_bottomNavigationBarTheme` around bottom navigation colors/labels,
  `_cardTheme` around card color/shape/clip constants, `_filledButtonTheme` around filled
  button color/shape/size constants, `_textButtonTheme` around text button color/shape
  constants, `_outlinedButtonTheme` around outlined button color/border/shape constants,
  `_inputDecorationTheme` around input fill/padding/border constants, or `_dividerTheme`
  around the divider color/thickness/space constants.
  `VideoCard` handwritten content/footer/thumbnail part splits are archived when they
  only contain private render helpers for the card owner.
  `VideoListCard` handwritten body/content/media part splits are archived when they
  only contain private render helpers for the card owner; keep the one-use media
  thumbnail/leading branch and title/badge/middle/author/stat column inline with
  `_VideoListCardBody.build`; do not restore `_VideoListCardContent`.
  `VideoListCard` stats-row wrappers are archived when they only space the already
  resolved stat widgets; keep custom stats precedence, default stat construction,
  `showDefaultStats` gating, and the 12px inter-stat spacing inline with
  `_VideoListCardBody.build`. Do not restore `_resolvedStats`.
  Compact `VideoListCard` thumbnail dimensions are owned by
  `video_list_card_dimensions.dart`; ranking and to-view list items must not repeat raw
  `140/88` layout literals.
  Wide `VideoListCard` thumbnail dimensions are owned by
  `video_list_card_dimensions.dart`; search, favorites, and history list-row items must
  not repeat raw `16 / 9` or `90` layout literals.
  `AppImagePreview` private widget part splits are archived when they only contain
  preview render/decode helpers or top/save/hint overlay chrome for the shared preview
  owner. Do not restore `_PreviewImagePager`, `_PreviewTopBar`, `_PreviewSaveButton`, or
  `_PreviewSwipeHint`. Keep the public `AppImagePreview` constructor and `open(...)` API
  stable unless handled as a separate high-impact change.
  Preview decode dimensions are owned by `_AppImagePreviewState.build`; do not restore
  `_previewDecodeDimension` as a one-call helper around finite/positive checks, DPR
  scaling, `_previewImageDecodeScale`, or `_previewMaxDecodeDimension` clamping.
  The preview save button owns its saving gate, long feedback toast, `MediaUtils`
  save call, success/error feedback, and `_isSaving` reset inline; do not restore
  `_saveImage` as a one-call state helper.
  `AppNetworkImage.build` owns cache-size resolution inline; do not restore
  `_resolveCacheSize` as a one-call helper around explicit cache overrides, logical
  dimensions, device-pixel-ratio multiplication, or `_normalizeCacheSize`.
  `MediaUtils.saveImage` owns its one-call temporary filename normalization inline;
  do not restore a private `_buildFileName` helper beside the image-save flow.
  `VideoCardContent` is not a public API unless another live caller uses it directly;
  `VideoCard` owns card content rendering.
  `AppAvatar` decorative fallback, shadow, and border helpers are archived when they
  only mirror `AppAvatar.build`; keep avatar visual construction in the widget owner.
  `SmartPagingView` handwritten content/load-more part splits are archived when they only
  contain the paging content layer and private load helpers for that owner. Keep
  loading/error/empty/data content selection and the one-use refresh result wrapper
  and load-more `ScrollLoadTrigger.runWithGate` call inline in `SmartPagingView.build`
  so fallback rendering, refresh failure mapping, previous-count capture, and
  `ui.smart_paging_view` source attribution stay at the EasyRefresh boundary; do not
  restore `_SmartPagingContent`, `_PagingStatusView`, or `_handleLoadMore`.
  Ranking one-use skeleton widgets are archived when they are only consumed by
  `RankingPage`; keep the skeleton private to the tab page owner.
  Ranking card-local overlay widgets are archived when they are only consumed by
  `RankingItemCard`; keep rank badge visuals private to the card owner.
  Publish dynamic page handwritten scaffold/app-bar splits are archived when they only
  contain private UI for that page owner.
  Publish dynamic page handwritten editor splits are archived when they only contain a
  single private editor widget for that page owner; keep `_PublishDynamicEditor` removed.
  Dynamic item content extension splits are archived when the app-facing content
  extension is short enough to live in the extension owner without obscuring mappers.
  Dynamic item private mapper part splits are archived when they only serve
  `DynamicItemContentExtension`; keep video/link-card/additional mapping private in
  `dynamic_item_extensions.dart`.
  The short video-content projection stays inline in `videoContent`; do not restore
  `_dynamicMapVideoContent` as a one-call helper while only that getter consumes it.
  Dynamic item identity extension splits are archived when the app-facing identity
  getters and optimistic like helper are short enough to live in the extension owner.
  Article detail section splits are archived when they only contain private author/stat
  render helpers for the single article detail scaffold owner.
  Article detail shell splits are archived when they only contain loading/error/empty
  scaffolds and menu item builders for the single article detail page owner.
  Article detail action splits are archived when they only contain methods for the
  single `ArticleDetailViewModel` owner.
  Sheet widgets are private when the feature exposes a behaviorful `show...` function as
  the cross-feature entrypoint.
  Live danmaku section/list view wrappers are archived when they are only consumed by
  `LiveRoomContent`; keep feed watching, enabled fallback, reverse list rendering, item
  repaint boundaries, top fade, and per-`dmType` renderer dispatch private to
  `LiveRoomContent.build` without `_DanmakuSection`, `_LiveDanmakuView`,
  `_LiveDanmakuMessageFactory`, `_LiveSystemMessage`, `_LiveInteractMessage`, or
  `_LiveGiftMessage`.
  Live normal-message badge wrappers are archived when they only render admin, guard, or
  medal chips for `LiveNormalMessage`; keep those branches inline with the message owner.
  Dynamic comments empty-state and list UI are inline when only `DynamicCommentsSliver`
  renders them; do not restore `_DynamicCommentsEmptyState` or `_DynamicCommentsList`
  as one-owner wrappers.
  Dynamic comments reply sheet launch is inline with the row callback and uses the shared
  `CommentReplySheet`; do not restore `_showReplySheet`, `_ReplySheetContent`, or
  `_ReplySheetContentState` as one-call modal/sheet wrappers.
  Dynamic comment target referer selection stays inline in `_resolveDynamicCommentTarget`
  beside the oid/type selection; do not restore `_getDynamicCommentReferer`.
  Video comments empty-state UI is private when only `VideoCommentsView` renders it.
  Video detail info tags/actions keep only the row/section widgets public; one-file tag
  chips and action buttons are private render details.
  Video detail header/stat wrappers are archived when the loaded-content owner already
  owns the owner tile, follow login gate, title expansion, view/danmaku/date, expanded
  BVID row, and description/tag placement.
  Video detail description/tag wrappers are archived when a branch-local `HookBuilder`
  can preserve description expansion separately from title expansion.
  Video detail action row wrappers are archived when the engagement section is the only
  owner of the like/dislike/coin/favorite/share row; keep only the repeated action button
  primitive split.
  Video detail collection summary wrappers are archived when the engagement section is
  the only owner of the row.
  Video detail recommendation item wrappers are archived when the loaded-content sliver is
  the only owner of the row.
  Video detail info loaded-content splits are archived when the private scroll body only
  serves `VideoInfoView`.
  Video detail info header splits are archived when they only contain private render
  sections for `VideoInfoView`; keep engagement split only while it owns action, part,
  and collection composition.
  Video detail controller helper splits are archived when they only expose private
  request-token, auxiliary-load, progress-report, and play-url cache helpers for the
  single `VideoDetailController` owner.
  Player panel empty-state helpers are private when only `QuickSelectionSheet` renders
  them.
  Quick-selection option tile wrappers are archived when only `QuickSelectionSheet`
  renders the menu rows. Keep the tap-to-select/pop behavior, selected/unselected
  colors, optional subtitle, animated container/switcher, and check/chevron icons inline
  with `QuickSelectionSheet.build`; do not restore `_PlayerMenuOptionTile`.
  Player settings filter chip wrappers are archived when only `PlayerSettingsSheet`
  renders the danmaku type filters. Keep the horizontal scroll row, selected/unselected
  colors, rounded XL radius, border alphas, fast animated container, tap callbacks, and
  label style inline with `PlayerSettingsSheet.build`; do not restore
  `_PlayerFilterChip`.
  Player settings section background helpers are archived when they only wrap one
  `ColorScheme` expression for the owning settings sheet/option section; keep that color
  expression inline beside each local decoration owner instead of restoring
  `_settingsSectionBackground`.
  Player settings option text chip wrappers are archived when only
  `_InlineTextOptionSectionState.build` renders the horizontal speed/quality choices.
  Keep each chip's `_itemKeys[index]` measurement key, semantics label/selected state,
  item equality, label builder, tap callback, transparent `Material`, small radius,
  3px padding, fast animated text style, selected/unselected colors and weights, and
  10px inter-chip spacing inline with the option section; do not restore
  `_OptionTextChip`.
  Player control helper labels, capsules, and icon buttons are private when only
  `VideoControlButtons` constructs them, and unused player panel part widgets are
  deleted instead of preserved as reserved UI.
  Player panel handwritten part files are archived when they only contain shared panel
  primitives or single-owner menu/filter helpers. Keep shared panel primitives in
  `player_panel.dart`, and keep single-owner menu/filter renderers private to their
  owning sheet.
  Player settings danmaku row splits are archived when they only contain private slider
  row UI for `PlayerSettingsSheet`; do not restore `_DanmakuSliderRow`.
  Player settings option-section splits are archived when they only contain private
  speed/quality option UI for `PlayerSettingsSheet`. The inline option section uses
  Flutter's shallow `listEquals` when reconciling item-key and selected-item scroll
  updates, and assigns fresh item `GlobalKey`s beside the lifecycle branches that need
  them; do not restore private `_sameItems` or `_buildItemKeys` helpers.
  Vertical video top/right and bottom-bar control splits are archived when they only
  contain private render helpers for the vertical player. Top controls, the right
  action column, and the bottom bar stay inline with `VerticalVideoPage.build`; do not
  restore `_TopBar`, `_RightBar`, or `_BottomBar`. Keep playback progress watches scoped
  to the inline bottom-bar `Consumer` so progress ticks do not rebuild the full page.
  Video comment reply bottom input bars are archived when they only serve
  `CommentReplyPage` and are wired without a real input handler. Delete the no-op bottom
  chrome instead of preserving it as a page-local placeholder.
  Player controller load-helper splits are archived when they only contain private
  request-guard, ready-marking, and media-open helper methods for `PlayerController`;
  keep public controller behavior and load semantics unchanged unless handled as a
  separate high-impact player-controller change.
  Search result tab UI is private when only `SearchResultView` constructs it.
  Search result prefetch tuning stays private to `SearchResultList` while only that
  owner consumes the scan limits and logical image sizes. Keep spec construction inline
  in `SearchResultList.build`; do not restore `_buildSearchResultImagePrefetchSpecs`.
  Comment item content/footer splits are archived when they only contain private
  rendering for the single comment item owner.
  Comment item header/replies handwritten splits are archived when they only contain
  private render helpers for the single comment item owner. Keep reply row rendering
  inline in `_Replies.build`; do not restore `_buildReplyItem`.
  Notification send services are archived when the owning repository already exposes the
  canonical upload/send behavior. Do not keep pass-through fetch APIs, named callback
  typedefs, or one-owner message-send delegate files.
  Single-provider callback typedefs are archived when they only name one local provider
  return type and do not represent a reusable contract. Inline the function type in the
  provider signature instead.
  Comment item controls must not expose menu affordances backed by empty callbacks, and
  feature comment surfaces must omit unsupported optional actions instead of passing
  empty handlers.
  Dynamic detail bottom-bar action icons are archived when they only render the owning
  detail bar's like/share buttons. Keep liked color, zero-count hiding, and share payload
  construction inline with `DynamicDetailBottomBar.build`.
  Live room action splits are archived when the methods only serve the single
  `LiveRoomController` owner and do not require a separate behavior boundary.
  Live room lifecycle/fetcher splits are archived when their private methods only serve
  `LiveRoomController`; keep load orchestration and request helpers in the state owner.
  The request token increment belongs inline in `_init`; do not restore a
  `_beginLiveRoomRequest` helper.
  Listen sleep timer disposal belongs inline in `build`; do not restore a private
  `_dispose` helper for ticker cleanup.
  Listen sleep timer preset buttons should call `setCustomMinutes` directly; do not
  restore a `setPresetMinutes` wrapper.
  Player controller lifecycle dispose registration belongs inline in `build`; do not
  restore a private `_disposePlayerLifecycle` wrapper.
  Player load request timeout/open handling and first-frame logging belong inline in
  `PlayerController.loadVideo`; do not restore private `_markReadyForRequest` or
  `_openMediaWithTimeout` wrappers.
  To-view command facades are archived when they only wrap one page's confirmation
  gating or refresh error mapping.
  One-use DTO mapper extensions are archived when they only copy or select a single
  field for one repository method; keep mappers when they normalize polymorphic response
  data into application concepts.
  Single-consumer mapper files are archived when their only direct importer is the
  repository library that owns the DTO-to-domain conversion. Keep the extension private
  in the repository library instead of exposing a separate public mapper file.
  Favorites DTO-to-domain mapping is repository-owned; do not keep a separate public
  `favorite_mapper.dart` file when `FavRepositoryImpl` is the only consumer. Favorites
  favorite-delta media ID normalization is owned inline by `dealVideoFavorite`; do not
  restore `_joinMediaIds` while no other repository operation shares it.
  System-notice JSON persistence mapping belongs with the canonical `SystemNotice`
  entity; do not keep a separate public `system_notice_mapper.dart` file or move
  `systemNoticeFromJson`/`systemNoticeToJson` back into `notification_mapper.dart`.
  Single-field callback typedefs are archived when they only name one route navigation
  field and add no shared policy; keep the callback type inline with the owning route
  navigation object.
  Same-file hook callbacks and private page record typedefs are archived when they only
  name one parameter or one local list shape and have no cross-module policy.
  Same-file executor callback typedefs are archived when they only name one field or
  method parameter and the executor class already owns the concurrency policy.
  `NetworkConcurrencyExecutor` owns bounded execution, task labels, fallbacks, and eager
  error behavior; do not restore unread per-call `scope` labels unless they are consumed
  by real instrumentation.
  Request executor pass-through wrappers are archived when they only map a void action
  to a null success result and no separate behavior exists beyond `run`/`runUnit`.
  Hook input record typedefs are archived when they only name one hook parameter and
  callers already pass inline record literals.
  Single-use settings enum mapping extension getters are archived when the owning
  notifier can keep the `ThemeMode`/`AppThemePreference` switch beside its read/write
  operations; do not restore `toThemeMode` or `toPreference`.
  One-call article detail comment bar wrappers are archived; keep the bottom composer
  surface inline with the scaffold that owns `bottomNavigationBar`.
  Profile navigation callback typedefs are archived when they only name one route/scope
  field and do not encode reusable navigation policy; keep those callback shapes inline
  with the owning navigation object.
  Page-specific app bar wrappers are archived when they only route a small title/actions
  set for one page and can live inline in the page file without reducing readability.
  Page-local app-bar action-list helpers are archived when they only return a static
  action list for the owning app bar.
  Page-local static header wrappers are archived when they only render one page's icon,
  title, version, or summary copy and do not own reusable state or behavior.
  Page-local callback factory helpers are archived when they only normalize input and
  dispatch to the owning page state once.
  Page-local refresh-result helpers are archived when the only refresh surface can own
  provider invalidation, reload, and `IndicatorResult` mapping inline.
  Thin share wrappers are archived when the only caller can build the share URL and
  payload inline and the shared utility keeps only the reusable share variants.
  Core initializer wrappers are archived when they only wrap a single guarded startup
  call; keep the in-flight future, retry, failure logging, and reset policy in the
  owning initializer function instead of splitting a one-call private helper.
  Page-local body builder helpers are archived when they only switch between one page's
  own view modes and can be read directly in the page build method.
  Page-specific tab/header/bottom-bar wrappers are archived when they only serve one
  page and do not own reusable navigation, state, or behavior.
  Home page tab descriptor helpers are archived when the only owner can construct the
  tab title/view records inline beside the `TabBarView`.
  Home app-bar protected-tap helpers are archived when the only avatar/message actions
  can own their auth gate directly beside the tap callback. Keep `_HomeAppBar` as the
  `currentUserProvider.select` rebuild boundary, but do not restore `_handleProtectedTap`.
  Home page one-call preload helpers are archived when the post-frame callback can own
  provider reads, mounted checks, and silent fallback behavior inline beside the startup
  readiness log; do not restore `_loadHintText`.
  Live header anchor-row helpers are archived when `LiveHeader.build` can own the only
  back button, room-info branch, avatar, name/online block, follow button, and viewer
  stack in order without a one-call row method.
  Live header anchor-avatar helpers are archived when `LiveHeader.build` can own the
  circular border, padding, avatar size, and cover fallback inline beside the row spacing.
  Live header follow-button helpers are archived when `LiveHeader.build` can own the
  nullable anchor/followed gate, lazy current-user watch, login/follow callback choice,
  right padding, height, and localized label inline.
  Live header name/online helpers are archived when `LiveHeader.build` can own the
  expanded name/level/online/guard text block inline with the avatar, follow button, and
  viewer stack that consume the same room/anchor data.
  Live header viewer-stack helpers are archived when `LiveHeader.build` can own the
  stacked rank avatars, count pill, null/empty gold-rank gate, and trailing row spacing
  inline with the anchor row. Do not restore `_buildViewerStack` or `_buildViewerAvatar`.
  Live header tag-row helpers are archived when the hot/popularity tags only serve
  `LiveHeader.build`; keep the row padding, tag order, color alpha, radius, font size,
  and weight inline with the header build owner.
  One-owner sliver header delegates are archived when they only wrap a single page's tab
  header and do not own shared layout policy.
  Page-local tab bar builder functions are archived when they only construct the single
  tab bar consumed by the owning sliver/header delegate.
  Single-owner loading skeleton wrappers are archived when they only serve one result
  view/feed and can remain private to the owning render surface.
  Page-local decorative divider widgets are archived when they only wrap a one-line
  visual separator for a single build method.
  Page-local modal/dialog helper parts are archived when they only serve one page and
  add no reusable navigation, workflow, or rendering boundary.
  Page-local enum label helpers are archived when their only owner can keep the
  exhaustive enum-to-translation switch beside the setting/menu row that displays it.
  `SettingsPage.build` owns theme and language labels directly instead of restoring
  `_getThemeName` or `_getLanguageName`.
  Single-use page modal methods are archived when the only trigger can own the sheet
  call directly; `LiveRoomPage` keeps its danmaku input sheet launch inline instead of
  restoring a one-call `_showInputSheet` method.
  Scaffold-local article detail block/menu helper parts are archived when the helpers
  are only consumed by the scaffold and can stay private beside that render owner.
  Layer-local render bridge parts are archived when they only contain private option,
  conversion, dispatch, badge, or clipper helpers for one owning overlay layer; keep
  behaviorful schedulers and buffers split when they preserve lifecycle readability.
  Auth login background, panel header, login-method tabs, and transient feedback UI are
  archived as standalone private widgets when they only serve `LoginPage`/`LoginPanel`.
  Keep that page chrome and dialog entrypoint beside the owning build methods instead of
  restoring component files, dialog wrapper files, or single-call private classes.
- UI controls must not keep empty callbacks just to preserve visual placeholders. Remove
  the control or implement real behavior in the owning feature phase.
- Feedback error widgets must not keep a separate one-use `_showErrorDetails` helper
  when `AppErrorWidget` is the only owner of the error-details button and dialog. Keep
  the details construction, selectable text, translated labels, and dialog close action
  inline with the owning feedback widget. The details and retry buttons are also owned
  directly by `AppErrorWidget.build`; do not restore one-use `_ErrorDetailsButton` or
  `_RetryButton` wrapper classes. Compactness is variant-owned; use
  `AppErrorWidgetVariant.compact` instead of restoring a parallel `compact` boolean
  parameter or call-site `compact:` override.
- Search result item cards must not be wrapped in clickable/follow affordances unless the
  result type has a real navigation or action handler.
- Player overlays must not show author/follow placeholders backed by empty callbacks or
  hard-coded social counts.
- Video detail controller state is owned by `video_detail_view_model.dart`. Do not
  restore a separate `video_detail_state.dart` or `video_detail_state.freezed.dart`
  one-owner state shell; keep `VideoDetailState` beside `VideoDetailController` so
  Freezed copy/null semantics remain in the controller owner.
- Video detail play-url cache reads are owned by `VideoDetailController`. Do not
  restore a one-use `_readCachedPlayUrl` wrapper; the controller may read
  `_playUrlSessionCache` inline with the shared cache-key builder while keeping cache
  semantics and `PlayUrl` hydration behavior unchanged.
- Video detail play-url request-token checks are owned by `VideoDetailController`.
  Do not restore one-use `_isCurrentPlayUrlRequest`; `_loadPlayUrl` keeps the
  `_playUrlRequestToken` comparison inline after the repository fetch.
- Comment reply controller state is owned by `comment_reply_view_model.dart`. Do not
  restore a separate `comment_reply_state.dart` or `comment_reply_state.freezed.dart`
  one-owner state shell; keep `CommentReplyState` beside `CommentReplyController` as a
  hand-written immutable value so request lifecycle behavior and copy/equality
  semantics stay with the controller owner.
- Listen sleep timer state is owned by `listen_sleep_timer_view_model.dart`. Do not
  restore `listen_sleep_timer_view_model.freezed.dart` for a two-field nullable timer
  shell; keep `ListenSleepTimerState` as a small hand-written immutable value beside
  `ListenSleepTimerController` so timer lifecycle behavior remains controller-owned.
  The controller emits new timer state with direct constructors; do not restore the
  unused `ListenSleepTimerState.copyWith` helper or nullable copy sentinel.
  `ListenSettingsSheet` owns its preset-minute button rendering inline; do not restore
  a one-use `_PresetMinuteTextButton` wrapper. Keep its modal bottom-sheet layout inline;
  do not restore a one-call `isBottomSheet` constructor flag.
- Playback snapshot state is owned by `playback_snapshot_view_model.dart`. Do not
  restore `playback_snapshot_view_model.freezed.dart` for the player snapshot shell;
  keep `PlaybackSnapshot` as a small hand-written immutable value beside the provider
  so playback position, duration, and buffer updates remain controller-owned.
  Playback snapshot quantization is provider-local emission policy; do not restore
  `_PlaybackSnapshotQuantizer` as a static facade when `playbackSnapshot` can keep
  position and buffer floor-step quantization beside equality suppression.
- Audio playback snapshot state is owned by `audio_playback_state_gate.dart`. Do not
  restore `audio_playback_state_gate.freezed.dart` for the state-gate snapshot shell;
  keep `AudioPlaybackSnapshot` as a hand-written immutable value beside
  `AudioPlaybackStateGate` so throttled playback broadcast equality remains
  service-owned. Do not restore the unused `AudioPlaybackSnapshot.copyWith` helper, and
  keep the 250ms state-gate step private instead of exposing unused timing overrides.
- Live danmaku feed state is owned by `live_danmaku_feed_view_model.dart`. Do not
  restore `live_danmaku_feed_view_model.freezed.dart` for the small feed status shell;
  keep `LiveDanmakuFeedState` as a hand-written immutable value beside
  `LiveDanmakuFeedController` so buffer flushing, revision, enabled, and connected
  behavior remain controller-owned.
- Subtitle overlay state is owned by `subtitle_view_model.dart`. Do not restore
  `subtitle_view_model.freezed.dart` for the small subtitle UI shell; keep
  `SubtitleState` as a hand-written immutable value beside `SubtitleController` so
  video-detail initialization, toggle, selection, loading, and error clearing remain
  controller-owned. The controller emits explicit constructors for state transitions;
  do not restore the unused `SubtitleState.copyWith` helper or nullable copy sentinel.
- Danmaku settings state is owned by `danmaku_settings_view_model.dart`. Do not restore
  `danmaku_settings_view_model.freezed.dart` for the small settings UI shell; keep
  `DanmakuSettings` as a hand-written immutable value beside
  `DanmakuSettingsController` so opacity, font-size, area, speed, visibility toggles, and
  ai-mask enablement remain controller-owned.
- Article detail state is owned by `article_detail_view_model.dart`. Do not restore
  `article_detail_view_model.freezed.dart` for the page-specific article/comment UI
  shell; keep `ArticleDetailUiState` as a hand-written immutable value beside
  `ArticleDetailViewModel` so detail loading, comment paging, nullable clear semantics,
  and submit-state behavior remain controller-owned. Non-refresh comment paging keeps
  its duplicate-replacement `rpid` merge inline in `loadComments`; do not restore
  `_appendUniqueComments` as a one-call helper. Keep the cursor end-state check inline
  in the same success branch; do not restore `_resolveHasMore`.
- Dynamic comment paging keeps cursor, page metadata, and default-page-size fallback
  checks in the `refresh` and `loadMore` success branches, where the current page is
  known; do not restore a shared `_resolveHasMore` helper beside
  `DynamicCommentController`.
- User profile tab-bar safe-area padding is always supplied by `UserProfilePage`; keep
  `_UserProfileTabBarDelegate` without a fallback `topPadding = 0` path so the pinned
  header extent and container padding have one page-owned source.
- Danmaku option state is owned by `danmaku_option.dart`. Do not restore
  `danmaku_option.freezed.dart` for the small danmaku render shell; keep
  `DanmakuOption` as a hand-written immutable value beside the ns_danmaku renderer so
  default font, area, opacity, visibility, and stroke settings remain owner-owned.
  The value is reconstructed from `DanmakuSettings` inline at the layer call site; do
  not restore `_buildDanmakuOption` or an unused `copyWith` helper.
- Shared comment list state must not carry a generated Freezed shell. Keep
  `CommentListState` as a small hand-written value over `PagedListState<CommentItem>`
  and `CommentSort` so dynamic/video comment controllers share the same paging contract
  without generated wrapper methods.
- Favorites folder detail state is owned by `favorites_view_model.folder_resources.dart`.
  Do not restore `favorites_view_model.freezed.dart` for the small folder-detail state
  shell; keep `FavFolderDetailState` as a hand-written immutable value beside
  `FavFolderResources` so folder info and resource paging remain controller-owned.
  The state stays explicit with constructor updates only; do not restore a one-use
  `copyWith` helper or nullable copy sentinel.
  Keep the initial folder-resource request and telemetry inline in
  `FavFolderResources.build`; do not restore a one-call `_fetchItems` helper that only
  wraps `getFolderResources`, request timing, and `dataOrNull`.
- Notification chat state is owned by `chat_view_model.dart`. Do not restore
  `chat_view_model.freezed.dart` for the two-field chat state shell; keep `ChatState` as
  a hand-written immutable value beside `Chat` so local sync, pagination, emoji map, and
  send-error behavior remain notifier-owned. `emojiMap` equality uses Flutter
  `mapEquals`, and hashCode uses `collection`'s shallow `MapEquality`; do not restore
  a local `_mapHash` helper.
- Notification feed entries are owned by `notification_entry.dart`. Do not restore
  `notification_entry.freezed.dart` or `notification_entry.g.dart`; keep
  `NotificationActor`, `NotificationEntryDetail`, and `NotificationEntry` as
  hand-written immutable values preserving `mid_link` JSON parsing, `NotificationActor`
  JSON output, actor/detail list equality, and `primaryActor`/`eventTime` behavior. Their unused
  `copyWith` helpers are archived.
- Dynamic content view models must not depend on `dynamic_content_entities.freezed.dart`.
  Keep `DynamicVideoContent`, `DynamicLinkCard`, `DynamicAdditional`, and
  `DynamicGoodsItem` as hand-written immutable value objects in
  `dynamic_content_entities.dart`, preserving nullable clearing, value equality, and
  read-only `goodsItems` semantics without generated wrappers. `DynamicAdditional`
  goods-list equality uses Flutter's canonical shallow `listEquals`; do not restore a
  file-local nullable `_listEquals` clone for this entity list. Do not restore unused
  `copyWith` helpers while no active dynamic content flow mutates these values.
- Profile user state must not depend on `profile_user.freezed.dart`. Keep
  `ProfileUser` as a hand-written immutable domain value in `profile_user.dart`,
  preserving defaults, nullable clearing, value equality, diagnostics, and the profile
  follow-toggle `copyWith` surface without a generated wrapper.

## Dependency Rules

- Prefer current Flutter, Riverpod, go_router, Dio/Retrofit, Drift, Freezed, and Slang
  ecosystem conventions already present in the app.
- Do not introduce new dependencies unless they remove real code and are popular,
  actively maintained, and used in the same phase.
- Upgrade existing dependencies in focused batches with analyzer/build verification.
- Remove unused direct dependencies after import and lockfile verification.
- Do not keep platform-interface packages as direct dev dependencies when the app has no
  direct imports and the runtime package already supplies them transitively.

## Performance Rules

- Synchronous startup work before first frame must stay minimal.
- Runtime initializers own deferred media, cache, performance, and lifecycle work.
- Hot list pages must avoid broad provider watches; use smaller providers or `select`
  where it reduces rebuilds.
- Feature-specific image prefetch tuning belongs with the owning feature UI. Keep scan
  limits, prefetch limits, and logical image sizes private to the owning widget/section
  instead of repeating raw dimensions or `NetworkImagePrefetchSpec` mapping in hot list
  builds.
- Hook-local image prefetch budget calculations stay inside the hook when no caller
  shares the budget object or policy resolver.
- When a prefetch tuning file only forwards constants to one widget or section, fold the
  constants into that owner instead of preserving a facade.
- Repositories do not keep extra in-memory caches unless they have a clear lifecycle owner
  and measurable value.
- JSON parsing or heavy transformations on hot paths should use existing isolate helpers
  or be moved off the UI frame path.
- `jsonDecodeCompute` keeps the isolate threshold and uses the SDK `jsonDecode` callback
  directly; do not restore a one-line `_parseAndDecode` wrapper around `jsonDecode`.
- Large player/live resources must be disposed by one owner and not mirrored through
  unrelated global state.
- Feature pagination defaults that affect request size, cache keys, and has-more
  decisions must have one owner. Profile space video paging uses
  `profileUserSpaceVideoPageSize`; do not repeat the same literal in API defaults,
  DTO fallbacks, or state notifiers.

## Archive Rules

- Old architecture decisions are documented under `archive/architecture/`.
- Replaced files are deleted from active code. Do not keep old and new implementations
  side by side.
- "Maybe later" extension points, empty wrappers, and unused facades are deleted, not
  parked.
- Architecture guards must cover archived source files and generated artifact filenames,
  not only handwritten Dart symbols. Freezed/Retrofit generated files for archived DTOs,
  route wrappers, ports, and one-use mappers must fail the guard if they reappear.
- Guard paths must track the active directory layout. Checks for model shells, generated
  files, and shared widget wrappers must point at `core/models`, feature `models`, and
  `ui/widgets`; old `core/contracts`, `domain/entities`, and `ui/assemblies` paths stay
  archived and must not be the only guard coverage.
- `docs/architecture/app_architecture_refactor_specs.md` and
  `docs/architecture/app_architecture_refactor_plan.md` are the active architecture
  document sources of truth. Coarse legacy root-level drafts such as
  `docs/architecture-spec.md` and `docs/refactoring-plan.md` stay archived under
  `archive/architecture` and must fail the architecture guard if restored.
- Two-field event/state wrappers without validation or business behavior are replaced by
  records or owner-local state. Home tab sync is hook-owned by `use_home_scroll_sync.dart`;
  keep the private sync-token/tab-index record and provider there, and do not restore
  `home_tab_sync_controller.dart`, `HomeTabSyncState`, `HomeTabSyncController`, or
  `homeTabSyncControllerProvider`.
- Thin repository facades that only forward to a database owner are deleted. Profile
  cache storage is archived entirely until a current reader/writer exists; logout cleanup
  uses the default no-op `SessionLogoutCleaner`, not a profile-specific empty adapter or
  `ProfileCacheRepositoryImpl` wrapper.
- One-owner repository part files are folded back into the repository when they only host
  private parser or helper methods. `ProfileRepositoryImpl` owns its profile/user-card
  parser helpers directly; do not restore `profile_repository_impl.parsers.dart`.
- One-line API default constants files are folded into the owning API when no other
  component uses the value. `SearchApi` owns its result page-size default privately; do
  not restore `search_paging_constants.dart`.
- Search application providers share cache-presence key construction through a single
  file-private helper. Do not restore per-provider `_hasCachedValue` methods that repeat
  the same `api_cache_` prefix rule.
- Settings one-page command notifiers are archived when their only behavior is an empty
  `build()` plus forwarding one repository command. Keep page-local pending state beside
  the only UI affordance, and keep reusable read models private to the owning page when
  only that page consumes them.
- Cross-feature service port interfaces are archived when the concrete service is already
  the runtime boundary and no alternate implementation or test seam consumes the
  interface. Relation callers read `relationServiceProvider` directly; do not restore
  `RelationPort`, `relation_port.dart`, or `relationPortProvider`.
- Network policy values are hand-owned by the network core. `EndpointPolicy` keeps
  request class, cache TTL, retry, deduplication, and prefetch decisions in
  `endpoint_policy.dart`; do not restore `endpoint_policy.freezed.dart` for this
  single network value object. `retryableStatuses` equality uses Flutter's canonical
  shallow `setEquals`; do not restore a file-local `_setEquals` clone for the
  status-set comparison.
- Notification private-message DTO content equality uses the shared
  `DeepCollectionEquality` from `collection`; do not restore DTO-local recursive
  `_contentEquals` or `_contentHash` helpers in `private_message_model.dart`.
- Live gold-rank models are hand-owned by the live domain model layer.
  `LiveGoldRankModel`, `LiveRankItem`, and `LiveRankMedalInfo` stay in
  `live_gold_rank_model.dart`; do not restore their generated Freezed/JSON shells or
  unused copy/serialization methods.
- Dynamic feed core response models are hand-owned by the dynamic application model
  layer. `DynamicData`, `DynamicItem`, `DynamicBasic`, `DynamicModules`,
  `ModuleAuthor`, and `ModuleDynamic` keep their JSON parsing, nullable field
  semantics, list equality, and diagnostics in `dynamic_response.core.dart`; do not
  restore Freezed declarations, generated core copy-with/private implementation
  classes, or unused hand-written `copyWith` helpers for `DynamicData`,
  `DynamicBasic`, `ModuleAuthor`, or `ModuleDynamic`, and do not restore unused
  core `toJson` helpers. Dynamic response list equality uses Flutter's canonical
  shallow `listEquals` across the part library; do not restore file-local
  `_listEquals` or `_nullableListEquals` clones in the dynamic response parts.
  Keep the live `DynamicItem.copyWith` and
  `DynamicModules.copyWith` path for dynamic like updates.
- Dynamic feed additional response models are also hand-owned by the dynamic application
  model layer. `ModuleAdditional`, `AdditionalCommon`, `AdditionalReserve`,
  `ReserveDesc`, `AdditionalGoods`, `GoodsItem`, `AdditionalVote`, and `AdditionalUgc`
  keep their JSON wire keys, nullable fields, goods list equality, and parsing in
  `dynamic_response.additional.dart`; do not restore Freezed declarations, generated
  additional copy-with/private implementation classes, or unused hand-written
  additional `copyWith`/`toJson` helpers.
- Dynamic feed major secondary response models are hand-owned by the dynamic
  application model layer. `MajorPgc`, `MajorCourses`, `MajorMusic`, `MajorOpus`,
  `OpusSummary`, `OpusPic`, `MajorLive`, and `MajorLiveRcmd` keep their PGC/course/
  music/opus/live wire keys, nullable list/list equality semantics, and parsing
  in `dynamic_response.major_secondary.dart`; do not restore Freezed declarations,
  generated major-secondary copy-with/private implementation classes, or unused
  hand-written major-secondary `copyWith`/`toJson` helpers.
- Dynamic feed major primary response models are hand-owned by the dynamic application
  model layer. `ModuleDesc`, `ModuleMajor`, `MajorArchive`, `MajorDraw`, `DrawItem`,
  `MajorArticle`, `MajorCommon`, `MajorStat`, `ModuleStat`, `StatLike`, `StatCommon`,
  and `ModuleTopic` keep their desc/major/stat/topic wire keys, nested branch parsing,
  nullable branch semantics, list equality, and parsing in
  `dynamic_response.major_primary.dart`. Unused hand-written primary `copyWith` helpers
  stay archived for `ModuleDesc`, `ModuleMajor`, `MajorArchive`, `MajorDraw`,
  `DrawItem`, `MajorArticle`, `MajorCommon`, `MajorStat`, `StatCommon`, and
  `ModuleTopic`; unused primary `toJson` helpers stay archived for all primary read
  models; only the live dynamic like update path keeps `ModuleStat.copyWith` and
  `StatLike.copyWith`. The whole `dynamic_response` model family must stay free of
  `freezed_annotation`, `dynamic_response.freezed.dart`, and `dynamic_response.g.dart`.
- Low-risk nested comment content/media values are hand-owned inside
  `comment_contract.types.dart` while the higher-risk main comment contract remains
  generated. `CommentLabel`, `CommentContent`, `CommentPicture`, and `CommentEmote`
  keep their Bilibili wire keys, default values, nullable `emote` parsing, list/map
  immutability and equality, diagnostics, and JSON parsing without unused `copyWith` or
  `toJson` helpers. Do not restore generated private implementations, pattern helpers,
  copy-with shells, or JSON helper functions in `comment_contract.freezed.dart` /
  `comment_contract.g.dart`.
- Article inline text nodes are hand-owned as the first low/medium-risk article-detail
  leaf extraction. `ArticleInlineNode` keeps text/link/color/font-size/bold/italic
  semantics and nullable clearing in `article_detail_data.dart`; do not restore its
  generated private implementation, pattern helper, or copy-with shell in
  `article_detail_data.freezed.dart` while the higher-risk article detail/block shells
  remain generated.
- Article block render units are hand-owned in `article_detail_data.dart`.
  `ArticleBlockParagraph`, `ArticleBlockImage`, `ArticleBlockLinkCard`,
  `ArticleBlockQuote`, and `ArticleBlockDivider` keep the existing
  `ArticleBlock.paragraph/image/linkCard/quote/divider` factories, Dart pattern matching
  subtype names, nullable fields, list immutability/equality, and diagnostics without
  unused block-level `copyWith` helpers. Do not restore generated block variants, pattern
  helpers, or copy-with shells in `article_detail_data.freezed.dart`; only the
  higher-risk article detail/stat shells may remain generated. `ArticleInlineNode` keeps
  its hand-written `copyWith` because the HTML tokenizer still layers inline styles with
  it.
- Article detail block render helpers are archived when they only wrap one article
  block variant. Keep image, link-card, and quote rendering inline in the
  article-detail scaffold renderer; do not restore
  `article_detail_page_block_renderers.cards.dart`, `_ImageBlockView`,
  `_LinkCardView`, or `_QuoteBlockView`.
- Article detail parsing must use shared JSON scalar utilities for integer coercion.
  Do not restore the local `_int` helper under `lib/features/dynamic/data/article_parsing`;
  parser code should call `JsonUtils.parseInt` directly. Keep `_asMap` local until a
  dedicated HIGH-risk article parsing map-shape slice is planned and verified. Keep
  Opus inline `font_size` double coercion beside `_parseOpusInlineNodes`; do not restore
  a one-use `_double` helper. Keep `extractInitialState` JSON decode/type normalization
  inline in `ArticleDetailParser`; do not restore a one-use `_parseInitialState` helper.
- Generated build output and machine-local platform artifacts are removed from git history
  going forward. They may exist locally, but they must remain ignored and untracked.

## Verification Gates

Run these before claiming a phase is complete:

```bash
bash tool/architecture/run_architecture_guards.sh
dart format <changed dart files>
flutter analyze --no-fatal-infos
git diff --check
```

Before committing, run:

```bash
gitnexus detect_changes
```

For any Dart symbol edit, first run GitNexus impact analysis on that symbol and report
direct callers, affected processes, and risk level. Warn before editing if the risk is
HIGH or CRITICAL.
