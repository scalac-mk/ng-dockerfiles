#!/bin/bash

version=0.10.2
set -ex

docker build -t quay.io/netguru/baseimage:$version --pull --no-cache .
docker push quay.io/netguru/baseimage:$version
