# amber-moon

[![Amber Framework](https://img.shields.io/badge/using-amber_framework-orange.svg)](https://amberframework.org)

```bash
docker-compose logs app --follow --no-log-prefix
```

```bash
docker-compose restart app 
```

```bash
docker-compose exec db psql -U postgres -W amber_moon_development
```

```bash 
docker-compose down && docker-compose up -d
```

This is a project written using [Amber](https://amberframework.org). Enjoy!

## Roadmap

- [ ] Fix O(n + 1) calendar queries
- [X] Move jwt secret to env
- [ ] Fix SQL injections
- [X] Make jwt token expire
- [ ] Calendar google sync
  - [ ] Google api integration
    - [ ] Create google api client
    - [ ] [google-api](https://github.com/PlaceOS/google)
    - [ ] Add sync to google calendar
    - [ ] Ask for google calendar permissions
  - [ ] Add [sidekiq.cr](https://github.com/hugopl/sidekiq.cr)
    - [ ] Sync calendar using sidekiq
- [ ] Add Dockerfile
  - [ ] CI/CD
    - [ ] Build docker image and push to docker hub
    - [ ] Deploy to somewhere (fly.io? railway.app? aws?)






























