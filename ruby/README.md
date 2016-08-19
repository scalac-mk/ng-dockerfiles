# Ready-to-use images with preinstalled Ruby

Quay repository: https://quay.io/repository/netguru/ng-ruby

## Description

Mostly, there are three "kinds" of images for each latest ruby version from each major tree (`2.1`, `2.2` and `2.3`). These kinds are:

* `2.x.y` - "naked" image which is built from [baseimage](https://github.com/netguru/ng-dockerfiles/blob/master/baseimage/Dockerfile) and contains pre-installed specific ruby version (`x` is `MINOR` and `y` is `TEENY`)
* `2.x.y-rails` - image with pre-installed specific ruby version based on [baseimage](https://github.com/netguru/ng-dockerfiles/blob/master/baseimage/Dockerfile) with additonal most-common libraries installed (such as imagemagick, passenger, nodejs), which can be a ready-to-go image for most rails applications
* `2.x.y-rails-onbuild` - this is same as `2.x.y-rails` but contains additional three `ONBUILD` commands, which copies Gemfiles and runs bundle install



### `APP_HOME` information

The `APP_HOME` is the environment variable which points to the folder inside the container, that can be used in various scripts, for example to copy the code there, execute a rake task from within that path etc. The value of `APP_HOME` is different depending on the image suffix:

* All `naked` ruby images default `APP_HOME` environment variable is pulled from [baseimage](https://github.com/netguru/ng-dockerfiles/blob/e3280657a7c28e277abd72002b2e14e6536a9a38/baseimage/Dockerfile#L43) and it's value is `/var/www/app`
* All `2.x.y-rails` ruby images changes the `APP_HOME` environment variable - it is overidden in each Dockerfile and its value is `/app`
* The `2.x.y-rails-onbuild` images runs `ONBUILD` task which copies Gemfile and code to the `APP_HOME`, which is set in `2.x.y-rails` image - so it is `/app`



## Tags included

Each specific ruby version has its own tag (ex. `2.3.1-rails`) and in addition to that a shorter version tag which will always pull latest `TEENY` version from `MINOR` tree (ex. `2.3-rails`). The `latest` tag will always point to the latest `naked` ruby version.

_Note: Some tags are old and not maintained anymore (specifically from `1.9.3` tree)_


The full list of tags that are currently in use with the links to Dockerfiles can be found in description [here](https://quay.io/repository/netguru/ng-ruby)
