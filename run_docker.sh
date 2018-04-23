#!/bin/bash

docker run -it \
  --rm \
  --name ethui-debugger-$USER \
  -p 127.0.0.1:8000:8000 \
  --env GETH_HOSTNAME=localhost \
  ethui-debugger
