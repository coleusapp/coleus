# Coleus

## Deploy

On the production server:

```bash
bin/deploy.sh          # auto-bumps patch version
bin/deploy.sh v1.0.49  # or pass a version
bin/pull
```

`bin/deploy.sh`:
1. `composer update 'coleus/*'` (no need to run it manually)
2. Commits and pushes to `main`
3. Builds multi-arch Docker image and pushes `coleus/coleus:<version>` and `:latest`

`bin/pull`:
1. `git pull`, `docker compose pull`, `docker compose up -d`
2. `php artisan vendor:publish --force --all`
3. `php artisan migrate --force`
