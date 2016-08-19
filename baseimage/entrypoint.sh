#!/bin/bash
set -e

function start {
  run-on-start
  :
}

if [ "$1" == "/sbin/my_init" ]; then
  start
fi

exec "$@"
