# Ghibli Gallery

A small Flutter interview assignment for Seznam. The app presents Studio Ghibli films as a movie-gallery experience with REST API loading, local favorite/rating persistence, Riverpod state management, and deterministic tests.

Package name: `ghibli_gallery`.

## Environment

Verified locally with:

- Flutter `3.41.0` stable
- Dart `3.11.0`
- Project SDK constraint: `^3.8.0`

## API

The app uses its own Dio-based API layer. It does not use an existing Dart Studio Ghibli API client.

- Base URL: `https://ghibli-api.vercel.app/api`
- Films endpoint: `/films`

Film detail resolves referenced people, species, locations, and vehicles into human-readable names where possible. Collection-like related URLs are skipped gracefully.

## Implemented Mandatory Requirements

- Streaming-service-style film gallery with loading, error, empty, and data states.
- Film detail screen with poster/banner, titles, description, director, producer, release date, running time, Rotten Tomatoes score, and related people/species/locations/vehicles sections.
- Favorite toggle and 1-5 rating on film detail.
- Interactive favorite toggle on gallery and favorites cards; user rating is also shown there.
- Compact Rotten Tomatoes card rating row with score percentage and stars.
- Locally persisted favorites and ratings by film ID.
- Favorites screen with rating filter and empty states.
- Simple Navigator-based routes for gallery, detail, and favorites.
- DTO parsing, safe numeric parsing, repository mapping, partial related-resource failure handling, persistence, provider, and widget tests.

## Implemented Bonus Features

- `cached_network_image` image loading and fallback states for poster/banner requests.
- Subtle card and screen-level UI animations via `flutter_animate` and built-in Flutter animations.
- Animated gallery search bar show/hide interaction.
- Debug-only Dio logging interceptor that logs method, sanitized URL, status, duration, and error type/status without bodies or headers.
- GitHub Actions CI for `flutter pub get`, formatting, analysis, and tests.
- RT scores render from a generic tomato SVG icon (not the official Rotten Tomatoes logo).

## Dependencies

Runtime dependencies:

- `flutter_riverpod`: state management and async provider state.
- `dio`: HTTP client for the custom Studio Ghibli API layer and debug logging interceptor.
- `shared_preferences`: local persistence for favorites and ratings.
- `cached_network_image`: cached poster/banner loading with polished loading/fallback states.
- `flutter_animate`: concise timing helpers for subtle UI animations.
- `flutter_svg`: icon rendering for the compact Tomato score asset.
- `collection`: small collection helpers where they keep UI/navigation code readable.
- `freezed_annotation`: immutable DTO/domain models and generated value behavior where used.
- `json_annotation`: explicit JSON mapping for API DTOs and local persistence mapping where used.

Development dependencies:

- `build_runner`, `freezed`, `json_serializable`: code generation.
- `flutter_launcher_icons`: generates Android and iOS launcher icons from
  the app icon assets.
- `flutter_native_splash`: generates a consistent native launch screen before
  Flutter renders the first frame.
- `mocktail`: deterministic repository/API tests.
- `very_good_analysis`: lint rules.
- Flutter test tooling.

## Setup

Install dependencies:

```bash
flutter pub get
```

Run code generation when generated models or annotations change:

```bash
dart run build_runner build
```

Regenerate launcher icons when app icon assets or launcher icon config change:

```bash
dart run flutter_launcher_icons
```

Generated files are committed for easier review, but they must not be edited manually:

- `*.freezed.dart`
- `*.g.dart`

## Run

Start the app:

```bash
flutter run
```

## Test And Verification

Use:

```bash
dart format .
flutter analyze
flutter test
```

Latest verified result:

- `flutter test` passed with `161` tests.

Tests use fakes/mocks and do not call the real network.

## CI

GitHub Actions workflow:

- `.github/workflows/flutter.yml`
- runs on `push` and `pull_request`
- executes `flutter pub get`, `dart format --set-exit-if-changed .`, `flutter analyze`, and `flutter test`

## Known Limitations And Trade-Offs

- If one related resource in a group fails, that related group may be shown as empty.
- Local storage write failures are handled safely in the UI flow, but they are not reported through a dedicated logging/analytics layer.
- Debug HTTP logging is intentionally minimal and avoids bodies, headers, query parameters, and secrets.
- UX polish and animations are intentionally modest for a small interview assignment.
- Navigation uses built-in Navigator routes instead of a routing package to keep the app simple.
- Android package identifier is `cz.krsak.ghibligallery` and application label is `Ghibli Gallery`.
- The app keeps a compact feature-first structure rather than a larger enterprise-style architecture.

## Thank You

Thank you for taking the time to review this project.

|  |
| :---: |
| ![Thank you](./assets/images/thx.png) |
