---
name: seznam-assignment-review
description: Use this skill when reviewing, planning, or preparing final submission for the Seznam Flutter Developer Studio Ghibli interview assignment. Checks mandatory requirements, Flutter architecture, Riverpod, Freezed/json_serializable, persistence, generated files, README accuracy, and submission readiness.
---

# Seznam Assignment Review Skill

Use this skill for the Studio Ghibli Flutter interview assignment.

Read these files first:

- `AGENTS.md`
- `.agents/context/assignment.md`
- `.agents/context/api.md`
- `.agents/context/architecture.md`
- `.agents/context/verification.md`
- `.agents/context/readme-requirements.md`
- `README.md`
- `pubspec.yaml`
- relevant files under `lib/`
- relevant tests under `test/`

## Review scope

Check the implementation against the mandatory requirements in `.agents/context/assignment.md`, especially:

- movie gallery screen in streaming-service-like style,
- film detail screen,
- favorite toggle,
- 1-5 star rating,
- persistent favorites and ratings,
- favorites screen,
- rating filter on favorites screen,
- all film parameters visible in detail,
- mapped people, species, locations, vehicles,
- no existing Studio Ghibli Dart API client,
- README with accurate setup, run, codegen, and test instructions.

## Technical review

Check the technical expectations from `.agents/context/api.md`, `.agents/context/architecture.md`, and `.agents/context/verification.md`, especially:

- Riverpod usage,
- separation of API DTOs, domain models, and UI models,
- Freezed/json_serializable usage,
- generated files,
- API error handling,
- partial failure handling for referenced resources,
- local persistence by film ID,
- Flutter rebuild/performance risks,
- loading, error, and empty states,
- test coverage,
- dependency justification,
- GitHub Actions if present.

## Output format

Return:

1. Critical issues blocking submission
2. Important issues to fix
3. Nice-to-have improvements
4. Requirement checklist table
5. README mismatches
6. Suggested next commit
7. Readiness score from 1 to 10

Do not edit files unless explicitly asked.

When asked to fix something, keep the fix small and focused.
