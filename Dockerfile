FROM alpine 

MAINTAINER CenturyLink Labs <innovationslab@ctl.io>

ENV BUILD_PACKAGES curl-dev ruby-dev build-base
ENV RUBY_PACKAGES ruby ruby-io-console ruby-bundler yaml
ENV DEV_PACKAGES zlib-dev libgcrypt libxml2-dev libxslt-dev tzdata sqlite-dev nodejs 

RUN echo 'gem: --no-document' >> /.gemrc

RUN apk update && \
    apk upgrade && \
    apk add $BUILD_PACKAGES && \
    apk add $RUBY_PACKAGES && \
    apk add $DEV_PACKAGES && \
    rm -rf /var/cache/apk/*

RUN gem install bundler --no-document

ONBUILD RUN mkdir /var/app
ONBUILD COPY . /var/app
ONBUILD WORKDIR /var/app
ONBUILD RUN bundle config build.nokogiri --use-system-libraries && bundle install && rake db:create && rake db:migrate && rake db:seed

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"] 
 
