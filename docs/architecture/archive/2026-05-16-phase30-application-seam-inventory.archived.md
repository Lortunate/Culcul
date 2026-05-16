# Archived Phase 30 Application Seam Inventory

Archived on 2026-05-16 during Phase 32 planning.

The active guard fixture remains at
`docs/architecture/phase30-application-seam-inventory.md` until Phase 32 updates
`test/architecture/architecture_boundary_guard_test.dart` to read a non-phase
specific active inventory path.

Original document summary:

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

Original active path:

`docs/architecture/phase30-application-seam-inventory.md`

Reason it was not moved in this planning slice:

`test/architecture/architecture_boundary_guard_test.dart` hard-codes the Phase
30 inventory path. Moving the file without updating the guard would make the
architecture test fail. Phase 32 includes a dedicated implementation slice to
rename the active fixture and update the guard in one code change.
