#!/bin/bash

version=0.10.1
set -ex

docker build -t quay.io/netguru/baseimage:$version --pull .
docker push quay.io/netguru/baseimage:$version
