FROM alpine:3.2

MAINTAINER CenturyLink Labs <innovationslab@ctl.io>

ENV BUILD_PACKAGES="curl-dev ruby-dev build-base" \
    DEV_PACKAGES="zlib-dev libxml2-dev libxslt-dev tzdata yaml-dev sqlite-dev postgresql-dev mysql-dev" \
    RUBY_PACKAGES="ruby ruby-io-console ruby-json yaml nodejs" \
    RAILS_VERSION="4.2.3"

RUN apk update

RUN apk add curl-dev
RUN apk add ruby-dev
RUN apk add build-base
RUN apk add zlib-dev
RUN apk add libxml2-dev
RUN apk add libxslt-dev
RUN apk add tzdata
RUN apk add yaml-dev
RUN apk add sqlite-dev
RUN apk add postgresql-dev
RUN apk add mysql-dev

RUN apk add ruby
RUN apk add ruby-io-console
RUN apk add ruby-json
RUN apk add yaml
RUN apk add nodejs
RUN gem install -N bundler

RUN gem install -N nokogiri -- --use-system-libraries && \
  gem install -N rails --version "$RAILS_VERSION" && \
  echo 'gem: --no-document' >> ~/.gemrc && \
  cp ~/.gemrc /etc/gemrc && \
  chmod uog+r /etc/gemrc && \

  # cleanup and settings
  bundle config --global build.nokogiri  "--use-system-libraries" && \
  bundle config --global build.nokogumbo "--use-system-libraries" && \
  find / -type f -iname \*.apk-new -delete && \
  rm -rf /var/cache/apk/* && \
  rm -rf /usr/lib/lib/ruby/gems/*/cache/* && \
  rm -rf ~/.gem

EXPOSE 3000
