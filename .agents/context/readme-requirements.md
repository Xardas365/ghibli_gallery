# README Requirements

README must contain:

- project purpose,
- Flutter version used,
- setup instructions,
- run instructions,
- test instructions,
- code generation instructions,
- list of used dependencies and why they were used,
- implemented mandatory requirements,
- implemented bonus features,
- known limitations,
- notes about any consciously simplified or imperfect solution.

Mention that the project uses Freezed and json_serializable, and include:

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

Suggested wording:

```md
### Code generation

The project uses `freezed` and `json_serializable` for immutable DTOs, local persistence models, and selected UI states. This keeps model classes concise while preserving type safety, value equality, `copyWith`, and explicit JSON mapping.

Generated files are committed for easier review, but they should not be edited manually.
```

Keep README concise and easy to review. README content must match the actual implementation and checks that were run.

