# Assignment Context

## Project Goal

Build a small Flutter mobile app for a Seznam Flutter Developer interview. The app presents Studio Ghibli films as a movie gallery and demonstrates:

- clean Flutter/Dart code,
- good REST API handling,
- reasonable architecture,
- understandable state management,
- persistent local user data,
- readable UX for a movie gallery.

Do not over-engineer the solution. It should look like a small but professionally structured interview assignment.

## Mandatory Requirements

- Mobile Flutter app working as a Studio Ghibli movie gallery.
- Film gallery screen in a streaming-service-like style.
- Film detail screen.
- Ability to mark a film as favorite.
- Ability to rate a film from 1 to 5 stars.
- Favorites and ratings are persisted locally.
- Favorites and ratings are visible where they make sense:
  - gallery,
  - detail,
  - favorites screen.
- Favorites screen allows filtering by rating.
- Film detail displays all film parameters.
- Film detail resolves and displays mapped people, species, locations, and vehicles.
- The app does not use an existing Dart client for the Studio Ghibli API.

## Bonus Features

Bonus features are allowed only after mandatory requirements are complete:

- animations,
- HTTP interceptor or logging,
- GitHub Actions,
- extra UX polish,
- tests beyond the minimum.

## UX Acceptance Criteria

The gallery should visually feel like a movie gallery or streaming service:

- poster cards,
- movie banners where useful,
- title,
- year,
- director,
- favorite indicator,
- user rating indicator.

The detail screen should include:

- poster or banner,
- title,
- original title,
- romanised title,
- description,
- director,
- producer,
- release date,
- running time,
- Rotten Tomatoes score,
- people,
- species,
- locations,
- vehicles,
- favorite toggle,
- 1-5 star rating.

The favorites screen should include:

- all favorited films,
- rating filter,
- empty state,
- ability to open detail.

UX requirements:

- loading indicators are meaningful,
- error states explain what happened,
- empty states do not look broken,
- user actions give immediate feedback.

## Navigation

Use simple navigation. If using `go_router`, keep routes minimal:

- `/`
- `/film/:id`
- `/favorites`

Flutter's built-in Navigator is also acceptable. Do not introduce complex nested navigation.

