#!/bin/bash

echo "Starting app ..."
echo "Browse to http://localhost:8000/step-08/index.html#/beers"
docker run --rm -it -p 8000:8000 mjbright/polymer

