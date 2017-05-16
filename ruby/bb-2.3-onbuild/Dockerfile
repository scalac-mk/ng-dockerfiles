FROM quay.io/netguru/ng-ruby:bb-2.3

ONBUILD ADD Gemfile* $APP_HOME/
ONBUILD RUN bundle install --jobs=8 --retry=3 --without development test --deployment

ONBUILD ADD . $APP_HOME/
