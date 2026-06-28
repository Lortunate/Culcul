# Legacy Culcul Architecture Specification

Archived: 2026-06-05

This document was an early coarse architecture draft. The active single source
of truth is `docs/architecture/app_architecture_refactor_specs.md`.

## Original Content

## Overview

Culcul is a Bilibili third-party client built with Flutter. The architecture follows a feature-first approach with shared core modules.

## Directory Structure

```
lib/
├── main.dart
├── app/                          # App-level configuration
│   ├── app.dart                  # MaterialApp
│   ├── router/                   # Routing (GoRouter)
│   └── shell/                    # Navigation shell
│
├── core/                         # Shared modules
│   ├── api/                      # Network layer (Dio + Retrofit)
│   ├── models/                   # Shared data models (cross-feature)
│   ├── error/                    # Error handling
│   ├── result/                   # Result<T, E> type
│   ├── storage/                  # SharedPreferences wrapper
│   ├── utils/                    # Utility functions
│   ├── theme/                    # App theme (colors, tokens)
│   ├── widgets/                  # Shared UI components
│   ├── i18n/                     # Internationalization
│   └── protos/                   # Protobuf definitions
│
├── features/                     # Feature modules
│   ├── auth/                     # Authentication
│   ├── home/                     # Home feed
│   ├── video/                    # Video player & detail
│   ├── dynamic/                  # Dynamic/Posts
│   ├── live/                     # Live streaming
│   ├── notification/             # Notifications & Chat
│   ├── profile/                  # User profile
│   ├── search/                   # Search
│   ├── favorites/                # Favorites
│   ├── history/                  # Watch history
│   ├── ranking/                  # Rankings
│   ├── to_view/                  # Watch later
│   └── settings/                 # App settings
│
└── generated/                    # Generated code (build_runner)
```

## Feature Module Structure

Each feature follows a flat structure:

```
features/<name>/
├── <name>_api.dart              # Retrofit API definitions
├── <name>_repository.dart       # Data repository (interface + impl)
├── <name>_providers.dart        # Riverpod providers/controllers
├── <name>_models.dart           # Feature-specific models (optional)
└── presentation/                # UI layer
    ├── <name>_page.dart
    └── widgets/
```

## Key Patterns

### State Management
- **Riverpod** with `riverpod_annotation` for code generation
- Simple state: `@riverpod` functions
- Complex state: `@Riverpod` classes

### API Layer
- **Retrofit** for API definitions
- **Dio** as HTTP client
- **ApiResponse<T>** as standard response wrapper

### Data Models
- **Freezed** for complex models with JSON serialization
- Hand-written for simple models
- Cross-feature models in `core/models/`

### Navigation
- **GoRouter** with `go_router_builder` for type-safe routing

### Error Handling
- **Result<T, AppError>** for operation results
- **AppError** sealed class with typed variants

## Dependencies

### State Management
- `hooks_riverpod` + `riverpod_annotation` + `riverpod_generator`

### Networking
- `dio` + `retrofit` + `dio_smart_retry`
- `dio_cache_interceptor` + `dio_http2_adapter`

### Data
- `freezed` + `json_serializable`
- `shared_preferences`
- `drift` (SQLite)

### UI
- `flutter_hooks`
- `easy_refresh`
- `extended_image`
- `media_kit`

### Navigation
- `go_router` + `go_router_builder`
