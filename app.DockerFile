FROM ruby:2.5.1-stretch

RUN mkdir -p /app
RUN mkdir -p /var/shared

WORKDIR /app
ADD . /app
RUN gem install bundler && bundle install

CMD bundle exec puma