# Coleus

## Deploy

Locally:

```bash
git pull && git add . && git commit -m "wip" && ./bin/deploy.sh
```

Pass a version to override the auto patch bump: `./bin/deploy.sh v1.0.49`.

Then on the production server:

```bash
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
