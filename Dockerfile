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
      tzdata

RUN gem install bundler -v 2.3.16

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./

# Stupid nokogiri.
RUN apk add --no-cache libxml2 libxslt &&  \
    apk add --no-cache --virtual .gem-installdeps build-base libxml2-dev libxslt-dev ruby-dev

RUN gem install nokogiri --platform=ruby -- --use-system-libraries
RUN gem install unf_ext --no-ri --no-rdoc

RUN bundle config build.nokogiri --use-system-libraries
RUN bundle config --global frozen 1
RUN bundle install

RUN rm -rf $GEM_HOME/cache && apk del .gem-installdeps

COPY . ./

EXPOSE 3000

ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]
