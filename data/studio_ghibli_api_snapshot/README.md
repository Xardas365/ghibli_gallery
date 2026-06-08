# Studio Ghibli API Snapshot

This directory contains a project-owned snapshot of the public Studio Ghibli API
data used by the app.

Captured at: `2026-06-08T14:07:53.8001422Z`

Source base URL: `https://ghibli-api.vercel.app/api`

Included collection endpoints:

- `films.json` from `/films`
- `people.json` from `/people`
- `species.json` from `/species`
- `locations.json` from `/locations`
- `vehicles.json` from `/vehicles`

Included film images referenced by `films.json`:

- `images/films/posters/` from each film `image` URL
- `images/films/banners/` from each film `movie_banner` URL

`manifest.json` records the source URLs, item counts, and SHA-256 hashes for the
captured JSON files. `images/films/manifest.json` records the source URLs, local
paths, byte sizes, and SHA-256 hashes for the captured image files.

The app does not load these files at runtime. They are intentionally kept outside
the Flutter asset bundle so the current implementation continues to use the live
API. The snapshot is only a backup in case the API becomes unavailable and a
future offline fallback is needed.
