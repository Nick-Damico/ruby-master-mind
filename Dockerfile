FROM ruby:3.3.0-alpine

ENV BUNDLER_VERSION=2.3.7

RUN apk update && apk add --no-cache build-base ruby-dev libc-dev linux-headers git

RUN gem install bundler -v $BUNDLER_VERSION

WORKDIR /app

COPY Gemfile* .

COPY . .


CMD ["./bin/setup"]