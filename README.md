# EasyAddress

Application to fetch address information

Developed by @adubas

## Index

1. [Requirements](#requirements)
2. [Setup](#setup)
3. [Gems](#gems)
4. [Testing](#testing)

## Requirements

[Docker](https://docs.docker.com/get-docker/)
[Docker compose](https://docs.docker.com/compose/install/)

## Setup

Initial setup configuration trough docker-compose run

```bash
$ docker-compose build
$ docker-compose run --rm --service-ports app bash
$ bin/setup
$ rails db:migrate
$ rails s -b 0.0.0.0
```

> Access application on `http://localhost:3000/`

## Gems

- [PostgreSQL](https://github.com/ged/ruby-pg)
- [Faraday](https://github.com/lostisland/faraday)
- [Rspec](https://github.com/rspec)
- [Faker](https://github.com/faker-ruby/faker)
- [Factory Bot](https://github.com/thoughtbot/factory_bot)
- [RuboCop](https://github.com/rubocop/rubocop)
- [WebMock](https://github.com/bblimke/webmock)

## Testing

Run the following

```bash
$ docker-compose run --rm --service-ports app bash
$ bin/setup
$ rails db:migrate
$ rspec
```
