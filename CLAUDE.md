# Coleus

- Solo-user app: I'm the only user. Built directly on the production server, no CI.
- Answer what's asked. Skip unsolicited warnings, CI/CD pitches, or hardening advice unless something is actually broken.

## Deploy
- `bin/deploy.sh [version]`: updates `coleus/*` packages, commits, pushes to `main`, builds/pushes Docker image.
- `bin/pull` (on server): git pull, compose pull/up, vendor:publish, migrate.
