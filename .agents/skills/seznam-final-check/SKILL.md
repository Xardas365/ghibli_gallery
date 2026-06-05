---
name: seznam-final-check
description: Use this skill before submitting the Seznam Flutter Developer Studio Ghibli assignment. Performs strict final readiness review without editing files.
---

# Seznam Final Check Skill

Use this skill before sending the GitHub repository.

Do not edit files.

Read:

- `AGENTS.md`
- `.agents/context/assignment.md`
- `.agents/context/api.md`
- `.agents/context/architecture.md`
- `.agents/context/verification.md`
- `.agents/context/readme-requirements.md`
- `README.md`
- `pubspec.yaml`

Check:

- mandatory assignment coverage,
- README accuracy,
- generated files,
- dependency justification,
- tests,
- formatting,
- Flutter analyze,
- GitHub Actions,
- no irrelevant TODOs,
- no AI leftovers,
- no secrets,
- no local machine paths.

For final code-submission validation, run or request these commands if possible:

```bash
dart run build_runner build --delete-conflicting-outputs
dart format --set-exit-if-changed .
flutter analyze
flutter test
```

For documentation-only or agent-instruction-only changes, full Flutter checks are usually not required. Explain skipped checks.
