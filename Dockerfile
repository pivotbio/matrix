FROM ubuntu

RUN sudo apt-get update --fix-missing
RUN sudo apt-get install -y \
  build-essential \
  ruby \
  ruby-dev \
  imagemagick \
  libmagickwand-dev \
  dmtx-utils

ADD . work
WORKDIR work

RUN gem install bundler

RUN bundle install

ENTRYPOINT bundle exec rspec
