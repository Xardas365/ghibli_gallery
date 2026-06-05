---
name: flutter-small-step
description: Use this skill when implementing one small approved step in the Seznam Flutter project. Keeps changes focused and runs relevant code generation, formatting, analysis, and tests when applicable.
---

# Flutter Small Step Skill

Use this skill to implement exactly one approved task.

Before editing:

- read `AGENTS.md`,
- read `README.md`,
- read the relevant files under `.agents/context/`,
- inspect only relevant files,
- identify the smallest safe change.

Rules:

- implement only the requested step,
- do not add unrelated features,
- do not add dependencies unless justified,
- do not edit generated files manually,
- keep widgets small,
- keep Riverpod state focused,
- keep DTO/domain/UI models separated.

After implementation, run the relevant checks for the kind of change. If model files, generated annotations, or JSON mapping changed, run code generation first:

```bash
dart run build_runner build --delete-conflicting-outputs
```

```bash
dart format .
flutter analyze
flutter test
```

For documentation-only or agent-instruction-only changes, full Flutter checks are usually not required. Explain skipped checks.
