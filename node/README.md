# Ready-to-use images with preinstalled Node

Quay repository: https://quay.io/repository/netguru/ng-node

## Description

These are base images that can be used to build and run SPA apps. Contains couple most-necessary software, like:

* node 6/8
* yarn
* nginx (along with basic configuration)
* [dumb-init](https://github.com/Yelp/dumb-init)


The default path for codebase when using this image should be `/app`. Nginx configuration assumes, that the result "built" JS app will be in `/app/dist` and this folder is being served, on port `3000`. You don't have to use nginx, this image is also suited to work with ember-cli-deploy and other tools.

