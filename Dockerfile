FROM alpine:edge

MAINTAINER CenturyLink Labs <innovationslab@ctl.io>
ENV BUILD_PACKAGES="curl-dev ruby-dev build-base" \
    DEV_PACKAGES="zlib-dev libxml2-dev libxslt-dev tzdata sqlite-dev nodejs" \
    RUBY_PACKAGES="ruby ruby-io-console ruby-json yaml"

RUN \
  echo 'gem: --no-document' >> /.gemrc && \
  apk --update --upgrade add $BUILD_PACKAGES $RUBY_PACKAGES $DEV_PACKAGES && \
  gem install --no-document bundler -- --use-system-libraries && \
  find / -type f -iname \*.apk-new -delete && \
  rm -rf /var/cache/apk/* && \
  rm -rf /usr/lib/lib/ruby/gems/*/cache/* && \
  rm -rf ~/.gem

EXPOSE 3000
