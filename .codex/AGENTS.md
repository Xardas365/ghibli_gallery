# Codex Project Guide

This file is a compact navigation guide for Codex in this repository. The root `AGENTS.md` is the main project-level instruction file.

## First Read

For any task, start with:

- `AGENTS.md`

Then read only the context files relevant to the request:

- `.agents/context/assignment.md` for assignment requirements and UX acceptance criteria.
- `.agents/context/api.md` for API endpoint rules, reference resolution, parsing, and API error handling.
- `.agents/context/architecture.md` for dependencies, Riverpod, Freezed/json_serializable, folders, data modeling, and persistence.
- `.agents/context/verification.md` for code generation, format, analyze, tests, CI, and final checklist.
- `.agents/context/readme-requirements.md` for README content expectations.

## Operating Rules

- Keep the assignment small, clear, and reviewable.
- Mandatory requirements come before bonus features.
- Prefer existing project patterns over introducing new architecture.
- Use Riverpod as the single state-management approach.
- Keep dependencies minimal and justified.
- Use Freezed/json_serializable where they improve correctness and readability.
- Do not use an existing Dart client for the Studio Ghibli API.
- Do not edit generated files manually.
- Do not silently skip assignment requirements.

## Workflow

For non-trivial changes:

1. Inspect relevant files.
2. State a short implementation plan when useful.
3. Implement in small focused steps.
4. Run the relevant checks from `.agents/context/verification.md`.
5. Summarize changed files and checks.

For documentation-only or agent-instruction-only changes, Flutter checks are usually unnecessary. Explain any skipped checks in the final response.

