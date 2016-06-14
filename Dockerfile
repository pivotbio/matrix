FROM ruby:2.3.0

RUN apt-get update -qq

RUN apt-get install -y \
  build-essential \
  libpq-dev \
  imagemagick \
  libmagickwand-dev \
  dmtx-utils

ADD . /app
WORKDIR /app

RUN bundle install
