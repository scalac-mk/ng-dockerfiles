FROM quay.io/netguru/ng-ruby:2.5.1-rails

ONBUILD ADD Gemfile* $APP_HOME/
ONBUILD RUN bundle install --jobs=8 --retry=3 --without development test --deployment

ONBUILD ADD . $APP_HOME/
