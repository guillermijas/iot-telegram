FROM ruby:2.5.1-stretch

RUN mkdir -p /app
RUN mkdir -p /var/shared

WORKDIR /app
ADD . /app
RUN gem install bundler && bundle install

EXPOSE 3000

# The default command that gets ran will be to start the Puma server.
CMD bundle exec puma -C config/puma.rb