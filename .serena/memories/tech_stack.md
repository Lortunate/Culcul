# Tech Stack

- Dart SDK constraint: `^3.10.7`. Flutter app with platform folders for Android/iOS/Linux/macOS/Windows.
- State: Riverpod 3 / hooks_riverpod with generated `@riverpod` providers; mutable/async state uses generated `Notifier`/`AsyncNotifier` patterns.
- Routing: `go_router` + `go_router_builder`; router source of truth is typed route data under `lib/app/router` plus feature `route_entry.dart` files. Generated route output includes `app_routes.g.dart` and may be absent in fresh checkout.
- Data/network: Dio, Retrofit, dio cache/cookie/retry/http2 packages. Architecture source of truth is `RequestExecutor` + `AppError` + `Result`; feature repositories should not duplicate generic Dio error mapping.
- Persistence/bootstrap: `shared_preferences`, path_provider directories, `cookie_jar`/`PersistCookieJar`, `dio_cache_interceptor_file_store`; Drift/sqlite used for local database work.
- Models/codegen: Freezed, json_serializable, Retrofit generator, Riverpod generator, slang, Drift dev. Generated `*.g.dart`, `*.freezed.dart`, protobuf outputs, and localization output are excluded from analyzer and are generated source, not hand-copied model layers.
- UI/media: extended_image, easy_refresh, media_kit, audio_service, QR/share/url/image/gal utilities, local app theme under `lib/ui/theme`.
- GitNexus indexed repo name: `Culcul` with a large Dart symbol graph; use GitNexus before edits per project instructions.