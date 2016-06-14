FROM ruby:2.3.0

RUN apt-get update -qq

RUN apt-get install -y \
  imagemagick \
  libmagickwand-dev \
  libdmtx-dev

ADD . /app
WORKDIR /app

RUN bundle install

ENTRYPOINT ["./app"]
