# Architecture Context

## Dependencies

Keep dependencies minimal and justify each addition.

Allowed or preferred dependencies:

- `flutter_riverpod` for state management,
- `dio` only if using interceptors or logging,
- `shared_preferences` or `hive` for local persistence,
- `freezed_annotation` for immutable models and union/sealed states,
- `json_annotation` for JSON mapping annotations,
- `go_router` only if navigation complexity justifies it,
- `flutter_animate` only if animations are implemented,
- `very_good_analysis` or `flutter_lints` for linting.

Allowed dev dependencies:

- `build_runner`,
- `freezed`,
- `json_serializable`,
- Flutter test tooling.

Do not add:

- Bloc,
- GetX,
- Provider,
- service locator packages,
- existing Studio Ghibli API Dart clients.

Freezed and json_serializable are allowed because they reduce repetitive model code, improve immutability, and make API parsing easier to review.

## Code Generation

Use Freezed and json_serializable for API DTOs, domain models, local persistence models, and selected state classes where they improve readability.

Generated files must not be edited manually:

- `*.freezed.dart`
- `*.g.dart`

Use `freezed` for:

- immutable DTOs,
- immutable domain models,
- `copyWith`,
- value equality,
- sealed/union state classes where useful.

Use `json_serializable` for:

- API response parsing,
- local persistence JSON mapping,
- explicit field mapping with `@JsonKey`.

Do not use code generation for every trivial class. Prefer it where it removes meaningful boilerplate or makes parsing safer.

## State Management

Use exactly one accepted state-management approach. Preferred for this project:

- Riverpod.

Do not mix multiple state-management systems.

Use Riverpod for:

- film list state,
- film detail state,
- favorites and rating state,
- rating filter state.

Keep state readable and easy to inspect. Avoid unnecessary rebuilds:

- use small widgets,
- watch only the state needed by the widget,
- split large UI widgets into focused components.

Use Freezed sealed/union classes for state only where it improves readability, such as loading/data/error state, film detail state, partial failure state, or local persistence state.

For simple filters, booleans, and selected rating values, normal Riverpod providers are enough.

## Structure

Use a simple feature-first structure:

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
      logging_interceptor.dart
    storage/
      local_storage.dart
  features/
    films/
      data/
        film_api.dart
        film_repository_impl.dart
        models/
          film_dto.dart
          person_dto.dart
          species_dto.dart
          location_dto.dart
          vehicle_dto.dart
      domain/
        film.dart
        film_details.dart
        favorite_movie.dart
        film_repository.dart
      presentation/
        providers/
          films_providers.dart
          favorites_providers.dart
        screens/
          film_gallery_screen.dart
          film_detail_screen.dart
          favorite_films_screen.dart
        widgets/
          film_card.dart
          rating_stars.dart
          favorite_button.dart
          film_metadata_section.dart
```

Keep folder depth reasonable. Do not create unnecessary layers. Domain models can stay lightweight for this assignment.

## Data Modeling

Separate API DTOs from UI/domain models when it improves clarity.

Recommended model types:

- `FilmDto` for raw API response,
- `Film` for app/domain usage,
- `FilmDetails` for resolved detail data,
- `FavoriteMovie` for locally persisted user data,
- `FilmWithUserData` for UI composition.

Prefer explicit mapping from DTO to domain model instead of leaking raw API DTOs directly into UI.

## Persistence

Favorites and ratings must survive app restart. Persist data by film ID.

Rules:

- rating must be from 1 to 5,
- favorite can exist without rating,
- rating can imply favorite only if the UI explicitly communicates that,
- removing favorite should not accidentally lose rating unless designed and documented.

