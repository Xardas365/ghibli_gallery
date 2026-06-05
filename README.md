# Ghibli Gallery

A Flutter skeleton for the Seznam Flutter Developer Studio Ghibli entry assignment.

The current state is intentionally a clean project foundation, not a finished implementation. It provides the app shell, feature-first folders, placeholder screens, Riverpod wiring, domain/data contracts, and a basic widget test.

## Assignment Target

The finished app should implement:

- Studio Ghibli movie gallery.
- Film detail screen.
- Favorite toggle.
- 1-5 star rating.
- Locally persisted favorites and ratings.
- Favorites screen with rating filtering.
- Detail screen with all film parameters.
- Resolved people, species, locations, and vehicles.
- Custom API layer without using an existing Dart Studio Ghibli client.

## Current Skeleton

Implemented now:

- `ProviderScope` app entry.
- `MaterialApp` shell with named routes.
- App theme.
- Gallery, detail, and favorites placeholder screens.
- Shared UI widgets for film cards, favorite button, rating stars, and metadata sections.
- Data/domain/repository contract files.
- Local storage and API client placeholders.
- Riverpod rating filter provider.
- Smoke widget test for the gallery shell.

Not implemented yet:

- Studio Ghibli API integration.
- DTO JSON parsing.
- Repository logic.
- Local persistence.
- Real gallery/detail/favorites state.
- Generated Freezed/json_serializable models.
- CI workflow.

## API

The assignment API source of truth is:

```text
https://ghibliapi.vercel.app/films
```

Film detail must later resolve referenced:

- people,
- species,
- locations,
- vehicles.

Empty, collection-like, unavailable, or inconsistent reference URLs should be handled gracefully.

## Structure

```text
lib/
  main.dart
  app/
    ghibli_app.dart
    router.dart
    theme.dart
  core/
    network/
      api_client.dart
      api_exception.dart
    storage/
      local_storage.dart
  features/
    films/
      data/
        film_api.dart
        film_repository_impl.dart
        models/
      domain/
      presentation/
        providers/
        screens/
        widgets/
test/
  widget_test.dart
```

## Dependencies

Current dependencies:

- Flutter
- `flutter_riverpod`
- `flutter_lints`
- Flutter test tooling

Planned dependencies should be added only when their implementation step needs them:

- `dio` for HTTP and optional logging,
- `shared_preferences` or `hive` for local persistence,
- `freezed` and `json_serializable` for DTOs, persistence models, and selected state classes,
- `build_runner` for code generation.

## Getting Started

```bash
flutter pub get
flutter run
```

## Quality Checks

```bash
dart format .
flutter analyze
flutter test
```

Run code generation only after generated models are introduced:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Next Steps

Suggested implementation order:

1. Add API DTO parsing and tests.
2. Implement `ApiClient` and `FilmApi`.
3. Implement repository mapping from DTOs to domain models.
4. Add local persistence for favorites and ratings.
5. Wire Riverpod providers to real data.
6. Replace placeholder screens with real gallery, detail, and favorites UI.
7. Add final README details and CI if useful.

