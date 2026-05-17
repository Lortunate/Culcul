# Phase 22 Cache Policy

## Cache Taxonomy

- HTTP cache: transport-level cache for public and safe reads. TTL stays short and is selected by endpoint policy.
- Domain cache: structured Drift storage for feature data that can be read warm and, when a feature opts in, read stale.
- Sensitive cache: session-bound data. Logout or account switch must clear it or keep it namespaced by user identity.

## First Durable Migration

Profile user info moved from `SharedPreferences` JSON blobs to the feature-owned `ProfileCacheDatabase`.

- Table: `cached_profile_users`.
- Default TTL: 30 minutes.
- Normal reads reject expired rows.
- Explicit stale reads are available through `allowStale`.
- Session invalidation clears all profile cache rows.
