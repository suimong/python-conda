#!/bin/bash

docker build --file Dockerfile \
    --tag python-conda:4.13 \
    --tag python-conda:4 \
    context
