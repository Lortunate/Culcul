# Culcul Design Philosophy

## Core Intent
- Optimize for long-term maintainability: lower complexity, lower coupling, and consistent engineering rules.
- Prefer direct, clean architecture over compatibility layers for legacy patterns.
- Refactoring decisions should solve real maintenance and product-delivery problems, not pursue abstract architectural purity.

## Architectural Direction
- Use a feature-first modular structure with clear boundaries between `presentation`, `domain`, and `data`.
- Keep `core` focused on stable cross-feature capabilities, not feature business logic.
- Let each feature own its state, data mapping, and dependency wiring.

## Layer Responsibilities
- Presentation:
  - Owns UI rendering, user interaction handling, and state consumption.
  - Must not depend directly on data implementation details.
- Domain:
  - Defines business entities and repository contracts.
  - Must stay independent from transport, serialization, and UI concerns.
- Data:
  - Implements API clients, DTOs, mappers, and repository implementations.
  - Exposes domain/contract outputs, not transport internals.
- Application/Workflow:
  - Exists only for meaningful orchestration across multiple steps.
  - Pure pass-through logic should be removed, not abstracted.

## API Design Principles
- Remote repository APIs should be explicit and consistent, using typed success/failure outcomes.
- Local persistence APIs may remain simple when no cross-boundary failure semantics are needed.
- Favor semantic parameters and value types over magic numbers and transport-centric flags.
- Remove one-off wrappers and redundant indirection that do not add business meaning.

## Error Handling Philosophy
- Use one unified error model and one predictable result flow.
- Map low-level failures in repository/data boundaries, not in UI code.
- UI state should be driven by typed outcomes, not by exception-throwing control flow.

## Shared Contracts and Boundaries
- Cross-feature collaboration should rely on stable shared contracts, not direct coupling to another feature’s internal domain implementation.
- Shared contracts should remain pure structural models and avoid UI-formatting or protocol-specific behavior.

## Redundancy Elimination
- Continuously remove dead code, duplicate definitions, unused parameters, and obsolete exports.
- Enforce one clear implementation path per responsibility.
- Introduce abstractions only when they provide proven reuse and clear semantic value.