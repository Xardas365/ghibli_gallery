# Repository Agent Guide

## Purpose

This is a small Flutter interview assignment for Seznam. The app should be a Studio Ghibli movie gallery with clean Dart code, clear architecture, REST API handling, local user data, and a readable mobile UX.

Keep the project small and reviewable. Prefer a well-finished assignment over an enterprise-style template.

## Priority

Implement mandatory requirements before bonus features:

- streaming-service-like film gallery,
- film detail screen,
- favorite toggle,
- 1-5 star rating,
- locally persisted favorites and ratings,
- favorites screen with rating filter,
- all film parameters visible in detail,
- resolved people, species, locations, and vehicles in detail,
- no existing Dart client for the Studio Ghibli API.

Bonus work such as animations, logging interceptors, CI, extra polish, and broader tests is allowed only after the mandatory requirements are covered.

## Project Context

Read only the context needed for the task:

- `.agents/context/assignment.md` for requirements and acceptance criteria.
- `.agents/context/api.md` for Studio Ghibli API rules and edge cases.
- `.agents/context/architecture.md` for preferred Flutter, Riverpod, model, and persistence patterns.
- `.agents/context/verification.md` for code generation and checks.
- `.agents/context/readme-requirements.md` for README expectations.

## Implementation Rules

- Use Riverpod as the state-management approach.
- Keep dependencies minimal and justified.
- Use Freezed and json_serializable where they reduce meaningful boilerplate.
- Do not edit generated files manually.
- Separate API DTOs from domain/UI models when it improves clarity.
- Persist favorites and ratings by film ID.
- Handle loading, empty, error, retry, and partial-reference-failure states gracefully.
- Keep UI components focused and avoid unnecessary rebuilds.

## Verification

For code changes, run the relevant checks before finishing. If model files, generated annotations, or JSON mapping changed, run code generation before format/analyze/test:

```bash
dart run build_runner build
```

```bash
dart format .
flutter analyze
flutter test
```

For documentation-only or agent-instruction-only changes, full Flutter checks are usually not required. If a relevant check is skipped, explain why.
