FROM ruby:2.2.0

RUN apt-get update -qq

RUN apt-get install -y \
  build-essential \
  libpq-dev \
  imagemagick \
  libmagickwand-dev \
  dmtx-utils

RUN mkdir /app
WORKDIR /app
ADD Gemfile /app/Gemfile
RUN bundle install
ADD . /app
