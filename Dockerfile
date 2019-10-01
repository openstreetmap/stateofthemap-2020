FROM ruby:2.6-alpine as build

RUN apk add --no-cache g++ musl-dev make

WORKDIR /app

ADD Gemfile* /app/
RUN gem install bundler \
    && bundle config build.nokogiri --use-system-libraries \
    && bundle install --frozen --jobs 4 --retry 5

COPY ./docker-entrypoint.sh /docker-entrypoint.sh

COPY . .

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["jekyll","serve","--host=0.0.0.0","-wl"]
