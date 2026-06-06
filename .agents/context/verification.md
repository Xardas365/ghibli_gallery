# Verification Context

## Standard Checks

For code changes, run the relevant checks before finishing. If model files, generated annotations, or JSON mapping changed, run code generation before format/analyze/test:

```bash
dart run build_runner build
```

```bash
dart format .
flutter analyze
flutter test
```

For documentation-only or agent-instruction-only changes, full Flutter checks are usually not required. If a relevant check is skipped, explain why in the final response.

## Code Generation

When adding or changing generated models, run:

```bash
dart run build_runner build
```

For active development, watch mode is allowed:

```bash
dart run build_runner watch
```

Never edit generated files manually:

- `*.freezed.dart`
- `*.g.dart`

## Testing Guidance

Add tests where they provide value. Minimum useful tests:

- film DTO parsing,
- favorite and rating persistence logic,
- rating filter logic,
- repository behavior with mocked API or local storage if practical.

## GitHub Actions

If adding CI, keep it simple:

- checkout,
- setup Flutter,
- flutter pub get,
- dart format --set-exit-if-changed .,
- flutter analyze,
- flutter test.

Do not add complex release or build pipelines.

## Final Readiness Checklist

Before considering the assignment complete, verify:

- Gallery screen works.
- Detail screen works.
- Favorites can be toggled.
- Rating 1-5 works.
- Favorites and ratings survive app restart.
- Favorites screen works.
- Rating filter works.
- Film detail displays all base film fields.
- People, species, locations, and vehicles are mapped or gracefully handled.
- Loading, error, and empty states exist.
- Generated files are up to date.
- No generated files were edited manually.
- `dart run build_runner build` was run after model changes.
- `dart format .` was run for code changes.
- `flutter analyze` passes for code changes.
- `flutter test` passes for code changes, or failures are explained.
- README is complete.
