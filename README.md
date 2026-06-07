# Ghibli Gallery

A small Flutter interview assignment for Seznam. The app presents Studio Ghibli films as a movie-gallery experience with REST API loading, local favorite/rating persistence, Riverpod state management, and deterministic tests.

## Environment

Verified locally with:

- Flutter `3.41.0` stable
- Dart `3.11.0`
- Project SDK constraint: `^3.8.0`

## API

The app uses its own API layer with Dio. It does not use an existing Dart Studio Ghibli API client.

- Base URL: `https://ghibli-api.vercel.app/api`
- Films endpoint: `/films`

Film detail resolves referenced people, species, locations, and vehicles into human-readable names where possible. Collection-like related URLs are skipped gracefully.

## Implemented Features

- Streaming-service-style film gallery with loading, error, empty, and data states.
- Film detail screen with poster/banner, titles, description, director, producer, release date, running time, Rotten Tomatoes score, and related people/species/locations/vehicles sections.
- Favorite toggle and 1-5 rating on detail.
- Favorite and rating indicators on gallery and favorites cards.
- Locally persisted favorites and ratings by film ID.
- Favorites screen with rating filter and empty states.
- Simple Navigator-based routes for gallery, detail, and favorites.

## Dependencies

Runtime dependencies used by the implementation:

- `flutter_riverpod`: state management and async provider state.
- `dio`: HTTP client for the custom Studio Ghibli API layer.
- `shared_preferences`: local persistence for favorites and ratings.
- `freezed_annotation`: immutable DTO/domain models and generated value behavior where used.
- `json_annotation`: JSON mapping for API DTOs.

Development dependencies:

- `build_runner`, `freezed`, `json_serializable`: code generation.
- `mocktail`: deterministic repository/API tests.
- `very_good_analysis`: lint rules.
- Flutter test tooling.

Some dependencies remain in `pubspec.yaml` from the starter/skeleton but are not used by the current implementation, including `go_router`, `cached_network_image`, `flutter_animate`, and `collection`. No animations are implemented.

## Setup

Install dependencies:

```bash
flutter pub get
```

Run code generation when generated models or annotations change:

```bash
dart run build_runner build
```

Generated files are committed for easier review, but they should not be edited manually:

- `*.freezed.dart`
- `*.g.dart`

Run the app:

```bash
flutter run
```

## Verification

Use:

```bash
dart format .
flutter analyze
flutter test
```

Latest verified result:

- `flutter test` passed with `125` tests.

## Testing Coverage

The test suite covers:

- DTO parsing and safe numeric parsing.
- API response shape handling.
- Repository mapping.
- Collection-like URL skipping.
- Partial related-resource failure handling.
- Favorite/rating persistence and validation.
- Rating filter logic.
- Gallery, detail, and favorites loading/error/empty/data states.
- Favorite/rating actions in the UI.

Tests use fakes/mocks and do not call the real network.

## Known Limitations And Trade-Offs

- If one related resource in a group fails, the whole related group may be shown as empty.
- Local storage write failures are handled safely, but they are not reported through a logging layer.
- UX polish is intentionally modest and focused on readability over animation.
- No CI/GitHub Actions are implemented.
- No animations are implemented.
- The app keeps a compact feature-first structure rather than a larger enterprise-style architecture.
