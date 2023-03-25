FROM ruby:2.7.7-alpine

ENV BUNDLER_VERSION=2.3.16
ENV BUNDLE_WITHOUT development:test

# ENV vars will live here.
ENV RAILS_ENV production

# make 'docker logs' work
ENV RAILS_LOG_TO_STDOUT=true

RUN apk add --update --no-cache \
      curl \
      musl \
      g++ \
      gcc \
      make \
      nodejs \
      postgresql-dev \
      gcompat \
      tzdata \
      libxml2-dev \
      libxslt1-dev

RUN gem install bundler -v 2.3.16

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./

RUN bundle config build.nokogiri --use-system-libraries
RUN bundle config --global frozen 1
RUN bundle install

COPY . ./

EXPOSE 3000

ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]
