# Phase 30 Application Seam Inventory

Generated from the current authored `lib/features/**/*.dart` source.

- Cross-feature `data/**` or `presentation/**` imports: 0.
- Cross-feature `domain/**` or `application/**` imports: 27.
- Cross-feature imports moved to feature public APIs: 3.
- `feature_scope.dart` files: 0.

Allowed categories:

- `approved-session-seam`
- `approved-search-seam`
- `approved-profile-seam`
- `move-to-core-contract`
- `move-to-ui`
- `new-feature-public-api`
- `remove-accidental-coupling`

| Importer | Target | Category | Decision |
|---|---|---|---|
| `lib/features/auth/presentation/view_models/auth_view_model.dart:7` | `lib/features/profile/application/profile_cache_actions.dart` | `approved-profile-seam` | Keep classified for the guard; profile cleanup ownership remains with the profile seam slice. |
| `lib/features/dynamic/presentation/pages/dynamic_page.dart:3` | `lib/features/auth/application/auth_session_providers.dart` | `approved-session-seam` | Keep classified for the guard; auth session state is the current cross-feature session seam. |
| `lib/features/dynamic/presentation/view_models/recently_followed_view_model.dart:3` | `lib/features/auth/application/auth_session_providers.dart` | `approved-session-seam` | Keep classified for the guard; auth session state is the current cross-feature session seam. |
| `lib/features/dynamic/presentation/widgets/topic_picker.dart:3` | `lib/features/search/application/search_application_providers.dart` | `approved-search-seam` | Keep classified for the guard; search query state is the current cross-feature search seam. |
| `lib/features/favorites/presentation/pages/favorite_detail_page.dart:5` | `lib/features/auth/application/auth_session_providers.dart` | `approved-session-seam` | Keep classified for the guard; auth session state is the current cross-feature session seam. |
| `lib/features/favorites/presentation/pages/favorites_page.dart:7` | `lib/features/auth/application/auth_session_providers.dart` | `approved-session-seam` | Keep classified for the guard; auth session state is the current cross-feature session seam. |
| `lib/features/favorites/presentation/view_models/favorites_view_model.dart:8` | `lib/features/auth/application/auth_session_providers.dart` | `approved-session-seam` | Keep classified for the guard; auth session state is the current cross-feature session seam. |
| `lib/features/history/presentation/pages/history_page.dart:3` | `lib/features/auth/application/auth_session_providers.dart` | `approved-session-seam` | Keep classified for the guard; auth session state is the current cross-feature session seam. |
| `lib/features/home/presentation/pages/home_page.dart:9` | `lib/features/search/application/search_application_providers.dart` | `approved-search-seam` | Keep classified for the guard; search query state is the current cross-feature search seam. |
| `lib/features/home/presentation/widgets/home_app_bar.dart:2` | `lib/features/auth/application/auth_session_providers.dart` | `approved-session-seam` | Keep classified for the guard; auth session state is the current cross-feature session seam. |
| `lib/features/live/application/live_room_page_commands.dart:1` | `lib/features/auth/application/auth_session_providers.dart` | `approved-session-seam` | Keep classified for the guard; auth session state is the current cross-feature session seam. |
| `lib/features/live/presentation/view_models/live_room_view_model.dart:15` | `lib/features/profile/application/profile_session_providers.dart` | `approved-profile-seam` | Keep classified for the guard; live anchor lookup uses the profile application seam instead of profile data. |
| `lib/features/live/presentation/widgets/live_header.dart:2` | `lib/features/auth/application/auth_session_providers.dart` | `approved-session-seam` | Keep classified for the guard; auth session state is the current cross-feature session seam. |
| `lib/features/notification/presentation/pages/chat_page.dart:2` | `lib/features/auth/application/auth_session_providers.dart` | `approved-session-seam` | Keep classified for the guard; auth session state is the current cross-feature session seam. |
| `lib/features/notification/presentation/pages/chat_page.dart:3` | `lib/features/profile/application/profile_session_providers.dart` | `approved-profile-seam` | Keep classified for the guard; profile session state is the current cross-feature profile seam. |
| `lib/features/notification/presentation/pages/notification_page.dart:4` | `lib/features/auth/application/auth_session_providers.dart` | `approved-session-seam` | Keep classified for the guard; auth session state is the current cross-feature session seam. |
| `lib/features/notification/presentation/view_models/notification_owner_uid_provider.dart:1` | `lib/features/auth/application/auth_session_providers.dart` | `approved-session-seam` | Keep classified for the guard; auth session state is the current cross-feature session seam. |
| `lib/features/notification/presentation/widgets/private_session_item.dart:5` | `lib/features/profile/application/profile_session_providers.dart` | `approved-profile-seam` | Keep classified for the guard; profile session state is the current cross-feature profile seam. |
| `lib/features/profile/presentation/pages/profile_page.dart:1` | `lib/features/auth/application/auth_session_providers.dart` | `approved-session-seam` | Keep classified for the guard; auth session state is the current cross-feature session seam. |
| `lib/features/profile/presentation/view_models/profile_view_model.dart:3` | `lib/features/auth/application/auth_session_providers.dart` | `approved-session-seam` | Keep classified for the guard; auth session state is the current cross-feature session seam. |
| `lib/features/profile/presentation/widgets/profile_app_bar.dart:3` | `lib/features/auth/application/auth_session_providers.dart` | `approved-session-seam` | Keep classified for the guard; auth session state is the current cross-feature session seam. |
| `lib/features/profile/presentation/widgets/relation_user_item.dart:3` | `lib/features/auth/application/auth_session_providers.dart` | `approved-session-seam` | Keep classified for the guard; auth session state is the current cross-feature session seam. |
| `lib/features/profile/presentation/widgets/user_profile_buttons.dart:2` | `lib/features/auth/application/auth_session_providers.dart` | `approved-session-seam` | Keep classified for the guard; auth session state is the current cross-feature session seam. |
| `lib/features/profile/presentation/widgets/user_profile_info.dart:2` | `lib/features/auth/application/auth_session_providers.dart` | `approved-session-seam` | Keep classified for the guard; auth session state is the current cross-feature session seam. |
| `lib/features/to_view/presentation/pages/to_view_page.dart:2` | `lib/features/auth/application/auth_session_providers.dart` | `approved-session-seam` | Keep classified for the guard; auth session state is the current cross-feature session seam. |
| `lib/features/to_view/presentation/view_models/to_view_view_model.dart:1` | `lib/features/auth/application/auth_session_providers.dart` | `approved-session-seam` | Keep classified for the guard; auth session state is the current cross-feature session seam. |
| `lib/features/video/presentation/detail/info/uploader_section.dart:2` | `lib/features/auth/application/auth_session_providers.dart` | `approved-session-seam` | Keep classified for the guard; auth session state is the current cross-feature session seam. |
