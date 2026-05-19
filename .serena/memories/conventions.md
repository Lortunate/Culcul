# Conventions

- Active architecture phase: Phase 37 Modern Architecture Consolidation. If docs conflict, use the newest active Phase 37 spec/plan and `docs/architecture/architecture-guide.md`.
- `core/` and `ui/` must not import `features/`.
- A feature must not import another feature's `data/**` or `presentation/**`; cross-feature access must be explicit and product-real, not hidden behind one-call adapters unless it removes a real cycle or enforces reusable policy.
- Feature public seams are narrow: router-facing seam is `route_entry.dart`; `<feature>.dart` is allowed only when it exports real feature API. Do not reintroduce `feature_scope.dart` without an approved runtime seam.
- Every shared model has one definition in `core/contracts/`; DTOs belong in `data/dtos/`; domain entities exist only when they carry business behavior.
- Generated code is authoritative for generated types. Do not copy generated types into handwritten layers.
- Riverpod source of truth is generated `@riverpod`; no new handwritten providers for Riverpod 3 work. Widgets call notifier methods and should not contain business logic.
- App notifications use `AppFeedback`; avoid raw `ScaffoldMessenger` paths for new work.
- `AppError` is the single app error hierarchy. Use `RequestExecutor`/`DioClient` for generic request execution/error policy; keep feature repositories focused on feature DTO/domain mapping.
- No runtime `UnimplementedError`/`TODO()` provider placeholders. No compatibility shims after callers move.
- No barrel chains or re-export-only files except approved public APIs: `core_contracts.dart` and `lib/ui/ui.dart`.
- Dependencies should be pinned, not `any`.
- Before editing any function/class/method, run GitNexus impact analysis upstream for the symbol and report blast radius. Stop before edits if impact is HIGH or CRITICAL.