#!/bin/bash

curr_dir=$(cd $(dirname $0); pwd)

docker build \
  -t ethui-debugger \
  -f Dockerfile \
  .
