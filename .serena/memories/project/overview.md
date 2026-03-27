# Culcul project overview
- Purpose: a third-party Bilibili client built with Flutter.
- Stack: Flutter/Dart, Riverpod/hooks_riverpod, GoRouter, Dio/Retrofit, Freezed/json_serializable, Slang for i18n, EasyRefresh, extended_image, media_kit, url_launcher, share_plus.
- Structure: `lib/core` for shared infrastructure, `lib/data` for APIs/models/network, `lib/features/*` for feature modules and presentation/controllers, `lib/ui/widgets` for reusable widgets.
- Platform: Android/iOS are present; no desktop platform folders in the repo.
- Style: null-safe Dart, feature-oriented organization, Riverpod providers and GoRouter typed routes are used heavily, UI code favors small reusable widgets.