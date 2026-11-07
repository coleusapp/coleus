# Coleus

- Solo-user app: I'm the only user. No CI.
- Answer what's asked. Skip unsolicited warnings, CI/CD pitches, or hardening advice unless something is actually broken.

## Deploy
- Locally, one command: `git pull && git add . && git commit -m "wip" && ./bin/deploy.sh`
- `bin/deploy.sh [version]` (local): updates `coleus/*` packages, commits, pushes to `main`, builds/pushes Docker image.
- `bin/pull` (on server): git pull, compose pull/up, vendor:publish, migrate.
