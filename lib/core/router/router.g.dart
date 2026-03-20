// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $mainShellRoute,
  $notificationRoute,
  $weeklyRoute,
  $videoDetailRoute,
  $liveRoomRoute,
  $commentReplyRoute,
  $searchRoute,
  $favoritesRoute,
  $followingsRoute,
  $followersRoute,
  $userProfileRoute,
  $loginRoute,
  $settingsRoute,
  $toViewRoute,
  $historyRoute,
  $scannerRoute,
  $dynamicDetailRoute,
  $publishDynamicRoute,
];

RouteBase get $mainShellRoute => StatefulShellRouteData.$route(
  factory: $MainShellRouteExtension._fromState,
  branches: [
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(path: '/home', factory: $HomeRoute._fromState),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(path: '/dynamic', factory: $DynamicRoute._fromState),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(path: '/ranking', factory: $RankingRoute._fromState),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(path: '/profile', factory: $ProfileRoute._fromState),
      ],
    ),
  ],
);

extension $MainShellRouteExtension on MainShellRoute {
  static MainShellRoute _fromState(GoRouterState state) =>
      const MainShellRoute();
}

mixin $HomeRoute on GoRouteData {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  @override
  String get location => GoRouteData.$location('/home');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $DynamicRoute on GoRouteData {
  static DynamicRoute _fromState(GoRouterState state) => const DynamicRoute();

  @override
  String get location => GoRouteData.$location('/dynamic');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $RankingRoute on GoRouteData {
  static RankingRoute _fromState(GoRouterState state) => const RankingRoute();

  @override
  String get location => GoRouteData.$location('/ranking');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ProfileRoute on GoRouteData {
  static ProfileRoute _fromState(GoRouterState state) => const ProfileRoute();

  @override
  String get location => GoRouteData.$location('/profile');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $notificationRoute => GoRouteData.$route(
  path: '/notification',
  factory: $NotificationRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: 'reply',
      factory: $ReplyNotificationRoute._fromState,
    ),
    GoRouteData.$route(path: 'at', factory: $AtNotificationRoute._fromState),
    GoRouteData.$route(
      path: 'like',
      factory: $LikeNotificationRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'system',
      factory: $SystemNotificationRoute._fromState,
    ),
    GoRouteData.$route(path: 'chat/:talkerId', factory: $ChatRoute._fromState),
  ],
);

mixin $NotificationRoute on GoRouteData {
  static NotificationRoute _fromState(GoRouterState state) =>
      const NotificationRoute();

  @override
  String get location => GoRouteData.$location('/notification');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ReplyNotificationRoute on GoRouteData {
  static ReplyNotificationRoute _fromState(GoRouterState state) =>
      const ReplyNotificationRoute();

  @override
  String get location => GoRouteData.$location('/notification/reply');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AtNotificationRoute on GoRouteData {
  static AtNotificationRoute _fromState(GoRouterState state) =>
      const AtNotificationRoute();

  @override
  String get location => GoRouteData.$location('/notification/at');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $LikeNotificationRoute on GoRouteData {
  static LikeNotificationRoute _fromState(GoRouterState state) =>
      const LikeNotificationRoute();

  @override
  String get location => GoRouteData.$location('/notification/like');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $SystemNotificationRoute on GoRouteData {
  static SystemNotificationRoute _fromState(GoRouterState state) =>
      const SystemNotificationRoute();

  @override
  String get location => GoRouteData.$location('/notification/system');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ChatRoute on GoRouteData {
  static ChatRoute _fromState(GoRouterState state) => ChatRoute(
    talkerId: int.parse(state.pathParameters['talkerId']!),
    name: state.uri.queryParameters['name'],
    sessionType: _$convertMapValue(
      'session-type',
      state.uri.queryParameters,
      int.tryParse,
    ),
    avatarUrl: state.uri.queryParameters['avatar-url'],
  );

  ChatRoute get _self => this as ChatRoute;

  @override
  String get location => GoRouteData.$location(
    '/notification/chat/${Uri.encodeComponent(_self.talkerId.toString())}',
    queryParams: {
      if (_self.name != null) 'name': _self.name,
      if (_self.sessionType != null)
        'session-type': _self.sessionType!.toString(),
      if (_self.avatarUrl != null) 'avatar-url': _self.avatarUrl,
    },
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

T? _$convertMapValue<T>(
  String key,
  Map<String, String> map,
  T? Function(String) converter,
) {
  final value = map[key];
  return value == null ? null : converter(value);
}

RouteBase get $weeklyRoute =>
    GoRouteData.$route(path: '/weekly', factory: $WeeklyRoute._fromState);

mixin $WeeklyRoute on GoRouteData {
  static WeeklyRoute _fromState(GoRouterState state) => const WeeklyRoute();

  @override
  String get location => GoRouteData.$location('/weekly');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $videoDetailRoute => GoRouteData.$route(
  path: '/video/:bvid',
  factory: $VideoDetailRoute._fromState,
);

mixin $VideoDetailRoute on GoRouteData {
  static VideoDetailRoute _fromState(GoRouterState state) =>
      VideoDetailRoute(bvid: state.pathParameters['bvid']!);

  VideoDetailRoute get _self => this as VideoDetailRoute;

  @override
  String get location =>
      GoRouteData.$location('/video/${Uri.encodeComponent(_self.bvid)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $liveRoomRoute => GoRouteData.$route(
  path: '/live/:roomId',
  factory: $LiveRoomRoute._fromState,
);

mixin $LiveRoomRoute on GoRouteData {
  static LiveRoomRoute _fromState(GoRouterState state) =>
      LiveRoomRoute(roomId: int.parse(state.pathParameters['roomId']!));

  LiveRoomRoute get _self => this as LiveRoomRoute;

  @override
  String get location => GoRouteData.$location(
    '/live/${Uri.encodeComponent(_self.roomId.toString())}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $commentReplyRoute => GoRouteData.$route(
  path: '/comment/reply',
  factory: $CommentReplyRoute._fromState,
);

mixin $CommentReplyRoute on GoRouteData {
  static CommentReplyRoute _fromState(GoRouterState state) => CommentReplyRoute(
    bvid: state.uri.queryParameters['bvid']!,
    oid: int.parse(state.uri.queryParameters['oid']!),
    rootId: int.parse(state.uri.queryParameters['root-id']!),
    $extra: state.extra as dynamic,
  );

  CommentReplyRoute get _self => this as CommentReplyRoute;

  @override
  String get location => GoRouteData.$location(
    '/comment/reply',
    queryParams: {
      'bvid': _self.bvid,
      'oid': _self.oid.toString(),
      'root-id': _self.rootId.toString(),
    },
  );

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $searchRoute =>
    GoRouteData.$route(path: '/search', factory: $SearchRoute._fromState);

mixin $SearchRoute on GoRouteData {
  static SearchRoute _fromState(GoRouterState state) => const SearchRoute();

  @override
  String get location => GoRouteData.$location('/search');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $favoritesRoute => GoRouteData.$route(
  path: '/favorites',
  factory: $FavoritesRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: 'detail/:mediaId',
      factory: $FavoriteDetailRoute._fromState,
    ),
  ],
);

mixin $FavoritesRoute on GoRouteData {
  static FavoritesRoute _fromState(GoRouterState state) =>
      const FavoritesRoute();

  @override
  String get location => GoRouteData.$location('/favorites');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $FavoriteDetailRoute on GoRouteData {
  static FavoriteDetailRoute _fromState(GoRouterState state) =>
      FavoriteDetailRoute(
        mediaId: int.parse(state.pathParameters['mediaId']!),
        title: state.uri.queryParameters['title']!,
        mid: int.parse(state.uri.queryParameters['mid']!),
      );

  FavoriteDetailRoute get _self => this as FavoriteDetailRoute;

  @override
  String get location => GoRouteData.$location(
    '/favorites/detail/${Uri.encodeComponent(_self.mediaId.toString())}',
    queryParams: {'title': _self.title, 'mid': _self.mid.toString()},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $followingsRoute => GoRouteData.$route(
  path: '/followings/:vmid',
  factory: $FollowingsRoute._fromState,
);

mixin $FollowingsRoute on GoRouteData {
  static FollowingsRoute _fromState(GoRouterState state) =>
      FollowingsRoute(vmid: int.parse(state.pathParameters['vmid']!));

  FollowingsRoute get _self => this as FollowingsRoute;

  @override
  String get location => GoRouteData.$location(
    '/followings/${Uri.encodeComponent(_self.vmid.toString())}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $followersRoute => GoRouteData.$route(
  path: '/followers/:vmid',
  factory: $FollowersRoute._fromState,
);

mixin $FollowersRoute on GoRouteData {
  static FollowersRoute _fromState(GoRouterState state) =>
      FollowersRoute(vmid: int.parse(state.pathParameters['vmid']!));

  FollowersRoute get _self => this as FollowersRoute;

  @override
  String get location => GoRouteData.$location(
    '/followers/${Uri.encodeComponent(_self.vmid.toString())}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $userProfileRoute => GoRouteData.$route(
  path: '/user/:mid',
  factory: $UserProfileRoute._fromState,
);

mixin $UserProfileRoute on GoRouteData {
  static UserProfileRoute _fromState(GoRouterState state) =>
      UserProfileRoute(mid: int.parse(state.pathParameters['mid']!));

  UserProfileRoute get _self => this as UserProfileRoute;

  @override
  String get location => GoRouteData.$location(
    '/user/${Uri.encodeComponent(_self.mid.toString())}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $loginRoute =>
    GoRouteData.$route(path: '/login', factory: $LoginRoute._fromState);

mixin $LoginRoute on GoRouteData {
  static LoginRoute _fromState(GoRouterState state) => const LoginRoute();

  @override
  String get location => GoRouteData.$location('/login');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $settingsRoute =>
    GoRouteData.$route(path: '/settings', factory: $SettingsRoute._fromState);

mixin $SettingsRoute on GoRouteData {
  static SettingsRoute _fromState(GoRouterState state) => const SettingsRoute();

  @override
  String get location => GoRouteData.$location('/settings');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $toViewRoute =>
    GoRouteData.$route(path: '/to_view', factory: $ToViewRoute._fromState);

mixin $ToViewRoute on GoRouteData {
  static ToViewRoute _fromState(GoRouterState state) => const ToViewRoute();

  @override
  String get location => GoRouteData.$location('/to_view');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $historyRoute =>
    GoRouteData.$route(path: '/history', factory: $HistoryRoute._fromState);

mixin $HistoryRoute on GoRouteData {
  static HistoryRoute _fromState(GoRouterState state) => const HistoryRoute();

  @override
  String get location => GoRouteData.$location('/history');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $scannerRoute =>
    GoRouteData.$route(path: '/scan', factory: $ScannerRoute._fromState);

mixin $ScannerRoute on GoRouteData {
  static ScannerRoute _fromState(GoRouterState state) => const ScannerRoute();

  @override
  String get location => GoRouteData.$location('/scan');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $dynamicDetailRoute => GoRouteData.$route(
  path: '/dynamic/detail/:id',
  factory: $DynamicDetailRoute._fromState,
);

mixin $DynamicDetailRoute on GoRouteData {
  static DynamicDetailRoute _fromState(GoRouterState state) =>
      DynamicDetailRoute(id: state.pathParameters['id']!);

  DynamicDetailRoute get _self => this as DynamicDetailRoute;

  @override
  String get location =>
      GoRouteData.$location('/dynamic/detail/${Uri.encodeComponent(_self.id)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $publishDynamicRoute => GoRouteData.$route(
  path: '/dynamic/publish',
  factory: $PublishDynamicRoute._fromState,
);

mixin $PublishDynamicRoute on GoRouteData {
  static PublishDynamicRoute _fromState(GoRouterState state) =>
      const PublishDynamicRoute();

  @override
  String get location => GoRouteData.$location('/dynamic/publish');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(router)
final routerProvider = RouterProvider._();

final class RouterProvider
    extends $FunctionalProvider<GoRouter, GoRouter, GoRouter>
    with $Provider<GoRouter> {
  RouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routerHash();

  @$internal
  @override
  $ProviderElement<GoRouter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GoRouter create(Ref ref) {
    return router(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoRouter>(value),
    );
  }
}

String _$routerHash() => r'3400b076782310af571e5099e1dde97e4a551d7b';
