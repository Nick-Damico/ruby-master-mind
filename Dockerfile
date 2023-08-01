FROM ruby:3.0.6-alpine3.16

ENV BUNDLER_VERSION=2.3.7

RUN apk update && apk add --no-cache build-base ruby-dev libc-dev linux-headers

RUN gem install bundler -v $BUNDLER_VERSION

WORKDIR /app

COPY Gemfile* .

RUN bundle install

COPY . .

CMD ["./bin/master_mind"]