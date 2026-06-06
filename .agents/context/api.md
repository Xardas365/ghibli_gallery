# API Context

## Source of Truth

Use the assignment endpoint as the source of truth:

- Base URL: `https://ghibli-api.vercel.app/api`
- Films endpoint: `/films`

Do not use an existing generated or third-party Dart Studio Ghibli API client. Create the app's own API layer.

## Referenced Resources

Film responses contain URL references for:

- people,
- species,
- locations,
- vehicles.

Resolve those references in the app and show human-readable mapped data in film detail.

Some API references may point to collection-like or empty URLs such as:

- `https://ghibli-api.vercel.app/api/people/`
- `https://ghibli-api.vercel.app/api/locations/`
- `https://ghibli-api.vercel.app/api/vehicles/`

Handle these gracefully:

- do not crash,
- do not show broken data,
- show an empty state or "No data available" where appropriate.

## Error Handling

Network code must handle:

- loading state,
- empty state,
- error state,
- retry action where useful.

Never let API or parsing errors crash the app. Create clear error handling for:

- network failure,
- invalid response,
- missing referenced resource,
- local storage failure.

Show user-friendly messages in the UI. Log technical details only in debug mode.

## DTO Parsing

DTOs should reflect the API response. Parse numeric values safely:

- `release_date` may arrive as a string,
- `running_time` may arrive as a string,
- `rt_score` may arrive as a string.

Do not assume perfect API data. Use `@JsonKey` when API field names do not match Dart naming conventions.

## Interceptors

If `dio` is used, a simple logging interceptor is acceptable as a bonus. Logging must not expose secrets.

The API is public and keyless, so no auth handling is needed.

