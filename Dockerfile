FROM ruby:3.2.0

RUN apt-get update -qq && apt-get install -y libpq-dev postgresql-client

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .
